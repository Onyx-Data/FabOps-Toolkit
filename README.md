# Microsoft Fabric Open Source Tools

This repository contains a collection of open-source tools designed to enhance the operational efficiency, reliability, and manageability of your Microsoft Fabric environment.

Each tool addresses a specific need or gap encountered when using Fabric Lakehouses, SQL Endpoints, Notebooks, and ingestion processes.

How to setup the Tools : [Setup](/Documentation/Production/docs/Setup)

## Tools Overview

### 🔧 Lakehouse Maintenance Tool
Performs essential delta table maintenance operations such as file compaction and cleanup. Tracks top query performance and table statistics during each run to monitor lakehouse health over time.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/lakehouse-maintenance)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/lakehouse-maintenance-tool)

### 🚨 Disabled Notebook Alert
Detects and alerts when a notebook schedule has been silently disabled after repeated failures. Helps prevent unnoticed stoppages in critical pipelines.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/disabled-notebook-alert)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/Notebook-Disabled-Monitoring-Tool)

### 🔄 SQL Endpoint Refresh Tool
Refreshes SQL Endpoints post-data ingestion to ensure metadata consistency and avoid query issues related to recent changes in lakehouse content.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/sql-endpoint-refresh)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/SQL-Endpoint-Refresh-Tool)

### 🧱 SCD Type 2 Tool
Implements Slowly Changing Dimensions Type 2 logic with minimal configuration. Automatically handles insertions, updates, and historicization for dimension records.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/scd-type-2)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/SCD-type-2-Tool)

### 🧭 Shortcut Identification Tool
Identifies and flags shortcuts in a lakehouse to exclude them from maintenance operations and avoid redundant processing.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/shortcut-identification)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/Shortcut-Identification-System)
### 📥 Save JSON Tool
Captures and stores raw JSON data during ingestion processes, providing a verifiable snapshot of the original input—especially important when working with APIs.

[Discover more about this tool](/Documentation/Production/docs/Onyx-Tools/save-json)

[Check the setup and usage instructions](/Documentation/Production/docs/How-to-Set-Up-Tool-docs/Save-JSON-tool)

## Documentation

See the `docs/` folder for detailed explanation of when and why each tool is used.

---

Contributions, issues, and feedback are welcome!
