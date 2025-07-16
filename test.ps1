
echo  starting

. "$PSScriptRoot\reusable.ps1"

Convert-PBIRByPathToByConnection -PBIRFilePath "$PSScriptRoot\Lakehouse Maintenance Report.Report\definition.pbir" -WorkspaceName "OnyxTools" -SemanticModelId "7fcc1088-feb6-4cee-9ec0-72cb893113bb" -SemanticModelName "Lakehouse Maintenance Report"