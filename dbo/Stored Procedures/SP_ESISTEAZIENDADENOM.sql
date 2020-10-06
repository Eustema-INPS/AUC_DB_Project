-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della tabella tb_ausca_sog_contr_az   qualificando :
--	ausca_denominazione = denominazione di input per tipo operazione = 2
--	ausca_denominazione like ‘denominazione%’  di input per tipo operazione = 3
--	ausca_denominazione like ‘%denominazione%’  di input per tipo operazione = 4
-- Modificato da Raffaele il 2018/07/10
-- Sostituito ausca_codice_comune in ausca_cod_com_Belfiore (AI 2086)
-- =============================================
CREATE PROCEDURE [dbo].[SP_ESISTEAZIENDADENOM] 
	-- Add the parameters for the stored procedure here
	
	@denominazione varchar(405), 
	@tipo_operazione int 
AS
		

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if @tipo_operazione = 2 
		begin
			SELECT [ausca_codice_pk], ausca_denominazione
			,[ausca_codice_fiscale]
			  ,[ausca_aungi_codice_pk]
			  ,[ausca_cciaa]
			  ,[ausca_codice_toponimo]
			  ,[ausca_indirizzo]
			  ,[ausca_civico]
			  ,[ausca_localita]
			  ,[ausca_sede_legale_italia]
			  ,ausca_cod_com_Belfiore --(AI 2086)
			  ,[ausca_descr_comune]
			  ,[ausca_frazione]
			  ,[ausca_sigla_provincia]
			  ,[ausca_regione]
			  ,[ausca_codice_stato_estero]
			  ,[ausca_cap]
			  ,[ausca_telefono1]
			  ,[ausca_telefono2]
			  ,[ausca_telefono3]
			  ,[ausca_fax]
			  ,[ausca_telex]
			  ,[ausca_email]
			  ,[ausca_PEC]
			  ,isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva]) [ausca_legalmail]  -- G.C. 2020-02-18
			  ,[ausca_n_rea]
			  ,[ausca_auate_codice_pk]
			  ,[ausca_soggetto_certificato]
			  ,[ausca_data_variazione_stato]
			  ,[ausca_auten_codice_pk]
			  ,[ausca_codice_entita_rif]
			  ,[ausca_note]
			  ,[ausca_data_modifica]
			  ,[ausca_descr_utente]
			  ,[ausca_toponimo]
				FROM  [dbo].[tb_ausca_sog_contr_az]
				where ausca_denominazione = @denominazione
						end
	else if @tipo_operazione = 3   
		begin
		set @denominazione = @denominazione  + '%'
			SELECT [ausca_codice_pk]
			,[ausca_codice_fiscale], ausca_denominazione
			  ,[ausca_aungi_codice_pk]
			  ,[ausca_cciaa]
			  ,[ausca_codice_toponimo]
			  ,[ausca_indirizzo]
			  ,[ausca_civico]
			  ,[ausca_localita]
			  ,[ausca_sede_legale_italia]
			  ,[ausca_codice_comune]
			  ,[ausca_descr_comune]
			  ,[ausca_frazione]
			  ,[ausca_sigla_provincia]
			  ,[ausca_regione]
			  ,[ausca_codice_stato_estero]
			  ,[ausca_cap]
			  ,[ausca_telefono1]
			  ,[ausca_telefono2]
			  ,[ausca_telefono3]
			  ,[ausca_fax]
			  ,[ausca_telex]
			  ,[ausca_email]
			  ,[ausca_PEC]
			  ,isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva]) [ausca_legalmail]  -- G.C. 2020-02-18
			  ,[ausca_n_rea]
			  ,[ausca_auate_codice_pk]
			  ,[ausca_soggetto_certificato]
			  ,[ausca_data_variazione_stato]
			  ,[ausca_auten_codice_pk]
			  ,[ausca_codice_entita_rif]
			  ,[ausca_note]
			  ,[ausca_data_modifica]
			  ,[ausca_descr_utente]
			  ,[ausca_toponimo]
				FROM  [dbo].[tb_ausca_sog_contr_az]
				where ausca_denominazione like   @denominazione 
		end
	else if @tipo_operazione = 4   
		begin
			set @denominazione = '%' + @denominazione  + '%'
  	SELECT [ausca_codice_pk]
			,[ausca_codice_fiscale], ausca_denominazione
			  ,[ausca_aungi_codice_pk]
			  ,[ausca_cciaa]
			  ,[ausca_codice_toponimo]
			  ,[ausca_indirizzo]
			  ,[ausca_civico]
			  ,[ausca_localita]
			  ,[ausca_sede_legale_italia]
			  ,[ausca_codice_comune]
			  ,[ausca_descr_comune]
			  ,[ausca_frazione]
			  ,[ausca_sigla_provincia]
			  ,[ausca_regione]
			  ,[ausca_codice_stato_estero]
			  ,[ausca_cap]
			  ,[ausca_telefono1]
			  ,[ausca_telefono2]
			  ,[ausca_telefono3]
			  ,[ausca_fax]
			  ,[ausca_telex]
			  ,[ausca_email]
			  ,[ausca_PEC]
			  ,isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva]) [ausca_legalmail]  -- G.C. 2020-02-18
			  ,[ausca_n_rea]
			  ,[ausca_auate_codice_pk]
			  ,[ausca_soggetto_certificato]
			  ,[ausca_data_variazione_stato]
			  ,[ausca_auten_codice_pk]
			  ,[ausca_codice_entita_rif]
			  ,[ausca_note]
			  ,[ausca_data_modifica]
			  ,[ausca_descr_utente]
			  ,[ausca_toponimo]
				FROM  [dbo].[tb_ausca_sog_contr_az]
				where ausca_denominazione like   @denominazione 
			end
			
END

