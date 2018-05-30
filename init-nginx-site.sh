#! /bin/bash

BASEDIR="$(cd "$(dirname "$0")"; pwd -P)"

cd "${BASEDIR}/nginx/sites"

echo "Please enter your project name under /var/www(ex: kkday-be2-api, kkday-be2-ci, ...). Enter /exit to quit \n"
read -p "Project Name: " PROJ_NAME
if [[ "$PROJ_NAME" == "/exit" ]]; then
	exit 1;
fi

IS_INVALID_PROJ_TYPE=true

while [[ $IS_INVALID_PROJ_TYPE == true ]]; do
	echo "Please enter your project type(two options: laravel, ci). Enter /exit to quit \n"
	read -p "Project Type: " PROJ_TYPE
	case "$PROJ_TYPE" in
		laravel) ROOT_DIR="/public"; IS_INVALID_PROJ_TYPE=false;;
		ci) ROOT_DIR=""; IS_INVALID_PROJ_TYPE=false;;
		/exit) exit 0;;
		*) echo "Invalid project type, retry.";;
	esac
done

echo "Please enter your site name in /etc/hosts(ex: be2.docker.kkday.com, ...). Enter /exit to quit \n"
read -p "Site Name: " SITE_NAME
if [[ "$SITE_NAME" == "/exit" ]]; then
	exit 1
fi

TMP_CONF="${PROJ_NAME}.tmp.conf"
CONF="${PROJ_NAME}.conf"

echo "\n --- Create new ${PROJ_NAME}-conf : Copy conf --- "
echo " --- Create new ${PROJ_NAME}-conf : Replace server name --- "

cp -rf laravel.conf.example $TMP_CONF
sed "s|server_name laravel.test|server_name ${SITE_NAME}|" $TMP_CONF > $CONF

echo " --- Create new ${CONF} : Replace root --- "
mv -f $CONF $TMP_CONF
sed "s|root /var/www/laravel/public|root /var/www/${PROJ_NAME}${ROOT_DIR}|" $TMP_CONF > $CONF

echo " --- Create new ${CONF} : replace access log --- "
mv -f $CONF $TMP_CONF
sed "s|laravel_access.log|${PROJ_NAME}-access.log|" $TMP_CONF > $CONF

echo " --- Create new ${CONF} : replace error log --- "
mv -f $CONF $TMP_CONF
sed "s|laravel_error.log|${PROJ_NAME}-error.log|" $TMP_CONF > $CONF

rm $TMP_CONF

echo " --- Create new ${CONF} : Done --- \n"

