





-- =============================================
-- Author:		Stefano Chiovelli
-- Create date: 10-07-2018
-- Description:	Stored per la ricerca della pratica in ComUnica tramite codice fiscale
-- =============================================


CREATE PROCEDURE [dbo].[CS_RicercaCF]
	@CF varchar(16)
AS
BEGIN	
SET NOCOUNT ON;

	SELECT 
		svvis_id_Key as DB_ID_Key,
		svvis_codice_fiscale as DB_CodiceFiscale,
		svvis_IdPratica as DB_IdPratica,
		svvis_segnatura_mittente as DB_Protocollo,
		svvis_area as DB_Area,
		svvis_posted_data as DB_DataPosted,
		svvis_delivered_data as DB_DataDelivered
		
	FROM tb_svvis_visure 
	WHERE 
		svvis_codice_fiscale = @CF
	
	ORDER by svvis_posted_data desc
  
 END




