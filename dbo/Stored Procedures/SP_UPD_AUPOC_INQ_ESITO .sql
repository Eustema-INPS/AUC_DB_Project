



-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.10.16
-- Description:	AI2062 Usata dal WSAggiorna-AggiornaContrInqAuto 
-- =============================================
create PROCEDURE [dbo].[SP_UPD_AUPOC_INQ_ESITO ] 
	@codice_aupoc as int,
	@aupoc_inq_data_esito_verifica_oper as datetime,
	@aupoc_inq_esito_verifica_oper as int,
	@aupoc_inq_cod_oper as varchar(10),
	@aupoc_inq_note as varchar(200)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[tb_aupoc_pos_contr]
    SET 
     aupoc_inq_esito_verifica_oper=@aupoc_inq_esito_verifica_oper,
     aupoc_inq_data_esito_verifica_oper=@aupoc_inq_data_esito_verifica_oper,
     aupoc_inq_cod_oper=@aupoc_inq_cod_oper,
     aupoc_inq_note=@aupoc_inq_note     
    where tb_aupoc_pos_contr.aupoc_codice_pk = @codice_aupoc
   
END


