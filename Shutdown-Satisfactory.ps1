<#
  .SYNOPSIS
  Shutdown configured Satisfactory Dedicated server.

  .DESCRIPTION
  This script authenticates to the satisfactory server running on the configured address, then sends a POST request to shut down the server.

  .EXAMPLE
  Shutdown-Satisfactory.ps1
  
  .NOTES
  Version:        1.0
  Author:         Terrordrone
  Creation Date:  25-09-2024
  Powershell version 6.0 or higher REQUIRED.
  This script was written and tested with the 64-bit release of powershell 7.4.5 at https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.msi
  Using Windows 11.
  HTTPS API is based on a simple JSON schema used to pass data to the functions executing on the server, and pass the responses back to the caller.
  All Server API functions are always executed as POST requests, although certain query requests support being executed through the GET requests,
  provided that they do not require any data to be provided to them.
  See https://satisfactory.wiki.gg/wiki/Dedicated_servers/HTTPS_API for documentation
#>
#Requires -Version 6


#------Change these settings------
#Quatation marks "" are required.
#Server address including port.
#Example: "https://example.com:7777"
$ServerAddress = "https://Changeme.com:7777"
#Server admin password
#Leave Password empty if you want to be prompted everytime. If you choose to save your admin password in this file, only ever share it with trusted users.
#Example: "examplePassword"
$Password = ""

#------Do not change anything else beyond this point------


#Shared variables.
$Uri = "$ServerAddress" + '/api/v1/'
$ContentType = 'application/json'
$Method = 'POST'
if ($Password -eq ""){$Password = Read-Host "Enter administrator Password" -MaskInput}

#Body of the request used to gain an authenticationToken.
$Loginbody = @{
	"function" = "PasswordLogin"
	"data" = @{
		"minimumPrivilegeLevel" = "Administrator"
		"password" = "$Password"
	}
}

#Body of the request used to shut down the server.
$ShutdownBody = @{
	"function" = "Shutdown"
}

#Actual attempt to authenticate 
$LoginResponse = Invoke-WebRequest -uri $Uri -Method $Method -ContentType $ContentType -Body ($LoginBody|ConvertTo-Json) -SessionVariable 'Session' -SkipCertificateCheck
#Converting data inside the JSON response to a Powershell secure string.
$Token = ConvertFrom-Json $LoginResponse.content
$Token = ConvertTo-SecureString -AsPlainText -Force $Token.data.AuthenticationToken
#Actual attempt to shut down the server
$ShutdownResponse = Invoke-WebRequest -uri $Uri -Method $Method -ContentType $ContentType -Body ($ShutdownBody|ConvertTo-Json) -Authentication Bearer -Token $Token -SkipCertificateCheck