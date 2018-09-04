# vim: set ft=yaml:
version: '2'
services:
  sonarr:
    image: linuxserver/sonarr:${sonarr_version}
    restart: always
    networks:
      - private
      - sonarr_vlan
    # labels:
    #   io.rancher.container.hostname_override: container_name
    # ports:
    #   - 8989:8989
    environment:
      - TZ=${timezone}
    networks:
      - sonarr_vlan
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ${config_path}:/config
      - ${tv_path}:/tv
      - downloads:/downloads

volumes:
  downloads:

networks:
  # use the default network driver for inter-container links
  private:

  sonarr_vlan:
    driver: macvlan
    driver_opts:
      parent: eth0
    ipam:
      config:
        - subnet: 10.0.0.0/24
          gateway: 10.0.0.1
          ip_range: 10.0.0.112/28 # IP from this pool are assigned automatically
