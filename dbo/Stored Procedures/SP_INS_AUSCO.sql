



-- =============================================
-- Author:		Peter
-- Create date: 
-- Description:	La stored effettua l’inserimento di un record su AUSCO 
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AUSCO] 
	
	-- parametri obbligatori
	@ausco_codice_fiscale varchar(16),
	@ausco_tipo_persona varchar(1),

	-- parametri "semi-facoltativi"
	@ausco_denominazione varchar(405) = NULL,
	@ausco_cognome varchar(255) = NULL,
	@ausco_nome varchar(150) = NULL,

	-- parametri facoltativi
	@ausco_data_nascita datetime = NULL,
	@ausco_comune_nascita varchar(50) = NULL,
	@ausco_prov_nascita varchar(2) = NULL,
	@ausco_stato_estero_nascita varchar(4) = NULL,
	@ausco_cittadinanza varchar(4) = NULL,
	@ausco_sesso varchar(1) = NULL,
	@ausco_codice_toponimo varchar(3) = NULL,
	@ausco_toponimo varchar(100) = NULL,
	@ausco_indirizzo varchar(100) = NULL,
	@ausco_civico varchar(50) = NULL,
	@ausco_localita varchar(50) = NULL,
	@ausco_codice_comune varchar(4) = NULL,
	@ausco_codice_comune_istat varchar(6) = NULL,
	@ausco_frazione [varchar](100) = NULL,
	@ausco_provincia varchar(2) = NULL,
	@ausco_cap varchar(5) = NULL,
	@ausco_telefono varchar(20) = NULL,
	@ausco_telefono2 varchar(20) = NULL,
	@ausco_fax varchar(20) = NULL,
	@ausco_email varchar(162) = NULL,
	@ausco_pec varchar(162) = NULL,
	@ausco_codice_stato_estero varchar(4) = NULL,
    @ausco_codice_qualita_ind varchar(1) = NULL,
	@ausco_descr_utente [varchar](50) = null



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--2016.05.11:
	if (@ausco_telefono IS NULL OR ltrim(rtrim(@ausco_telefono)) = '') begin set @ausco_telefono = '000000' end
	if (@ausco_telefono2 IS NULL OR ltrim(rtrim(@ausco_telefono2)) = '') begin set @ausco_telefono2 = '000000' end
	if (@ausco_fax IS NULL OR ltrim(rtrim(@ausco_fax)) = '') begin set @ausco_fax = '000000' end
	--2016.05.11.


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
@ausco_sesso,--           ,[ausco_sesso]
@ausco_cittadinanza,--           ,[ausco_cittadinanza]
@ausco_comune_nascita,--           ,[ausco_comune_nascita]
@ausco_data_nascita,--           ,[ausco_data_nascita]
@ausco_prov_nascita,--           ,[ausco_prov_nascita]
@ausco_stato_estero_nascita,--           ,[ausco_stato_estero_nascita]
@ausco_tipo_persona,--           ,[ausco_tipo_persona]
@ausco_codice_qualita_ind,--           ,[ausco_codice_qualita_ind]
@ausco_codice_toponimo,--           ,[ausco_codice_toponimo]
@ausco_toponimo,--           ,[ausco_toponimo]
@ausco_frazione,--           ,[ausco_frazione]
@ausco_localita,--           ,[ausco_localita]
@ausco_indirizzo,--           ,[ausco_indirizzo]
@ausco_civico,--           ,[ausco_civico]
@ausco_cap,--           ,[ausco_cap]
@ausco_codice_comune_istat,--           ,[ausco_codice_comune_istat]
@ausco_codice_comune,--           ,[ausco_codice_comune]
@ausco_provincia,--           ,[ausco_provincia]
null,--           ,[ausco_sigla_nazione]
@ausco_codice_stato_estero,--           ,[ausco_codice_stato_estero]
@ausco_telefono,--           ,[ausco_telefono]
@ausco_telefono2,--           ,[ausco_telefono2]
@ausco_fax,--           ,[ausco_fax]
@ausco_email,--           ,[ausco_email]
@ausco_pec,--           ,[ausco_pec]
null,--           ,[ausco_legalmail]
null,--           ,[ausco_note]
GETDATE(),
@ausco_descr_utente);

SELECT isnull(SCOPE_IDENTITY(),0) AS id;


END


