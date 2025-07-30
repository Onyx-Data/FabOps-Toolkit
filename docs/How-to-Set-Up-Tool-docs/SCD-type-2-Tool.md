## **How to use it:**
The user defined functions - _**addSCDFields**_ in the notebook can be called from data ingesting notebook with **_%RUN_** that allows sharing of the user defined functions in the ingesting notebooks. 


Run the lines of code below in your notebook ingesting data:


1. `%run NB - Py Common`

1. save the new data in variable _df_new_

1. `df_new = addSCDFields(df_new)` - adds SCD columns

1. read and save existing data in another variable _df_old_

1. `final_df = merge_scd_type2(df_old,df_new,'KeyColumn')` - track changes and merge the two dataframes. 

## **See Also**

- [Discover more about this tool](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/docs/Onyx-Tools/scd-type-2)
- [Home](https://github.com/Onyx-Data/FabOps-Toolkit/blob/main/README.md)
