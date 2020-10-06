





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/04/2018
-- Description:		Storicizza i dati della tabella "tb_ausys_sistema" nella tabella "tb_ausss_sistema_storico"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricizzaAUSYS]

/*@CF varchar (16),*/
@Cod int,
@interv varchar (1),
@motivo varchar (200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[tb_ausss_sistema_storico] (
	   [ausys_codice_pk]
      ,[ausys_parametro]
      ,[ausys_descr_breve]
      ,[ausys_descr_lunga]
      ,[ausys_data_modifica]
      ,[ausys_descr_utente]
      ,[ausys_valore]
      ,[ausss_data_storicizza]
      ,[ausss_descr_utente]
      ,[ausss_motivo]
      ,[ausss_tipo_intervento])


select * from (

SELECT  [ausys_codice_pk]
      ,[ausys_parametro]
      ,[ausys_descr_breve]
      ,[ausys_descr_lunga]
      ,[ausys_data_modifica]
      ,[ausys_descr_utente]
      ,[ausys_valore]
      ,Getdate() as [ausss_data_storicizza]
      ,rtrim(@utente) as [ausss_descr_utente]
      ,rtrim(@motivo) as [ausss_motivo]
      ,rtrim(@interv) as [ausss_tipo_intervento]
  FROM [AUC].[dbo].[tb_ausys_sistema]

where  [ausys_codice_pk] = @Cod) as tab


END






