# 📥 Save JSON Tool – When and Why

## 🧩 Problem – Can You Prove What Was Ingested?

In modern data architectures like the **Medallion architecture**, raw data is ingested and passed through multiple stages of transformation — from raw to bronze, silver, and gold layers. By the time the data reaches the BI dashboards or analytical models, it may be **deeply transformed, filtered, aggregated, or joined**.

Now imagine a scenario where someone questions the accuracy of a dashboard number:
- Why is this customer missing?
- Why does this total seem too low?
- Why is the format of this field inconsistent?

To answer those questions, you must **trace the data lineage** back to the moment it was first received — and that’s only possible if you kept a precise copy of the **raw ingested data**.

Without it, you're stuck:
- Guessing whether the data arrived malformed
- Re-ingesting (if the API even allows it)
- Struggling to reconstruct what the pipeline actually received

## ✅ Why this tool matters

The **Save JSON Tool** solves this gap by letting you **persist the raw data** exactly as it was received from the source — before any transformation or parsing occurs.

It enables:
- Full traceability and data lineage across all transformation layers
- Post-mortem investigations

## Folder Structure

The image of the ingested data is saved in the files area of the lakehouse. The tool uses the structure below.

![architecture](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/images/savejson.png)

## See Also

- [Setup the tools](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Setup.md)
- [Configure Save JSON tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/How-to-Set-Up-Tool-docs/Save-JSON-tool.md)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/README.md)

## References

- [Microsoft Fabric: Ingesting from API’s and the JSON result] (https://www.red-gate.com/simple-talk/blogs/microsoft-fabric-ingesting-from-apis-and-the-json-result/)
