cp .env.example .env
echo Docker up
docker-compose up -d
echo Install
docker-compose exec php-fpm bash -c "composer install"
docker-compose exec php-fpm bash -c "chmod -R 777 storage"

