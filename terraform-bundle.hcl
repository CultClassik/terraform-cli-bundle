terraform {
  # Version of Terraform to include in the bundle. An exact version number
  # is required.
  version = "0.12.19"
}

# Define which provider plugins are to be included
providers {
  # Standard Terraform providers to include in the bundle
  vsphere = ["1.14.0"]
  azurerm = ["1.28.0"]
  bigip = ["1.1.1"]

  # Include a custom plugin to the bundle. Will search for the plugin in the
  # plugins directory, and package it with the bundle archive. Plugin must have
  # a name of the form: terraform-provider-*, and must be build with the operating
  # system and architecture that terraform enterprise is running, e.g. linux and amd64
  infoblox = ["1.0.1"]
}
