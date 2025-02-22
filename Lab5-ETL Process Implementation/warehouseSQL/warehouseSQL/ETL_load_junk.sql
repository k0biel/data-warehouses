USE [developer_dw];
GO

INSERT INTO [dbo].[DimJunk] (IsDelayed)
SELECT IsDelayed
FROM 
	  (
		VALUES 
			  (0)  -- Nieop�nione
			, (1)  -- Op�nione
	  ) 
	AS DelayStatus(IsDelayed);
GO
