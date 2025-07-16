

function Set-DefaultLakehouseInNotebook {
    param (
        [Parameter(Mandatory = $true)]
        [string]$NotebookPath,

        [Parameter(Mandatory = $true)]
        [string]$LakehouseId,

        [Parameter(Mandatory = $true)]
        [string]$LakehouseName,

        [Parameter(Mandatory = $true)]
        [string]$LakehouseWorkspaceId
    )

    if (-not (Test-Path $NotebookPath)) {
        throw "Notebook file not found: $NotebookPath"
    }

    # Read and parse the JSON content
    $json = Get-Content -Raw -Path $NotebookPath | ConvertFrom-Json

    # Ensure the metadata and dependencies path exists
    if (-not $json.metadata) {
        $json | Add-Member -MemberType NoteProperty -Name metadata -Value @{}
    }
    if (-not $json.metadata.dependencies) {
        $json.metadata | Add-Member -MemberType NoteProperty -Name dependencies -Value @{}
    }
    if (-not $json.metadata.dependencies.lakehouse) {
        $json.metadata.dependencies | Add-Member -MemberType NoteProperty -Name lakehouse -Value @{}
    }

    # Set default lakehouse values
    $json.metadata.dependencies.lakehouse.default_lakehouse = $LakehouseId
    $json.metadata.dependencies.lakehouse.default_lakehouse_name = $LakehouseName
    $json.metadata.dependencies.lakehouse.default_lakehouse_workspace_id = $LakehouseWorkspaceId
    $json.metadata.dependencies.lakehouse.known_lakehouses = @(
        @{ id = $LakehouseId }
    )

    # Save the updated JSON back to the file
    $json | ConvertTo-Json -Depth 100 | Set-Content -Path $NotebookPath -Encoding UTF8

    Write-Host "✅ Default lakehouse set in notebook '$NotebookPath'"
}

function Set-NotebookAndWorkspaceIdsInJson {
    param (
        [Parameter(Mandatory)]
        [string]$JsonPath,

        [Parameter(Mandatory)]
        [string]$NotebookId,

        [Parameter(Mandatory)]
        [string]$WorkspaceId,

        [string]$OutputPath  # Optional, defaults to overwrite original
    )

    if (-not (Test-Path $JsonPath)) {
        throw "File not found: $JsonPath"
    }

    # Read and convert JSON to object
    $jsonContent = Get-Content $JsonPath -Raw | ConvertFrom-Json -Depth 50

    # Find and update all relevant notebookId/workspaceId entries
    foreach ($activity in $jsonContent.properties.activities) {
        if ($activity.type -eq "TridentNotebook") {
            if ($activity.typeProperties.notebookId) {
                $activity.typeProperties.notebookId = $NotebookId
            }
            if ($activity.typeProperties.workspaceId) {
                $activity.typeProperties.workspaceId = $WorkspaceId
            }
        }
    }

    # Serialize and save
    $newJson = $jsonContent | ConvertTo-Json -Depth 50

    if (-not $OutputPath) {
        $OutputPath = $JsonPath  # Overwrite original
    }

    Set-Content -Path $OutputPath -Value $newJson -Encoding UTF8

    Write-Host "Updated notebookId and workspaceId in: $OutputPath"
}


function Create-Folder
{
    param (
        [Parameter(Mandatory)]
        [string]$WorkspaceName,
        [Parameter(Mandatory)]
        [string]$folderName
    )

    $wkId=Get-WorkspaceId -workspaceName $WorkspaceName



    $body = @{
        displayName = "$folderName"
    }


    #$jsonBody='{\"displayName\":\"$folderName\"}'

    $jsonBody="{\""displayName\"":\""$folderName\""}"

    fab api -X post "workspaces/$wkId/folders" -i $jsonBody
    Write-Host $jsonBody
    
}


#Check Object exitance
function Check-FabricWorkspaceExists {
    param (
        [Parameter(Mandatory)]
        [string]$WorkspaceName
    )
    $workspaceFullName="$WorkspaceName.Workspace"

    Write-Host "Checking if the workspace $workspaceFullName exists"

    # Check if any workspace name matches (case-insensitive)
    return (Check-ItemExists -itemPath "/"  -itemName $workspaceFullName)
}

