# 🧱 SCD Type 2 Tool – When and Why

## Problem

Many analytical models require keeping a **history of changes** to dimension records. For example:
- Customer address changes
- Product description updates
- Changes in pricing or categorization

Doing this manually involves complex logic:
- Compare incoming and current records
- Detect changes while ignoring unchanged rows
- Expire old records (with end timestamps)
- Insert new ones with correct validity dates

This is error-prone and time-consuming.

## Why this tool matters

This tool automates the SCD Type 2 pattern. You simply provide:
- The current state of the dimension table
- The incoming updates (new snapshot)

The tool:
- Compares records based on natural key and change columns
- Inserts new rows only if something has changed
- Expires the old row properly (sets an EndDate)
- Ensures time-valid data integrity

## When to use it

- In any dimensional modeling where **historical accuracy** matters.
- In slowly changing dimensions like Customer, Product, Location, etc.
- When integrating with Power BI or analytical tools where current and past state must coexist.
