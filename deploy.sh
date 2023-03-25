# FOR EACH OF THE FOLLOWING ASKS USE THE AZURE CLI
# 1. Create a resource group
# 2. Create an App Service Plan
# 3. Create an App Service with a python runtime and use github as a deployment source and use the dev branch and build the app
# 4. Build application during deployment
# 5. Set the configuration startup file to python app.py


# AUTOCOMPLETES FROM HERE (SET VARIABLES BY YOURSELF):
resourceGroupName="csu-nl-sr-asr-rg"
location="westeurope"
appServicePlanName="csu-nl-sr-asr-appserviceplan"
webAppName="csu-nl-sr-asr-webapp"
repoUrl="https://github.com/Sruinard/building-an-app-through-nlp"
branch="dev"

# 1. Create a resource group
az group create --name $resourceGroupName --location $location

# 2. Create an App Service Plan
az appservice plan create --name $appServicePlanName --resource-group $resourceGroupName --sku B1 --is-linux

# 3. Create an App Service with a python runtime
az webapp create --name $webAppName --resource-group $resourceGroupName --plan $appServicePlanName --runtime "PYTHON|3.7" --deployment-source-url $repoUrl --deployment-source-branch $branch

az webapp config set -n $webAppName --startup-file 'python app.py' --resource-group $resourceGroupName

az webapp config appsettings set -n $webAppName --settings "SCM_DO_BUILD_DURING_DEPLOYMENT=1" --resource-group $resourceGroupName

# 4. Build application during deployment


