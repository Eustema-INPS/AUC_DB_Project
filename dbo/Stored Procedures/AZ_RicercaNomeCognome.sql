-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 25-03-2013
-- Description:	Stored per la ricerca SCO o AUSCA tramite nome e/o cognome
-- =============================================
CREATE PROCEDURE [dbo].[AZ_RicercaNomeCognome]
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
  ausca_codice_pk as DB_CodiceAzienda,
  ausca_denominazione as DB_Denominazione,
  ausca_cognome as DB_Cognome,
  ausca_nome as DB_Nome,
  ausca_cognome + ' ' + ausca_nome as DB_NomeCompleto,
  ausca_descr_comune as DB_Comune,
  --devo usare campi di asuco o ausca per la griglia?
  ausca_sigla_provincia as DB_SiglaProvincia,
  ausca_codice_fiscale as DB_CodiceFiscale
 
FROM tb_ausca_sog_contr_az 
where
    
	(@cognome IS NULL OR @cognome = '' OR (ausca_cognome like @cognome))
	
	AND (@nome IS NULL OR @nome = '' OR (ausca_nome like @nome))
	ORDER BY 
		ausca_cognome,
		ausca_nome

END
