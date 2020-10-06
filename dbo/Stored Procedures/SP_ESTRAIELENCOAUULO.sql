-- =============================================
-- Author:		Letizia
-- Create date: 2014.09.24
-- Description:	SP richiamata dal WS EstraiDatiAuulo
-- =============================================
CREATE PROCEDURE [dbo].[SP_ESTRAIELENCOAUULO]
@codice_fiscale_azienda varchar(16)
	
AS
BEGIN
	
SET NOCOUNT ON;
SELECT        tb_auulo_unita_locale.auulo_codice_pk, tb_auulo_unita_locale.auulo_Progressivo_localizz, tb_auulo_unita_locale.auulo_Tipo_localizz, 
                         tb_auulo_unita_locale.auulo_descr_tipo_localizz, tb_auulo_unita_locale.auulo_descr_tipo_iscr, tb_auulo_unita_locale.auulo_denominazione, 
                         tb_auulo_unita_locale.auulo_data_apertura, tb_auulo_unita_locale.auulo_flag_cessazione, tb_auulo_unita_locale.auulo_data_cessazione, 
                         tb_auulo_unita_locale.auulo_descr_sotto_tipo1, tb_auulo_unita_locale.auulo_sotto_tipo1, tb_auulo_unita_locale.auulo_descr_sotto_tipo2, 
                         tb_auulo_unita_locale.auulo_sotto_tipo2, tb_auulo_unita_locale.auulo_sotto_tipo3, tb_auulo_unita_locale.auulo_descr_sotto_tipo4, 
                         tb_auulo_unita_locale.auulo_sotto_tipo4, tb_auulo_unita_locale.auulo_descr_sotto_tipo5, tb_auulo_unita_locale.auulo_sotto_tipo5, 
                         tb_auulo_unita_locale.auulo_comune, tb_auulo_unita_locale.auulo_sigla_prov, tb_auulo_unita_locale.auulo_codice_comune, 
                         tb_auulo_unita_locale.auulo_toponimo, tb_auulo_unita_locale.auulo_descr_toponimo, tb_auulo_unita_locale.auulo_via, tb_auulo_unita_locale.auulo_civico, 
                         tb_auulo_unita_locale.auulo_cap, tb_auulo_unita_locale.auulo_codice_stato_estero, tb_auulo_unita_locale.auulo_stato_estero, 
                         tb_auulo_unita_locale.auulo_frazione, tb_auulo_unita_locale.Auulo_nrea_ul, tb_auulo_unita_locale.Auulo_nrea_ul_cciaa, 
                         tb_auulo_unita_locale.auulo_descr_sotto_tipo3, 
                         tb_auulo_unita_locale.auulo_data_denuncia_cessazione, tb_auulo_unita_locale.auulo_tipo_iscr, tb_auulo_unita_locale.auulo_Cod_Ateco2007, 
                         tb_auulo_unita_locale.auulo_DesAteco2007, tb_auulo_unita_locale.auulo_Importanza, tb_auulo_unita_locale.auulo_DataInizio 
                      
FROM            tb_auulo_unita_locale INNER JOIN
                         tb_ausca_sog_contr_az ON tb_auulo_unita_locale.auulo_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE        (tb_ausca_sog_contr_az.ausca_codice_fiscale = @codice_fiscale_azienda)
END

