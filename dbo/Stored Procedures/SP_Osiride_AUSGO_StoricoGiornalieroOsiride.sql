CREATE PROCEDURE [dbo].[SP_Osiride_AUSGO_StoricoGiornalieroOsiride] 
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[TB_AUSGO_STORICO_GIORNALIERO_OSIRIDE]
           ([ausgo_Lotto]
           ,[ausgo_CodiceFiscale]
           ,[ausgo_DataEstrazione]
           ,[ausgo_nome_file_osiride]
           ,[ausgo_data_modifica]
           ,[ausgo_descr_utente])

			SELECT REPLACE(convert(date,getdate()),'-','') As Lotto,
				dbo.TB_AUT01_OSIRIDE_TR01.AUT01_R1_COD_FISC_IMP As CF, 
				convert(date,dbo.tb_auvis_visure.auvis_DataEstrazione,103) as DataEstrazione,
				dbo.tb_auvis_visure.auvis_nome_file_osiride As NomeFileOsiride ,
				GetDate() As DataModifica,
				'AdminPlus' As DescrUtente
			FROM dbo.TB_AUT01_OSIRIDE_TR01 WITH (nolock) 
			LEFT OUTER JOIN dbo.tb_auvis_visure ON dbo.TB_AUT01_OSIRIDE_TR01.AUT01_R1_COD_FISC_IMP = dbo.tb_auvis_visure.auvis_CF
			ORDER BY DataEstrazione

	--Print '*** Elaborazione Terminata !! ***'
		
END
