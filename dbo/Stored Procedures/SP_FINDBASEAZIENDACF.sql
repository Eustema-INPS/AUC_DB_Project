-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della tabella tb_ausca_sog_contr_az
-- =============================================


CREATE PROCEDURE [dbo].[SP_FINDBASEAZIENDACF] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_di_input varchar(16) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT	
	   [ausca_codice_pk],
	   [ausca_codice_toponimo]
	  ,[ausca_codice_fiscale]
	  ,[ausca_denominazione]
      ,[ausca_indirizzo]
      ,[ausca_civico]
      ,[ausca_localita]
      ,[ausca_sede_legale_italia]
      ,[ausca_descr_comune]
      ,[ausca_frazione]
      ,[ausca_sigla_provincia]
      ,[ausca_regione]
      ,[ausca_codice_stato_estero]
      ,[ausca_cap]
	  ,[ausca_toponimo]
      ,[ausca_n_rea]
      
	  --2014.04.17: se cognome e nome sono nulli in AUSCA, si leggono da AUSCO
      --,[ausca_cognome] -- rel.2      
      --,[ausca_nome] -- rel.2
      ,ISNULL([ausca_cognome], [ausco_cognome]) as ausca_cognome      
      ,ISNULL([ausca_nome], [ausco_nome]) as ausca_nome      
	  --2014.04.17.

      ,[ausca_codice_comune_istat] -- rel.2
      ,[ausca_codice_qualita_ind] -- rel.2
      ,[ausca_contro_codice] -- rel.2

	  --AI 2056:
	  
	  ,[ausca_codice_gruppo_enpals]
	  ,[ausca_codice_gestione]               
	  ,[ausca_provenienza_cert_gs]           
	  ,[ausca_data_certificazione_gs]

	  ,case when ausca_auten_codice_pk = 1 then
		(
		SELECT auute_utenza
		FROM tb_auute_ute_sistema
		WHERE auute_codice_pk = ausca_codice_entita_rif
		)
		when ausca_auten_codice_pk = 2 then
		(
		SELECT auece_descr
		FROM tb_auece_ente_cert
		WHERE auece_codice_pk = ausca_codice_entita_rif
		)
		when ausca_auten_codice_pk = 3 then
		(
		SELECT     tb_aurea_area_gestione.aurea_descrizione
		FROM        tb_auapp_appl LEFT OUTER JOIN
		tb_aurea_area_gestione ON tb_auapp_appl.auapp_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
		WHERE     (tb_auapp_appl.auapp_codice_pk = ausca_codice_entita_rif)
		)
		else 'Non definita'
		end as fonte_acquisizione	 
		 
	  --AI 2056.
 

-- 		FROM         tb_aucfi_cod_fiscale INNER JOIN
--                      tb_ausca_sog_contr_az ON tb_aucfi_cod_fiscale.aucfi_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
--WHERE     (tb_aucfi_cod_fiscale.aucfi_codice_fiscale = @codice_fiscale_di_input)
     
  FROM  [dbo].[tb_ausca_sog_contr_az] 

  --2014.04.17: se cognome e nome sono nulli in AUSCA, si leggono da AUSCO
  left outer join  [dbo].tb_ausco_sog_contr_col
  on tb_ausca_sog_contr_az.ausca_codice_fiscale = tb_ausco_sog_contr_col.ausco_codice_fiscale
  --2014.04.17.
  
  where ausca_codice_fiscale = @codice_fiscale_di_input
END
