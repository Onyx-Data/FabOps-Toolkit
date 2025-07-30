How to Set Up the Shortcut Identification System
================================================

This guide provides a detailed walkthrough for setting up and using the "Shortcut Identification System." This solution allows you to programmatically list, inspect, and verify shortcut tables within a Lakehouse environment.

Setting Parameters
------------------

Before execution, define the following parameters in the notebook's initial cell. These parameters are required for identifying the workspace and lakehouse where shortcuts reside.

**Parameters Cell:**


```
workspace_id = "your-workspace-guid"
lakehouse_id = "your-lakehouse-guid"
```

Listing Shortcut Tables
-----------------------

The notebook retrieves all shortcut tables present in the specified Lakehouse. It authenticates using a Fabric API token and queries the relevant endpoint. The results are displayed in a tabular format for easy inspection.
*   If shortcuts are found, their details are shown.
*   If no shortcuts are found, a message is displayed.

Checking if a Table is a Shortcut
---------------------------------

You can check whether a specific table name corresponds to a shortcut table:
*   Set the `input_name` variable to the table or shortcut name you want to check.
*   The notebook will compare this name (case-insensitive) against the list of shortcuts.
*   It will print whether the given name is a shortcut table or not.

**Example:**

`input_name = "DummyData"  # Replace with your table/shortcut name`

Integration and Usage
---------------------

This notebook can be used as a standalone tool for Lakehouse maintenance or integrated into broader data management workflows. It is especially useful for:
*   Auditing shortcut usage
*   Validating shortcut configurations
*   Troubleshooting data access issues related to shortcuts

## **See Also**

- [Discover more about this tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Onyx-Tools/shortcut-identification)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/README.md)

