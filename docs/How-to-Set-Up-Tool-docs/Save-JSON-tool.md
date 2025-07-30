## **How to use it:**
Run the notebook with mssparkutils and pass the necessary arguments from inside the ingesting notebook.

The parameters of the mssparkutils MUST be changed as need.

- "contenttosave": the piece of data to be saved must be JSON. See below:
![image.png](https://github.com/Onyx-Data/FabOps-Toolkit/docs/images/image-3c287785-2be2-4959-b6c2-2c82f0777f65.png)
- "path": change the path
- "filenameprefix": adjust the file prefix
- "include_hourly": `include_hourly ` is an optional argument that creates hour subfolder. 



See below: 

if hour subfolder is desired run the following code:

`include_hourly = True`

`mssparkutils.notebook.run("NB - Save JSON",arguments= { "contenttosave": content,"path": "AuditTrail/", "filenameprefix": "AuditTrailFile", "ingestionid": executionId, "include_hourly": include_hourly })`

if hour subfolder is not desired:


`mssparkutils.notebook.run("NB - Save JSON",arguments= { "contenttosave": content,"path": "AuditTrail/", "filenameprefix": "AuditTrailFile", "ingestionid": executionId, "include_hourly": include_hourly })`

## **See Also**

- [Discover more about this tool](https://github.com/Onyx-Data/FabOps-Toolkit/docs/Onyx-Tools/save-json)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/README.md)
