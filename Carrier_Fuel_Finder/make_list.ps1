$lines = Get-Content '\\SPACEVAULT\Down_To_Earth_Astronomy\EliteGuides\Carrier_Fuel_Finder\Trit2.txt'

ForEach($Line in $Lines){

    $RegEX = '([^:]*):'
    if($Line -match $RegEX){
        $SystemName = $Matches[1]
    }
    $RegEX = $('-\s{0}\s([^\(]*)\(' -f $SystemName)
    if($Line -match $RegEx){
        $Planet = $Matches[1]

        Write-host $("12/17/2020 20:14:53`t{0}`t{1}" -f $SystemName, $Planet)
    }
    
}