# 🔄 SQL Endpoint Refresh Tool – When and Why

## Problem

SQL Endpoints in Fabric are **serverless** and operate on cached metadata views of your lakehouse content. After ingestion or schema changes:
- Newly created tables may not be visible in SQL Endpoint queries.
- Recently added columns or updated schemas may cause query errors.
- Query plans may not be updated, leading to stale or incorrect results.

These issues can impact downstream analytics, BI dashboards, or applications that rely on SQL connectivity.

## Why this tool matters

This tool allows you to explicitly **refresh SQL Endpoints** after ingestion or structural changes. This ensures:
- Metadata reflects the latest state of the lakehouse.
- Query results are up-to-date and accurate.
- You reduce the risk of query failures from schema mismatches.

## When to use it

- Run immediately after ingestion or ETL jobs that:
  - Create new tables
  - Drop and recreate tables
  - Alter schemas
- Include in orchestration pipelines for **data freshness guarantees**.
