#!/bin/bash  

prefix="aitour"

ai_resource_name="$prefix-$(shuf -i 1000-9999 -n 1)"

#ai_resource_name="aitour-9092"

echo "Resource name: $ai_resource_name"  

# Create the resource group
ai_resource_name_resource_group_name=$ai_resource_name"_RG"
echo "Creating resource group: $ai_resource_name_resource_group_name"
az group create --name $ai_resource_name_resource_group_name --location eastus > null

# Create the Hub
ai_resource_name_hub_name=$ai_resource_name"-hub"
echo "Creating AI Studio Hub: $ai_resource_name_hub_name"
az ml workspace create --kind hub --resource-group $ai_resource_name_resource_group_name --name $ai_resource_name_hub_name > null

# Create a Azure AI Service Account
ai_resource_ai_service=$ai_resource_name"-aiservice"
echo "Creating AI Service Account: $ai_resource_ai_service"
az cognitiveservices account create --kind AIServices --location eastus --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --sku S0 --yes > null

# Deploying GPT-4o in Azure AI Service
echo "Deploying GPT-4o"
az cognitiveservices account deployment create --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --deployment-name "gpt-4o" --model-name "gpt-4o" --model-version "2024-05-13" --model-format "OpenAI" --sku-capacity "1" --sku-name "Standard" --capacity "50" > null

# Adding connection to the AI Hub
echo "Adding AI Service Connection to the HUB"
ai_service_resource_id=$(az cognitiveservices account show --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --query id --output tsv)

rm connection.yml   
echo "name: $ai_resource_name_hub_name" >> connection.yml  
echo "type: azure_ai_services" >> connection.yml  
echo "endpoint: https://eastus.api.cognitive.microsoft.com/" >> connection.yml  
echo "ai_services_resource_id:  $ai_service_resource_id" >> connection.yml  

az ml connection create --file connection.yml --resource-group $ai_resource_name_resource_group_name --workspace-name  $ai_resource_name_hub_name > null