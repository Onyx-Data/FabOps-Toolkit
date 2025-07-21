# 📥 Save JSON Tool – When and Why

## Problem

Ingesting data from APIs or external systems can be unpredictable:
- API schema may change without notice
- Data quality may vary between calls
- Some records may cause parsing failures or data loss

When things go wrong, you need to **see exactly what was ingested**.

## Why this tool matters

This tool allows you to:
- Save the raw JSON response from an API or ingestion source
- Store it in OneLake or another location for traceability

This enables:
- Debugging ingestion errors
- Reprocessing failed data without re-calling the API
- Providing an **audit trail** of what data was accepted

## When to use it

- For any ingestion process from dynamic APIs
- When working with external systems where contracts may change
- In regulated environments where **data lineage** matters
