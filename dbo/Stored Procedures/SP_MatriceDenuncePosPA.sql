-- ===============================================================================================
-- Author:		Italo Paioletti
-- Create date: 26/10/2017
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_MatriceDenuncePosPA] 
	@DtInizio date, 
	@DtFine date
	AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
	
		IF IsNull(@DtInizio,'29991231') = '29991231' SET @DtInizio = '20170101'  
		IF IsNull(@DtFine,'29991231')   = '29991231' SET @DtFine  = GETDATE()  
		
		SELECT 
		   [DataRicezione] As 'Data Ricezione',
		   [TotaleAtterrateAccoglienza] As 'Tot. Accoglienza' ,
		   [TotaleAtterrateUniemensPosPA] As 'Tot. PosPA',
		   [TotalePrelevateSIN]  As 'Tot. Prelevate SIN (0Z)'
		FROM [AUC].[dbo].[TB_AUDEN_DENUNCE_MATRICE]
		WHERE [DataRicezione] BETWEEN @DtInizio AND @DtFine
		AND CONVERT(bigint,Lotto) = ( SELECT MAX(CONVERT(bigint,Lotto)) 
									  FROM [AUC].[dbo].[TB_AUDEN_DENUNCE_MATRICE]  
									   WHERE [DataRicezione] between @DtInizio and @DtFine
									)
		GROUP BY [DataRicezione],[TotaleAtterrateAccoglienza] ,[TotaleAtterrateUniemensPosPA] ,[TotalePrelevateSIN]
		ORDER BY [DataRicezione] DESC
		
	END
	
	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END