function Check-FabricLakehouseExists {
    param (
        [Parameter(Mandatory)]
        [string]$WorkspaceName,

        [Parameter(Mandatory)]
        [string]$LakehouseName
    )

    $lakehouseFullName="$LakehouseName.Lakehouse"

    Write-Host "Checking if the lakehouse $lakehouseFullName exists"

    return (Check-ItemExists -itemPath $WorkspaceName  -itemName $lakehouseFullName)
}

function Check-FabricNotebookExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceName,

        [Parameter(Mandatory = $true)]
        [string]$NotebookName
    )

    $notebookFullname="$NotebookName.Notebook"

    Write-Host "Checking if the notebook $notebookFullname exists"

    return (Check-ItemExists -itemPath $WorkspaceName  -itemName $notebookFullname)
}

function Check-PipelineExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceName,

        [Parameter(Mandatory = $true)]
        [string]$PipelineName
    )

    $pipelineFullname="$PipelineName.DataPipeline"

    Write-Host "Checking if the notebook $pipelineFullname exists"

    return (Check-ItemExists -itemPath $WorkspaceName  -itemName $pipelineFullname)
}

function Check-SemanticModelExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceName,

        [Parameter(Mandatory = $true)]
        [string]$SemanticModelName
    )

    $semanticModelFullname="$SemanticModelName.SemanticModel"

    Write-Host "Checking if the notebook $semanticModelFullname exists"

    return (Check-ItemExists -itemPath $WorkspaceName  -itemName $semanticModelFullname)
}


function Check-ItemExists
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$itemPath,

        [Parameter(Mandatory = $true)]
        [string]$itemName
    )

    $items = Get-Items -WorkspaceName $itemPath

    if (-not $items)
    {
        return 0
    }

    return @($items | Where-Object { $_.name -eq $itemName }).Count -gt 0
}


#Retrieval object Ids
function Get-LakehouseId {
    param (
        [string]$workspaceName,
        [string]$lakehouseName
    )

    $fullLakehouseName="$lakehouseName.Lakehouse"

    return (Get-ObjectId -workspaceName $workspaceName -objectName $fullLakehouseName)
}

function Get-NotebookId
{
    param (
        [string]$workspaceName,
        [string]$notebookName
    ) 

    $fullNotebookName="$notebookName.Notebook"

    return (Get-ObjectId -workspaceName $workspaceName -objectName $fullNotebookName)
}

function Get-SemanticModelId
{
    param (
        [string]$workspaceName,
        [string]$semanticModelName 
    ) 

    $fullSemanticModelName="$semanticModelName.SemanticModel"

    return (Get-ObjectId -workspaceName $workspaceName -objectName $fullSemanticModelName)
}

function Get-ObjectId
{
    param (
        [string]$workspaceName,
        [string]$objectName
    )

    $result=Get-Items -WorkspaceName $workspaceName |
        Where-Object { $_.name -eq $objectName } |
        Select-Object -ExpandProperty id

    return $result
}

function Get-WorkspaceId {
    param (
        [string]$workspaceName
    )
    $results=Get-Workspaces
    $fullWorkspaceName="$workspaceName.Workspace"

    Write-Host "looking for the id of $fullWorkspaceName"

    $result= $results | Where-Object { $_.name -eq $fullWorkspaceName } | Select-Object -ExpandProperty id

    Write-Host "workspace Id: $result"

    return $result
}

function Get-CapacityRegion()
{
    $result = fab ls .capacities -l | Convert-FixedWidthTableToObjects

    if ($result.Count -eq 0) {
        Write-Host "No capacities found"
        exit
    }
    $filtered = $result | Where-Object { $_.name -notlike "*Reserved*" }
    $first=$filtered[0]


    $capacityregion=$first.region
    return $capacityregion

}

function Get-CapacityName()
{
    $result = fab ls .capacities -l | Convert-FixedWidthTableToObjects

    if ($result.Count -eq 0) {
        Write-Host "No capacities found"
        exit
    }
    $filtered = $result | Where-Object { $_.name -notlike "*Reserved*" }
    $first=$filtered[0]


    $capacityname=$first.name + ".capacity"
    return $capacityname

}

