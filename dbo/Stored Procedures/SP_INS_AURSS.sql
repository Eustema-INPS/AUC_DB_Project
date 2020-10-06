-- ========================================================================================================
-- Author:			Raffaele
-- Create date: 
-- Description:		La stored effettua l’inserimento di un record su AURSS.

-- Author:			Peter 
-- Modified date:	2014.08.04
-- Action item:		2050
-- Description:     modifiche per compatibilità con il nuovo metodo "Aggiorna" di WSAggiornaAnagrUnicaContr
--
-- ========================================================================================================
CREATE PROCEDURE [dbo].[SP_INS_AURSS] 
	-- Add the parameters for the stored procedure here
	 @aurss_ausca_codice_pk int       --codice azienda
	,@aurss_ausco_codice_pk int       --codice soggetto collegato
	,@aurss_descr_utente varchar(50)  -- utente che effettua l’operazione
	--AI 2050: parametri inutili, resi facoltativi, lasciati solo per compatibilità con riferimenti già esistenti a questa SP
	,@ausco_codice_fiscale varchar(16) = null
	,@ausco_denominazione varchar(405) = null
	,@ausco_cognome varchar(255) = null
	,@ausco_nome varchar(150) = null
	,@ausco_tipo_persona varchar(1) = null
	--AI 2050.
	,@aurss_aussu_codice_pk int
	,@aurss_autis_codice_pk int = null      		
	,@aurss_rappresentante_legale varchar(1) = null
	--AI 2050:
	,@aurss_codice_carica varchar(4) = null
	,@aurss_data_inizio_validita datetime = null
	,@aurss_data_di_fine_validita datetime = null
	,@aurss_provenienza varchar(30) = null
	--AI 2050.
		  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--AI 2050:
DECLARE @codice_entita_rif integer = null
SET @codice_entita_rif = 
(
		SELECT TOP 1 [auapp_codice_pk]
		FROM [dbo].[tb_auapp_appl] 
		WHERE auapp_app_name = @aurss_descr_utente
)

--AI 2050.

INSERT INTO [dbo].[tb_aurss_rel_sog_sog]
           ([aurss_ausca_codice_pk]
           ,[aurss_ausco_codice_pk]
           ,[aurss_aussu_codice_pk]
           ,[aurss_autis_codice_pk]
           ,[aurss_data_inizio_validita]
           ,[aurss_data_di_fine_validita]
           ,[aurss_data_iscr_libro_soci]
           ,[aurss_data_atto_di_nomina]
           ,[aurss_data_nomina]
           ,[aurss_data_fine_carica]
           ,[aurss_note]
           ,[aurss_rappresentante_legale]
		   --AI 2050:
		   ,[aurss_codice_carica]
		   ,[aurss_provenienza]
			,[aurss_auten_codice_pk]
			,[aurss_codice_entita_rif]
		   --AI 2050.
           ,[aurss_data_modifica]
           ,[aurss_descr_utente])
VALUES (
@aurss_ausca_codice_pk,
 @aurss_ausco_codice_pk,
 @aurss_aussu_codice_pk,
 @aurss_autis_codice_pk,
 ISNULL(@aurss_data_inizio_validita, GETDATE()), 
 ISNULL(@aurss_data_di_fine_validita, '29991231'), 
 null,         -- ,[aurss_data_iscr_libro_soci]
 null,         -- ,[aurss_data_atto_di_nomina]
 null,         -- ,[aurss_data_nomina]
 null,         -- ,[aurss_data_fine_carica]
 null,         -- ,[aurss_note]
@aurss_rappresentante_legale,
--AI 2050:
@aurss_codice_carica,
@aurss_provenienza,
3, --[aurss_auten_codice_pk]
@codice_entita_rif,
--AI 2050.
GETDATE(),
@aurss_descr_utente
)

    -- Insert statements for procedure here

	DECLARE @codice_pk integer,
			@id integer;
			SELECT SCOPE_IDENTITY() AS id;
			set @codice_pk = @id;
	
	
END

