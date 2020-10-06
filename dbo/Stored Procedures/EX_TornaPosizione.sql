
-- ===================================================================
-- Author:		Italo Paioletti
-- Create date: 16 03 2017
-- ===================================================================

CREATE PROCEDURE [dbo].[EX_TornaPosizione] 
	@aupoc_codice_pk int ,
	@aupoc_contro_codice varchar(2)	
AS
BEGIN
	SET NOCOUNT ON;	
	
	SELECT	aupoc_posizione 	 
	FROM  [dbo].[tb_aupoc_pos_contr]
	WHERE [aupoc_codice_pk] = @aupoc_codice_pk
	AND [aupoc_contro_codice] = @aupoc_contro_codice;      

END

