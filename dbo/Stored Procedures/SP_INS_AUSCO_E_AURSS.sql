


-- =============================================
-- Author:		Raffaele
-- Create date: 
-- Description:	La stored effettua l’inserimento di un record su AUSCO e su AURSS.
-- Modificato da Raffaele il 23 maggio 2014
-- Il codice fiscale del soggetto deve essere memorizzato in maiuscolo
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AUSCO_E_AURSS] 
	-- Add the parameters for the stored procedure here
	@aurss_ausca_codice_pk int ,      --codice azienda
	@aurss_ausco_codice_pk int ,      --codice soggetto collegato
	@aurss_descr_utente varchar(50),  -- utente che effettua l’operazione
	@ausco_codice_fiscale varchar(16),
	@ausco_denominazione varchar(405),
	@ausco_cognome varchar(255),
	@ausco_nome varchar(150),
	@aurss_aussu_codice_pk int ,      		
	@aurss_autis_codice_pk int,       		
	@aurss_rappresentante_legale varchar(1),
	@ausco_tipo_persona varchar(1)
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

INSERT INTO [dbo].[tb_ausco_sog_contr_col]
           ([ausco_codice_fiscale]
           ,[ausco_denominazione]
           ,[ausco_cognome]
           ,[ausco_nome]
           ,[ausco_sesso]
           ,[ausco_cittadinanza]
           ,[ausco_comune_nascita]
           ,[ausco_data_nascita]
           ,[ausco_prov_nascita]
           ,[ausco_stato_estero_nascita]
           ,[ausco_tipo_persona]
           ,[ausco_codice_qualita_ind]
           ,[ausco_codice_toponimo]
           ,[ausco_toponimo]
           ,[ausco_frazione]
           ,[ausco_localita]
           ,[ausco_indirizzo]
           ,[ausco_civico]
           ,[ausco_cap]
           ,[ausco_codice_comune_istat]
           ,[ausco_codice_comune]
           ,[ausco_provincia]
           ,[ausco_sigla_nazione]
           ,[ausco_codice_stato_estero]
           ,[ausco_telefono]
           ,[ausco_telefono2]
           ,[ausco_fax]
           ,[ausco_email]
           ,[ausco_pec]
           ,[ausco_legalmail]
           ,[ausco_note]
          ,[ausco_data_modifica]
           ,[ausco_descr_utente])
     VALUES
(upper(@ausco_codice_fiscale),
@ausco_denominazione,
@ausco_cognome,
@ausco_nome,
null,--           ,[ausco_sesso]
null,--           ,[ausco_cittadinanza]
null,--           ,[ausco_comune_nascita]
null,--           ,[ausco_data_nascita]
null,--           ,[ausco_prov_nascita]
null,--           ,[ausco_stato_estero_nascita]
@ausco_tipo_persona,--           ,[ausco_tipo_persona]
null,--           ,[ausco_codice_qualita_ind]
null,--           ,[ausco_codice_toponimo]
null,--           ,[ausco_toponimo]
null,--           ,[ausco_frazione]
null,--           ,[ausco_localita]
null,--           ,[ausco_indirizzo]
null,--           ,[ausco_civico]
null,--           ,[ausco_cap]
null,--           ,[ausco_codice_comune_istat]
null,--           ,[ausco_codice_comune]
null,--           ,[ausco_provincia]
null,--           ,[ausco_sigla_nazione]
null,--           ,[ausco_codice_stato_estero]
--2016.05.13:
--null,--           ,[ausco_telefono]
--null,--           ,[ausco_telefono2]
--null,--           ,[ausco_fax]
'000000',--           ,[ausco_telefono]
'000000',--           ,[ausco_telefono2]
'000000',--           ,[ausco_fax]
--2016.05.13.
null,--           ,[ausco_email]
null,--           ,[ausco_pec]
null,--           ,[ausco_legalmail]
null,--           ,[ausco_note]
GETDATE(),
@aurss_descr_utente);

	DECLARE 
			@id1 integer;
			SELECT @id1=SCOPE_IDENTITY();

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
 			,[aurss_auten_codice_pk]
			,[aurss_codice_entita_rif]
			--AI 2050.
           ,[aurss_data_modifica]
           ,[aurss_descr_utente])
VALUES
(@aurss_ausca_codice_pk,
 @id1,
 @aurss_aussu_codice_pk,
 @aurss_autis_codice_pk,
GETDATE(), 	   -- ,[aurss_data_inizio_validita]
 '29991231',   -- ,[aurss_data_di_fine_validita]
 null,         -- ,[aurss_data_iscr_libro_soci]
 null,         -- ,[aurss_data_atto_di_nomina]
 null,         -- ,[aurss_data_nomina]
 null,         -- ,[aurss_data_fine_carica]
 null,         -- ,[aurss_note]
 @aurss_rappresentante_legale,
--AI 2050:
3, --[aurss_auten_codice_pk]
@codice_entita_rif,
--AI 2050.
 GETDATE(),
 @aurss_descr_utente)

    -- Insert statements for procedure here

--	DECLARE @codice1_pk integer,
--			@id1 integer;
			SELECT isnull(SCOPE_IDENTITY(),0) AS id;
--			set @codice1_pk = @id1;
	
	
END

