﻿
-- =============================================
-- Autore:		Raffaele Palmieri
-- Data:		09/05/2019
-- Per la posizione fornita in input ritorna un insieme di dati relativi 
-- alla produzione di un tracciato record da fornire, tramite intermediario, a SISPI
-- Se la posizione non viene fornita ritorna -1
-- Se la posizione non esiste ritorna -2
-- Modificata da: Raffaele
-- Data:		18/06/2019
-- Descrizione:		Aggiunto l'attributo aupoc_attivita_dichiarata in output 
-- =============================================
CREATE PROCEDURE [dbo].[EX_Posizione_SISPI] @posizione varchar(50)
AS
SET NOCOUNT ON;

BEGIN

    if @posizione is null
	   return -1 --la posizione non è stata fornita

	IF ( EXISTS
		(Select aupoc_codice_pk FROM  tb_aupoc_pos_contr
			where aupoc_aurea_codice_pk = 1 and aupoc_ausca_codice_Pk > 2 and @posizione = aupoc_posizione) )
		begin

			select aupoc_posizione as AZMATRICOLA,
					aungi_descr_breve as AZCLAS,
					aupoc_denom_posiz_contr as AZDENAZI,
					aupoc_desATECO as AZATTECO,
					auind_toponimo as AZPRSTRA,
					auind_indirizzo as AZNOMVIA,
					auind_civico as AZNUMCIV,
					auind_cap as AZCAP,
					auind_descr_comune as AZCOMUNE,
					auind_sigla_provincia as AZSIGPRO,
					'' as AZPRETEL,
					ausca_telefono1 as AZNUMTEL,
					'' as AZPRETE2,
					ausca_telefono2 as AZNUMTE2,
					'' as AZPREFAX,
					ausca_fax as AZNUMFAX,
					ausca_codice_fiscale as AZCODFIS,
					ausca_piva as AZPARIVA,
					aupoc_ateco as AZISTAT,
					aupco_cod_stat_contr as AZCSC,
					ausca_email as AZMAIL,
					aupoc_cod_sede_INPS as AZCDSEDE,
					convert(date,aupoc_data_ultimo_stato) as AZCESAZI,
					auspc_codice as AZTIPCES,
					auate_cod_ateco_complessivo as TATECO07,
					ausca_pec as AZPEC,
					aupoc_attivita_dichiarata as AZATTECO
			from tb_aupoc_pos_contr
			inner join tb_ausca_sog_contr_az on ausca_codice_pk = aupoc_ausca_codice_pk
			left outer join tb_aungi_nat_giur_ct on ausca_aungi_codice_pk = aungi_codice_pk
			left outer join tb_auind_indirizzi on auind_tabella_codice_pk = aupoc_codice_pk and auind_tabella = 'AUPOC'
			left outer join tb_aupco_periodo_contr on aupoc_codice_pk = aupco_aupoc_codice_pk 
			left outer join tb_auate_cod_ateco_ct on auate_codice_pk = aupco_auate_2007_codice_pk
			left outer join tb_auspc_stato_pos_contr_ct on aupoc_auspc_codice_pk = auspc_codice_pk
			where aupoc_aurea_codice_pk = 1 and aupoc_ausca_codice_Pk > 2 and
			convert(date,getdate()) >= convert(date,aupco_data_inizio_validita) and
			convert(date,getdate()) <= convert(date,aupco_data_fine_validita) and
			@posizione = aupoc_posizione
	 end
	 else
		return -2 --la posizione non esiste		
END

