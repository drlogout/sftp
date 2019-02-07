# drlogout/sftp

This container enables the user www-data to login via ssh to have write access to mounted volumes from e.g. a wordpress container.

```yml

version: '2'

volumes:
  db:
  wordpress:

services:
  db:
    image: mysql:5.7
    volumes:
      - "db:/var/lib/mysql"
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:5.0.2-apache
    volumes:
      - "wordpress:/var/www/html"
    links:
      - db
    ports:
      - "9009:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_PASSWORD: wordpress
  
  sftp:
    image: drlogout/sftp
    volumes:
      - "wordpress:/var/www/html/wordpress"
    ports:
      - "2222:22"

```

Login with user name `www-data` and password `www-data`.

