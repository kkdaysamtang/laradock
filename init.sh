#! /bin/bash

BASEDIR="$(cd "$(dirname "$0")"; pwd -P)"

cd "${BASEDIR}/nginx/sites"

echo -e "\n --- Create new be2-api-conf : Copy conf --- "

echo -e " --- Create new be2-api-conf : Replace server name --- "
cp -rf laravel.conf.example kkday-be2-api.tmp.conf
sed '1,/server_name laravel.test/s/server_name laravel.test/server_name be2api.docker.kkday.com/' kkday-be2-api.tmp.conf > kkday-be2-api.conf

echo -e " --- Create new be2-api-conf : Replace root --- "
mv -f kkday-be2-api.conf kkday-be2-api.tmp.conf
sed "1,/root \/var\/www\/laravel\/public/s/root \/var\/www\/laravel\/public/root \/var\/www\/kkday-be2-api\/public/" kkday-be2-api.tmp.conf > kkday-be2-api.conf

echo -e " --- Create new be2-api-conf : Replace access log --- "
mv -f kkday-be2-api.conf kkday-be2-api.tmp.conf
sed '1,/laravel_access.log/s/laravel_access.log/be2-api-access.log/' kkday-be2-api.tmp.conf > kkday-be2-api.conf

echo -e " --- Create new be2-api-conf : Replace access log --- "
mv -f kkday-be2-api.conf kkday-be2-api.tmp.conf
sed '1,/laravel_error.log/s/laravel_error.log/be2-api-error.log/' kkday-be2-api.tmp.conf > kkday-be2-api.conf

rm kkday-be2-api.tmp.conf

echo -e " --- Create new be2-api-conf : Done --- \n"

echo -e " --- Create new be2-ci-conf : Copy conf --- "
cp -rf laravel.conf.example kkday-be2-ci.tmp.conf

echo -e " --- Create new be2-ci-conf : Replace server name --- "
sed '1,/server_name laravel.test/s/server_name laravel.test/server_name be2.docker.kkday.com/' kkday-be2-ci.tmp.conf > kkday-be2-ci.conf

echo -e " --- Create new be2-ci-conf : Replace root --- "
mv -f kkday-be2-ci.conf kkday-be2-ci.tmp.conf
sed "1,/root \/var\/www\/laravel\/public/s/root \/var\/www\/laravel\/public/root \/var\/www\/kkday-be2-ci/" kkday-be2-ci.tmp.conf > kkday-be2-ci.conf

echo -e " --- Create new be2-ci-conf : Replace access log --- "
mv -f kkday-be2-ci.conf kkday-be2-ci.tmp.conf
sed '1,/laravel_access.log/s/laravel_access.log/be2-ci-access.log/' kkday-be2-ci.tmp.conf > kkday-be2-ci.conf

echo -e " --- Create new be2-ci-conf : Replace access log --- "
mv -f kkday-be2-ci.conf kkday-be2-ci.tmp.conf
sed '1,/laravel_error.log/s/laravel_error.log/be2-ci-error.log/' kkday-be2-ci.tmp.conf > kkday-be2-ci.conf

rm kkday-be2-ci.tmp.conf

echo -e " --- Create new be2-ci-conf : Done --- \n"

