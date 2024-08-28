
INSERT INTO [dbo].[cust_details]
           ([Client_Num]
           ,[Customer_Age]
           ,[Gender]
           ,[Dependent_Count]
           ,[Education_Level]
           ,[Marital_Status]
           ,[State_cd]
           ,[Zipcode]
           ,[Car_Owner]
           ,[House_Owner]
           ,[Personal_loan]
           ,[Contact]
           ,[Customer_Job]
           ,[Income]
           ,[Cust_Satisfaction_Score])

SELECT [Client_Num]
           ,[Customer_Age]
           ,[Gender]
           ,[Dependent_Count]
           ,[Education_Level]
           ,[Marital_Status]
           ,[State_cd]
           ,[Zipcode]
           ,[Car_Owner]
           ,[House_Owner]
           ,[Personal_loan]
           ,[Contact]
           ,[Customer_Job]
           ,[Income]
           ,[Cust_Satisfaction_Score]

FROM [dbo].[cust_add];


