Param(
    [string] $InPath
)

$OutPath = $($InPath -replace '.csv', '.HTML')

'' | out-file $OutPath

foreach($Line in $(import-csv $InPath)){
    $SystemName = $Line."System Name"
    $Planet = $Line."Planet"

    $url = 'https://www.edsm.net/api-v1/system?systemName=' +  $($SystemName -replace ' ','%20' -replace '\+', '%2B') + '&showCoordinates=1';
    $Respone = Invoke-WebRequest $url
   
    if($Respone.content -match '{"name":"([^"]+)","coords":{"x":([\d.-]+),"y":([\d.-]+),"z":([\d.-]+)}'){
		
        $X = [math]::round($matches[2],2)
        $Y = [math]::round($matches[3],2)
        $Z = [math]::round($matches[4],2)
        $('<TR><TD>{0}</TD><TD>{1}</TD><TD>{2}</TD><TD>{3}</TD><TD>{4}</TD><TD></TD></TR>' -f $SystemName, $X, $Y, $Z, $Planet) | Out-File $OutPath -append
    }
}