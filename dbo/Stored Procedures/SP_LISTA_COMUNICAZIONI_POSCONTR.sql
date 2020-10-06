


-- =============================================
-- Author:		Peter Dimpflmeier
-- Data:		2017.02.24
-- Descrizione: Creata
-- =============================================
CREATE PROCEDURE [dbo].[SP_LISTA_COMUNICAZIONI_POSCONTR] 
	
@posizione varchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

SELECT        tb_aucia_com_ist_az.aucia_codice_pk, tb_aucia_com_ist_az.aucia_chiave_gestionale, tb_aucia_com_ist_az.aucia_posizione, 
                         tb_aucia_com_ist_az.aucia_origine, tb_aucia_com_ist_az.aucia_cod_oper, tb_aucia_com_ist_az.aucia_cf_del_tit, tb_aucia_com_ist_az.aucia_mail_destinatario, tb_aucia_com_ist_az.aucia_localita_uff_registro, 
                         tb_aucia_com_ist_az.aucia_data_invocazione, tb_aucia_com_ist_az.aucia_data_invio, tb_aucia_com_ist_az.aucia_oggetto_invio, 
                         tb_aucia_com_ist_az.aucia_messaggio_invio, tb_aucia_com_ist_az.aucia_allegato_invio, tb_aucia_com_ist_az.aucia_stato_codice, 
                         tb_aucia_com_ist_az.aucia_stato_descr, tb_aucia_com_ist_az.aucia_stato_data, tb_aucia_com_ist_az.aucia_data_ins, 
                         tb_aucia_com_ist_az.aucia_flag_verifica_esito, tb_aucia_com_ist_az.aucia_flag_pec
FROM            tb_aucia_com_ist_az 
WHERE        (tb_aucia_com_ist_az.aucia_posizione = @posizione)


END



