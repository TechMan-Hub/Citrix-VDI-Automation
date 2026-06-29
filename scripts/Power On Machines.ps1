# ===============================
# AUTH
# ===============================
#$ProfileName = "CitrixAutomation"
#Get-XDAuthentication -ProfileName $ProfileName

# ===============================
# DELIVERY GROUPS (FINAL)
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
$LogFile = "C:\Scripts\Logs\VDI-Morning.log"

function Log {
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$time - $args" | Tee-Object -FilePath $LogFile -Append
}

# ===============================
# RETRY CONFIG
# ===============================
$RetryDelaySeconds = 600
$MaxRetries = 2

# ===============================
# GET MACHINES
# ===============================
$allMachines = Get-BrokerMachine -MaxRecordCount 10000 | Where-Object {
    $DeliveryGroups -contains $_.DesktopGroupName
}

$unassigned = $allMachines | Where-Object { $_.IsAssigned -eq $false }
$assigned   = $allMachines | Where-Object { $_.IsAssigned -eq $true }

Log "Unassigned count: $($unassigned.Count)"
Log "Assigned count: $($assigned.Count)"

# ===============================
# UNASSIGNED → MAINTENANCE + ON
# ===============================
foreach ($vm in $unassigned) {

    if ($vm.InMaintenanceMode -ne $true) {
        Log "Maintenance ON: $($vm.MachineName)"
        Set-BrokerMachine -MachineName $vm.MachineName -InMaintenanceMode $true | Out-Null
    }

    if ($vm.PowerState -ne "On") {
        Log "Power ON (unassigned): $($vm.MachineName)"
        New-BrokerHostingPowerAction -MachineUid $vm.MachineUid -Action TurnOn -ActualPriority 10 | Out-Null
    }
}

# ===============================
# ASSIGNED → POWER ON ONLY
# ===============================
foreach ($vm in $assigned) {

    if ($vm.PowerState -ne "On") {
        Log "Power ON (assigned): $($vm.MachineName)"
        New-BrokerHostingPowerAction -MachineUid $vm.MachineUid -Action TurnOn -ActualPriority 10 | Out-Null
    }
}

Log "Initial pass complete"

# ===============================
# RETRY LOOP
# ===============================
for ($i = 1; $i -le $MaxRetries; $i++) {

    Start-Sleep -Seconds $RetryDelaySeconds

    $current = Get-BrokerMachine -MaxRecordCount 10000 | Where-Object {
        $DeliveryGroups -contains $_.DesktopGroupName
    }

    $stillOff = $current | Where-Object { $_.PowerState -ne "On" }

    Log "Retry $i - still off: $($stillOff.Count)"

    foreach ($vm in $stillOff) {

        if ($vm.IsAssigned -eq $false -and $vm.InMaintenanceMode -ne $true) {
            Log "Maintenance ON retry: $($vm.MachineName)"
            Set-BrokerMachine -MachineName $vm.MachineName -InMaintenanceMode $true | Out-Null
        }

        Log "Retry power ON: $($vm.MachineName)"
        New-BrokerHostingPowerAction -MachineUid $vm.MachineUid -Action TurnOn -ActualPriority 10 | Out-Null
    }
}

Log "Morning script complete"
