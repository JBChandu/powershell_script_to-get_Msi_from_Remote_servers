$id= Get-Content <# path where u created your text file which contains ur userid or username #>
$getpassword= Get-Content <#path where u created text file which contains ur password(may be generated or password you set)#>
$username="domain\$id"
$pass=ConvertTo-SecureString "$getpassword" -AsPlainText -Force
$Credentials=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username,$pass

<# what we do below is for server hostname we give a meaningful servername so that csv files will be created based on meaningful name#>
$serverNames=@{
<#hostname/hostname with full fqdn/ip address =servername; #>
hostname1 = "namelessserver1";
hostname2 = "namelessserver2";
hostname3 ="namelessserver3";
}

$servers = Get-Content <#path where a text file consists of all seversname hostname/ip/full FQDN#>
foreach($server in $servers){
$outputServerName=$serverNames[$server]
Write-Host "processing $server"
$results= Get-WmiObject -ComputerName $server -Class Win32_Product -Namespace "root\cimv2" -Credential $Credentials | select __SERVER,Name,Version,InstallDate -ErrorAction SilentlyContinue
$results|Export-Csv -Path <#path where the results get stored as txt files in afolder Ex: "C:\user\results\$outputservername.txt" #> 
}


<#Connect to vpn whenever needed before executing the file because some servers needed established connection to connect to that zone #>