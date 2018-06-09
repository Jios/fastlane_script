#!/bin/bash

##
# fastlane + Apple enterprise account
# This script creates Bundle_ID with push notifications, pem file and upload to git
##
# account: appleAccount@email.com
# team ID: xxxxxxxxxx
# SKU....: 0123456789
# output.: output_pem
# git URL: ssh://git@github.com:Jios/fastlane_script.git
##



# variables
USER_NAME=appleAccount@email.com
SKU=0123456789
TEAM_ID=xxxxxxxxxx

OUTPUT_PEM=output_pem

# git url from stash
GITURL=ssh://git@github.com:Jios/fastlane_script.git


while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "bash app_store_bundle_ID.sh -b com.company.appname.jenkins -a AppName"
    exit 0
    ;;
    -b|--bundleid)
    BUNDLEID=$2
    shift
    ;;
    -a|--app_name)
    APP_NAME=$2
    shift
    ;;
    -g|--git_url)
    GITURL=$2
    shift
    ;;
    -u|--username)
    GITURL=$2
    shift
    ;;
    --development)
    PEM_TYPE="--development"
    MATCH_TYPE=development
    MATCH_FORCE=""
    shift
    ;;
    --appstore)
    PEM_TYPE=""
    MATCH_TYPE=appstore
    shift
    ;;
esac
shift
done


echo "Bundle ID: $BUNDLEID"
echo "App name : $APP_NAME"

# validate bundle ID and app name
if [ -z "$BUNDLEID" ]; then
	echo "Error: Bundle ID cannot be empty"
	exit 1
fi

if [ -z "$APP_NAME" ]; then
	echo "Error: App name cannot be empty"
	exit 1
fi

if [ -z "$PEM_TYPE" ]; then
	PEM_TYPE=""
fi

if [ -z "$MATCH_TYPE" ]; then
	MATCH_TYPE=appstore
fi


###
# fastlane commands

# create bundle ID with app name and push notifications enabled
fastlane produce --username $USER_NAME --app_identifier $BUNDLEID --app_name $APP_NAME --sku $SKU --skip_itc --team_id $TEAM_ID
fastlane produce enable_services --push-notification --username $USER_NAME --app_identifier $BUNDLEID --team_id $TEAM_ID

# create pem file
fastlane pem --username $USER_NAME --team_id $TEAM_ID --app_identifier $BUNDLEID --output_path $OUTPUT_PEM $PEM_TYPE

# upload provisioning profile to git.  Types: enterprise, development, adhoc or appstore
fastlane match $MATCH_TYPE --git_url $GITURL --app_identifier $BUNDLEID --username $USER_NAME --team_id $TEAM_ID
# fastlane match appstore --git_url ssh://git@github.com:Jios/fastlane_script.git --app_identifier com.company.bosma.testflight --username appleAccount@email.com

exit 0
