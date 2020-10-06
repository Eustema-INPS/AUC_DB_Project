

-- =============================================
-- Author:		Peter
-- AI 2050
-- Create date: 2014-08-27
-- Description:	La stored effettua l’aggiornamento di un record su AURSS.
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_AURSS] 
	-- Add the parameters for the stored procedure here
	@aurss_codice_pk int
	,@aurss_ausca_codice_pk int = null      --codice azienda
	,@aurss_ausco_codice_pk int = null       --codice soggetto collegato
	,@aurss_descr_utente varchar(50) = null  -- utente che effettua l’operazione
	,@aurss_aussu_codice_pk int = null
	,@aurss_autis_codice_pk int = null       		
	,@aurss_rappresentante_legale varchar(1) = null
	,@aurss_codice_carica varchar(4) = null
	,@aurss_data_inizio_validita datetime = null
	,@aurss_data_di_fine_validita datetime = null
	,@aurss_provenienza varchar(30) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
UPDATE [dbo].[tb_aurss_rel_sog_sog]
SET
aurss_ausca_codice_pk       =  ISNULL(@aurss_ausca_codice_pk         ,    aurss_ausca_codice_pk           ),
aurss_ausco_codice_pk       =  ISNULL(@aurss_ausco_codice_pk         ,    aurss_ausco_codice_pk           ),
aurss_descr_utente			=  ISNULL(@aurss_descr_utente			 ,    aurss_descr_utente              ),
aurss_aussu_codice_pk       =  ISNULL(@aurss_aussu_codice_pk         ,    aurss_aussu_codice_pk           ),
aurss_autis_codice_pk       =  ISNULL(@aurss_autis_codice_pk         ,    aurss_autis_codice_pk           ),
aurss_rappresentante_legale =  ISNULL(@aurss_rappresentante_legale   ,    aurss_rappresentante_legale     ),
aurss_codice_carica			=  ISNULL(@aurss_codice_carica           ,    aurss_codice_carica             ),
aurss_data_inizio_validita  =  ISNULL(@aurss_data_inizio_validita    ,    aurss_data_inizio_validita      ),
aurss_data_di_fine_validita =  ISNULL(@aurss_data_di_fine_validita   ,    aurss_data_di_fine_validita     ),
aurss_provenienza           =  ISNULL(@aurss_provenienza             ,    aurss_provenienza               ),
aurss_data_modifica         =  getdate()

WHERE 
aurss_codice_pk             = @aurss_codice_pk
           
;

	
END