#Basic retrieval functions
function Get-Items
{
    param (
        [Parameter(Mandatory)]
        [string]$WorkspaceName
    )

    if ($workspaceName -notmatch "/") {
        $workspacePath = "/$workspaceName.Workspace"
    }
    else
    {
        $workspacePath = $WorkspaceName
    }
    $items = fab ls $workspacePath -l | Convert-FixedWidthTableToObjects

    return $items
}


function Get-Workspaces()
{
    return Get-Items -WorkspaceName "/"
}



#Basic Processing function
function Convert-FixedWidthTableToObjects {
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$TableText
    )

    begin {
        $lines = @()
    }

    process {
        # Ensure each input is treated as a string
        $lines += $_.ToString()
    }

    end {
        # Remove empty or whitespace-only lines
        $lines = $lines | Where-Object { $_.Trim() -ne "" }

        # Validate input: expect at least 3 lines (header, separator, and at least one row)
        if ($lines.Count -lt 3) {
            Write-Host "Expected tabular output with at least 3 lines (header, separator, data). Received: $lines"
            return @()
        }

        $headerLine = $lines[0]
        $separatorLine = $lines[1]

        # Validate separator line (should be dashes and spaces only)
        if ($separatorLine -notmatch "^-{3,}") {
            throw "Second line is not a valid separator. Did you forget to use `-l` with the command?"
        }

        # Identify column start and end positions
        $columnBounds = @()
        $inColumn = $false
        for ($i = 0; $i -lt $headerLine.Length; $i++) {
            if ($headerLine[$i] -ne ' ' -and -not $inColumn) {
                $start = $i
                $inColumn = $true
            } elseif ($headerLine[$i] -eq ' ' -and $inColumn) {
                $end = $i
                $columnBounds += ,@($start, $end)
                $inColumn = $false
            }
        }
        if ($inColumn) {
            $columnBounds += ,@($start, $headerLine.Length)
        }

        # Extract column names based on header line and boundaries
        $columns = $columnBounds | ForEach-Object {
            $start = $_[0]
            $length = $_[1] - $_[0]
            if ($start -lt $headerLine.Length) {
                $length = [Math]::Min($length, $headerLine.Length - $start)
                $headerLine.Substring($start, $length).Trim()
            } else {
                "Column$start"
            }
        }

        # Validate column parsing
        if ($columns.Count -eq 0 -or $columns.Count -ne $columnBounds.Count) {
            throw "Failed to parse columns from header. Please check the tabular alignment of the input."
        }

        # Parse data lines into objects
        $dataLines = $lines[2..($lines.Count - 1)]

        $objects = foreach ($line in $dataLines) {
            $obj = [PSCustomObject]@{}
            for ($i = 0; $i -lt $columns.Count; $i++) {
                $start = $columnBounds[$i][0]
                if ($i -lt $columnBounds.Count)                
                { 
                    if ($null -ne $columnBounds[$i + 1]) {
                        $length = ($columnBounds[$i + 1][0] - $start)
                    }
                    else
                    {
                        $length = ($separatorLine.Length - $start)                
                    }
                }
                else
                {
                    $length = ($separatorLine.Length - $start)                
                }

                if ($start -ge $line.Length) {
                    $value = ""
                } else {
                    $length = [Math]::Min($length, $line.Length - $start)                     
                    $Dirtvalue = ($line.Substring($start, $length) -replace '\p{C}', '').Trim()
                    $value = -join ($DirtValue.ToCharArray() | Where-Object { [int]$_ -ge 32 -and [int]$_ -le 126 })
                }

                $obj | Add-Member -NotePropertyName $columns[$i] -NotePropertyValue $value
            }
            $obj
        }

        return $objects
    }
}

