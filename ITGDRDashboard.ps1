$Pages = New-UDPage -Name 'IT Glue Disaster Site' -Content {
    New-UDDynamic -Id 'DynOrgData' -Content { 
        New-UDGrid -Item -ExtraSmallSize 12 -Content {
            $OrgData = Import-Csv -Path $ITGBacPath
            $FormattedData = $OrgData.ForEach({
                    $Obj = [PSCustomObject]@{
                        OrgName   = $_.Name
                        OrgStatus = $_.organization_status
                        OrgType   = $_.organization_type
                        OrgID     = $_.ID
                    }
                    $Obj | Where-Object { $_.OrgType -eq "Customer" -and ($_.OrgStatus -eq "Contract Customer" -or $_.OrgStatus -eq "Active") }
                })
                $PassData = Import-Csv -Path $ITGBacPath
                $FormattedPassData = $PassData.ForEach({
                        $PassObj = [PSCustomObject]@{
                            PassOrgName = $_.organization
                            PassName    = $_.name
                            PassUname   = $_.username
                            Pass        = $_.password
                        }
                        $PassObj
                    })
            $Columns = @(
                New-UDTableColumn -Property OrgName -Title "Organization Name" -IncludeInSearch -DefaultSortColumn
                New-UDTableColumn -Property OrgID -Title "Organization ID" -IncludeInSearch
                New-UDTableColumn -Property OrgType -Title "Organization Type" -IncludeInSearch
                New-UDTableColumn -Property OrgStatus -Title "Organization Status" -IncludeInSearch
            )
            New-UDTable -Id 'OrgColumns' -Title "Organization Information" -Data $FormattedData -Columns $Columns -Paging -PageSize 20 -Dense -ShowSelection -HideToggleAllRowsSelected -DisableMultiSelect -ShowSearch
            New-UDButton -Text 'Load Data' -OnClick {
                Show-UDModal -Content {
                    $Item = ((Get-UDElement -Id 'OrgColumns').selectedrows).OrgName
                    $PassColumns = @(
                        New-UDTableColumn -Property PassOrgName -Title "Organization Name"
                        New-UDTableColumn -Property PassName -Title "Password Title" -IncludeInSearch
                        New-UDTableColumn -Property PassUname -Title "Username" -IncludeInSearch
                        New-UDTableColumn -Property Pass -Title "Password" -IncludeInSearch -Render {
                            New-UDButton -Id "btn$($EventData.Pass)" -Text "Click to Copy" -OnClick {
                                Set-UDClipboard -Data $($EventData.Pass) -toastOnSuccess -toastOnError
                            } 
                        }
                    )
                    New-UDTable -Id 'PassColumns' -Title "Password Information" -Data ($FormattedpassData | Where-Object {$_.PassOrgName -like $($Item)}) -Columns $passColumns -Paging -ShowSearch -PageSize 10 -Dense
                } -FullWidth -MaxWidth 'md'
            }
        }
    }
}

New-UDDashboard -Page $Pages
