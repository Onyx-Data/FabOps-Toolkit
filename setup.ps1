function Create-Workspace
{
        param (
            [Parameter(Mandatory)]
            [string]$capacityName,
            [Parameter(Mandatory)]
            [string]$workspaceName
        )

     fab create $workspaceName -P capacityname=$capacityName
     Write-Host "Workspace Created: $workspaceName"

}

function Create-Lakehouse()
{
        fab create "/OnyxToolsMeta.Workspace/OnyxToolsLake.Lakehouse"
        Set-DefaultLakehouse
}

#functions
function Create-WorkspaceAndLake
{
        (
            [Parameter(Mandatory)]
            [string]$capacityName
        )

    Create-Workspace -capacityName $capacityName -workspaceName "OnyxToolsMeta.Workspace"
    Create-Lakehouse
}




function Create-ToolsWorkspace
{
        (
            [Parameter(Mandatory)]
            [string]$capacityName
        )

    fab create OnyxTools.Workspace -P capacityname=$capacityname
}

function Import-SQLEndpointNotebook()
{
    fab import "/OnyxTools.Workspace/NB - Sync LH and Endpoint.Notebook" -i ".\NB - Sync LH and Endpoint.Notebook" -f
}

function Set-DefaultLakehouse()
{
    $workspaceId=Get-WorkspaceId -workspaceName "OnyxToolsMeta"

    $lakehouseId=Get-LakehouseId -workspaceName "OnyxToolsMeta" -lakehouseName "OnyxToolsLake"

    Set-DefaultLakehouseInNotebook `
        -NotebookPath "$PSScriptRoot\MetaInitialize.Notebook\notebook-content.ipynb" `
        -LakehouseId "$lakehouseId" `
        -LakehouseName "OnyxToolsLake" `
        -LakehouseWorkspaceId "$workspaceId"

    Set-DefaultLakehouseInNotebook `
        -NotebookPath "$PSScriptRoot\NB - Sync LH and Endpoint.Notebook\notebook-content.ipynb" `
        -LakehouseId "$lakehouseId" `
        -LakehouseName "OnyxToolsLake" `
        -LakehouseWorkspaceId "$workspaceId"

    Set-DefaultLakehouseInNotebook `
        -NotebookPath "$PSScriptRoot\NB - Optimize Lakehouse.Notebook\notebook-content.ipynb" `
        -LakehouseId "$lakehouseId" `
        -LakehouseName "OnyxToolsLake" `
        -LakehouseWorkspaceId "$workspaceId"

    Set-DefaultLakehouseInNotebook `
        -NotebookPath "$PSScriptRoot\NB - Load Lakehouse Maintenance Data.Notebook\notebook-content.ipynb" `
        -LakehouseId "$lakehouseId" `
        -LakehouseName "OnyxToolsLake" `
        -LakehouseWorkspaceId "$workspaceId"
}


function Create-SQLEndpointFolder
{
    Create-Folder -WorkspaceName "OnyxTools"  -folderName "SQL Endpoint System"
}


fab auth login

. .\reusable.ps1

#Identifying the capacity
$capacityname=Get-CapacityName

#Creating Meta workspace and lakehouse
if (-not (Check-FabricWorkspaceExists -WorkspaceName "OnyxToolsMeta")) {
    Write-Host "Workspace OnyxToolsMeta doesn't exist. Creating"
    Create-WorkspaceAndLake -capacityName $capacityname
}
else
{
    Write-Host "Workspace OnyxToolsMeta already exists"

    if (-not (Check-FabricLakehouseExists -WorkspaceName "OnyxToolsMeta" -LakehouseName "OnyxToolsLake")) {
        Write-Host "Lakehouse OnyxToolsLake doesn't exist. Creating"
        Create-Lakehouse
    } 
    else
    {
        #set the meta lakehouse as default in the notebooks
        Set-DefaultLakehouse
    }
}

#Creating tables in the meta lakehouse
if (-not (Check-FabricNotebookExists -WorkspaceName "OnyxToolsMeta" -NotebookName "MetaInitialize")) {
    fab import "/OnyxToolsMeta.Workspace/MetaInitialize.Notebook" -i ".\MetaInitialize.Notebook" -f
    fab job run "/OnyxToolsMeta.Workspace/MetaInitialize.Notebook"
}

#Creating Tools workspace
if (-not (Check-FabricWorkspaceExists -WorkspaceName "OnyxTools")) {
    Write-Host "Workspace OnyxTools doesn't exist. Creating"
    Create-Workspace -workspaceName "OnyxTools.Workspace" -capacityName $capacityname
}

$wksToolsId=Get-WorkspaceId -workspaceName "OnyxTools"

#Creating tables in the meta lakehouse

if (-not (Check-FabricNotebookExists -WorkspaceName "OnyxTools.Workspace" -NotebookName "NB - Sync LH and Endpoint")) {
    Import-SQLEndpointNotebook
}

