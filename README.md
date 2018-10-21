# Docker MediaWiki with VisualEditor

Docker image for [MediaWiki 1.31.1](https://www.mediawiki.org) with [VisualEditor](https://www.mediawiki.org/wiki/VisualEditor) plugin. The image is based on the [kristophjunge/mediawiki](https://hub.docker.com/r/kristophjunge/mediawiki/) image but has been simplified, and slightly updated so that it runs the latest MediaWiki release. 

## Features

- [MediaWiki](https://www.mediawiki.org) 1.31.1
- [Nginx](https://www.nginx.com)
- [PHP-FPM](https://php-fpm.org/) with [PHP7](https://www.mediawiki.org/wiki/Compatibility/de#PHP)
- [VisualEditor](https://www.mediawiki.org/wiki/VisualEditor) plugin
- [UserMerge](https://www.mediawiki.org/wiki/Extension:UserMerge) plugin
- [Parsoid](https://www.mediawiki.org/wiki/Parsoid) running on NodeJS v4.6.x LTS
- Imagick for thumbnail generation
- Intl for Unicode normalization
- APC as in memory PHP object cache
- Configured with [Short URLs](https://www.mediawiki.org/wiki/Manual:Short_URL)

## Usage

The image is to be used behind a proxy service like [Traefik](https://traefik.io/). It does not contain a `LocalSettings.php` configuration file and expects that this file is mounted as a separate volume. Consequently, it does not provide any environment variables for customization. A sample `LocalSettings.php` file is included.

A typical docker-compose file will look like the following: 

    mediawiki:
        image: timschroeder/mediawiki
        container_name: mediawiki
        depends_on:
          - mediawiki-db
        volumes:
          - /opt/mediawiki/LocalSettings.php:/var/www/mediawiki/LocalSettings.php
          - /opt/mediawiki/images:/var/www/mediawiki/images
        restart: always

Give permissions 999:999 to the volumes you mount inside the container. 

## Source

Source code is available on [GitHub](https://github.com/timschroedernet/docker-mediawiki). 

## License

The image is licensed under the MIT license. Please see the separate [license file](LICENSE) for details.