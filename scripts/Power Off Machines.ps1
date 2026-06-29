# Power Off Machines script
# ===============================
# AUTH
# ===============================
#$ProfileName = "CitrixAutomation"
#Get-XDAuthentication -ProfileName $ProfileName

# ===============================
# DELIVERY GROUPS (SAME LIST)
# ===============================
$DeliveryGroups = @(
    "Windows 11 Production\W11 - Ring 1 - Front Office",
    "Windows 11 Production\W11 - Ring 2 - Front Office",
    "Windows 11 Production\W11 - Ring 3 - Front Office",
    "Windows 11 Production\W11-IT-Tools",
    "Windows 11 Production\W11-Net-Tools",
    "Windows 11 Production\W11-TRAINING-DESKTOP",
    "Windows 11 Testing\Win 11 Persistent Test"
)

# ===============================
# LOGGING
# ===============================
$LogFile = "C:\Scripts\Logs\VDI-Night.log"

function Log {
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$time - $args" | Tee-Object -FilePath $LogFile -Append
}

# ===============================
# GET MACHINES
# ===============================
$vms = Get-BrokerMachine -MaxRecordCount 10000 | Where-Object {
    $DeliveryGroups -contains $_.DesktopGroupName
}

Log "Total machines: $($vms.Count)"

# ===============================
# REMOVE MAINTENANCE + POWER OFF
# ===============================
foreach ($vm in $vms) {

    # Remove maintenance FIRST
    if ($vm.InMaintenanceMode -eq $true) {
        Log "Maintenance OFF: $($vm.MachineName)"
        Set-BrokerMachine -MachineName $vm.MachineName -InMaintenanceMode $false | Out-Null
    }

    # Then power off
    if ($vm.PowerState -ne "Off") {
        Log "Power OFF: $($vm.MachineName)"
        New-BrokerHostingPowerAction -MachineUid $vm.MachineUid -Action TurnOff -ActualPriority 10 | Out-Null
    }
}

Log "Night script complete"
