-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2016.10.26
-- Description:	Estrae le relazioni afferenti ad un soggetto collegato 
-- =============================================

CREATE PROCEDURE  [dbo].[EX_Alert_Dipendenti]
	@codice_fiscale_SoggColl varchar(16)	

--Il codice fiscale del soggetto fisico
--Il codice fiscale del soggetto contribuente
--La partita iva del soggetto contribuente
--La ragione sociale del soggetto contribuente
--La natura giuridica (due caratteri) del soggetto contribuente
--La descrizione della natura giuridica del soggetto contribuente
--La camera di commercio del soggetto contribuente
--Il numero rea del soggetto contribuente
--Il codice della carica ricoperta (tre caratteri)
--La descrizione della carica ricoperta
--La data di inizio validità
--La data di fine validità
--Il codice ateco 1991
--Il codice ateco 2002
--Il codice ateco 2007
	
AS

BEGIN

	SET NOCOUNT ON;
	select
	ausco_codice_fiscale as CF_SoggettoCollegato,
    tb_ausca_sog_contr_az.ausca_codice_fiscale AS CF_SoggettoContribuente,
	ausca_piva as PartitaIva,
	ausca_denominazione as RagioneSociale,
	aungi_codice_forma as NaturaGiuridica,
	aungi_descr_breve as DescrizioneNaturaGiuridica,
	ausca_cciaa as CameraCommercio,
	ausca_n_rea as NumeroREA,
	autis_codice_carica as CodiceCarica,
	autis_descr as DescrizioneCarica,
	convert(date,tb_aurss_rel_sog_sog.aurss_data_inizio_validita) as DataInizioRelazione,
	convert(date,tb_aurss_rel_sog_sog.aurss_data_di_fine_validita) as DataFineRelazione,
    (SELECT LEFT(auate_cod_ateco_complessivo + '000000', 6)
  
		  FROM   tb_auate_cod_ateco_ct 
		  WHERE  tb_auate_cod_ateco_ct.auate_codice_pk = [ausca_auate_1991_codice_pk] 
       ) 
       as Ateco1991,
	  (SELECT LEFT(auate_cod_ateco_complessivo + '000000', 6)
		  
		  FROM   tb_auate_cod_ateco_ct 
		  WHERE  tb_auate_cod_ateco_ct.auate_codice_pk = [ausca_auate_2002_codice_pk] 
       ) 
       as Ateco2002,
	  (SELECT LEFT(auate_cod_ateco_complessivo + '0000000', 7)
		  
		  FROM   tb_auate_cod_ateco_ct 
		  WHERE  tb_auate_cod_ateco_ct.auate_codice_pk = [ausca_auate_2007_codice_pk] 
       ) 
       as Ateco2007
	FROM   
	tb_ausco_sog_contr_col WITH (READUNCOMMITTED)
	INNER JOIN	tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk 
	INNER JOIN	tb_autis_tipo_sog_col_ct WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk 
	INNER JOIN	tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
	left outer JOIN tb_aungi_nat_giur_ct with (READUNCOMMITTED) ON ausca_aungi_codice_pk = aungi_codice_pk
	WHERE     tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale_SoggColl
			AND aurss_relazione_certificata = 'S'            						
END
