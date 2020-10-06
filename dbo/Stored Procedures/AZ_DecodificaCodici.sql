-- ==========================================================================================
-- Author:		<Maurizio Picone>
-- Create date: <30/04/2012>
-- Description:	<Stored Procedure decodifica Codici autore>
-- ==========================================================================================
-- ==========================================================================================
-- Author:		Letizia Bellantoni
-- Create date: 2014.10.08
-- Description:	<Aggiunto intervallo di validità>
-- ==========================================================================================
CREATE PROCEDURE  [dbo].[AZ_DecodificaCodici] 
	 @codice AS VARCHAR(2)
	,@DataInizio DATETIME = NULL
    ,@DataFine DATETIME = NULL

AS
BEGIN
	SET NOCOUNT ON;

	

	SELECT TOP 1   
	--dbo.tb_aupco_periodo_contr.aupco_codici_autor, 
	--dbo.tb_aucau_cod_autor_ct.aucau_codice
	dbo.tb_aucau_cod_autor_ct.aucau_descrizione AS DB_Descrizione
	 
	FROM         
	dbo.tb_aucau_cod_autor_ct 
	
	--Peter 2014.09.30: JOIN errata:
	--INNER JOIN
	--dbo.tb_aupco_periodo_contr 
	--ON dbo.tb_aucau_cod_autor_ct.aucau_codice = dbo.tb_aupco_periodo_contr.aupco_codici_autor  
	--Peter 2014.09.30.
  
    WHERE 
	--Peter 2014.09.30:
	--aupco_codici_autor = @codice
	aucau_codice = @codice
	--Peter 2014.09.30.
	--Letizia 2014.10.08
	and @DataInizio <= aucau_data_fine  and @DataFine>= aucau_data_inizio

	--Letizia 2014.10.08
	--Peter 2014.09.30: prendiamo la definizione più recente:
	ORDER BY aucau_data_inizio desc
	--Peter 2014.09.30.

END
