# Demo setup

- Setup AI Studio
- Deploy GTP4-o
- Add index with data


## Install Azure CLI
[Learn more](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

- curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az bicep install

## Setup AI Studio

- az login
- Select your subscription
- Check if your subscription is selected (az account show )
- az extension add --name ml



az group create --name aitour-bicep_RG --location eastus   
az ml workspace create --kind hub --resource-group aitour-789798_RG --name aitour-789798-hub
az ml workspace create --kind project --resource-group aitour-789798_RG --name aitour-789798-project --hub-id aitour-789798-hub



az cognitiveservices account deployment create \
--name aisdemolvrs \
--resource-group  aitour-bicep_RG \
--deployment-name gpt-4o \
--model-name gpt-4o \
--model-version "2024-05-13"  \
--model-format OpenAI \
--sku-capacity "1" \
--sku-name "Standard" \
--capacity 50



az ml connection create --file {connection.yml} --resource-group aitour-9092_RG --workspace-name  aitour-9092-hub

az cognitiveservices account show --name aitour-9092-aiservice --resource-group aitour-9092_RG --query id --output tsv  