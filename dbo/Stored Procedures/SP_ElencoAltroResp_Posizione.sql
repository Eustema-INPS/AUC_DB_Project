-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2014.10.17
-- Description:	Stored Procedure per caricare gli altri responsabili della posizione contributiva

-- =============================================
-- =============================================
-- Modificata da: Letizia
-- Data:		2015.04.27
-- Descrizione:	AI 3106
-- =============================================
CREATE PROCEDURE [dbo].[SP_ElencoAltroResp_Posizione]
	 @posizione varchar(50) 
	,@DataInizio DATETIME = NULL
    ,@DataFine DATETIME = NULL

AS
BEGIN
	
	SET NOCOUNT ON;
	
     

	SELECT
		tb_ausco_sog_contr_col.ausco_codice_pk,     
		tb_ausco_sog_contr_col.ausco_codice_fiscale , 
		tb_ausco_sog_contr_col.ausco_cognome , 
		tb_ausco_sog_contr_col.ausco_nome , 
		tb_ausco_sog_contr_col.ausco_sesso ,
		ausco_cittadinanza,
		ausco_comune_nascita,
		ausco_data_nascita ,
        ausco_prov_nascita ,
        ausco_stato_estero_nascita,
        ausco_tipo_persona ,
        ausco_codice_toponimo ,
        ausco_toponimo ,
        ausco_indirizzo ,
        ausco_civico ,
        ausco_cap ,
        ausco_codice_comune ,
        ausco_localita ,
        ausco_provincia ,
        ausco_sigla_nazione ,
        ausco_codice_stato_estero ,
        ausco_telefono ,
        ausco_fax,
        ausco_email ,
        ausco_pec ,
        ausco_legalmail ,
        ausco_note ,
        ausco_denominazione ,
		autis_descr,
		
			
		case
			when ([aursp_data_inizio_validita] IS null) then 
				CONVERT(varchar(10),'01/01/1900',103) 
			else CONVERT(varchar(10),[aursp_data_inizio_validita],103)
		end as data_inizio_validita,
		
		case
			when ([aursp_data_di_fine_validita] IS null) then 
				CONVERT(varchar(10),'31/12/2999',103) 
			else CONVERT(varchar(10),[aursp_data_di_fine_validita],103)
		end as data_di_fine_validita
	
		
	
	FROM         
		tb_ausco_sog_contr_col INNER JOIN
		tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.[aursp_autis_codice_pk] = tb_autis_tipo_sog_col_ct.autis_codice_pk  INNER join
		tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk 
		
	
	WHERE [tb_aupoc_pos_contr].[aupoc_posizione] = @posizione 
	--AI 3106
	--non si prendono in considerazione i collaboratori (artigiani e commercianti)
	and aursp_autis_codice_pk<>163
	--AI 3106
	

	
END

