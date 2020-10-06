-- ===================================================================
-- Author:		Italo Paioletti 
-- Create date: 20 Maggio 2015
-- Input : Matricola Posizione
-- Output: CF Ausca , Denominazione AUSCA
-- ===================================================================
CREATE PROCEDURE [dbo].[Ex_Find_CF_Denom_POC] 
	@aupoc_posizione varchar(50)	
AS
BEGIN
	SET NOCOUNT ON;	

	--IF ( EXISTS
	-- (	SELECT a.ausca_codice_fiscale	 
	--	FROM tb_ausca_sog_contr_az a with (nolock) INNER JOIN  tb_aupoc_pos_contr p ON 
	--		 p.aupoc_ausca_codice_pk = a.ausca_codice_pk
	--	WHERE aupoc_posizione = @aupoc_posizione)
	-- )  
	--BEGIN
		SELECT  TOP(1)
			a.ausca_codice_fiscale, 
			a.ausca_denominazione
		FROM tb_ausca_sog_contr_az a with (nolock) INNER JOIN  tb_aupoc_pos_contr p ON 
			p.aupoc_ausca_codice_pk = a.ausca_codice_pk
		WHERE 
			aupoc_posizione = @aupoc_posizione 
--	END
--ELSE
--	--non esiste un CF riconducibile alla Matricola: la stored ritorna False
--	RETURN 0
END
