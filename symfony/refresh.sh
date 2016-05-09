#!/bin/bash
CONSOLE="/var/www/api/symfony/app/console"
BEHAT="/var/www/api/symfony/bin/behat"
cd /var/www/api/symfony && sudo composer self-update
cd /var/www/api/symfony && composer install --no-interaction
$CONSOLE cache:clear; $CONSOLE cache:clear --env=test
$CONSOLE doctrine:database:drop --force
$CONSOLE doctrine:database:create
$CONSOLE doctrine:migrations:migrate --no-interaction
$BEHAT --tags=@uat --out /dev/null
