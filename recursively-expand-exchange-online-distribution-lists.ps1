#https://agbo.blog/2021/02/18/get-distributiongroupmember-recursive/

## 1. write this file as a script file get-gmbr.ps1
function Get-GMBR{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        $Identity
    )
    Process{
        foreach ($Member in @(
                    try {
                        Get-DistributionGroupMember -Identity $Identity -ResultSize Unlimited -ErrorAction Stop
                    }
                    catch {
                        Get-DynamicDistributionGroupMember -Identity $Identity -ResultSize Unlimited
                    } 
                )
            ){
            switch ($Member) {
 
                {$_.RecipientType -notlike "*Group*"}{
                    $_
                }
                Default {
                    Get-GMBR -Identity $_.primarysmtpAddress
                }
            }
        }
    }
}

## 2. using it
import .\get-gmbr.ps1
#then you can import the function, feed emails into the function, sort then deduplicate, then export the table as csv
"group1@domain.com", "group2@domain.com" | Get-GMBR | Sort-Object Name | Get-Unique -asstring | select-object displayname, primarysmtpaddress | Export-Csv -Path C:\Members.csv -Encoding UTF8 -NoTypeInformation
