#!/bin/bash
deploymentFolder=Deployment
[ ! -d $deploymentFolder ] && mkdir $deploymentFolder
rm -Rf $deploymentFolder/*
cp *.xml $deploymentFolder/

sed s/b2c-extensions-app-ClientId/b2c_extensions_app_ClientId/g appsettings.Development.json > $deploymentFolder/appsettings.json
cd $deploymentFolder
sed -i s/b2c-extensions-app-ObjectId/b2c_extensions_app_ObjectId/g appsettings.json


tenant=`jq -r .Environments[0].Tenant appsettings.json`
identityAppId=`jq -r .Environments[0].PolicySettings.IdentityExperienceFrameworkAppId appsettings.json`
proxyAppId=`jq -r .Environments[0].PolicySettings.ProxyIdentityExperienceFrameworkAppId appsettings.json`
b2cClientId=`jq -r '.Environments[0].PolicySettings.b2c_extensions_app_ClientId' appsettings.json`
b2cObjectId=`jq -r '.Environments[0].PolicySettings.b2c_extensions_app_ObjectId' appsettings.json`
echo $b2cClientId

sed -i s/\{Settings:Tenant\}/$tenant/ *.xml
sed -i s/\{Settings:IdentityExperienceFrameworkAppId\}/$identityAppId/g *.xml 
sed -i s/\{Settings:ProxyIdentityExperienceFrameworkAppId\}/$proxyAppId/g *.xml 
sed -i s/\{Settings:b2c-extensions-app-ClientId\}/$b2cClientId/g *.xml 
sed -i s/\{Settings:b2c-extensions-app-ObjectId\}/$b2cObjectId/g *.xml
sed -i s/\{Settings:FacebookAppId\}/71263/g *.xml
sed -i s/\{Settings:GoogleAppId\}/123123/g *.xml
sed -i s/\{Settings:FacebookAppId\}//g *.xml
sed -i s/\{Settings:FacebookAppId\}//g *.xml
sed -i s/\{Settings:FacebookAppId\}//g *.xml


