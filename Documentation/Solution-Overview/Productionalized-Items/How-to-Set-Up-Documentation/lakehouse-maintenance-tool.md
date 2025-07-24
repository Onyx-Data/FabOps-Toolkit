# 🧹 Lakehouse Maintenance Tool – How to Use

## **What it is:**

Every Fabric Lakehouse uses **Delta tables**, and over time, these tables accumulate metadata and small data files that **degrade performance**, increase storage usage, and can even cause **SQL Endpoint failures**.

This tool helps **automate essential Lakehouse maintenance** by:
- Running `OPTIMIZE` to compact small files and improve query performance
- Running `VACUUM` to remove outdated data files and free up storage
- Collecting **performance baselines** of top queries (by execution count, duration, and scan size)
- Capturing metadata about each table (number of files, total size, and row count)

This regular housekeeping ensures a **healthy SQL Endpoint environment**, and minimizes the risk of stale, fragmented, or slow queries.

> ℹ️ You can optionally integrate this tool with the **SQL Endpoint Refresh Tool** to ensure query results reflect the latest optimized and ingested data.  
> _(Insert link to that tool’s documentation here)_

---

## **How to Install:**

Please follow the [setup instructions in `setup.md`](./setup.md) to install the tool and its dependencies.

This will also install the **Lakehouse Maintenance Report**, a Power BI report used to visualize and analyze the metadata and performance data collected by this tool.

---

## **Configuration steps:**

1. **Open `NB - Performance Baseline` notebook**  
   - Go to **cell 2** and replace the `WorkspaceId` and `SQLEndpointId` with the correct IDs for your environment.  
   ![screenshot-placeholder](path-to-your-image.png)

2. **(Optional) Adjust filters or logic in the notebook** if you'd like to focus on specific query types or time periods.

3. **Open `NB - Optimize Lakehouse` notebook**  
   - This notebook will run `OPTIMIZE` and `VACUUM` across selected tables to reduce file count and improve performance.

4. **Open `NB - Load Lakehouse Maintenance Data` notebook**  
   - This notebook loads and organizes metadata produced by the two other notebooks for use in the Lakehouse Maintenance Report.

---

## **How to use it:**

1. **Schedule `NB - Optimize Lakehouse`**  
   - Recommended to run during off-peak hours, e.g., **8 AM every Monday**.

2. **Schedule `NB - Load Lakehouse Maintenance Data`**  
   - Run **after** the Optimize notebook finishes, e.g., **9 AM every Monday**.

3. **Schedule or run `NB - Performance Baseline`**  
   - Can be run manually or periodically (e.g., once a month) to evaluate query behavior over time.

4. **Use the Power BI report (`Lakehouse Maintenance Report`)**  
   - This report (installed during setup) helps you:
     - Visualize table size growth and file fragmentation
     - Monitor which queries are consuming the most resources
     - Detect tables or endpoints that require more frequent maintenance

---

## **Tips & Notes:**

- ✅ This tool is **non-disruptive** when scheduled wisely — avoid overlapping with ingestion jobs.
- 🔍 Metadata and performance logs can help with **scaling**, **troubleshooting**, or **auditing**.
- 📊 Use the report to **track the health of your lakehouse over time** and catch problems before they affect business reporting.
