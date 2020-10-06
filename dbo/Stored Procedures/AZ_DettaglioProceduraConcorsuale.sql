
-- =============================================
-- Author:		Maurizio Picone
-- =============================================
-- ==============================================================================
-- Author:		Quirino Vannimartini
-- Modifica date: 03/10/2013
-- Description:	Reperimento di nuovi campi
-- Author:		Letizia Bellantoni
-- Modifica date: 2014.05.19
-- Description:	Reperimento di nuovi campi
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.07
-- Description:	(AI3116) Reperimento di nuovi campi (aucon_altre_indicazioni)
-- ==============================================================================
CREATE PROCEDURE [dbo].[AZ_DettaglioProceduraConcorsuale]
	@aucon_codice_pk int
AS
BEGIN	
	--INIZIO modifca Quirino 03/10/2013
	--SELECT 
	--aucon_info,
	--aucon_data_iscrizione,
	--aucon_tribunale,
	--aucon_num_registrazione,
	--aucon_data_registrazione,
	--aucon_localita_uff_registro,
	--aucon_prov_uff_registro
	
	--FROM dbo.tb_aucon_concorsuale WHERE aucon_codice_pk = @aucon_codice_pk
	
	SELECT 
		aucon_info,
		aucon_data_iscrizione,
		aucon_tribunale,
		aucon_num_registrazione,
		aucon_data_registrazione,
		aucon_localita_uff_registro,
		aucon_prov_uff_registro ,
		aucon_cciaa_fuori_provincia,
		aucon_codice_liquidazione,
		aucon_descr_liquidazione,
		aucon_data_iscrizione_procedura,
		aucon_codice_atto,
		aucon_descrizione_atto,
		aucon_cod_tipo,
		aucon_tipo,
		aucon_data_atto,
		aucon_notaio,
		--Letizia 2014.05.19
		aucon_data_provvedimento,
		aucon_data_termine,
		aucon_data_omologazione,
		aucon_data_chiusura,
		aucon_data_esecuzione,
		aucon_data_revoca,
		aucon_Proposta_Concordato,
		aucon_Annotazioni_Procedure,
		aucon_Accordi_Debiti,
		aucon_Rapporto_Curatore,
		aucon_Appelli_Reclami,
		aucon_Esercizio_Provvisorio,
		aucon_Continuazione_Esercizio_Provv,
		aucon_Cessazione_Esercizio_Provv,
		aucon_Esecuzione_Concordato,
		--Letizia 2014.05.19
		--Panuccio AI3116:
		aucon_altre_indicazioni
		--Panuccio AI3116.
	FROM dbo.tb_aucon_concorsuale 
	WHERE aucon_codice_pk = @aucon_codice_pk
	
	--FINE modifca Quirino 03/10/2013
END

