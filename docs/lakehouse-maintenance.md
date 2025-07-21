# 🔧 Lakehouse Maintenance Tool – When and Why

## Problem

Delta tables in Microsoft Fabric Lakehouses accumulate **many small files** and **obsolete data versions** over time. These fragments are byproducts of common operations such as streaming ingestion, append-only loads, or frequent updates.

Consequences include:
- Degraded query performance due to metadata bloat and excessive file scanning.
- Failures in SQL Endpoints that try to query these large volumes of unmanaged small files.
- Increased storage costs from outdated file versions that are no longer relevant.

## Why this tool matters

The tool performs two critical operations:
- **Optimize**: Combines many small files into larger ones, drastically improving read performance and reducing metadata overhead.
- **Vacuum**: Cleans up obsolete files that are no longer part of the current table snapshot, reclaiming storage and avoiding endpoint issues.

Additionally, it logs:
- Top 15 most expensive queries by multiple metrics (duration, IO, CPU).
- File counts for each table before and after maintenance.

These logs allow teams to **track trends over time**, ensuring maintenance is improving system health and not just applied blindly.

## When to use it

- Run on a **regular schedule** (e.g., daily, weekly) depending on data volume.
- Particularly useful before heavy querying periods or releases.
- Should be paired with monitoring dashboards for query and table health.
