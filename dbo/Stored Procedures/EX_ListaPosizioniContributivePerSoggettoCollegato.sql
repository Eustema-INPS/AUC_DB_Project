/*
La Stored Procedure restituisce l'elenco delle posizioni contributive relative
a soggetti contribuenti collegati ad un soggetto (individuato da un CF)
Le posizioni vengono filtrate in funzione dello stato al momento
dell'invocazione della presente procedura. Gli stati contemplati sono:
Attiva, Sospesa, Riattivata. Il filtro viene applicato a livello di aupoc.
Gotcha!!! Questa logica presuppone una coerenza tra lo stato presente in aupoc
e quello risultante dalle variazioni di stato registrate in auvas.
*/
CREATE PROCEDURE [dbo].[EX_ListaPosizioniContributivePerSoggettoCollegato](
	@CfSoggettoCollegato varchar(16)
)
AS

BEGIN
	SET NOCOUNT ON;

	declare @ausco_codice_pk int = null;

	select @ausco_codice_pk = ausco_codice_pk
	 from tb_ausco_sog_contr_col WITH (nolock)
	 where ausco_codice_fiscale = @CfSoggettoCollegato
	
	select
		 tb_ausca_sog_contr_az.ausca_codice_fiscale AS [CF_SoggettoContribuente]
		,tb_aupoc_pos_contr.aupoc_posizione as [Posizione]
		,tb_aupoc_pos_contr.aupoc_denom_posiz_contr as DenominazionePosizione 
		,tb_auspc_stato_pos_contr_ct.auspc_descr [StatoPosizione]
	 from tb_ausca_sog_contr_az with(nolock)
	  join tb_aupoc_pos_contr WITH (nolock)
		on tb_aupoc_pos_contr.aupoc_ausca_codice_pk=tb_ausca_sog_contr_az.ausca_codice_pk
	  join tb_auspc_stato_pos_contr_ct
		on tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
	 where exists (
		select *
		 from tb_aurss_rel_sog_sog WITH (nolock) 
		 where tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = @ausco_codice_pk
			and tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
			and (tb_aurss_rel_sog_sog.aurss_autis_codice_pk in (89, 90) or aurss_rappresentante_legale='S')
			and getdate() between isnull(tb_aurss_rel_sog_sog.aurss_data_inizio_validita, dateadd(d, -1, getdate()))
				and isnull(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita, dateadd(d, 1, getdate()))
		)
		and tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1 -- Solo aziende DM
		and tb_auspc_stato_pos_contr_ct.auspc_codice in (0, 3, 4) -- Attive, Sospese, Riattivate
	union
	select
		 tb_ausca_sog_contr_az.ausca_codice_fiscale AS [CF_SoggettoContribuente]
		,tb_aupoc_pos_contr.aupoc_posizione as [Posizione]
		,tb_aupoc_pos_contr.aupoc_denom_posiz_contr as DenominazionePosizione 
		,tb_auspc_stato_pos_contr_ct.auspc_descr [StatoPosizione]
	 from tb_ausca_sog_contr_az with(nolock)
	  join tb_aupoc_pos_contr WITH (nolock)
		on tb_aupoc_pos_contr.aupoc_ausca_codice_pk=tb_ausca_sog_contr_az.ausca_codice_pk
	  join tb_auspc_stato_pos_contr_ct
		on tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
	 where exists (
		select *
			from tb_aursp_rel_sog_pos WITH (nolock) 
			where tb_aursp_rel_sog_pos.aursp_ausco_codice_pk = @ausco_codice_pk
			and tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk
			and (tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97)
			and getdate() between isnull(tb_aursp_rel_sog_pos.aursp_data_inizio_validita, dateadd(d, -1, getdate()))
				and isnull(tb_aursp_rel_sog_pos.aursp_data_di_fine_validita, dateadd(d, 1, getdate()))
		)
		and tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1 -- Solo aziende DM
		and tb_auspc_stato_pos_contr_ct.auspc_codice in (0, 3, 4) -- Attive, Sospese, Riattivate
END
