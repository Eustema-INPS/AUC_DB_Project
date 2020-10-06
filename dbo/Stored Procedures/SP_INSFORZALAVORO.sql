-- =======================================================
-- Author:		Letizia
-- Create date: 2013.07.18
-- Description:	Inserimento un record di AUFOR (forza lavoro)
-- =======================================================
CREATE PROCEDURE [dbo].[SP_INSFORZALAVORO]
	@aufor_posizione varchar(50), 
    @aufor_annomese int,
    @aufor_aupoc_codice_pk int,
    @aufor_num_dip_cert int,
    @aufor_utente_cert_mod varchar(50),
    @appName varchar(50)
AS
BEGIN
   INSERT INTO  [tb_aufor_forze_lavoro] 
   
   (
		aufor_posizione,
		aufor_annomese,
		aufor_aupoc_codice_pk,
	    [aufor_num_dip_cert] ,
		[aufor_stato_certificazione],
		[aufor_data_cert]       ,    
		[aufor_data_cert_mod]  ,     
		[aufor_utente_cert]       ,  
		[aufor_utente_cert_mod]     ,
		[aufor_data_modifica]     ,  
		[aufor_descr_utente]   
	)     
   VALUES
  
		(
		@aufor_posizione,
		@aufor_annomese,
		@aufor_aupoc_codice_pk,
		@aufor_num_dip_cert, 
		1, 
		GETDATE(), 
		GETDATE(), 
		@aufor_utente_cert_mod, 		
		@aufor_utente_cert_mod, 
		GETDATE(), 
		@appName 
		 ) 
  
END

