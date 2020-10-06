-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 2013-07-31
-- Description:	<Description,,>
-- =============================================
-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017-08-11
-- Description:	AI3116 - aggiunta campi
-- =============================================
CREATE PROCEDURE [dbo].[AZ_SingolaUnitaLocale]
@auulo_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;

 SELECT 
       [auulo_Progressivo_localizz]
      ,[auulo_Tipo_localizz]
      ,[auulo_descr_tipo_localizz]
      ,[auulo_tipo_iscr]
      ,[auulo_descr_tipo_iscr]
      ,[auulo_denominazione]
      ,[auulo_nrea_ul]
      ,[auulo_nrea_ul_cciaa]
      ,[auulo_data_apertura]
      ,[auulo_data_cessazione]
      ,[auulo_flag_cessazione]
      ,[auulo_data_denuncia_cessazione]
      ,[auulo_descr_sotto_tipo1]auulo_descr_sotto_tipo1
      ,[auulo_sotto_tipo1]
      ,[auulo_descr_sotto_tipo2]
      ,[auulo_sotto_tipo2]
      ,[auulo_descr_sotto_tipo3]
      ,[auulo_sotto_tipo3]
      ,[auulo_descr_sotto_tipo4]
      ,[auulo_sotto_tipo4]
      ,[auulo_descr_sotto_tipo5]
      ,[auulo_sotto_tipo5]
      --aggiornamento Letizia 20130731
			, auulo_altre_indicazioni
      ,[auulo_comune]
      ,[auulo_sigla_prov]
      ,[auulo_toponimo]
      ,[auulo_descr_toponimo]
      ,[auulo_via]
      ,[auulo_civico]
      ,[auulo_cap]
      --aggiornamento Letizia 20130731
			   ,auulo_Cod_Ateco2007
			   ,auulo_DesAteco2007
      ,[auulo_stato_estero]
      ,[auulo_frazione]
	  --AI3116:
	  ,[auulo_insegna]
	   ,[auulo_cod_istat_comune]
	   ,[auulo_cod_stradario]
	   ,[auulo_telefono]
	   ,[auulo_fax]
	   ,[auulo_cod_causa_cess]
	   ,[auulo_art_categoria]
	   ,[auulo_art_descr_categoria]
	   ,[auulo_art_num_iscrizione_ruolo]
	   ,[auulo_art_provincia_iscrizione_ruolo]
	   ,[auulo_art_data_accertamento]
	   ,[auulo_art_data_domanda]
	   ,[auulo_art_data_domanda_accertamento]
	   ,[auulo_art_data_iscrizione]
	   ,[auulo_art_data_delibera]
	   ,[auulo_art_data_iscrizione_inizio]
	   ,[auulo_art_data_inizio]
	   ,[auulo_art_info_suppl]
	   ,[auulo_art_causale_cess]
	   ,[auulo_art_descr_causale_cess]
	   ,[auulo_art_data_domanda_accert_cess]
	   ,[auulo_art_data_delibera_cess]
	   ,[auulo_art_data_cessazione]
	   ,[auulo_art_descrizione_attivita]
	   --AI3116.

  FROM [dbo].[tb_auulo_unita_locale]
  where auulo_codice_pk = @auulo_codice_pk 

END
