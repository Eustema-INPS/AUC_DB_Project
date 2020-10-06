-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 2015.20.02
-- Description:	Per un CF restituisce la PEC se e solo se esiste un'unica pec per quel codice
-- =============================================
-- Output
-- 0 : PEC UNICA NON PRESENTE
-- PEC
--- La presente stored è stata incapsulata nella SP_CFtoPEC  
--- per motivi di compatibilità di utilizzo del cliente

CREATE PROCEDURE [dbo].[EX_CFtoPECUnica] 	@CF varchar(16) 
AS
BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @RetCode as Varchar(500) = '0'
	
	if 1= (select count(ausca_codice_fiscale) FROM [AUC].[dbo].[tb_ausca_sog_contr_az]
         where ausca_PEC=(select ausca_PEC 
         FROM [AUC].[dbo].[tb_ausca_sog_contr_az]
         where ausca_codice_fiscale=@CF))
 
 	BEGIN
		SELECT @RetCode = Isnull(ausca_PEC,'1')
		FROM [dbo].[tb_ausca_sog_contr_az]
		WHERE ausca_codice_fiscale = @CF
	END
			
	SELECT @RetCode As PEC
	
END
