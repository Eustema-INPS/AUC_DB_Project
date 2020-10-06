-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	Accesso alla tabella tb_ausco_sog_contr_col   qualificando: 
--				ausco_codice_fiscale= codice fiscale

-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDSOGGCOLLEGATO] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_di_input varchar(16)  
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ausco_codice_pk]
	,[ausco_codice_fiscale]
      ,[ausco_cognome]
      ,[ausco_nome]
      ,[ausco_sesso]
      ,[ausco_cittadinanza]
      ,[ausco_comune_nascita]
      ,[ausco_data_nascita]
      ,[ausco_prov_nascita]
      ,[ausco_stato_estero_nascita]
      ,[ausco_tipo_persona]
      ,[ausco_codice_toponimo]
      ,[ausco_toponimo]
      ,[ausco_indirizzo]
      ,[ausco_civico]
      ,[ausco_cap]
      ,[ausco_codice_comune]
      ,[ausco_localita]
      ,[ausco_provincia]
      ,[ausco_sigla_nazione]
      ,[ausco_codice_stato_estero]
      ,[ausco_telefono]
      ,[ausco_fax]
      ,[ausco_email]
      ,[ausco_pec]
      ,[ausco_legalmail]
      ,[ausco_note]
      ,[ausco_data_modifica]
      ,[ausco_descr_utente]
      ,[ausco_denominazione]
  FROM  [dbo].[tb_ausco_sog_contr_col]
  WHERE ausco_codice_fiscale= @codice_fiscale_di_input
END
