# vim: set ft=yaml:
version: '2'
services:
  plex:
    container_name: plex
      image: plexinc/pms-docker
      restart: always
      labels:
        io.rancher.container.hostname_override: container_name
      ports:
        - 32400:32400/tcp
        - 3005:3005/tcp
        - 8324:8324/tcp
        - 32469:32469/tcp
        - 1900:1900/udp
        - 32410:32410/udp
        - 32412:32412/udp
        - 32413:32413/udp
        - 32414:32414/udp
      environment:
        - TZ=${timezone}
        - PLEX_CLAIM=${claim_token}
        - ADVERTISE_IP=http://<hostIPAddress>:32400/
        - CHANGE_CONFIG_DIR_OWNERSHIP=false
      # networks:
      #   physical:
      #     ipv4_address: <ipAddress>
      # hostname: <hostname>
      volumes:
        - ${config_path}:/config
        - ${transcode_path}:/transcode
        - ${media_path}:/data
