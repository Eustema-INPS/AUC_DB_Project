-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 2015.20.02
-- Description:	Per un CF restituisce la PEC se e solo se esiste un'unica pec per quel codice
-- =============================================
-- Output
-- 0 : PEC UNICA NON PRESENTE
-- PEC

CREATE PROCEDURE [dbo].[SP_CFtoPEC] 	@CF varchar(16) 
with recompile
AS

BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @RetCode as Varchar(500) = '0'
	
	if 1= (select count(ausca_codice_fiscale) FROM [AUC].[dbo].[tb_ausca_sog_contr_az]
         where ausca_PEC=(select ausca_PEC 
         FROM [AUC].[dbo].[tb_ausca_sog_contr_az]
         where ausca_codice_fiscale=@CF AND Right(rtrim(ausca_PEC),24) <>  '@POSTACERTIFICATA.GOV.IT'))
 
 	BEGIN
		SELECT @RetCode = Isnull(ausca_PEC,'1')
		FROM [dbo].[tb_ausca_sog_contr_az]
		WHERE ausca_codice_fiscale = @CF AND Right(rtrim(ausca_PEC),24) <>  '@POSTACERTIFICATA.GOV.IT'
	END
			
	SELECT @RetCode As PEC
	
END
