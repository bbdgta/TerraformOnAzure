#!/bin/bash

# Enable "exit immediately if any command fails"
set -e

RESOURCE_GROUP_NAME=bbdgt-learntf
STORAGE_ACCOUNT_NAME=bbdgt$RANDOM
CONTAINER_NAME=tfstate

echo "Logging in... (Ensure you have run 'az login')"

echo "Creating Resource Group: $RESOURCE_GROUP_NAME..."
az group create --name $RESOURCE_GROUP_NAME --location eastus

echo "Creating Storage Account: $STORAGE_ACCOUNT_NAME..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

echo "Creating Blob Container: $CONTAINER_NAME..."
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

echo "Success! Storage Account Name is: $STORAGE_ACCOUNT_NAME"