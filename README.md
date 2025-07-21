# Microsoft Fabric Open Source Tools

This repository contains a collection of open-source tools designed to enhance the operational efficiency, reliability, and manageability of your Microsoft Fabric environment.

Each tool addresses a specific need or gap encountered when using Fabric Lakehouses, SQL Endpoints, Notebooks, and ingestion processes.

## Tools Overview

### 🔧 Lakehouse Maintenance Tool
Performs essential delta table maintenance operations such as file compaction and cleanup. Tracks top query performance and table statistics during each run to monitor lakehouse health over time.

### 🚨 Disabled Notebook Alert
Detects and alerts when a notebook schedule has been silently disabled after repeated failures. Helps prevent unnoticed stoppages in critical pipelines.

### 🔄 SQL Endpoint Refresh Tool
Refreshes SQL Endpoints post-data ingestion to ensure metadata consistency and avoid query issues related to recent changes in lakehouse content.

### 🧱 SCD Type 2 Tool
Implements Slowly Changing Dimensions Type 2 logic with minimal configuration. Automatically handles insertions, updates, and historicization for dimension records.

### 🧭 Shortcut Identification Tool
Identifies and flags shortcuts in a lakehouse to exclude them from maintenance operations and avoid redundant processing.

### 📥 Save JSON Tool
Captures and stores raw JSON data during ingestion processes, providing a verifiable snapshot of the original input—especially important when working with APIs.

## Documentation

See the `docs/` folder for detailed explanation of when and why each tool is used.

---

Contributions, issues, and feedback are welcome!
