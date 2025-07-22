# 🧭 Shortcut Identification Tool – When and Why

## Problem

Microsoft Fabric lakehouses can contain both:
- **Regular tables**
- **Shortcuts**: pointers to tables in other lakehouses or OneLake sources.

Some operations, such as optimization or table-level metrics, should **not be applied** to shortcuts. Trying to do so may:
- Cause failures
- Lead to redundant computation
- Distort metrics or data lineage

## Why this tool matters

This tool:
- Scans a lakehouse to identify which items are shortcuts.
- Produces a list that other tools can use to **exclude these entries** during maintenance or processing.

This prevents accidental misuse and improves the accuracy and safety of your lakehouse operations.

## When to use it

- As a **pre-step** in any lakehouse-wide batch operation (e.g., vacuum, optimize, lineage building).
- When building tools that traverse table lists.

## References

- [How Shortcuts affect Lakehouse’s Maintenance] (https://www.red-gate.com/simple-talk/blogs/how-shortcuts-affect-lakehouses-maintenance/)