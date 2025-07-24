# Microsoft Fabric Open Source Tools

This repository contains a collection of open-source tools designed to enhance the operational efficiency, reliability, and manageability of your Microsoft Fabric environment.

Each tool addresses a specific need or gap encountered when using Fabric Lakehouses, SQL Endpoints, Notebooks, and ingestion processes.

How to setup the Tools : [Setup](docs/setup.md)

## Tools Overview

### 🔧 Lakehouse Maintenance Tool
Performs essential delta table maintenance operations such as file compaction and cleanup. Tracks top query performance and table statistics during each run to monitor lakehouse health over time.

[Discover more about this tool](docs/lakehouse-maintenance.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/lakehouse-maintenance-tool.md)

### 🚨 Disabled Notebook Alert
Detects and alerts when a notebook schedule has been silently disabled after repeated failures. Helps prevent unnoticed stoppages in critical pipelines.

[Discover more about this tool](docs/disabled-notebook-alert.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/Notebook-Disabled-Monitoring-Tool.md)


### 🔄 SQL Endpoint Refresh Tool
Refreshes SQL Endpoints post-data ingestion to ensure metadata consistency and avoid query issues related to recent changes in lakehouse content.

[Discover more about this tool](docs/sql-endpoint-refresh.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/SQL-Endpoint-Refresh-Tool.md)

### 🧱 SCD Type 2 Tool
Implements Slowly Changing Dimensions Type 2 logic with minimal configuration. Automatically handles insertions, updates, and historicization for dimension records.

[Discover more about this tool](docs/scd-type-2.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/SCD-type-2-Tool.md)

### 🧭 Shortcut Identification Tool
Identifies and flags shortcuts in a lakehouse to exclude them from maintenance operations and avoid redundant processing.

[Discover more about this tool](docs/shortcut-identification.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/Shortcut-Identification-System.md)

### 📥 Save JSON Tool
Captures and stores raw JSON data during ingestion processes, providing a verifiable snapshot of the original input—especially important when working with APIs.

[Discover more about this tool](docs/save-json.md)

[Check the setup and usage instructions](Documentation/Solution-Overview/Productionalized-Items/How-to-Set-Up-Documentation/Save-JSON-tool.md)

## Documentation

See the `docs/` folder for detailed explanation of when and why each tool is used.

---

Contributions, issues, and feedback are welcome!
