-- =======================================================
-- Author:		Maurizio Picone
-- Create date: 28 Ottobre 2012
-- Description:	Modifica un record di AUFOR (forza lavoro)
-- =======================================================
CREATE PROCEDURE [dbo].[SP_UPDFORZALAVORO]
	@aufor_posizione varchar(50), 
    @aufor_annomese int,
    @aufor_num_dip_cert int,
    @aufor_utente_cert_mod varchar(50),
    @appName varchar(50)
AS
BEGIN
   SET NOCOUNT ON;

   UPDATE [tb_aufor_forze_lavoro] 
   
   SET  [aufor_num_dip_cert] = @aufor_num_dip_cert, 
		[aufor_stato_certificazione] = 1, 
		[aufor_data_cert]            = GETDATE(), 
		[aufor_data_cert_mod]        = GETDATE(), 
		[aufor_utente_cert]          = @aufor_utente_cert_mod, 		
		[aufor_utente_cert_mod]      = @aufor_utente_cert_mod, 
		[aufor_data_modifica]        = GETDATE(), 
		[aufor_descr_utente]         = @appName 
   
   WHERE aufor_posizione = @aufor_posizione AND aufor_annomese = @aufor_annomese
END
