#!/bin/bash  

prefix="BRK440"
location="swedencentral"

ai_resource_name="$prefix-$(shuf -i 1000-9999 -n 1)"
echo "Resource name: $ai_resource_name"  

#ai_resource_name ="BRK440-2516"

# Create the resource group
ai_resource_name_resource_group_name=$ai_resource_name"_RG"
echo "======================================="
echo "Creating resource group: $ai_resource_name_resource_group_name"
az group create --name $ai_resource_name_resource_group_name --location $location > null
echo "Resource group [$ai_resource_name_resource_group_name] created in [$location]"
echo "======================================="

# Create the Hub
ai_resource_name_hub_name=$ai_resource_name"-hub"
echo "======================================="
echo "Creating AI Studio Hub: $ai_resource_name_hub_name"
az ml workspace create --kind hub --resource-group $ai_resource_name_resource_group_name --name $ai_resource_name_hub_name > null
echo "AI Studio Hub [$ai_resource_name_hub_name] created in resource group [$ai_resource_name_resource_group_name]"
echo "======================================="

# Create project in Hub
hub_id=$(az ml workspace show  -g $ai_resource_name_resource_group_name --name $ai_resource_name_hub_name --query id --output tsv)
ai_resource_project_name=$ai_resource_name"-project"
echo "======================================="
echo "Creating AI Studio Project: $ai_resource_project_name"
az ml workspace create --kind project --resource-group $ai_resource_name_resource_group_name --name $ai_resource_project_name --hub-id $hub_id > null
echo "AI Studio Project [$ai_resource_project_name] created in resource group [$ai_resource_name_resource_group_name]"
echo "======================================="

# Create a Azure AI Service Account
ai_resource_ai_service=$ai_resource_name"-aiservice"
custom_domain_name=${ai_resource_name,,}
echo "======================================="
echo "Creating AI Service Account: $ai_resource_ai_service"
az cognitiveservices account create --kind AIServices --location $location --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --sku S0 --yes --custom-domain $custom_domain_name  > null
#az cognitiveservices account create --kind OpenAI --location $location --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --sku S0 --yes > null
echo "AI Service Account [$ai_resource_ai_service] created with custom domain [$custom_domain_name]"
echo "======================================="

# Deploying GPT-4o in Azure AI Service
echo "======================================="
#echo "Deploying GPT-4o"
# recommended config GPT-4o with 50 capacity
# az cognitiveservices account deployment create --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --deployment-name "gpt-4o" --model-name "gpt-4o" --model-version "2024-05-13" --model-format "OpenAI" --sku-capacity "1" --sku-name "Standard" --capacity "50" > null
# echo "GPT-4o deployment completed successfully"

# optional with GPT-4o-mini with 8 capacity
echo "Deploying GPT-4o-mini"
az cognitiveservices account deployment create --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --deployment-name "gpt-4o" --model-name "gpt-4o-mini" --model-version "2024-07-18" --model-format "OpenAI" --sku-capacity "1" --sku-name "Standard" --capacity "8" > null
echo "GPT-4o-mini deployment parameters:"
echo "Model Name: gpt-4o-mini"
echo "Model Version: 2024-07-18"
echo "Model Format: OpenAI"
echo "SKU Capacity: 1"
echo "SKU Name: Standard"
echo "Capacity: 8"
echo "GPT-4o-mini deployment completed successfully"
echo "======================================="

# Adding connection to the AI Hub
echo "======================================="
echo "Adding AI Service Connection to the HUB"
ai_service_resource_id=$(az cognitiveservices account show --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --query id --output tsv)
ai_service_api_key=$(az cognitiveservices account keys list --name $ai_resource_ai_service --resource-group $ai_resource_name_resource_group_name --query key1 --output tsv)
echo "AI Service Connection added to the HUB successfully"
echo "Previous step: Added AI Service Connection to the HUB"
echo "======================================="

