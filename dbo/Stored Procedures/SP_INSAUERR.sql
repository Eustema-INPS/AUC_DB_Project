-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSAUERR] 
	-- Add the parameters for the stored procedure here
	@AppName VARCHAR(50),
	@CodiceErrore int,
	@DescrizioneBreve VARCHAR(50),
	@DescrizioneLunga VARCHAR(200) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO  [dbo].[tb_auerr_errori]
           ([auerr_tipo_contesto]
           ,[auerr_data_errore]
           ,[auerr_attore]
           ,[auerr_aucme_codice_pk]
           ,[auerr_descr_breve]
           ,[auerr_descr_lunga])
     VALUES
           ('W',
            GETDATE(),
            @AppName,
            @CodiceErrore,
            @DescrizioneBreve,
            @DescrizioneLunga)
END
