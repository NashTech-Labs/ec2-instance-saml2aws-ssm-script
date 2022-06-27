#!/bin/bash

HOST=$1

case $HOST in
	testing)
		PROFILE="testing"
		INSTANCE=""
		CONTROLLER="Connecting to testing node"
		;;
	dev)
    	PROFILE="dev"
		INSTANCE=""
		CONTROLLER="Connecting to dev node"
		;;
	staging)
		PROFILE="staging"
		INSTANCE=""
		CONTROLLER="Connecting to staging node"
		;;
	production)
		PROFILE="production"
		INSTANCE=""
		CONTROLLER="Connecting to production node"
		;;
	*)
		echo "Invalid Host"
		;;
esac

sed '/'$PROFILE'/,+7 d' ~/.aws/credentials > ~/.aws/credentials_new && mv ~/.aws/credentials_new ~/.aws/credentials
echo "Connecting to $CONTROLLER"
aws --profile $PROFILE ssm start-session --target $INSTANCE