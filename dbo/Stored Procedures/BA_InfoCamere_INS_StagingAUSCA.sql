-- =============================================
-- Author:		Italo Paioletti
-- Create date: 10/09/2012
-- Description:	Popola le varie Staging di AUSCA per il ramo dell'INSERMENTO
-- =============================================
CREATE PROCEDURE [dbo].[BA_InfoCamere_INS_StagingAUSCA]
	
AS
BEGIN

	-- Passo 1 --
		UPDATE dbo.Import_ausca_sog_contr_azienda
		SET St_ausca_FLAG = 0 
		FROM dbo.Import_ausca_sog_contr_azienda 
		WHERE St_ausca_codice_fiscale IS NULL ;
	
	-- Passo 2 --
	-- Vengono DISTINTE (St_Ausca_FLAG = 1) tutte le righe ACCODABILI (St_ausca_PRESENTE IS NULL e St_ausca_codice_fiscale is not null)
	
	UPDATE Import_ausca_sog_contr_azienda
		SET St_Ausca_FLAG = 1
		WHERE [St_ausca_codice_pk] IS NULL 
		AND (St_ausca_FLAG <> 0 OR St_ausca_FLAG is null)
		AND St_ausca_codice_fiscale  
		IN
		(
			SELECT St_ausca_codice_fiscale 
			FROM Import_ausca_sog_contr_azienda 
			WHERE [St_ausca_codice_pk] IS NULL
			GROUP BY St_ausca_codice_fiscale
			HAVING (COUNT(St_ausca_codice_fiscale) = 1)
		);
						
END
