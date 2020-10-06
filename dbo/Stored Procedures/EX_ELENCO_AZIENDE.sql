
-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2015.03.27
-- Description:	Estrae i dati relativi alle posizioni Padri, figlie e sorelle
-- =============================================
CREATE PROCEDURE  [dbo].[EX_ELENCO_AZIENDE]
	@posizione_contributiva varchar(50)	
AS
declare @aupoc_padre integer;
declare @aupoc_figlia integer;

SET NOCOUNT ON;
BEGIN
IF ( EXISTS  -- Se esiste la posizione PADRE
	 
	 (SELECT     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk 
						 = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre
--WHERE        tb_aupoc_pos_contr.aupoc_posizione = '4804838005')
WHERE        tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
	 ) 
begin
	 set @aupoc_padre = (
	 SELECT    top(1)    tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre
--WHERE        (tb_aupoc_pos_contr.aupoc_posizione = '4804838005')
WHERE        (tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
	 )

SELECT  top(1)   tb_ausca_sog_contr_az.ausca_codice_fiscale AS CodiceFiscale,
                                     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva,
                                     tb_aupoc_pos_contr.aupoc_denom_posiz_contr as Denominazione,
                                     tb_autia_tipo_accentr_ct.autia_codice as TipoAzienda,
                                     tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede,
                                     'PADRE' as TipoRelazione,
                                     tb_auspc_stato_pos_contr_ct.auspc_descr as Stato,
                       tb_aupoc_pos_contr.aupoc_codice_pk as PosizioneContributivaUnicaID,
                                     tb_aupoc_pos_contr.aupoc_contro_codice as PosizioneContributivaUnicaControcodice
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre INNER JOIN
                         tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
                         tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk INNER JOIN
                         tb_autia_tipo_accentr_ct ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
--WHERE        (tb_aupoc_pos_contr.aupoc_posizione = '4804838005')
WHERE        (tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
union all
SELECT     tb_ausca_sog_contr_az.ausca_codice_fiscale AS CodiceFiscale,
                                     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva,
                                     tb_aupoc_pos_contr.aupoc_denom_posiz_contr as Denominazione,
                                     tb_autia_tipo_accentr_ct.autia_codice as TipoAzienda,
                                     tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede,
                                     'FIGLIA' as TipoRelazione,
                                     tb_auspc_stato_pos_contr_ct.auspc_descr as Stato,
                       tb_aupoc_pos_contr.aupoc_codice_pk as PosizioneContributivaUnicaID,
                                     tb_aupoc_pos_contr.aupoc_contro_codice as PosizioneContributivaUnicaControcodice
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia INNER JOIN
                         tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
                         tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk INNER JOIN
                         tb_autia_tipo_accentr_ct ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
--WHERE        (aurpp_aupoc_cod_pk_madre = 998521)
WHERE        (aurpp_aupoc_cod_pk_madre = @aupoc_padre)
end
ELSE -- non esiste la madre per cui si cerca la figlia
begin
	IF ( EXISTS  -- Se esiste la posizione FIGLIA
	 (
		SELECT     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva
		FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk 
						 = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia
		WHERE        tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
	 )
	 begin
	 set @aupoc_padre = (
	 SELECT    top(1)    tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia
WHERE        (tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
	 )
	 set @aupoc_figlia = (
	 SELECT        tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia
WHERE        (tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
	 )
SELECT     tb_ausca_sog_contr_az.ausca_codice_fiscale AS CodiceFiscale,
                                     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva,
                                     tb_aupoc_pos_contr.aupoc_denom_posiz_contr as Denominazione,
                                     tb_autia_tipo_accentr_ct.autia_codice as TipoAzienda,
                                     tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede,
                                     'FIGLIA' as TipoRelazione,
                                     tb_auspc_stato_pos_contr_ct.auspc_descr as Stato,
                       tb_aupoc_pos_contr.aupoc_codice_pk as PosizioneContributivaUnicaID,
                                     tb_aupoc_pos_contr.aupoc_contro_codice as PosizioneContributivaUnicaControcodice
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia INNER JOIN
                         tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
                         tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk INNER JOIN
                         tb_autia_tipo_accentr_ct ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE        (tb_aupoc_pos_contr.aupoc_posizione = @posizione_contributiva)
union 
SELECT     tb_ausca_sog_contr_az.ausca_codice_fiscale AS CodiceFiscale,
                                     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva,
                                     tb_aupoc_pos_contr.aupoc_denom_posiz_contr as Denominazione,
                                     tb_autia_tipo_accentr_ct.autia_codice as TipoAzienda,
                                     tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede,
                                     'PADRE' as TipoRelazione,
                                     tb_auspc_stato_pos_contr_ct.auspc_descr as Stato,
                       tb_aupoc_pos_contr.aupoc_codice_pk as PosizioneContributivaUnicaID,
                                     tb_aupoc_pos_contr.aupoc_contro_codice as PosizioneContributivaUnicaControcodice
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre INNER JOIN
                         tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
                         tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk INNER JOIN
                         tb_autia_tipo_accentr_ct ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk

WHERE        (aurpp_aupoc_cod_pk_madre = @aupoc_padre)
union 
SELECT     tb_ausca_sog_contr_az.ausca_codice_fiscale AS CodiceFiscale,
                                     tb_aupoc_pos_contr.aupoc_posizione as PosizioneContributiva,
                                     tb_aupoc_pos_contr.aupoc_denom_posiz_contr as Denominazione,
                                     tb_autia_tipo_accentr_ct.autia_codice as TipoAzienda,
                                     tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede,
                                     'SORELLA' as TipoRelazione,
                                     tb_auspc_stato_pos_contr_ct.auspc_descr as Stato,
                       tb_aupoc_pos_contr.aupoc_codice_pk as PosizioneContributivaUnicaID,
                                     tb_aupoc_pos_contr.aupoc_contro_codice as PosizioneContributivaUnicaControcodice
FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_aurpp_rel_poc_poc ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia INNER JOIN
                         tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
                         tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk INNER JOIN
                         tb_autia_tipo_accentr_ct ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE        (aurpp_aupoc_cod_pk_madre = @aupoc_padre) and (aurpp_aupoc_cod_pk_figlia <> @aupoc_figlia)
	 end
	 else
	 return 1
end
RETURN 1
END
