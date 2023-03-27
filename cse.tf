resource "azurerm_virtual_machine_extension" "python" {
  name                 = "installPython"
  virtual_machine_id   = azurerm_windows_virtual_machine.main.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/yury-dubinin/tf-vm-deployment/main/install-python.ps1"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file install-python.ps1 -EnableCredSSP -DisableBasicAuth"
    }
SETTINGS
}