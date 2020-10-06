-- ===============================================================================================
-- Author:		Italo Paioletti
-- Create date: 26/10/2017
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_PrelevamentoDenuncePosPA] 
	@DtInizio date, 
	@DtFine date
	AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
	
		IF IsNull(@DtInizio,'29991231') = '29991231' SET @DtInizio = '20170101'  
		IF IsNull(@DtFine,'29991231')   = '29991231' SET @DtFine  = GETDATE()  
		
		SELECT 
			Lotto,
			[DataFinePrelevamento] As 'Data Fine Prelevamento',
			[Totale] As 'Totale Prelevate SIN (0Z)'
		FROM [dbo].[TB_AUPRE_DENUNCE_PRELEVAMENTO]
		WHERE [DataFinePrelevamento] BETWEEN @DtInizio AND @DtFine
		AND CONVERT(bigint,Lotto) = ( SELECT MAX(CONVERT(bigint,Lotto)) 
									  FROM [AUC].[dbo].[TB_AUPRE_DENUNCE_PRELEVAMENTO]  
									   WHERE [DataFinePrelevamento] between @DtInizio and @DtFine
									)
		--GROUP BY [DataRicezione],[TotaleAtterrateAccoglienza] ,[TotaleAtterrateUniemensPosPA] ,[TotalePrelevateSIN]
		ORDER BY [DataFinePrelevamento] DESC

		

	END
	
	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END
