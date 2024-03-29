function Baseline
{
    echo "Running Script"
    echo "
██████╗  █████╗ ███████╗███████╗██╗     ██╗███╗   ██╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔════╝██║     ██║████╗  ██║██╔════╝
██████╔╝███████║███████╗█████╗  ██║     ██║██╔██╗ ██║█████╗  
██╔══██╗██╔══██║╚════██║██╔══╝  ██║     ██║██║╚██╗██║██╔══╝  
██████╔╝██║  ██║███████║███████╗███████╗██║██║ ╚████║███████╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝"
    echo "By Jones"
    echo "_______________________________________________________________________________________________________"

    ###----- Date and Time Stamp -----###
    $DateTime= Get-Date

    ###----- Current Logged in user and Enabled Accounts -----###
    $LoggedInUser= (Get-ChildItem Env:\USERNAME).Value
    $EnabledAccounts= Get-LocalUser

    ###----- File Comparison Parameters ------###
    $Scan1= Get-ChildItem -Recurse -path "C:\Users\$LoggedInUser\BaseLine\Scan1\"
    $Scan2= Get-ChildItem  -Recurse -path "C:\Users\$LoggedInUser\BaseLine\Scan2\"

    ###----- Parameters -----###
    $Params= $DateTime, $Tree, $ComputerInfo, $Processes, $Users, $SystemLogs, $SecurityLogs, $OpenConnections, $RunningServices
    $Params2= $DateTime, $Tree2, $ComputerInfo2, $Processes2, $Users2, $SystemLogs2, $SecurityLogs2, $OpenConnections2, $RunningServices2

    ###----- Initial Scan Parameter Output - Files -----###
    $Tree= Tree /f | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\Tree.txt"
    $ComputerInfo= Get-ComputerInfo | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\ComputerInfo.txt"
    Write-Output (Get-Date) | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\Processes.txt" ; Get-Process | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\Processes.txt" -Append
    $Users= Get-LocalUser | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\Users.txt"
    $SystemLogs= Get-EventLog -LogName System -Newest 125 | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\SystemLogs.txt"
    $SecurityLogs= Get-EventLog -LogName Security -Newest 125 | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\SecurityLogs.txt"
    Netstat -an | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\OpenConnections.txt"
    Get-Service | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan1\RunningServices.txt"

    ###----- Post-Scan Parameter Output(Denoted by the number 2) - Files -----###
    $Tree2= Tree /f | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\Tree2.txt"
    $ComputerInfo2= Get-ComputerInfo | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\ComputerInfo2.txt"
    Get-Process | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\Processes2.txt"
    Get-LocalUser | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\Users2.txt"
    Get-EventLog -LogName System -Newest 125 | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\SystemLogs2.txt"
    Get-EventLog -LogName Security -Newest 125 | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\SecurityLogs2.txt"
    Netstat -an | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\OpenConnections2.txt"
    Get-Service | Out-File "C:\Users\$LoggedInUser\BaseLine\Scan2\RunningServices2.txt"

    ###----- Initial Scan and File Creation -----###
    if ((Test-Path -Path "C:\Users\$LoggedInUser\Baseline") -eq $false){ MD "C:\Users\$LoggedInUser\Baseline" } ;
    if ((Test-Path -Path "C:\Users\$LoggedInUser\Baseline\Scan1") -eq $false){ MD "C:\Users\$LoggedInUser\Baseline\Scan1" } ;
    if ((Test-Path -Path "C:\Users\$LoggedInUser\Baseline\Scan2") -eq $false){ MD "C:\Users\$LoggedInUser\Baseline\Scan2" } ;
    Start-Sleep 5
    $Params

    ###----- Post-Scan and Prompt -----###
    $Confirmation= Read-Host "Are you ready to start the Post-Scan?(Y/N)"
    if (($Confirmation -eq 'Y')) {echo "Starting Post-Scan.." ; $Params2}
    else {Echo "Initial Baseline Scan Complete, Post-Scan not Initiated"}
    Start-Sleep 3

    ### ----- File Comparison Prompt ----- ###
    Get-Date | Out-File "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\Tree.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\Tree2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\ComputerInfo.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\ComputerInfo2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\Processes.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\Processes2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\Users.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\Users2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\SystemLogs.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\SystemLogs2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\SecurityLogs.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\SecurityLogs2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\OpenConnections.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\OpenConnections2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"
    Compare-Object -ReferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan1\RunningServices.txt") -DifferenceObject (Get-Content "C:\Users\$LoggedInUser\BaseLine\Scan2\RunningServices2.txt") | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\PostScanDifferentials.txt"

    ####----- Raw Scan Report -----###
    if ((Test-Path -Path "C:\Users\$LoggedInUser\Baseline\Rawfile") -eq $false){ MD "C:\Users\$LoggedInUser\Baseline\Rawfile"} ;
    Start-Sleep 3
    Get-Date | Out-File -Append "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt"
    Tree /f | Out-file "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-ComputerInfo | Out-file "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-Process | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-LocalUser | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-EventLog -LogName System | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-EventLog -LogName Security | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Netstat -an | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append
    Get-Service | Out-File "C:\Users\$LoggedInUser\BaseLine\Rawfile\Rawscan.txt" -Append

    echo "_______________________________________________________________________________________________________________"
    echo "
███████╗ ██████╗ █████╗ ███╗   ██╗     ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗███████╗
██╔════╝██╔════╝██╔══██╗████╗  ██║    ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██╔════╝
███████╗██║     ███████║██╔██╗ ██║    ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   █████╗  
╚════██║██║     ██╔══██║██║╚██╗██║    ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██╔══╝  
███████║╚██████╗██║  ██║██║ ╚████║    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ███████╗
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚══════╝
"

    ### ----- Progress Bar ----- ###
}
