# 🧱 SCD Type 2 Tool – When and Why

## ⚠️ Problem – Fake Data, False Decisions

Most analytical models must preserve a **history of changes** in dimension records. For example:
- Customers moving from one city to another
- Products being renamed or reclassified
- Regions being reorganized
- Pricing evolving over time

Without **Slowly Changing Dimension (SCD) Type 2** logic, you’re not just missing history — you’re introducing **false information** into your analytics.

> 🔥 Imagine this:  
> A customer buys a bicycle while living in Rome.  
> A year later, they move to London.  
> If you overwrite the customer’s address without preserving history, every historical order — including that bicycle purchase — will now show up as being from **London**, not Rome.  
> 
> ❗That’s not outdated data. That’s **fake data**.

It gets worse: You may be basing strategic decisions, KPI dashboards, and machine learning models on **data that never actually happened**.

Now ask yourself:
- How many similar **invisible errors** might already exist in your model?
- How many facts are now tied to **wrong dimensions** because history was lost?
- How many customer, product, or region changes have silently corrupted your historical insight?

## ✅ Why this tool matters

Implementing SCD Type 2 logic manually is tedious, complex, and highly error-prone:
- You must detect changes precisely
- Expire old versions correctly (using end dates)
- Insert new versions with valid timeframes
- Maintain surrogate key consistency

This tool automates all of that for you.

You simply provide:
- The current state of the dimension table
- A new snapshot (e.g., today's version)

The tool will:
- Compare based on natural keys and tracking columns
- Insert a new row **only when something changed**
- Expire the old row with the correct `EndDateTime`
- Keep your dimension table **historically accurate and trustworthy**

## 📅 When to use it

Use this tool in **any dimensional model** where past and present states coexist — especially in:

- Customer dimensions (addresses, status, segments)
- Product dimensions (categories, brands, SKUs)
- Organizational structures (region, branch, territory)
- Any table where history matters and overwriting records would cause **data lies**

If you’re using Power BI or any other BI tool, incorrect dimensions don’t just pollute your data — they corrupt the stories your dashboards tell.

✅ Don’t risk making decisions based on a version of history that **never happened**.

## See Also

- [Setup the tools](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Setup.md)
- [Configure SCD type 2 Tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/How-to-Set-Up-Tool-docs/SCD-type-2-Tool.md)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/README.md)
