# Install Chocolatey
if (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}

# Install MySQL, Git, Terraform and Azure CLI using Chocolatey
choco install mysql git terraform azure-cli -y
