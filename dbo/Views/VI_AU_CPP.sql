









CREATE VIEW [dbo].[VI_AU_CPP]
AS
SELECT 
ausin_codice_sede as Sede_4_Cifre,
'46010' AS Cod14O,
case when aupoc_provenienza_iscr = '4' then convert(date,aupoc_data_iscrizione_provvisoria) 
	else convert(date,aupoc_data_domanda_iscr) end AS DataInizio,
convert(date,aupoc_data_validazione) as DataAccoglimento, 
aupoc_posizione as MatricolaAzienda,
ausca_codice_fiscale AS CodiceFiscale,
'' AS NumeroPratica,
aupoc_denom_posiz_contr AS Denominazione,
aungi_codice_forma AS CodiceClassificazione, 
aungi_descr_breve AS Classificazione,
convert(date,aupoc_data_inizio_attivita) AS DataInizioAttivita,
'ACCOLTA' AS Esito
  FROM [AUC].[dbo].[tb_aupoc_pos_contr]
  inner join tb_ausin_sedi_inps_ct on aupoc_ausin_codice_pk = ausin_codice_pk
  inner join tb_ausca_sog_contr_az on aupoc_ausca_codice_pk = ausca_codice_pk
  inner join tb_aungi_nat_giur_ct on aungi_codice_pk = ausca_aungi_codice_pk 
  where 
   aupoc_prov_acquisizione IN ('33333333', '55555555') or aupoc_provenienza_iscr = '4'










