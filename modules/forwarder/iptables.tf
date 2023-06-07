locals {
  iptables_mangle_prerouting_lines = [for address in sort(distinct([for rule in var.forwarding_rules : rule.to_address])) :
    "-A PREROUTING -s ${address}/32 -j TTL --ttl-set 64"
  ]

  iptables_mangle_postrouting_lines = [for address in sort(distinct([for rule in var.forwarding_rules : rule.to_address])) :
    "-A POSTROUTING -d ${address}/32 -j TTL --ttl-set 64"
  ]

  iptables_nat_prerouting_lines = [for rule in var.forwarding_rules :
    "-A PREROUTING -i eth0 -p ${rule.protocol} -m ${rule.protocol} --dport ${rule.from_port} -j DNAT --to-destination ${rule.to_address}:${rule.to_port}"
  ]

  iptables_nat_postrouting_lines = [for rule in var.forwarding_rules :
    "-A POSTROUTING -d ${rule.to_address}/32 -o eth0 -p ${rule.protocol} -m ${rule.protocol} --dport ${rule.to_port} -j MASQUERADE --to-ports 1024-60927 --random --random-fully"
  ]

  iptables_forward_lines = [for rule in var.forwarding_rules :
    "-A FORWARD -d ${rule.to_address}/32 -p ${rule.protocol} -m ${rule.protocol} --dport ${rule.to_port} -m state --state NEW -j ACCEPT"
  ]

  iptables_input_lines = [for port in sort(tolist(var.http_health_check_ports)) :
    "-A INPUT -p tcp -m tcp --dport ${port} -j ACCEPT"
  ]

  iptables_contents = join("\n", concat(
    [
      "*mangle",
      ":PREROUTING ACCEPT [0:0]",
      ":INPUT ACCEPT [0:0]",
      ":FORWARD ACCEPT [0:0]",
      ":OUTPUT ACCEPT [0:0]",
      ":POSTROUTING ACCEPT [0:0]",
    ],
    local.iptables_mangle_prerouting_lines,
    local.iptables_mangle_postrouting_lines,
    [
      "COMMIT",
      "*nat",
      ":PREROUTING ACCEPT [0:0]",
      ":INPUT ACCEPT [0:0]",
      ":OUTPUT ACCEPT [0:0]",
      ":POSTROUTING ACCEPT [0:0]",
    ],
    local.iptables_nat_prerouting_lines,
    local.iptables_nat_postrouting_lines,
    [
      "COMMIT",
      "*filter",
      ":INPUT DROP [0:0]",
      ":FORWARD DROP [0:0]",
      ":OUTPUT ACCEPT [0:0]",
      "-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT",
      "-A INPUT -p icmp -j ACCEPT",
      "-A INPUT -i lo -j ACCEPT",
    ],
    local.iptables_input_lines,
    [
      "-A INPUT -p tcp -j REJECT --reject-with tcp-reset",
      "-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable",
      "-A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT",
    ],
    local.iptables_forward_lines,
    [
      "COMMIT",
      "",
    ],
  ))
}
