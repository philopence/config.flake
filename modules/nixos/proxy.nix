{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.proxy;
in {
  options.features.proxy = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    # networking.proxy.default = "192.168.0.100:2333";
    services.sing-box = {
      enable = true;
      settings = {
        dns = {
          servers = [
            {
              tag = "proxy-dns";
              address = "https://1.1.1.1/dns-query";
              detour = "proxy-out";
            }
            {
              tag = "direct-dns";
              address = "https://223.5.5.5/dns-query";
              detour = "direct-out";
            }
          ];

          rules = [
            {
              outbound = "any";
              server = "direct-dns";
            }
            {
              rule_set = "geosite-geolocation-cn";
              server = "direct-dns";
            }
          ];
          final = "proxy-dns";
          strategy = "prefer_ipv4";
        };

        inbounds = [
          {
            type = "tun";
            tag = "tun-in";
            interface_name = "sing-box";
            ## TODO v1.10.0 "address": [ "172.18.0.1/30" ]
            inet4_address = "172.19.0.1/30";
            mtu = 1480;
            gso = true;
            auto_route = true;
            stack = "gvisor";
            sniff = true;
            sniff_override_destination = false;
          }
        ];

        outbounds = [
          {
            type = "selector";
            tag = "proxy-out";
            outbounds = [
              "us-out"
              "jp-out"
              "hk-out"
              # "bak-out"
            ];
            default = "jp-out";
          }
          {
            type = "shadowsocks";
            tag = "us-out";
            server = {
              _secret = /run/secrets/proxy/us;
            };
            server_port = 11027;
            method = "aes-128-gcm";
            password = {
              _secret = /run/secrets/proxy/password;
            };
          }
          {
            type = "shadowsocks";
            tag = "jp-out";
            server = {
              _secret = /run/secrets/proxy/jp;
            };
            server_port = 11013;
            method = "aes-128-gcm";
            password = {
              _secret = /run/secrets/proxy/password;
            };
          }
          {
            type = "shadowsocks";
            tag = "hk-out";
            server = {
              _secret = /run/secrets/proxy/hk;
            };
            server_port = 11007;
            method = "aes-128-gcm";
            password = {
              _secret = /run/secrets/proxy/password;
            };
          }
          # {
          #   type = "trojan";
          #   tag = "bak-out";
          #   server = {
          #     _secret = /run/secrets/proxy/bak_server;
          #   };
          #   server_port = 443;
          #   password = {
          #     _secret = /run/secrets/proxy/bak_password;
          #   };
          # }
          {
            type = "dns";
            tag = "dns-out";
          }
          {
            type = "block";
            tag = "block-out";
          }
          {
            type = "direct";
            tag = "direct-out";
          }
        ];
        route = {
          rules = [
            {
              protocol = "dns";
              outbound = "dns-out";
            }
            {
              protocol = "quic";
              outbound = "block-out";
            }
            {
              rule_set = ["geoip-cn" "geosite-geolocation-cn"];
              outbound = "direct-out";
            }
          ];
          rule_set = [
            {
              tag = "geoip-cn";
              format = "binary";
              type = "remote";
              url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
              download_detour = "proxy-out";
            }
            {
              tag = "geosite-geolocation-cn";
              format = "binary";
              type = "remote";
              url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-cn.srs";
              download_detour = "proxy-out";
            }
          ];
          final = "proxy-out";
          auto_detect_interface = true;
        };

        experimental = {
          cache_file = {
            enabled = true;
          };
        };
      };
    };
  };
}
