function Get-ADSZoneIdentifier{
<#
.SYNOPSIS
A PowerShell function that retrieves Alternate Data Stream information pertaining to when and from where a file was downloaded.
.DESCRIPTION
A PowerShell function that retrieves Alternate Data Stream information pertaining to when and from where a file was downloaded. You can provide a path to a specific file or a directory. With a directory you can also use -Recurse. Output will contain the full filename, Zone ID, Referral URL, Host URL, as well as the Creation, Last Access, and Last Write times.
.PARAMETER Path
Specifies a path to a file or directory.
.PARAMETER Recurse
Indicates that this cmdlet retrieves Alternate Data Stream information for files recursively.
.EXAMPLE
PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar\accesschk.exe

File              : C:\foo\bar\accesschk.exe
ZoneId            : 3
ReferrerUrl       : https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk
HostUrl           : https://live.sysinternals.com/accesschk.exe
CreationTimeUTC   : 6/28/2020 10:17:05 AM
LastAccessTimeUTC : 6/28/2020 10:17:05 AM
LastWriteTimeUTC  : 6/28/2020 10:17:05 AM

-------------------------- EXAMPLE 2 --------------------------

PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar

Will retrieve the ADS information for each file in the specified directory.

-------------------------- EXAMPLE 3 --------------------------

PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar -Recurse

Will retrieve the ADS information for each file in the specified folder recursively.
#>    
    param (
        [Parameter(Mandatory=$true,Position=0)]$Path,
        [Parameter(ParameterSetName='Recurse')][switch]$Recurse
    )

    if($Recurse){$files = Get-ChildItem -Path $Path -Recurse -File}
    else{$files = Get-ChildItem -Path $Path -File}

    foreach($file in $files){

        try {                  
            Get-Item -Path $($file.FullName) -Stream Zone.Identifier -ErrorAction Stop | Out-Null
            $content = Get-Content -Path $($file.FullName) -Stream Zone.Identifier
            $zone_id = $content[1] -replace "ZoneId=", ""

            if($content[2] -like "ReferrerUrl=*"){
                $referrer_url = $content[2] -replace "ReferrerUrl=", ""
            }
            elseif($content[2] -like "HostUrl=*"){
                $host_url = $content[2] -replace "HostUrl=", ""
                $referrer_url = ""
            }

            if($content[3] -like "HostUrl=*"){
                $host_url = $content[3] -replace "HostUrl=", ""
            }

            $obj=[PSCustomObject]@{
                File = $file.FullName
                ZoneId = $zone_id
                ReferrerUrl = $referrer_url
                HostUrl = $host_url
                CreationTimeUTC = $file.CreationTimeUtc
                LastAccessTimeUTC = $file.LastAccessTimeUtc
                LastWriteTimeUTC = $file.LastWriteTimeUtc
            }
            $obj

        }
        catch {}
    

    }
}