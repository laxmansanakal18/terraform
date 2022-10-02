data "azurerm_service_plan" "appservicepln" {
  name                = "#{appservicepln}#"
  resource_group_name = "#{resourcegroupname}#"
}

resource "azurerm_windows_web_app" "appsrcname" {
  name                  = "#{appsrcname}#"
  resource_group_name   = "#{resourcegroupname}#"
  location              = data.azurerm_service_plan.appservicepln.location
  service_plan_id       = data.azurerm_service_plan.appservicepln.id
  https_only            = true
  site_config { 
    always_on           = false                        #default true
    minimum_tls_version = "1.2"
  }

  tags = {
    environment = "#{env}#"
  }
  lifecycle {
    prevent_destroy = true
  }
}