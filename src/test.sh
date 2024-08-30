storage_name="brk44012storage5f5039916"
foldername="contosodata"
storage_container_name=""
containers=$(az storage container list --account-name $storage_name --query "[].name" --output tsv)
for container in $containers
do
    if [[ $container == *"blobstore"* ]]; then
        storage_container_name=$container
    fi
done
echo $storage_container_name

az storage blob upload-batch --account-name $storage_name --destination $storage_container_name/$foldername --source "data"  > null


az ml datastore list
# 
az ml data list -w BRK440-1220-project --resource-group BRK440-1220_RG

az ml data create -w BRK440-1220-hub --resource-group BRK440-1220_RG -n test1 -p data

az ml data create -w BRK440-1220-project --resource-group BRK440-1220_RG -n test1 -p data


az ml index create -w BRK440-1220-project --resource-group BRK440-1220_RG --name test1  --path ./data



$(az search service show --name brk440-1220-aisearch --resource-group BRK440-1220_RG --query id --output tsv)