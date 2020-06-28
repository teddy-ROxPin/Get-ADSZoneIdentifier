# Get-ADSZoneIdentifier
A PowerShell function that retrieves Alternate Data Stream information pertaining to when and from where a file was downloaded.

### Example 1 - Individual File
PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar\accesschk.exe

File              : C:\foo\bar\accesschk.exe\\
ZoneId            : 3\\
ReferrerUrl       : https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk \\
HostUrl           : https://live.sysinternals.com/accesschk.exe \\
CreationTimeUTC   : 6/28/2020 10:17:05 AM\\
LastAccessTimeUTC : 6/28/2020 10:17:05 AM\\
LastWriteTimeUTC  : 6/28/2020 10:17:05 AM\\

### Example 2 - All Files in a Directory
PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar\

File              : C:\foo\bar\accesschk.exe\\
ZoneId            : 3\\
ReferrerUrl       : https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk \\
HostUrl           : https://live.sysinternals.com/accesschk.exe \\
CreationTimeUTC   : 6/28/2020 10:17:05 AM\\
LastAccessTimeUTC : 6/28/2020 10:17:05 AM\\
LastWriteTimeUTC  : 6/28/2020 10:17:05 AM\\

File              : C:\foo\bar\autoruns.exe\\
ZoneId            : 3\\
ReferrerUrl       : https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns \\
HostUrl           : https://live.sysinternals.com/autoruns.exe \\
CreationTimeUTC   : 6/28/2020 10:16:50 AM\\
LastAccessTimeUTC : 6/28/2020 10:16:50 AM\\
LastWriteTimeUTC  : 6/28/2020 10:16:50 AM\\

File              : C:\foo\bar\Bginfo.exe\\
ZoneId            : 3\\
ReferrerUrl       : https://docs.microsoft.com/en-us/sysinternals/downloads/bginfo \\
HostUrl           : https://live.sysinternals.com/Bginfo.exe \\
CreationTimeUTC   : 6/28/2020 10:14:46 AM\\
LastAccessTimeUTC : 6/28/2020 10:14:46 AM\\
LastWriteTimeUTC  : 6/28/2020 10:14:46 AM\\

### Example 3 - Recursively
PS C:\> Get-ADSZoneIdentifier -Path C:\foo\bar\ -Recurse