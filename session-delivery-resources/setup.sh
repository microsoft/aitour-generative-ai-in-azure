#!/bin/bash  

prefix="BRK440"
location="swedencentral"

ai_resource_name="$prefix-$(shuf -i 1000-9999 -n 1)"
echo "Resource name: $ai_resource_name"  

#ai_resource_name ="BRK440-2516"

# Create the resource group
ai_resource_name_resource_group_name=$ai_resource_name"_RG"
echo "Creating resource group: $ai_resource_name_resource_group_name"
az group create --name $ai_resource_name_resource_group_name --location $location > null

# Create the Hub
ai_resource_name_hub_name=$ai_resource_name"-hub"
echo "Creating AI Studio Hub: $ai_resource_name_hub_name"
az ml workspace create --kind hub --resource-group $ai_resource_name_resource_group_name --name $ai_resource_name_hub_name > null

# Create project in Hub
hub_id=$(az ml workspace show  -g $ai_resource_name_resource_group_name --name $ai_resource_name_hub_name --query id --output tsv)
ai_resource_project_name=$ai_resource_name"-project"
echo "Creating AI Studio Project: $ai_resource_project_name"
az ml workspace create --kind project --resource-group $ai_resource_name_resource_group_name --name $ai_resource_project_name --hub-id $hub_id > null

# Create a Azure AI Service Account
ai_resource_ai_service=$ai_resource_name"-aiservice"
custom_domain_name=${ai_resource_name,,}
echo "Creating AI Service Account: $ai_resource_ai_service"
az cognitiveservices account create --kind AIServices --location $location --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --sku S0 --yes --custom-domain $custom_domain_name  > null
#az cognitiveservices account create --kind OpenAI --location $location --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --sku S0 --yes > null

# Deploying GPT-4o in Azure AI Service
echo "Deploying GPT-4o"
az cognitiveservices account deployment create --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --deployment-name "gpt-4o" --model-name "gpt-4o" --model-version "2024-05-13" --model-format "OpenAI" --sku-capacity "1" --sku-name "Standard" --capacity "50" > null

# Adding connection to the AI Hub
echo "Adding AI Service Connection to the HUB"
ai_service_resource_id=$(az cognitiveservices account show --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --query id --output tsv)
ai_service_api_key=$(az cognitiveservices account keys list --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --query key1 --output tsv)

rm connection.yml   
echo "name: $ai_resource_ai_service" >> connection.yml  
echo "type: azure_ai_services" >> connection.yml  
echo "endpoint: https://$custom_domain_name.api.cognitive.microsoft.com/" >> connection.yml  
echo "api_key: $ai_service_api_key" >> connection.yml  
echo "ai_services_resource_id:  $ai_service_resource_id" >> connection.yml  

az ml connection create --file connection.yml --resource-group $ai_resource_name_resource_group_name --workspace-name  $ai_resource_name_hub_name > null
rm connection.yml 

# Security
echo "Disable storage SAS keys"
storage_resource_id=$(az ml workspace show --name $ai_resource_name_hub_name --resource-group $ai_resource_name_resource_group_name --query storage_account --output tsv)
storage_name=$(echo $storage_resource_id | awk -F'/' '{print $NF}') 
#az storage account update --name $storage_name --resource-group $ai_resource_name_resource_group_name --allow-shared-key-access false   > null
az storage account update --name $storage_name --resource-group $ai_resource_name_resource_group_name --min-tls-version TLS1_2  

# AI Search
tmp_name=$ai_resource_name"-aisearch"
ai_resource_ai_search="${tmp_name,,}"
az search service create --name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --sku Free --partition-count 1 --replica-count 1

search_url="https://"$ai_resource_ai_search".search.windows.net"
search_key=$(az search admin-key show --service-name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --query primaryKey --output tsv)
search_id=$(az search service show --name brk440-1220-aisearch --resource-group BRK440-1220_RG --query id --output tsv)

rm connection_search.yml   
echo "name: $ai_resource_ai_search" >> connection_search.yml  
echo "type: azure_ai_search" >> connection_search.yml  
echo "endpoint: $search_url" >> connection_search.yml  
echo "api_key: $search_key" >> connection_search.yml  
echo "ResourceIdL: $search_id" >> connection_search.yml

az ml connection create --file connection_search.yml --resource-group $ai_resource_name_resource_group_name --workspace-name  $ai_resource_name_hub_name > null
rm connection_search.yml  

# Upload data to the storage
az ml data create -w $ai_resource_project_name --resource-group $ai_resource_name_resource_group_name -n ContosoProducts -p content-safety/data

# Create a index