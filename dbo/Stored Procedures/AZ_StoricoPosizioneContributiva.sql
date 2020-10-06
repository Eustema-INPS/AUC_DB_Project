-- =============================================
-- Author:		<Letizia,Bellantoni>
-- Create date: <23/04/2012>
-- Description:	<Storep Procedure utilizzata nella pagina AZ_StoricoPosizioneContributiva>
-- Modificata: il 21 maggio 2012 da Raffaele
-- Descrizione: puntare a auspc_codice_pk piuttosto che a auspc_codice
-- Modificata: il 11 giugno 2013 da Raffaele
-- Descrizione: Modificato criterio ordinamento a parità di data
-- =============================================
-- =============================================
-- Author:		<Letizia,Bellantoni>
-- Modificata: 2014.07.24
-- Descrizione: il pulsante Storico Stati sarà visibile solo se lo stato della Pos. Contr. è diverso da Attiva   tb_aupoc_pos_contr.[aupoc_auspc_codice_pk]!=1

-- =============================================
CREATE PROCEDURE  [dbo].[AZ_StoricoPosizioneContributiva] 
	@codiceAupocPK as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT 
	[auvas_codice_pk] ,
       [auvas_aupoc_codice_pk]  as DB_CodiceAupoc,
       [auvas_auspc_codice_pk] as DB_CodiceStato,
       CONVERT(VARCHAR(10), auvas_data_variazione_stato, 103) as DB_DataDecorrenza,
       [auvas_utente] as DB_Utente,
       [auvas_dispositivo_utente] as DB_Dispositivo,
       tb_aupoc_pos_contr.aupoc_posizione as DB_PosizioneContributiva,
       tb_auspc_stato_pos_contr_ct.auspc_descr as DB_DescStato,
       CONVERT(VARCHAR(10), auvas_data_modifica_utente, 103) as DB_DataVariaz
  FROM [tb_auvas_var_stato_pos] 
  INNER JOIN 
  tb_auspc_stato_pos_contr_ct ON
  [tb_auvas_var_stato_pos].auvas_auspc_codice_pk=tb_auspc_stato_pos_contr_ct.auspc_codice_pk
  INNER JOIN  tb_aupoc_pos_contr  ON tb_aupoc_pos_contr.aupoc_codice_pk=[tb_auvas_var_stato_pos].auvas_aupoc_codice_pk
  where tb_aupoc_pos_contr.aupoc_codice_pk=@codiceAupocPK
  and
  tb_aupoc_pos_contr.[aupoc_auspc_codice_pk]!=1
  order by auvas_data_variazione_stato desc, auspc_ordinamento desc
END

