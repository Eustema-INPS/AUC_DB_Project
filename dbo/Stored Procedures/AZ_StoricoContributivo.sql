

-- =============================================
-- Author:		<Emanuela Paletta>
-- Create date: <19/04/2019>
-- Description:	<Storep Procedure utilizzata nella pagina AZ_StoricoPosizioneContributiva>
-- Descrizione: il pulsante Storico Contributivo sarà visibile solo se lo stato della Pos. Contr.

-- =============================================
CREATE PROCEDURE  [dbo].[AZ_StoricoContributivo] 
	@codiceAupocPK as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

  select [aupcs_data_modifica] as DB_DataModifica,
	  count(*) as DB_quanti
	  from [AUC].[dbo].[tb_aupcs_periodo_contr_storico]	 
   where aupcs_aupoc_codice_pk = @codiceAupocPK 
    group by [aupcs_data_modifica]
	order by aupcs_DATA_MODIFICA desc

  
END


