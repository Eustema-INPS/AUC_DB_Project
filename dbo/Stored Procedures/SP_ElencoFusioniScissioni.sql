

-- =============================================
-- Author:		Letizia Bellantoni
-- Data:		2014.07.14
-- Descrizione: Creata
-- =============================================
CREATE PROCEDURE [dbo].[SP_ElencoFusioniScissioni] 
	
@codice_fiscale_azienda varchar(16)
	
AS
BEGIN
	SET NOCOUNT ON;

SELECT   'RifDatiFusSciss' as TableName,   tb_aufus_fusioni_scissioni.aufus_codice_pk, tb_aufus_fusioni_scissioni.aufus_approvazione, tb_aufus_fusioni_scissioni.aufus_c_evento, tb_aufus_fusioni_scissioni.aufus_evento, 
                      tb_aufus_fusioni_scissioni.aufus_data_iscrizione, tb_aufus_fusioni_scissioni.aufus_data_mod_evento, tb_aufus_fusioni_scissioni.aufus_data_delibera, 
                      tb_aufus_fusioni_scissioni.aufus_data_atto_esecuzione, tb_aufus_fusioni_scissioni.aufus_data_atto, tb_aueve_eventi.aueve_prog_societa, 
                      tb_aueve_eventi.aueve_denominazione, tb_aueve_eventi.aueve_comune, tb_aueve_eventi.aueve_codice_fiscale, tb_aueve_eventi.aueve_cciaa, 
                      tb_aueve_eventi.aueve_n_rea,aueve_codice_pk
FROM         
tb_aufus_fusioni_scissioni INNER JOIN
tb_aueve_eventi ON tb_aufus_fusioni_scissioni.aufus_codice_pk = tb_aueve_eventi.aueve_aufus_codice_pk INNER JOIN
tb_ausca_sog_contr_az ON tb_aufus_fusioni_scissioni.aufus_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk

WHERE        (ausca_codice_fiscale = @codice_fiscale_azienda)


SELECT    'RifDatiAzienda' as TableName,   tb_ausca_sog_contr_az.ausca_denominazione,tb_ausca_sog_contr_az.ausca_DesATECO, tb_ausca_sog_contr_az.ausca_ATECO,    tb_aungi_nat_giur_ct.aungi_descr_breve
            FROM tb_ausca_sog_contr_az INNer JOIN
                         tb_aungi_nat_giur_ct ON tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk
	WHERE        (ausca_codice_fiscale = @codice_fiscale_azienda)

END


