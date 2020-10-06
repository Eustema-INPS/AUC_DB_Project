-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.09.24
-- Description:	Usata dal WSAggiorna-AggiornaCaratteristicheContributive 
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_AUPOC_AUATE] 
	@codice_aupoc as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[tb_aupoc_pos_contr]
   SET 
     
       [aupoc_ateco] = aupco_ateco_91
      ,[aupoc_auate_1991_codice_pk] = [aupco_auate_1991_codice_pk]
      ,[aupoc_auate_2007_codice_pk] = [aupco_auate_2007_codice_pk]
	  ,aupoc_data_modifica = getdate()
	  ,aupoc_descr_utente = [aupco_descr_utente]
     
  from 
  [tb_aupoc_pos_contr]  INNER JOIN 
  dbo.tb_aupco_periodo_contr 
  ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk
  where aupco_data_inizio_validita <= convert(date,GETDATE(),103) AND convert(date,GETDATE(),103) <= aupco_data_fine_validita 
  and tb_aupoc_pos_contr.aupoc_codice_pk = @codice_aupoc
   
END
