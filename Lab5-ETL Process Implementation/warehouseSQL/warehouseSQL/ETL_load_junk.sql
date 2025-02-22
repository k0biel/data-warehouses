USE [developer_dw];
GO

INSERT INTO [dbo].[DimJunk] (IsDelayed)
SELECT IsDelayed
FROM 
	  (
		VALUES 
			  (0)  -- Nieopóźnione
			, (1)  -- Opóźnione
	  ) 
	AS DelayStatus(IsDelayed);
GO
