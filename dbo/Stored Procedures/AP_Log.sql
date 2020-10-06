
-- =========================================================
-- Author:		Maurizio Picone
-- Create date: 11-11-11 (!)
-- Description:	Inserimento messaggio in tabella di LOG
-- =========================================================
-- =========================================================
-- Author:		Letizia Bellantoni
-- Modifica date: 10-06-2013
-- Description:	Inserimento tipo contesto per codice aucme 67
-- =========================================================
-- ===========================================================
-- Author:		Quirino Vannimartini
-- Modifica date: 26/09/2013
-- Description:	Inserimento tipo contesto per codice aucme 91
-- ===========================================================
CREATE PROCEDURE [dbo].[AP_Log]
	@aulog_nome_attore varchar(50),
	@aulog_aucme_codice_pk int,
	@aulog_descr_lunga varchar(200)
AS
BEGIN
    DECLARE @descr_breve VARCHAR(50)
    DECLARE @contesto VARCHAR(1)
    
	SET NOCOUNT ON;
	
    SET @descr_breve = (SELECT aucme_descr_breve FROM dbo.tb_aucme_codici_mes_err WHERE aucme_codice_pk = @aulog_aucme_codice_pk)
    
    IF @aulog_aucme_codice_pk = 55 SET @contesto = 'L'
    IF @aulog_aucme_codice_pk = 999 SET @contesto = 'A'  
    IF @aulog_aucme_codice_pk = 10001 or @aulog_aucme_codice_pk = 10002  SET @contesto = 'A'  
    --modifca Letizia 10-06-2013
    IF @aulog_aucme_codice_pk = 87 SET @contesto = 'A'             
    --modifca Quirino 26/09/2013
    IF @aulog_aucme_codice_pk = 91 SET @contesto = 'A'
                   
    INSERT INTO [dbo].[tb_aulog_log]
           ([aulog_tipo_contesto]
           ,[aulog_nome_attore]
           ,[aulog_data_log]
           ,[aulog_aucme_codice_pk]
           ,[aulog_descr_breve]
           ,[aulog_descr_lunga])
     VALUES
           (@contesto
           ,@aulog_nome_attore
           ,getdate()
           ,@aulog_aucme_codice_pk
           ,@descr_breve           
           ,@aulog_descr_lunga)

END


