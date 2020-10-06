
-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2014.10.17
-- Description:	Stored Procedure per caricare i Rappresentanti Legali dell'azienda della posizione contributiva

-- =============================================
CREATE PROCEDURE [dbo].[SP_ElencoRappLegale_Posizione]
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
		autis_descr ,
		autis_codice_carica,
		tb_ausca_sog_contr_az.ausca_pec,
		case
			when (tb_aurss_rel_sog_sog.aurss_relazione_certificata IS null) then 
				'N'
			else tb_aurss_rel_sog_sog.aurss_relazione_certificata
		end as aurss_relazione_certificata,
		
		case
			when (tb_aurss_rel_sog_sog.aurss_data_inizio_validita IS null) then 
				CONVERT(varchar(10),'01/01/1900',103) 
			else CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_inizio_validita,103)
		end as data_inizio_validita,
		
		case
			when (tb_aurss_rel_sog_sog.aurss_data_di_fine_validita IS null) then 
				CONVERT(varchar(10),'31/12/2999',103) 
			else CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_di_fine_validita,103)
		end as data_di_fine_validita

	
	FROM         
		tb_ausca_sog_contr_az INNER JOIN
		tb_aurss_rel_sog_sog ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk INNER JOIN
		tb_ausco_sog_contr_col ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
		[tb_aupoc_pos_contr] ON [tb_aupoc_pos_contr].[aupoc_ausca_codice_pk]=tb_ausca_sog_contr_az.ausca_codice_pk
	WHERE [tb_aupoc_pos_contr].[aupoc_posizione] = @posizione 
	AND aurss_rappresentante_legale = 'S' 
	--AND
	--(
	--((tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
	--(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )) or 
	--(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita is null)
	--or (tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null)	
	--)   

	
END

