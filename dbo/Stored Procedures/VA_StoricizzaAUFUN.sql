






-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/04/2018
-- Description:		Storicizza i dati della tabella "tb_aufun_funz_sistema" nella tabella "tb_aufzs_funzioni_storico"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricizzaAUFUN]

/*@CF varchar (16),*/
@Cod int,
@interv varchar (1),
@motivo varchar (200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[tb_aufzs_funzioni_storico] (
      [aufun_codice_pk]
	  ,[aufun_funzione]
      ,[aufun_raggruppamento]
      ,[aufun_tipo_funzione]
      ,[aufun_descr]
      ,[aufun_flag_abilitato]
      ,[aufun_data_modifica]
      ,[aufun_descr_utente]
      ,[aufzs_data_storicizza]
      ,[aufzs_descr_utente]
      ,[aufzs_motivo]
      ,[aufzs_tipo_intervento])

select * from (

SELECT  [aufun_codice_pk]
	  ,[aufun_funzione]
      ,[aufun_raggruppamento]
      ,[aufun_tipo_funzione]
      ,[aufun_descr]
      ,[aufun_flag_abilitato]
      ,[aufun_data_modifica]
      ,[aufun_descr_utente]
      ,Getdate() as [aufzs_data_storicizza]
      ,rtrim(@utente) as [aufzs_descr_utente]
      ,rtrim(@motivo) as [aufzs_motivo]
      ,rtrim(@interv) as [aufzs_tipo_intervento]
  FROM [AUC].[dbo].[tb_aufun_funz_sistema]

where  [aufun_codice_pk]= @Cod) as tab


END



