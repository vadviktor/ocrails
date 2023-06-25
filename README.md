# README

Generated with:

```
rails new OCRails \
--database=postgresql \
--skip-action-mailer \
--skip-action-mailbox \
--skip-action-text \
--skip-action-cable \
--skip-spring \
--skip-turbolinks \
--skip-bootsnap \
--skip-webpack-install \
--skip-hotwire \
--skip-bundle
```

For ActiveStorage:

```shell
sudo apt-get install libvips libvips-dev libvips-tools libjpeg-turbo8-dev
```

For HTTPS:

```shell    
$> openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt
$> rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
```
