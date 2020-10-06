

-- =============================================
-- Author:		Letizia Bellantoni
-- Data:		2014.09.14
-- Descrizione: Creata
-- =============================================
CREATE PROCEDURE [dbo].[SP_ElencoConflFusioni] 
	
@codice_fiscale_azienda varchar(16)
	
AS
BEGIN
	SET NOCOUNT ON;
--Dati provenienti da fusioni
SELECT        tb_ausca_sog_contr_az.ausca_codice_gestione AS id_gestionale, tb_ausca_sog_contr_az.ausca_codice_fiscale AS codicefiscale, 
                         tb_aueve_eventi.aueve_codice_fiscale AS codfiscfusione, tb_aueve_eventi.aueve_denominazione AS denominazione, CASE ISNULL(aufus_data_atto, '01/01/1900') 
                         WHEN '01/01/1900' THEN aufus_data_atto_esecuzione ELSE aufus_data_atto END AS data, CONVERT(int, CASE LEFT(aufus_c_evento, 1) 
                         WHEN 'F' THEN '1' + RIGHT(aufus_c_evento, 2) WHEN 'S' THEN '2' + RIGHT(aufus_c_evento, 2) END) AS tipo, 
                         tb_aufus_fusioni_scissioni.aufus_evento AS descrTipo
FROM            tb_aufus_fusioni_scissioni INNER JOIN
                         tb_aueve_eventi ON tb_aufus_fusioni_scissioni.aufus_codice_pk = tb_aueve_eventi.aueve_aufus_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aufus_fusioni_scissioni.aufus_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE        (LEN(tb_aufus_fusioni_scissioni.aufus_c_evento) = 3) AND (tb_ausca_sog_contr_az.ausca_codice_fiscale = @codice_fiscale_azienda)

UNION
--Dati provenienti da pos. contributive
SELECT        tb_ausca_sog_contr_az.ausca_codice_gestione AS id_gestionale, tb_aupoc_pos_contr.aupoc_cf_confluito AS codicefiscale, 
                         tb_ausca_sog_contr_az.ausca_codice_fiscale AS codfiscfusione, tb_ausca_sog_contr_az_1.ausca_denominazione AS Denominazione, 
                         CASE ISNULL(aupoc_data_ultimo_stato, '01/01/1900') WHEN '01/01/1900' THEN aupoc_data_ultimo_stato ELSE aupoc_data_ultimo_stato END AS data, '301' AS tipo, 
                         'Confluito' AS descrTipo
FROM            tb_ausca_sog_contr_az INNER JOIN
                         tb_aupoc_pos_contr ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk AND 
                         tb_ausca_sog_contr_az.ausca_codice_fiscale <> tb_aupoc_pos_contr.aupoc_cf_confluito LEFT OUTER JOIN
                         tb_ausca_sog_contr_az AS tb_ausca_sog_contr_az_1 ON tb_aupoc_pos_contr.aupoc_cf_confluito = tb_ausca_sog_contr_az_1.ausca_codice_fiscale
WHERE        (tb_aupoc_pos_contr.aupoc_cf_confluito IS NOT NULL) AND (tb_aupoc_pos_contr.aupoc_cf_confluito <> '') AND 
                         (tb_ausca_sog_contr_az.ausca_codice_fiscale = @codice_fiscale_azienda)
GROUP BY tb_ausca_sog_contr_az.ausca_codice_gestione, tb_aupoc_pos_contr.aupoc_cf_confluito, tb_ausca_sog_contr_az.ausca_codice_fiscale, 
                         tb_ausca_sog_contr_az_1.ausca_denominazione, tb_aupoc_pos_contr.aupoc_data_ultimo_stato

UNION
--Dati provenienti da gestione separata
SELECT        tb_aucfc_cfconfluiti.aucfc_codice_gestione as id_gestionale, 
				tb_aucfc_cfconfluiti.aucfc_cf_confluenza AS codicefiscale, 
				Aucfc_cf AS codfiscfusione, 
				tb_ausca_sog_contr_az.ausca_denominazione  AS Denominazione, 
				aucfc_data_fine AS data, 
				'401' AS tipo, 
				'Confluiti Gestione Separata' AS DescrTipo
FROM            tb_aucfc_cfconfluiti INNER JOIN
                tb_ausca_sog_contr_az ON tb_aucfc_cfconfluiti.aucfc_ausca_codice_PK = tb_ausca_sog_contr_az.ausca_codice_pk
where  (tb_ausca_sog_contr_az.ausca_codice_fiscale = @codice_fiscale_azienda)




END


