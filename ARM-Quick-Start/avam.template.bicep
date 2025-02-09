
param location string = resourceGroup().location

@description('The name of the AVAM resource')
param accountName string

@description('The managed identity Resource Id used to grant access to the Azure Media Service (AMS) account')
param managedIdentityResourceId string

@description('The media Service Account Id. The Account needs to be created prior to the creation of this template')
param mediaServiceAccountResourceId string 

@description('The AVAM Template')
resource avamAccount 'Microsoft.VideoIndexer/accounts@2021-11-10-preview' = {
  name: accountName
  location: location
  identity:{
    type: 'UserAssigned'
    userAssignedIdentities : {
      '${managedIdentityResourceId}' : {}
    }
  }
  properties: {
    mediaServices: {
      resourceId: mediaServiceAccountResourceId
      userAssignedIdentity: managedIdentityResourceId
    }
  }
}
