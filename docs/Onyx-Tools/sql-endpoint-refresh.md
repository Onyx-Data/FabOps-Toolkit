# 🔄 SQL Endpoint Refresh Tool – When and Why

## Problem

SQL Endpoints in Microsoft Fabric are **serverless** and rely on **cached metadata and data snapshots** from the lakehouse. While they attempt to **auto-refresh** metadata and data periodically, this process is **not always reliable or timely**, especially under certain conditions:

- When the **number of files in the lakehouse is too high**, automatic refreshes become less frequent or may **fail silently**, leading to **stale query results**.
- After **long periods of inactivity**, SQL Endpoints may shut down. The first query on the next day (or after many hours) may be served from **outdated cached metadata**, missing tables or schema changes that occurred during the downtime.
- If ingestions occur **overnight or outside business hours**, the first query in the morning might not reflect those updates unless a refresh is triggered explicitly.

These issues can lead to:
- Queries not finding recently ingested data
- Schema mismatch errors when accessing recently changed tables
- BI dashboards displaying outdated metrics
- Broken dependencies in downstream pipelines

⚠️ These are **silent issues** – there are usually **no warnings or errors** indicating that the data is stale.

## Why this tool matters

This tool offers a reliable and programmable way to **explicitly refresh SQL Endpoints** as part of your ingestion or orchestration process.

Using this tool:
- Ensures that **data and metadata are up-to-date** for downstream consumption.
- Prevents users from querying **stale or incomplete data**.
- Eliminates the guesswork around whether a refresh has happened automatically.
- Helps enforce **data freshness guarantees** for analytics, dashboards, and AI workloads.

## When to use it

You should include this tool in **every ingestion or ETL pipeline** that loads or modifies data in a lakehouse that is consumed via SQL Endpoints.

Typical scenarios:
- After ingesting new data
- After creating or dropping tables
- After altering table schemas (e.g., adding columns)
- After vacuum/optimize/compaction processes

Even if no schema change occurs, a **refresh should still be triggered** to update the cached state of the data.

## Additional recommendation

If you are experiencing issues with SQL Endpoint freshness due to high file counts in the lakehouse, consider also using the [Lakehouse Maintenance Tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Onyx-Tools/lakehouse-maintenance.md) to reduce file fragmentation and improve SQL Endpoint responsiveness.

---

## See Also

- [Setup the tools](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Setup.md)
- [Configure SQL Endpoint Refresh Tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/How-to-Set-Up-Tool-docs/SQL-Endpoint-Refresh-Tool.md)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/README.md)


## References

- [SQL Endpoint Secrets you need to know](https://www.red-gate.com/simple-talk/blogs/sql-endpoint-secrets-you-need-to-know/)