function Get-RegionConnectionDetails {
    param (
        [string]$RegionName
    )

    $regionMap = @{
        "Australia East"         = "australiaeast"
        "Australia Southeast"    = "australiasoutheast"
        "Brazil South"           = "brazilsouth"
        "Canada Central"         = "canadacentral"
        "Canada East"            = "canadaeast"
        "Central India"          = "centralindia"
        "Central US"             = "centralus"
        "East Asia"              = "eastasia"
        "East US"                = "eastus"
        "East US 2"              = "eastus2"
        "France Central"         = "francecentral"
        "France South"           = "francesouth"
        "Germany North"          = "germanynorth"
        "Germany West Central"   = "germanywestcentral"
        "Italy North"            = "italynorth"
        "Japan East"             = "japaneast"
        "Japan West"             = "japanwest"
        "Korea Central"          = "koreacentral"
        "Korea South"            = "koreasouth"
        "North Central US"       = "northcentralus"
        "North Europe"           = "northeurope"
        "Norway East"            = "norwayeast"
        "Norway West"            = "norwaywest"
        "Qatar Central"          = "qatarcentral"
        "South Africa North"     = "southafricanorth"
        "South Central US"       = "southcentralus"
        "South India"            = "southindia"
        "Southeast Asia"         = "southeastasia"
        "Sweden Central"         = "swedencentral"
        "Switzerland North"      = "switzerlandnorth"
        "Switzerland West"       = "switzerlandwest"
        "UAE Central"            = "uaecentral"
        "UAE North"              = "uaenorth"
        "UK South"               = "uksouth"
        "UK West"                = "ukwest"
        "West Central US"        = "westcentralus"
        "West Europe"            = "westeurope"
        "West India"             = "westindia"
        "West US"                = "westus"
        "West US 2"              = "westus2"
        "West US 3"              = "westus3"
    }

    if (-not $regionMap.ContainsKey($RegionName)) {
        throw "Unknown or unsupported region: '$RegionName'"
    }

    $regionCode = $regionMap[$RegionName]
    return @{
        RegionCode     = $regionCode
        VirtualServer  = "wabi-$regionCode-redirect.analysis.windows.net"
    }
}




function Convert-PBIRByPathToByConnection {
    param (
        [string]$PBIRFilePath,
        [string]$WorkspaceName,
        [string]$SemanticModelName,
        [string]$SemanticModelId
    )

    $VirtualServerName = "sobe_wowvirtualserver"

    $pbirJson = Get-Content -Path $PBIRFilePath -Raw | ConvertFrom-Json -Depth 10

    $pbirJson.datasetReference = @{
        byPath = $null
        byConnection = @{
            connectionString          = "Data Source=powerbi://api.powerbi.com/v1.0/myorg/$WorkspaceName;Initial Catalog=$SemanticModelName;Integrated Security=ClaimsToken"
            pbiServiceModelId         = $null
            pbiModelVirtualServerName = $VirtualServerName
            pbiModelDatabaseName      = $SemanticModelId
            connectionType            = "pbiServiceXmlaStyleLive"
            name                      = "EntityDataSource"
        }
    }

    if ($pbirJson.PSObject.Properties.Name -contains 'connections') {
        $pbirJson.PSObject.Properties.Remove('connections')
    }

    $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText(
        (Resolve-Path $PBIRFilePath),
        ($pbirJson | ConvertTo-Json -Depth 10),
        $utf8NoBomEncoding
    )
}

function Get-FabricLakehouseUrl {
    param (
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [string]$LakehouseId
    )

    try {
        $Response = fab api "workspaces/$WorkspaceId/lakehouses/$LakehouseId" 

       #Write-Host "API Result: $Response"

        $apiResponse= $Response | ConvertFrom-Json -Depth 10

        #Write-Host "API Response JSON: $apiResponse"

        $url = $apiResponse.text.properties.sqlEndpointProperties.connectionString

        if (-not $url) {
            throw "Lakehouse connection URL not found in API response."
        }

        return $url
    }
    catch {
        throw "Failed to retrieve Lakehouse URL: $_"
    }
}

function Update-TmdlExpressionsFile {
    param (
        [string]$FilePath,
        [string]$NewLakehouseUrl,
        [string]$NewLakehouseName
    )

    $content = Get-Content $FilePath -Raw

    $content = $content -replace '(?<=expression Lakehouse_URL = ")[^"]+(?=")', $NewLakehouseUrl
    $content = $content -replace '(?<=expression Lakehouse_Name = ")[^"]+(?=")', $NewLakehouseName

    Set-Content -Path $FilePath -Value $content -Encoding UTF8
}


