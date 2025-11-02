#### Create lockers hash table
$Lockers = @{}
$Lockers['PWR - Power'] = ''
$Lockers['SEC - Security'] = 'Security Locker'
$Lockers['OPR - Operations'] = 'Tech Locker'
$Lockers['MED - Medical'] = 'Medical Locker'
$Lockers['LAB - Laboratory'] = 'Research Locker'
$Lockers['PROC - Production'] = 'Industrial Locker'
$Lockers['DORM - Dorms'] = 'Locker'
$Lockers['STO - Storage'] = 'Mining Locker'
$Lockers['AGR - Agricultural'] = 'Agricultural Locker'
$Lockers['(CORR) - Corridor (blank doors)'] = 'Locker'

#### Load Data CSV
$MaterialLocationCSV = Import-Csv '.\Material_Locations.csv'
$MaterialTypeCSV = Import-Csv '.\Material_Types.csv'

$MaterialLocations = @{}
'' | Out-File '.\Mat_rows.html'

Foreach($Material in $MaterialTypeCSV){

    $MaterialLocations[$Material.MaterialName] = @()

    if($Material.Type -eq 'Item' -or $Material.Type -eq 'Components'){

        $MaterialLocationCSVLocker = $MaterialLocationCSV | Where-object {$_.Type -eq 'Small locker' -or $_.Type -eq 'Large Locker'}

        $MaterialReports = $MaterialLocationCSVLocker | Where-object{
            $_.Mat1 -eq $Material.MaterialName `
            -or $_.Mat2 -eq $Material.MaterialName `
            -or $_.Mat3 -eq $Material.MaterialName `
            -or $_.Mat4 -eq $Material.MaterialName `
            -or $_.Mat5 -eq $Material.MaterialName `
            -or $_.Mat6 -eq $Material.MaterialName `
            -or $_.Mat7 -eq $Material.MaterialName `
            -or $_.Mat8 -eq $Material.MaterialName `
            -or $_.Mat9 -eq $Material.MaterialName `
            -or $_.Mat10 -eq $Material.MaterialName
        }

        Foreach($Report in $MaterialReports){

            $LootPoint = $('{0} - {1}'-f $Lockers[$Report.Room], $Report.Type)

            If($MaterialLocations[$Material.MaterialName] -Notcontains $LootPoint){
                $MaterialLocations[$Material.MaterialName] += $LootPoint
            }
        }
        
        $HTMLLine = '<tr>'
        $HTMLLine += $('<td><b>{0}</b></td>' -f $Material.MaterialName)

        # Security Locker - Small locker
        # Security Locker - Large locker
        # Tech Locker - Small locker
        # Tech Locker - Large locker
        # Medical Locker - Small locker
        # Medical Locker - Large locker
        # Research Locker - Small locker
        # Research Locker - Large locker
        # Industrial Locker - Small locker
        # Industrial Locker - Large locker
        # Mining Locker - Small locker
        # Mining Locker - Large locker
        # Agricultural Locker - Small locker
        # Agricultural Locker - Large locker
        # Locker - Small locker
        # Locker - Large locker


        if($MaterialLocations[$Material.MaterialName] -contains 'Security Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Security Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Tech Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Tech Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Medical Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Medical Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Research Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Research Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Industrial Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Industrial Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Mining Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Mining Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Agricultural Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Agricultural Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Locker - Small locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }
        if($MaterialLocations[$Material.MaterialName] -contains 'Locker - Large locker'){
            $HTMLLine += '<td  bgcolor="White"></td>'
        }Else{
            $HTMLLine += '<td></td>'
        }

        $HTMLLine += '</tr>'
        $HTMLLine | Out-File '.\Mat_rows.html' -Append
        

    }
}