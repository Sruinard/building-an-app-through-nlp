# FOR EACH OF THE FOLLOWING ASKS USE THE AZURE CLI
# 1. Create a resource group
# 2. Create an App Service Plan
# 3. Create an App Service with a python runtime and use github as a deployment source and use the dev branch and build the app
# 4. Build application during deployment using SCM_DO_BUILD_DURING_DEPLOYMENT=true
# 5. Set the configuration startup file to use gunicorn


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

# 4. Build application during deployment using SCM_DO_BUILD_DURING_DEPLOYMENT=true
az webapp config appsettings set --name $webAppName --resource-group $resourceGroupName --settings SCM_DO_BUILD_DURING_DEPLOYMENT=true

# 5. Set the configuration startup file to use gunicorn
az webapp config set --startup-file "gunicorn --bind='0.0.0.0' --timeout 600 app:app" --name $webAppName --resource-group $resourceGroupName



