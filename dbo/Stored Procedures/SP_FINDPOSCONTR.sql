-- ====================================================================
-- Author:		Martini

-- Description:	lettura della tabella tb_aupoc_pos_contr qualificando:
--				aupoc_posizione = matricola di input
-- ====================================================================

CREATE PROCEDURE [dbo].[SP_FINDPOSCONTR] 
	@aupoc_posizione varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	   [aupoc_codice_pk]
	  ,[aupoc_ausca_codice_pk]
	  ,[aupoc_auapp_codice_pk] 	
      ,[aupoc_auspc_codice_pk]
      ,[aupoc_posizione]
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,tb_auspc_stato_pos_contr_ct.auspc_descr
      
  FROM  [dbo].[tb_aupoc_pos_contr]
  
  left outer join  [dbo].[tb_auspc_stato_pos_contr_ct]
  ON	aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
  
  WHERE aupoc_posizione = @aupoc_posizione
END
