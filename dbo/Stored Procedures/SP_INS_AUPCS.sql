




-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.10.06
-- Description:	AI2064
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AUPCS]
	-- Add the parameters for the stored procedure here
	@codice_aupoc  int
AS
BEGIN
	
	SET NOCOUNT ON;

	declare @dataModifica as datetime;
	set @dataModifica=getdate();

 INSERT INTO [tb_aupcs_periodo_contr_storico]    
                      ([aupcs_data_modifica]    
                     ,[aupcs_aupoc_codice_pk]    
                     ,[aupcs_data_inizio_validita]    
                     ,[aupcs_data_fine_validita]    
                     ,[aupcs_data_scad_autor]   
                     ,[aupcs_giorni_proroga]   
                     ,[aupcs_cod_stat_contr]   
                     ,[aupcs_codici_autor]   
                     ,[aupcs_lavoratori_autonomi]   
                     ,[aupcs_inserimento]   
                     ,[aupcs_ateco_91]   
                     ,[aupcs_auate_1991_codice_pk]   
                     ,[aupcs_auate_2002_codice_pk]   
                     ,[aupcs_auate_2007_codice_pk]   
                     ,[aupcs_descr_utente])    
		             select    
                     @dataModifica
                      ,@codice_aupoc  
                     ,[aupco_data_inizio_validita]   
                     ,[aupco_data_fine_validita]   
                     ,[aupco_data_scad_autor]   
                     ,[aupco_giorni_proroga]   
                     ,[aupco_cod_stat_contr]   
                     ,[aupco_codici_autor]   
                     ,[aupco_lavoratori_autonomi]   
                     ,[aupco_inserimento]   
                     ,[aupco_ateco_91]   
                     ,[aupco_auate_1991_codice_pk]   
                     ,[aupco_auate_2002_codice_pk]   
                     ,[aupco_auate_2007_codice_pk]   
                     ,[aupco_descr_utente]   
                     from    
                     [tb_aupco_periodo_contr]   
		             where aupco_aupoc_codice_pk=     @codice_aupoc 
	
	
	SELECT isnull(SCOPE_IDENTITY(),0) AS id;
END




