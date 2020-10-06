



-- =============================================
-- Author:		<Emanuela Paletta>
-- Modificata: 2017.11.21
-- Descrizione: 
-- Modificato da Raffaele il 26/06/2018
-- Eliminato il vincolo su auspc
-- =============================================
CREATE PROCEDURE  [dbo].[AZ_DettaglioStoricoComunicazioni] 
	@codiceAupocPK as int,
	@codComunic as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT			tb_aucia_com_ist_az.aucia_codice_pk,
				tb_aucia_com_ist_az.aucia_posizione, 
				tb_aucia_com_ist_az.aucia_chiave_gestionale AS DB_ChiaveGest,
				tb_aucia_com_ist_az.aucia_posizione AS DB_PosizioneContributiva, 
				tb_aucia_com_ist_az.aucia_origine as DB_ORIGINE,
				tb_aucia_com_ist_az.aucia_cod_oper AS DB_CodOp, 
				tb_aucia_com_ist_az.aucia_cf_del_tit AS DB_CFUtente, 
				tb_aucia_com_ist_az.aucia_localita_uff_registro, 
				tb_aucia_com_ist_az.aucia_data_invocazione as DB_DataInvocazione,
				tb_aucia_com_ist_az.aucia_data_invio as DB_DataInvio,
				tb_aucia_com_ist_az.aucia_oggetto_invio AS DB_Oggetto, 
				tb_aucia_com_ist_az.aucia_messaggio_invio as DB_Messaggio, 
				tb_aucia_com_ist_az.aucia_allegato_invio, 
				tb_aucia_com_ist_az.aucia_stato_codice as DB_Stato, 
				tb_aucia_com_ist_az.aucia_stato_descr AS DB_DescrStato, 
				tb_aucia_com_ist_az.aucia_stato_data as DB_DataStato,
				tb_aucia_com_ist_az.aucia_data_ins, 
				tb_aucia_com_ist_az.aucia_flag_verifica_esito, 
				tb_aucia_com_ist_az.aucia_flag_pec, 
				tb_aucia_com_ist_az.aucia_mail_destinatario as DB_Email
FROM            tb_aucia_com_ist_az INNER JOIN
                         tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_posizione = tb_aucia_com_ist_az.aucia_posizione
WHERE    (tb_aupoc_pos_contr.aupoc_codice_pk = @codiceAupocPK) AND 
--(tb_aupoc_pos_contr.aupoc_auspc_codice_pk <> 1) and 
(tb_aucia_com_ist_az.aucia_codice_pk = @codComunic)


--  order by auvas_data_variazione_stato desc, auspc_ordinamento desc*/

END


