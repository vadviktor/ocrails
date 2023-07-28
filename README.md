# README

## Generated with:

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

## For ActiveStorage:

```shell
sudo apt-get install libvips libvips-dev libvips-tools
```

## Docker

```shell
docker -H "ssh://rpi@192.168.1.222" build -t vadviktor.xyz/ocr-rails:1.0.0 -f Dockerfile .
```

```shell
docker \
  -H "ssh://rpi@192.168.1.222" \
  run \
  --detach \
  --name ocr-rails \
  --network rpi-services \
  -p 0.0.0.0:3000:3000/tcp \
  -e RAILS_MASTER_KEY="" \
  -e REDIS_URL="redis://redis:6379/1" \
  -e DATABASE_URL="postgres://dbuser:dbpassword@postgres:5432/OCRails_production" \
  vadviktor.xyz/ocr-rails:1.0.0 \
  bin/rails server
```

```shell
docker \
  -H "ssh://rpi@192.168.1.222" \
  run \
  --detach \
  --name ocr-sidekiq \
  --network rpi-services \
  -e RAILS_MASTER_KEY="" \
  -e REDIS_URL="redis://redis:6379/1" \
  -e DATABASE_URL="postgres://dbuser:dbpassword@postgres:5432/OCRails_production" \
  vadviktor.xyz/ocr-rails:1.0.0 \
  bin/sidekiq
```
