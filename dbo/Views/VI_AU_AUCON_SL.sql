


CREATE VIEW [dbo].[VI_AU_AUCON_SL]
AS
SELECT  
      [ausca_codice_fiscale] as CodiceFiscale
      ,[aucon_info] as Info
      ,convert(date,[aucon_data_iscrizione]) as DataIscrizione
      ,[aucon_tribunale] as Tribunale
      ,[aucon_num_registrazione] as NumeroRegistrazione
      ,convert(date,[aucon_data_registrazione]) as DataRegistrazione
      ,[aucon_localita_uff_registro] as UfficioRegistro
      ,[aucon_prov_uff_registro] as ProvinciaUfficioRegistro
      ,convert(date,[aucon_data_modifica]) as DataModifica
      ,[aucon_descr_utente] as DescrizioneUtente
      ,[aucon_cod_tipo] as CodiceTipo
      ,convert(date,[aucon_data_atto]) as DataAtto
      ,[aucon_notaio] as Notaio
      ,[aucon_tipo] as Tipo
      ,[aucon_cciaa_fuori_provincia] as CCIAAFuoriProvincia
      ,[aucon_codice_atto] as CodiceAtto
      ,[aucon_codice_liquidazione] as CodiceLiquidazione
      ,convert(date,[aucon_data_iscrizione_procedura]) as DataIscrizioneProcedura
      ,[aucon_descr_liquidazione] as DescrizioneLiquidazione
      ,[aucon_descrizione_atto] as DescrizioneAtto
      ,[aucon_Accordi_Debiti] as AccordiDebiti
      ,[aucon_Annotazioni_Procedure] as AnnotazioniProcedure
      ,[aucon_Appelli_Reclami] as AppelliReclami
      ,[aucon_Cessazione_Esercizio_Provv] as CessazioneEsercizioProvvisorio
      ,[aucon_Continuazione_Esercizio_Provv] as ContinuazioneEsercizioProvvisorio
      ,convert(date,[aucon_data_chiusura]) as DataChiusura
      ,convert(date,[aucon_data_esecuzione]) as DataEsecuzione
      ,convert(date,[aucon_data_omologazione]) as DataOmologazione
      ,convert(date,[aucon_data_provvedimento]) as DataProvvedimento
      ,convert(date,[aucon_data_revoca]) as DataRevoca
      ,convert(date,[aucon_data_termine]) as DataTermine
      ,[aucon_Esecuzione_Concordato] as EsecuzioneConcordato
      ,[aucon_Esercizio_Provvisorio] as EsercizioProvvisorio
      ,[aucon_Proposta_Concordato] as PropostaConcordato
      ,[aucon_Rapporto_Curatore] as RapportoCuratore
FROM         tb_aucon_concorsuale INNER JOIN
                      tb_ausca_sog_contr_az ON tb_aucon_concorsuale.aucon_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE     (tb_aucon_concorsuale.aucon_codice_liquidazione in ('SL','AP','AR','BF','BS','LG','LI','LV','SA','SC'
,'SG','SI','SL','SN','SQ','SS'))





