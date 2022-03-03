# Clustered JBoss Quickstart

To complete this quickstart you will need an active Azure Subscription and the following tools installed on your machine: 

- Azure CLI
- Java 11
- Maven

If you do not have those tools installed locally, you can use the [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/quickstart) in your web browser.

1. Clone this repository

    ```bash
    git clone https://github.com/JasonFreeberg/clustered-jboss.git
    ```

2. Run the shell commands below to create a resource group and deploy the ARM template. The template will create a Virtual Network, App Service Plan, and JBoss EAP web app. The `WEBAPP_NAME` must be globally unique, so consider using your name or appending numbers to ensure it's unique.

    **Bash**

    ```bash
    WEBAPP_NAME=<provide a unique name>  # upper and lowercase letters, numbers, and dashes OK
    LOCATION=eastus
    RESOURCE_GROUP=jboss-rg
    az group create --name $RESOURCE_GROUP --location $LOCATION
    az deployment group create \
        --name jboss_deployment \
        --resource-group $RESOURCE_GROUP \
        --template-file arm-template.json \
        --parameters jboss_app_name=$WEBAPP_NAME
    ```

    **PowerShell**

    ```powershell
    $env:WEBAPP_NAME=''
    $env:LOCATION='westus'
    $env:RESOURCE_GROUP='jboss-rg'
    az group create --name $env:RESOURCE_GROUP --location $env:LOCATION
    az deployment group create `
        --name jboss_deployment `
        --resource-group $env:RESOURCE_GROUP `
        --template-file arm-template.json `
        --parameters jboss_app_name=$env:WEBAPP_NAME
    ```

    The App Service Plan is configured to have 3 JBoss EAP instances which will form the cluster.

3. Build the app with Maven.

    ```bash
    mvn clean package
    ```

4. Deploy the app using the Azure CLI.

    **Bash**

    ```bash
    az webapp deploy -n $WEBAPP_NAME -g $RESOURCE_GROUP --src-path target/session-replication.war --type war
    ```

    **PowerShell**

    ```PowerShell
    az webapp deploy -n $env:WEBAPP_NAME -g $env:RESOURCE_GROUP --src-path target/session-replication.war --type war
    ```

5. After a moment the web app will restart and initialize JBoss with the new application. Browse to the app at `http://<your-site-name>.azurewebsites.net/testHA.jsp`.

   The web page will display your session ID, the JBoss instance ID, and a simple counter. Increment the counter and refresh the web page. You should see a new JBoss EAP instance ID, but the counter will display the same session and counter information. This means that the stateful session information was shared between the first and second EAP instances, and even though you were routed to a different instance the session information was persisted across instances.

   ToDo: add pictures here of the pages (before & after)
