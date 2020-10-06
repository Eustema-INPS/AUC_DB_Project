-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSAULOG] 
	-- Add the parameters for the stored procedure here
	@AppName VARCHAR(50),
	@CodiceErrore int,
	@DescrizioneBreve VARCHAR(50),
	@DescrizioneLunga VARCHAR(200),
	--AI 2036:
	@DescrizioneMassima VARCHAR(800) = NULL
	--AI 2036.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO  [dbo].[tb_aulog_log]
           ([aulog_tipo_contesto]
           ,[aulog_data_log]
           ,[aulog_nome_attore]
           ,[aulog_aucme_codice_pk]
           ,[aulog_descr_breve]
           ,[aulog_descr_lunga]
           --AI 2036:
           ,[AULOG_DESCRMAX]
           --AI 2036.
           )
     VALUES
           ('W',
            GETDATE(),
            @AppName,
            @CodiceErrore,
            @DescrizioneBreve,
            @DescrizioneLunga,
           --AI 2036:
           	@DescrizioneMassima 
           --AI 2036.
           	)

END
