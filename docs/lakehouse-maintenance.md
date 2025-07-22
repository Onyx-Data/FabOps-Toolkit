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

## References

Here are some references about the issues which are solved by this tool:

- [Microsoft Fabric and Delta lake secrets] (https://www.red-gate.com/simple-talk/blogs/microsoft-fabric-and-the-delta-tables-secrets/)
- [Using Spark Jobs for Multiple Lakehouse Maintenance in Microsoft Fabric] (https://www.red-gate.com/simple-talk/databases/sql-server/bi-sql-server/using-spark-jobs-for-multiple-lakehouse-maintenance-in-microsoft-fabric/)
- [Fabric Monday 06: Delta Optimization Secrets] (https://www.youtube.com/watch?v=BluZJxfwfCM&list=PLNbt9tnNIlQ5TB-itSbSdYd55-2F1iuMK)
- [Fabric Monday 07: Schedule Optimization Maintenance] (https://www.youtube.com/watch?v=3x2CffbLxTA&list=PLNbt9tnNIlQ5TB-itSbSdYd55-2F1iuMK)
- [Fabric Monday 08: Optimization Maintenance for Multiple Lakehouses] (https://www.youtube.com/watch?v=See6XZ-vx0s&list=PLNbt9tnNIlQ5TB-itSbSdYd55-2F1iuMK)