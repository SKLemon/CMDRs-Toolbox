$LocationCSV = Import-Csv '\\SPACEVAULT\Down_To_Earth_Astronomy\EliteGuides\crystal shards\crystal_shards.csv'

'SystemName,Planet,Material,X,Y,Z' | out-file '\\SPACEVAULT\Down_To_Earth_Astronomy\EliteGuides\crystal shards\crystal_shards_2.csv'

ForEach($Location in $LocationCSV){
    $SystemName = $Location.SystemName
    $systemMetadata = Invoke-WebRequest $('https://www.edsm.net/api-v1/system?systemName={0}&showCoordinates=1' -f $SystemName) -UseBasicParsing

    If ($systemMetadata.content -match '{"name":"([^"]+)","coords":{"x":([\d.-]+),"y":([\d.-]+),"z":([\d.-]+)}') {
        [decimal]$X = $matches[2]
        [decimal]$Y = $matches[3]
        [decimal]$Z = $matches[4]
        $SolDis = [Math]::Sqrt($($X*$X + $Y*$Y + $Z*$Z))
        If($SolDis -lt 2000){
            
            $('{0},{1},{2},{3},{4},{5}' -f $SystemName,$Location.Planet,$Location.Material,$matches[2],$matches[3],$matches[4] ) | out-file '\\SPACEVAULT\Down_To_Earth_Astronomy\EliteGuides\crystal shards\crystal_shards_2.csv' -append
        }
    }
}