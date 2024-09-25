Scripts to manage the Satisfactory Dedicated server via Powershell.
Mainly for personal use and to serve as an example for anyone that wants it.

The in-game console is only really used to restart the server, but whenever there is a version mismatch between the server and client the console stops functioning.
I'm sharing these scripts to serve as examples for anyone looking to do something similar. The scripts NEED to be edited to change the server address and optionally store your admin password. I DO NOT recommend storing your password in these files.
There is 0 error handling or output.
Powershell 6.0 or higher is required, unless you have a valid and trusted certificate installed on the server. If you do have a certificate, the scripts ''should'' work just fine on any Powershell version after removing any instances of "-SkipCertificateCheck"
Actually running the scripts boils down to opening a Powershell terminal and issuing "C:\Path\To\Shutdown-Satisfactory.ps1 -Executionpolicy bypass"
Shutdown-Satisfactory.ps1 will connect to the server, authenticate and then issue a shutdown. Assuming you've got a script running that updates and then restarts the server, any user with the script and your admin password can update or restart your server on-demand.
https://github.com/terrordrone5nl/Satisfactory-HTTPS-API-Powershell/blob/master/Shutdown-Satisfactory.ps1

Because everyone on my server loves the interactive map I've automated the fetching of Savefiles to upload to the interactive map.
Download-Satisfactory.ps1 boils down to the following steps;
  1. Authenticate
  2. remove the existing savefile called DownloadSave (Will error silently if this file doesn't exist, does not impact the rest of the script)
  3. create a new savefile called DownloadSave
  4. download DownloadSave to whatever directory is configured as the default download directory for the user. The file will be named DownloadSave.sav
https://github.com/terrordrone5nl/Satisfactory-HTTPS-API-Powershell/blob/master/Download-Satisfactory.ps1
