## **What it is:** 
Notebooks get disabled after about 4 consecutive failures without any notification. This is a big problem for critical notebook to disabled without anyone noticing. 

This tool is designed to send notification when such happens. This currently consist of a notebook [NB - Check Disabled Notebooks - Power BI](https://app.powerbi.com/groups/99d86726-bf0e-47a4-ba2c-b882679df8f1/synapsenotebooks/6ccafa73-1280-4cd7-b684-0ee65a4af72c?experience=power-bi) and a pipeline [PL - Disabled Notebook Alert - Power BI](https://app.powerbi.com/groups/99d86726-bf0e-47a4-ba2c-b882679df8f1/pipelines/32623d0b-6402-4eb2-9049-a0f233836f44?experience=power-bi)

## **How to install:** 
To install this tool,
- import the notebook and the pipeline to your environment.

- Edit the notebook, add the workspaces the notebooks are located in cell 2 and also add list of critical notebooks to be monitored in code cell 4.

See Below: 
- ![image.png](/.attachments/image-4c202558-fa54-42fd-99ce-45a5fd811256.png)

- Edit the pipeline, select the outlook activity, go to settings tab, sign in the outlook activity, allow access and add email(s) to be notified, 

see below:

![image.png](/.attachments/image-3719f41f-8c0d-4e06-88d9-fbff5f30aa48.png)





**to send notification to multiple emails, separate with ";" for example:** 

`francis.folaranmi@onyxdata.co.uk;dennes.torres@onyxdata.co.uk;leon@onyxdata.co.uk`

## **How to use it:**

After installation, schedule the pipeline to run at suitable frequency