echo "======================================="
rm connection.yml
echo "name: $ai_resource_ai_service" >> connection.yml  
echo "type: azure_ai_services" >> connection.yml  
echo "endpoint: https://$custom_domain_name.api.cognitive.microsoft.com/" >> connection.yml  
echo "api_key: $ai_service_api_key" >> connection.yml  
echo "ai_services_resource_id:  $ai_service_resource_id" >> connection.yml  
echo "======================================="

echo "======================================="
echo "Creating connection in the AI Hub using connection.yml"
az ml connection create --file connection.yml --resource-group $ai_resource_name_resource_group_name --workspace-name  $ai_resource_name_hub_name > null
rm connection.yml 
echo "Previous step: Created connection in the AI Hub using connection.yml"
echo "======================================="

# Security
echo "======================================="
echo "Disable storage SAS keys"
storage_resource_id=$(az ml workspace show --name $ai_resource_name_hub_name --resource-group $ai_resource_name_resource_group_name --query storage_account --output tsv)
storage_name=$(echo $storage_resource_id | awk -F'/' '{print $NF}') 
#az storage account update --name $storage_name --resource-group $ai_resource_name_resource_group_name --allow-shared-key-access false   > null
az storage account update --name $storage_name --resource-group $ai_resource_name_resource_group_name --min-tls-version TLS1_2  
echo "Previous steps completed successfully"
echo "Details of previous steps:"
echo "Resource Group: $ai_resource_name_resource_group_name"
echo "AI Studio Hub: $ai_resource_name_hub_name"
echo "AI Studio Project: $ai_resource_project_name"
echo "AI Service Account: $ai_resource_ai_service"
echo "Custom Domain: $custom_domain_name"
echo "Storage Account: $storage_name"
echo "======================================="

# AI Search
echo "======================================="
echo "Creating AI Search"
tmp_name=$ai_resource_name"-aisearch"
ai_resource_ai_search="${tmp_name,,}"
# creating AI Search service using Standard tier
az search service create --name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --sku Standard --partition-count 1 --replica-count 1
# uncomment previous line and uncomment below line to create AI Search service using Free tier
# az search service create --name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --sku Free --partition-count 1 --replica-count 1
echo "Previous steps completed successfully"
echo "Details of previous steps:"
echo "Resource Group: $ai_resource_name_resource_group_name"
echo "AI Studio Hub: $ai_resource_name_hub_name"
echo "AI Studio Project: $ai_resource_project_name"
echo "AI Service Account: $ai_resource_ai_service"
echo "Custom Domain: $custom_domain_name"
echo "Storage Account: $storage_name"
echo "======================================="

echo "======================================="
echo "Getting AI Search URL, Key and ID"
search_url="https://"$ai_resource_ai_search".search.windows.net"
search_key=$(az search admin-key show --service-name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --query primaryKey --output tsv)
search_id=$(az search service show --name $ai_resource_ai_search --resource-group $ai_resource_name_resource_group_name --query id --output tsv)
echo "Search URL: $search_url"
echo "Search Key: $search_key"
echo "Search ID: $search_id"
echo "======================================="

# delete connection_search.yml if exists
echo "======================================="
echo "Checking and deleting connection_search.yml if it exists"
if [ -f connection_search.yml ]; then
    rm connection_search.yml
fi
echo "name: $ai_resource_ai_search" >> connection_search.yml  
echo "type: azure_ai_search" >> connection_search.yml  
echo "endpoint: $search_url" >> connection_search.yml  
echo "api_key: $search_key" >> connection_search.yml  
# echo "ai_services_resource_id: $search_id" >> connection_search.yml
echo "======================================="

echo "======================================="
echo "Contents of connection_search.yml:"
cat connection_search.yml
echo "======================================="

echo "======================================="
echo "Creating AI Search connection in the AI Hub"
az ml connection create --file connection_search.yml --resource-group $ai_resource_name_resource_group_name --workspace-name $ai_resource_name_hub_name > null
rm connection_search.yml  
echo "======================================="

# Upload data to the storage
echo "======================================="
echo "Uploading data to the storage"
az ml data create -w $ai_resource_project_name --resource-group $ai_resource_name_resource_group_name -n ContosoProducts -p content-safety/data
echo "======================================="

# Create a index