#if (-not (Check-ItemExists -itemPath "OnyxTools" -itemName "SQL Endpoint System"))
#{
#    Create-SQLEndpointFolder
#}

#Folders are not well supported in Fabric APIs yet

#if (-not (Check-ItemExists -itemPath "OnyxTools" -itemName "Common"))
#{
#    Create-Folder -WorkspaceName "OnyxTools"  -folderName "Common"
#}

#if (-not (Check-ItemExists -itemPath "OnyxTools" -itemName "Save JSON System"))
#{
#    Create-Folder -WorkspaceName "OnyxTools"  -folderName "Save JSON System"
#}

#if (-not (Check-ItemExists -itemPath "OnyxTools" -itemName "SCD System"))
#{
#    Create-Folder -WorkspaceName "OnyxTools"  -folderName "SCD System"
#}

#if (-not (Check-ItemExists -itemPath "OnyxTools" -itemName "Disabled Notebook System"))
#{
#    Create-Folder -WorkspaceName "OnyxTools"  -folderName "Disabled Notebook System"
#}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Load Configuration")) {
    fab import "/OnyxTools.Workspace/NB - Load Configuration.Notebook" -i "$PSScriptRoot\NB - Load Configuration.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Save JSON")) {
    fab import "/OnyxTools.Workspace/NB - Save JSON.Notebook" -i "$PSScriptRoot\NB - Save JSON.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Py Common")) {
    fab import "/OnyxTools.Workspace/NB - Py Common.Notebook" -i "$PSScriptRoot\NB - Py Common.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Check Disabled Notebooks")) {
    fab import "/OnyxTools.Workspace/NB - Check Disabled Notebooks.Notebook" -i "$PSScriptRoot\NB - Check Disabled Notebooks.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Exclude Shortcuts")) {
    fab import "/OnyxTools.Workspace/NB - Exclude Shortcuts.Notebook" -i "$PSScriptRoot\NB - Exclude Shortcuts.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Load Lakehouse Maintenance Data")) {
    fab import "/OnyxTools.Workspace/NB - Load Lakehouse Maintenance Data.Notebook" -i "$PSScriptRoot\NB - Load Lakehouse Maintenance Data.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Optimize Lakehouse")) {
    fab import "/OnyxTools.Workspace/NB - Optimize Lakehouse.Notebook" -i "$PSScriptRoot\NB - Optimize Lakehouse.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - performance baseline")) {
    fab import "/OnyxTools.Workspace/NB - performance baseline.Notebook" -i "$PSScriptRoot\NB - performance baseline.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - TableSizeAnalysis")) {
    fab import "/OnyxTools.Workspace/NB - TableSizeAnalysis.Notebook" -i "$PSScriptRoot\NB - TableSizeAnalysis.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "NB - Shortcut Identification")) {
    fab import "/OnyxTools.Workspace/NB - Shortcut Identification.Notebook" -i "$PSScriptRoot\NB - Shortcut Identification.Notebook" -f
}

if (-not (Check-FabricNotebookExists -WorkspaceName "/OnyxTools.Workspace" -NotebookName "Fabric_utils")) {
    fab import "/OnyxTools.Workspace/Fabric_utils.Notebook" -i "$PSScriptRoot\Fabric_utils.Notebook" -f
}

if (-not (Check-PipelineExists -WorkspaceName "/OnyxTools.Workspace" -PipelineName "PL - Disabled Notebook Alert")) {

    $notebookId=(Get-NotebookId -workspaceName "OnyxTools" -notebookName "NB - Check Disabled Notebooks")

    Set-NotebookAndWorkspaceIdsInJson -JsonPath "$PSScriptRoot/PL - Disabled Notebook Alert.DataPipeline/pipeline-content.json" `
                                   -NotebookId $notebookId `
                                   -WorkspaceId $wksToolsId

    fab import "OnyxTools.Workspace/PL - Disabled Notebook Alert.DataPipeline" -i "$PSScriptRoot/PL - Disabled Notebook Alert.DataPipeline" -f

}

if (-not (Check-SemanticModelExists -WorkspaceName "/OnyxTools.Workspace" -SemanticModelName "Lakehouse Maintenance Report")) {

    fab import "/OnyxTools.Workspace/Lakehouse Maintenance Report.SemanticModel" -i "$PSScriptRoot/Lakehouse Maintenance Report.SemanticModel" -f

    $semanticModelId=Get-SemanticModelId -workspaceName "OnyxTools" -semanticModelName "Lakehouse Maintenance Report"

    Write-Host "Semantic Model Id: $semanticModelId"

    Convert-PBIRByPathToByConnection -PBIRFilePath "$PSScriptRoot\Lakehouse Maintenance Report.Report\definition.pbir" -WorkspaceName "OnyxTools" -SemanticModelName "Lakehouse Maintenance Report" -SemanticModelId $semanticModelId 

    fab import "/OnyxTools.Workspace/Lakehouse Maintenance Report.Report" -i "$PSScriptRoot\Lakehouse Maintenance Report.Report" -f
}
