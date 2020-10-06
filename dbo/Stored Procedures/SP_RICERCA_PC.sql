


-- =============================================
-- Author:		Raffaele
-- Create date: 	Marzo 2012
-- Description:	lettura della tabella tb_aupoc_pos_contr qualificando:
--				aupoc_matricola = aupoc_posizione di input
--				aupoc_ausca_codice_pk = codice azienda
-- =============================================
CREATE PROCEDURE [dbo].[SP_RICERCA_PC] 
	-- Add the parameters for the stored procedure here
	@aupoc_posizione varchar(50),
	@aupoc_cida varchar(10),
	--AI 2050:
	@aupoc_aurea_codice_pk int = null
	--AI 2050.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

If @aupoc_posizione <> '' and  @aupoc_posizione is not NULL
Begin

	SELECT [aupoc_codice_pk]
	      ,[aupoc_ausca_codice_pk]
	      ,[aupoc_auapp_codice_pk] 	
         ,[aupoc_auspc_codice_pk]
         ,[aupoc_posizione]
         ,[aupoc_cida]
         ,[aupoc_data_modifica]
         ,[aupoc_descr_utente]
  FROM [dbo].[tb_aupoc_pos_contr]
  WHERE aupoc_posizione = @aupoc_posizione
  --AI 2050:
  AND aupoc_aurea_codice_pk = ISNULL(@aupoc_aurea_codice_pk, aupoc_aurea_codice_pk)
  --AI 2050.

End
Else
Begin
	SELECT [aupoc_codice_pk]
	  ,[aupoc_ausca_codice_pk]
	  ,[aupoc_auapp_codice_pk] 	
         ,[aupoc_auspc_codice_pk]
         ,[aupoc_posizione]
         ,[aupoc_cida]
         ,[aupoc_data_modifica]
         ,[aupoc_descr_utente]
  FROM [dbo].[tb_aupoc_pos_contr]
  WHERE aupoc_cida = @aupoc_cida
End
END

