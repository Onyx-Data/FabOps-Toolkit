## **What it is:**
This tool adds helps to keep audit trail of data ingestion. It takes a snapshot of the data being ingested at a particular ingestion cycle and save as JSON file in the file area of the lakehouse. This tool is a notebook [[NB - Save JSON - Power BI](https://app.powerbi.com/groups/99d86726-bf0e-47a4-ba2c-b882679df8f1/synapsenotebooks/79e836a6-9fdb-4e17-92c6-455b0462c8f2?experience=power-bi)]

## **How to install:**
Import the notebook to your environment.

## **How to use it:**
Run the notebook with mssparkutils and pass the necessary arguments from inside the ingesting notebook.

The parameters of the mssparkutils MUST be changed as need.

- "contenttosave": the piece of data to be saved must be JSON. See below:
![image.png](/.attachments/image-3c287785-2be2-4959-b6c2-2c82f0777f65.png)
- "path": change the path
- "filenameprefix": adjust the file prefix
- "include_hourly": `include_hourly ` is an optional argument that creates hour subfolder. 



See below: 

if hour subfolder is desired run the following code:

`include_hourly = True`

`mssparkutils.notebook.run("NB - Save JSON",arguments= { "contenttosave": content,"path": "AuditTrail/", "filenameprefix": "AuditTrailFile", "ingestionid": executionId, "include_hourly": include_hourly })`

if hour subfolder is not desired:


`mssparkutils.notebook.run("NB - Save JSON",arguments= { "contenttosave": content,"path": "AuditTrail/", "filenameprefix": "AuditTrailFile", "ingestionid": executionId, "include_hourly": include_hourly })`