-- =============================================
-- Author:		Raffaele
-- Create date: 	Marzo 2012
-- Description:	lettura della tabella tb_aupoc_pos_contr qualificando:
--				aupoc_matricola = aupoc_posizione di input
--				aupoc_ausca_codice_pk = codice azienda
-- =============================================
CREATE PROCEDURE [dbo].[SP_RICERCA_PC_MATR] 
	-- Add the parameters for the stored procedure here
	@aupoc_posizione varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [aupoc_codice_pk]
	  ,[aupoc_ausca_codice_pk]
	  ,[aupoc_auapp_codice_pk] 	
      ,[aupoc_auspc_codice_pk]
      ,[aupoc_posizione]
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
--      ,tb_auspc_stato_pos_contr_ct.auspc_descr
  FROM [dbo].[tb_aupoc_pos_contr]
--  left outer join [dbo].[tb_auspc_stato_pos_contr_ct]
--  on	aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
  WHERE aupoc_posizione = @aupoc_posizione
END
