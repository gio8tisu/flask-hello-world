terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "22aa365c-c2a1-4686-a124-fb8f5a27d1f2"
}

resource "azurerm_resource_group" "rg" {
  name     = "FlaskHelloWorld-resources"
  location = "North Europe"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "hello-world-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "as" {
  name                = "hello-world-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    app_command_line = "gunicorn hello"
    linux_fx_version = "DOCKER|gio8tisu/flask-helloworld:latest"
  }

  app_settings = {
    "PORT" = "80"
  }
}
