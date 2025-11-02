#### Create Data Ports Hash table
$DataPorts = @{}
$DataPorts['PWR - Power'] = 'Power Data Port'
$DataPorts['SEC - Security'] = 'Security Data Ports'
$DataPorts['OPR - Operations'] = ''
$DataPorts['MED - Medical'] = 'Medical Data Ports'
$DataPorts['LAB - Laboratory'] = 'Laboratory Data Port'
$DataPorts['PROC - Production'] = 'Industrial Data Port'
$DataPorts['DORM - Dorms'] = 'Data Port'
$DataPorts['STO - Storage'] = 'Industrial Data Port'
$DataPorts['AGR - Agricultural'] = 'Agricultural Data Port'
$DataPorts['(CORR) - Corridor (blank doors)'] = 'Data Port'

#### Load Data CSV
$MaterialLocationCSV = Import-Csv '.\Material_Locations.csv'
$MaterialTypeCSV = Import-Csv '.\Material_Types.csv'

$MaterialLocations = @{}
'' | Out-File '.\Data_rows.html'

Foreach($Material in $MaterialTypeCSV){

    $MaterialLocations[$Material.MaterialName] = @()

    if($Material.Type -eq 'Data'){

        $MaterialLocationCSVDataPort = $MaterialLocationCSV | Where-object {$_.Type -eq 'Data port'}

        $MaterialReports = $MaterialLocationCSVDataPort | Where-object{
            $_.Data1 -eq $Material.MaterialName `
            -or $_.Data2 -eq $Material.MaterialName `
            -or $_.Data3 -eq $Material.MaterialName `
            -or $_.Data4 -eq $Material.MaterialName `
            -or $_.Data5 -eq $Material.MaterialName `
            -or $_.Data6 -eq $Material.MaterialName `
            -or $_.Data7 -eq $Material.MaterialName `
            -or $_.Data8 -eq $Material.MaterialName `
            -or $_.Data9 -eq $Material.MaterialName `
            -or $_.Data10 -eq $Material.MaterialName
        }

        Foreach($Report in $MaterialReports){

            $LootPoint = $DataPorts[$Report.Room]

            If($MaterialLocations[$Material.MaterialName] -Notcontains $LootPoint){
                $MaterialLocations[$Material.MaterialName] += $LootPoint
            }
        }
        
        $HTMLLine = '<tr>'
        $HTMLLine += $('<td><b>{0}</b></td>' -f $Material.MaterialName)

        # Power Data Port
        # Security Data Ports
        # Medical Data Ports
        # Laboratory Data Port
        # Industrial Data Port
        # Agricultural Data Port
        # Data Port

        if($MaterialLocations[$Material.MaterialName] -contains 'Power Data Port'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Security Data Ports'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Medical Data Ports'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Laboratory Data Port'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Industrial Data Port'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Agricultural Data Port'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Data Port'){
            $HTMLLine += '<td bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }

        $HTMLLine += '</tr>'
        $HTMLLine | Out-File '.\Data_rows.html' -Append
        

    }
}