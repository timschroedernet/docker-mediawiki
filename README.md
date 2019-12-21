# Docker MediaWiki with VisualEditor

Docker image for [MediaWiki 1.34.0](https://www.mediawiki.org) with [VisualEditor](https://www.mediawiki.org/wiki/VisualEditor) plugin. The image is based on the [kristophjunge/mediawiki](https://hub.docker.com/r/kristophjunge/mediawiki/) image but has been simplified, and slightly updated, so that it runs the latest MediaWiki release. 

## Features

- [MediaWiki](https://www.mediawiki.org) 1.34.0
- [Nginx](https://www.nginx.com)
- [PHP-FPM](https://php-fpm.org/)
- [VisualEditor](https://www.mediawiki.org/wiki/VisualEditor) plugin
- [UserMerge](https://www.mediawiki.org/wiki/Extension:UserMerge) plugin
- [Parsoid](https://www.mediawiki.org/wiki/Parsoid) running on NodeJS
- Imagick for thumbnail generation
- Intl for Unicode normalization
- APC as in-memory PHP object cache
- Configured with [Short URLs](https://www.mediawiki.org/wiki/Manual:Short_URL)

## Usage

The image is to be used behind a proxy service like [Traefik](https://traefik.io/). It does not contain a `LocalSettings.php` configuration file and expects that this file is mounted as a separate volume. Consequently, it does not provide any environment variables for customization. A sample `LocalSettings.php` file is included.

A typical docker-compose file, in this case using Traefik, will look like the following: 

    mediawiki:
        image: timschroeder/mediawiki
        container_name: mediawiki
        depends_on:
          - mediawiki-db
        networks:
          - internal
          - proxy
        labels:
          - traefik.enable=true
          - traefik.backend=mediawiki
          - traefik.docker.network=proxy
          - traefik.port=8080
          - traefik.frontend.rule=Host:my.domain.com
        volumes:
          - /opt/mediawiki/LocalSettings.php:/var/www/mediawiki/LocalSettings.php
          - /opt/mediawiki/images:/var/www/mediawiki/images
        restart: always
        
    mediawiki-db:
        image: mysql
        container_name: mediawiki-db
        command: ["--default-authentication-plugin=mysql_native_password"]
        restart: unless-stopped
        ports:
          - "3308:3306"
        volumes:
          - /opt/mediawiki-db:/var/lib/mysql
        networks:
          - internal
        labels:
          - traefik.enable=false
     
    networks:
        proxy:
            external: true
        internal:
            external: false

Give permissions 999:999 to the volumes you mount inside the container. 

## License

The image is licensed under the MIT license. Please see the separate [license file](LICENSE) for details.
