

-- Modificata da: Letizia
-- Data:		16-05-2013
-- Descrizione:	Seleziona il solo codice fiscale
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAreaApplicazione] 
	@ausca_auten_codice_pk int,
	@ausca_codice_entita_rif int,
	@area int OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	
                  
	IF @ausca_auten_codice_pk = 1 -- E' un Utente non esiste area di appartenenza
	BEGIN
		SET @AREA = -2   
	END
	ELSE
	IF @ausca_auten_codice_pk = 2 -- E' un Ente Certificatore
	BEGIN
	set @AREA = (
				SELECT auece_aurea_codice_pk 
		        FROM tb_auece_ente_cert 
			    WHERE auece_codice_pk = @ausca_codice_entita_rif
				)
	END
	ELSE
	IF @ausca_auten_codice_pk = 3 -- E' un'applicazione
	BEGIN
	set @AREA = (
				SELECT     tb_aurea_area_gestione.aurea_codice_pk
				FROM        tb_auapp_appl LEFT OUTER JOIN
				tb_aurea_area_gestione ON tb_auapp_appl.auapp_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
				WHERE     (tb_auapp_appl.auapp_codice_pk = @ausca_codice_entita_rif)
				)
	END
	else 
		SET @AREA = -1    
	IF @AREA is null
	SET @AREA = -2
	return @AREA
END

