-- ======================================================
-- Author:		Vannimartini
-- Create date: 15/05/2013
-- Description:	Carica l'Elenco delle Nature Giuridiche
-- ======================================================
CREATE PROCEDURE [dbo].[AZ_CaricaNaturaGiuridica] 

AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT 
		aungi_descr_lunga AS Descrizione,
		aungi_descr_breve AS Testo,
		aungi_codice_forma AS Forma,
		aungi_codice_pk AS Valore
	FROM 
		tb_aungi_nat_giur_ct
	ORDER BY 
		Valore

	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END
