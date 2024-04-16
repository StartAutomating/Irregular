FROM mcr.microsoft.com/powershell
ARG ModuleName=Irregular
COPY . ./usr/local/share/powershell/Modules/$ModuleName
RUN pwsh -c "New-Item -Path /root/.config/powershell/Microsoft.PowerShell_profile.ps1 -Value 'Import-Module $ModuleName' -Force"
