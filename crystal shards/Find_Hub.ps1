$LocationCSV = Import-Csv '\\SPACEVAULT\Down_To_Earth_Astronomy\EliteGuides\crystal shards\crystal_shards_2.csv'

$AntimonyList = $LocationCSV | Where-Object{$_.Material -eq 'Antimony'}
$PoloniumList = $LocationCSV | Where-Object{$_.Material -eq 'Polonium'}
$RutheniumList = $LocationCSV | Where-Object{$_.Material -eq 'Ruthenium'}
$TechnetiumList = $LocationCSV | Where-Object{$_.Material -eq 'Technetium'}
$TelluriumList = $LocationCSV | Where-Object{$_.Material -eq 'Tellurium'}
$YttriumList = $LocationCSV | Where-Object{$_.Material -eq 'Yttrium'}

$BestAntimony = -1
$BestPolonium = -1
$BestRuthenium = -1
$BestTechnetium = -1
$BestTellurium = -1
$BestYttrium = -1

$BestTotalDis = 9999999

For($i=0; $i -lt $LocationCSV.Count; $i++ ){
    $Location = $LocationCSV[$i]

    $AntimonyDis = 9999
    $PoloniumDis = 9999
    $RutheniumDis = 9999
    $TechnetiumDis = 9999
    $TelluriumDis = 9999
    $YttriumDis = 9999

    $Antimony = -1
    $Polonium = -1
    $Ruthenium = -1
    $Technetium = -1
    $Tellurium = -1
    $Yttrium = -1

    Foreach($AntimonyLocation in $AntimonyList){
        $Xdis = [decimal]$AntimonyLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$AntimonyLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$AntimonyLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $AntimonyDis){
            $AntimonyDis = $Dis
            $Antimony = $AntimonyLocation.id
        }   
    }
    Foreach($PoloniumLocation in $PoloniumList){
        $Xdis = [decimal]$PoloniumLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$PoloniumLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$PoloniumLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $PoloniumDis){
            $PoloniumDis = $Dis
            $Polonium = $PoloniumLocation.id
        }   
    }
    Foreach($RutheniumLocation in $RutheniumList){
        $Xdis = [decimal]$RutheniumLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$RutheniumLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$RutheniumLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $RutheniumDis){
            $RutheniumDis = $Dis
            $Ruthenium = $RutheniumLocation.id
        }   
    }
    Foreach($TechnetiumLocation in $TechnetiumList){
        $Xdis = [decimal]$TechnetiumLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$TechnetiumLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$TechnetiumLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $TechnetiumDis){
            $TechnetiumDis = $Dis
            $Technetium = $TechnetiumLocation.id
        }   
    }
    Foreach($TelluriumLocation in $TelluriumList){
        $Xdis = [decimal]$TelluriumLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$TelluriumLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$TelluriumLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $TelluriumDis){
            $TelluriumDis = $Dis
            $Tellurium = $TelluriumLocation.id
        }   
    }
    Foreach($YttriumLocation in $YttriumList){
        $Xdis = [decimal]$YttriumLocation.X - [decimal]$Location.X
        $Ydis = [decimal]$YttriumLocation.Y - [decimal]$Location.Y
        $Zdis = [decimal]$YttriumLocation.Z - [decimal]$Location.Z
        $Dis = [Math]::Sqrt($Xdis*$Xdis + $Ydis*$Ydis + $Zdis*$Zdis)
        If($Dis -lt $YttriumDis){
            $YttriumDis = $Dis
            $Yttrium = $YttriumLocation.id
        }   
    }

    $TotalDis = $AntimonyDis + $PoloniumDis + $RutheniumDis + $TechnetiumDis + $TelluriumDis + $YttriumDis
    if($TotalDis -lt $BestTotalDis){
        $BestAntimony = $Antimony
        $BestPolonium = $Polonium
        $BestRuthenium = $Ruthenium
        $BestTechnetium = $Technetium
        $BestTellurium = $Tellurium
        $BestYttrium = $Yttrium

        $BestTotalDis = $TotalDis
    }
}

Write-host $('Antimony: {0}' -f $BestAntimony)
Write-host $('Polonium: {0}' -f $BestPolonium)
Write-host $('Ruthenium: {0}' -f $BestRuthenium)
Write-host $('Technetium: {0}' -f $BestTechnetium)
Write-host $('Tellurium: {0}' -f $BestTellurium)
Write-host $('Yttrium: {0}' -f $BestYttrium)
Write-host $BestTotalDis


#HIP 36601 C 4 A,Selenium -  (Not cryatal shards)
#HIP 36601,C 1 a,Polonium
#HIP 36601,C 1 d,Ruthenium
#HIP 36601,C 3 b,Tellurium
#HIP 36601,C 5 a,Technetium

#Outotz LS-K d8-3,B 7 b,Ruthenium
#Outotz LS-K d8-3,B 5 a,Yttrium
#Outotz LS-K d8-3,B 5 c,Antimony