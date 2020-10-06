

-- =============================================
-- Author:		Raffaele
-- Data:		2014.07.02
-- Descrizione: Creata
-- =============================================
CREATE PROCEDURE [dbo].[SP_ElencoProcedureConcorsuali] 
	
@codice_fiscale_azienda varchar(16)
AS
BEGIN
	SET NOCOUNT ON;

SELECT  'RifProcConc' as TableName,  tb_aucon_concorsuale.aucon_info, 
                         tb_aucon_concorsuale.aucon_data_iscrizione, tb_aucon_concorsuale.aucon_tribunale, tb_aucon_concorsuale.aucon_num_registrazione, 
                         tb_aucon_concorsuale.aucon_data_registrazione, tb_aucon_concorsuale.aucon_localita_uff_registro, tb_aucon_concorsuale.aucon_prov_uff_registro, 
                          tb_aucon_concorsuale.aucon_cod_tipo, tb_aucon_concorsuale.aucon_tipo, 
                         tb_aucon_concorsuale.aucon_data_atto, tb_aucon_concorsuale.aucon_notaio, tb_aucon_concorsuale.aucon_cciaa_fuori_provincia, 
                         tb_aucon_concorsuale.aucon_codice_liquidazione, tb_aucon_concorsuale.aucon_descr_liquidazione, tb_aucon_concorsuale.aucon_data_iscrizione_procedura, 
                         tb_aucon_concorsuale.aucon_codice_atto, tb_aucon_concorsuale.aucon_descrizione_atto, tb_aucon_concorsuale.aucon_data_termine, 
                         tb_aucon_concorsuale.aucon_data_omologazione, tb_aucon_concorsuale.aucon_data_chiusura, tb_aucon_concorsuale.aucon_data_esecuzione, 
                         tb_aucon_concorsuale.aucon_data_revoca, tb_aucon_concorsuale.aucon_Proposta_Concordato, tb_aucon_concorsuale.aucon_Annotazioni_Procedure, 
                         tb_aucon_concorsuale.aucon_Accordi_Debiti, tb_aucon_concorsuale.aucon_Rapporto_Curatore, tb_aucon_concorsuale.aucon_Appelli_Reclami, 
                         tb_aucon_concorsuale.aucon_Esercizio_Provvisorio, tb_aucon_concorsuale.aucon_Continuazione_Esercizio_Provv, 
                         tb_aucon_concorsuale.aucon_Cessazione_Esercizio_Provv, tb_aucon_concorsuale.aucon_Esecuzione_Concordato
FROM            tb_aucon_concorsuale Inner JOIN
                         tb_ausca_sog_contr_az ON tb_aucon_concorsuale.aucon_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk

WHERE        (ausca_codice_fiscale = @codice_fiscale_azienda)


SELECT   'RifDatiAzienda' as TableName,   tb_ausca_sog_contr_az.ausca_denominazione,tb_ausca_sog_contr_az.ausca_DesATECO, tb_ausca_sog_contr_az.ausca_ATECO,    tb_aungi_nat_giur_ct.aungi_descr_breve
            FROM tb_ausca_sog_contr_az INNer JOIN
                         tb_aungi_nat_giur_ct ON tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk
	WHERE        (ausca_codice_fiscale = @codice_fiscale_azienda)

END


