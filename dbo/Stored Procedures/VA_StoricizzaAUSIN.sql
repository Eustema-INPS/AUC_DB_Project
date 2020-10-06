







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  15/05/2018
-- Description:		Storicizza i dati della tabella "tb_ausin_sedi_inps_ct" nella tabella "tb_ausis_ausin_storico"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricizzaAUSIN]

/*@CF varchar (16),*/
@Cod int,
@interv varchar (1),
@motivo varchar (200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

insert into  [AUC].[dbo].[tb_ausis_ausin_storico] (
      [ausin_codice_pk]
      ,[ausin_codice_sede]
      ,[ausin_descr]
      ,[ausin_codice_regione]
      ,[ausin_descrizione_regione]
      ,[ausin_ordinamento]
      ,[ausin_data_modifica]
      ,[ausin_descr_utente]
      ,[ausin_codice_pk_db2]
      ,[ausis_data_storicizza]
      ,[ausis_descr_utente]
      ,[ausis_motivo]
      ,[ausis_tipo_intervento])

select * from (

SELECT [ausin_codice_pk]
      ,[ausin_codice_sede]
      ,[ausin_descr]
      ,[ausin_codice_regione]
      ,[ausin_descrizione_regione]
      ,[ausin_ordinamento]
      ,[ausin_data_modifica]
      ,[ausin_descr_utente]
      ,[ausin_codice_pk_db2]
	  ,Getdate() as [aufzs_data_storicizza]
      ,rtrim(@utente) as [aufzs_descr_utente]
      ,rtrim(@motivo) as [aufzs_motivo]
      ,rtrim(@interv) as [aufzs_tipo_intervento]
  FROM [AUC].[dbo].[tb_ausin_sedi_inps_ct]

where  [ausin_codice_pk]= @Cod) as tab


END




