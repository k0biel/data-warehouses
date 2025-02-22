USE [developer_dw];
GO

INSERT INTO [dbo].[DimJunk] (IsDelayed)
SELECT IsDelayed
FROM 
	  (
		VALUES 
			  (0)  -- NieopóŸnione
			, (1)  -- OpóŸnione
	  ) 
	AS DelayStatus(IsDelayed);
GO
