-- =============================================
-- Author:		Quirino Vannimartini
-- Create date: 10-08-2011
-- Description:	Stored per la ricerca SCO tramite nome e/o cognome
-- =============================================
CREATE PROCEDURE [dbo].[SC_RicercaNomeCognome]
	@cognome	varchar(50) = NULL,
	@nome		varchar(50) = NULL,
	@criterio	varchar(1)		-- '0' = Inizia per / '1' = Contiene / '2' = Puntuale
AS
BEGIN	
	SET NOCOUNT ON;
	
	if @criterio = '0'
		begin
			SET @cognome = @cognome + '%'
			SET @nome = @nome + '%'
		end
	else if @criterio = '1'
		begin
			SET @cognome = '%' + @cognome + '%'
			SET @nome = '%' + @nome + '%'
		end

   SELECT TOP 501 -- TOP 501 aggiunto per motivi di performance. Maurizio, 30 novembre 2012
		ausco_codice_pk				AS DB_CodiceSoggetto,
		
		--ISNULL(ausco_cognome, '') + ' ' + ISNULL(ausco_nome, '')
		--AS DB_Denominazione,
		ISNULL(ausco_cognome, '') 	AS DB_Cognome,
		ISNULL(ausco_nome, '')		AS DB_Nome,
		ausco_codice_fiscale		AS DB_CodiceFiscale,
		ausco_data_nascita			AS DB_DataNascita,
		ausco_tipo_persona			AS DB_TipoPersona, 
		ausco_sesso					AS DB_Sesso,
		ausco_localita				AS DB_Localita,
		ausco_provincia				AS DB_SiglaProvincia,
		ausco_codice_toponimo		AS DB_CodiceToponimo,
		ausco_indirizzo				AS DB_Indirizzo,
		ausco_civico				AS DB_Civico,
		ausco_localita				AS DB_Comune,
		ausco_provincia				AS DB_Provincia,
		ausco_cap					AS DB_Cap
	FROM tb_ausco_sog_contr_col
	WHERE 
		(@cognome IS NULL OR ltrim(rtrim(@cognome)) = '' OR (ausco_cognome like @cognome))
	AND (@nome IS NULL OR ltrim(rtrim(@nome)) = '' OR (ausco_nome like @nome))
	ORDER BY 
		DB_Cognome,
		DB_Nome

END
