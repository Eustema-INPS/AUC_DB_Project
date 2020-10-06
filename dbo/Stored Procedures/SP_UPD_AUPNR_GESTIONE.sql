


-- =============================================
-- Author:		Peter Dimpflmeier
-- Create date: 2016.01.22
-- Description:	AI 2069
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_AUPNR_GESTIONE]
	-- Add the parameters for the stored procedure here
	@codiceFiscale [varchar](16),
	@utente [varchar](20) = null,
	@righeModificate [int] = null out

AS
BEGIN
	
	SET NOCOUNT ON;

UPDATE [tb_aupnr_procedure_per_nrc]
SET            
[aupnr_gestione_pc] = 0,
[aupnr_data_modifica] = getdate(), 
[aupnr_descr_utente] = isnull(@utente,'Modifica Utente' )

WHERE
aupnr_codice_fiscale = @codiceFiscale
--Per effettuare l’aggiornamento il cf deve esistere ed il valore di gestione_pc deve essere pari a 1 e la data di invio della mail non deve essere null
and aupnr_gestione_pc = 1
--and aupnr_data_invio_email is not null		   

set @righeModificate = @@ROWCOUNT

END




