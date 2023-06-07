data "cloudinit_config" "cloudinit_config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"

    content = yamlencode({
      packages = [
        "iptables-services",
      ]

      write_files = [
        {
          path        = "/etc/sysconfig/iptables"
          permissions = "0444"
          content     = local.iptables_contents
        },
        {
          path        = "/etc/systemd/system/health-check-responder@.service"
          permissions = "0444"
          content     = file("${path.module}/files/health-check-responder.service")
        },
        {
          path        = "/usr/local/bin/health-check-responder"
          permissions = "0555"
          content     = file("${path.module}/files/health-check-responder.py")
        },
        {
          path        = "/etc/sysctl.d/10-ip_forward.conf"
          permissions = "0444"
          content     = "net.ipv4.ip_forward=1\n"
        },
        {
          path        = "/etc/sysctl.d/10-ip_local_port_range.conf"
          permissions = "0444"
          content     = "net.ipv4.ip_local_port_range=61408 65535\n"
        }
      ]

      users = [
        {
          name   = "health-check-responder"
          system = true
        }
      ]

      runcmd = [
        [
          "systemctl",
          "disable",
          "--now",
          "sshd.service",
        ],
        [
          "yum",
          "remove",
          "-y",
          "openssh-server",
        ],
        [
          "systemctl",
          "daemon-reload",
        ],
        [
          "systemctl",
          "restart",
          "systemd-sysctl.service",
        ],
        concat(
          [
            "systemctl",
            "enable",
            "--now",
            "systemd-sysctl.service",
            "iptables.service",
          ],
          local.health_check_services,
        ),
      ]
    })
  }
}

locals {
  health_check_services = [for port in sort(tolist(var.http_health_check_ports)) :
    "health-check-responder@${port}.service"
  ]
}
