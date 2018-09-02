# vim: set ft=yaml:
version: '2'
services:
  sonarr:
    image: linuxserver/sonarr:${sonarr_version}
    restart: always
    labels:
      io.rancher.container.hostname_override: container_name
    ports:
      - 80:8989
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
  - downloads

networks:
  # use the default network driver for inter-container links
  private:

  sonarr_vlan:
    driver: macvlan
    # driver_opts:
    #   parent: ens160.30
    ipam:
      config:
        - subnet: 10.0.1.0/24
