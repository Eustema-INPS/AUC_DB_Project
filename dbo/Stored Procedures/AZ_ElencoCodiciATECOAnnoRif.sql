

CREATE PROCEDURE [dbo].[AZ_ElencoCodiciATECOAnnoRif] 
	@AnnoRiferimento INT			
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		T.auate_codice_pk AS CodPK,
		T.auate_cod_ateco_complessivo AS CodiceAteco,
		LEFT(T.auate_cod_ateco_complessivo + '      ', 6) + ' - ' +
		CASE
			WHEN LEN(T.auate_cod_sottocategoria_tit) > 60 THEN UPPER(SUBSTRING(T.auate_cod_sottocategoria_tit, 1, 50) + '...')
			ELSE UPPER(T.auate_cod_sottocategoria_tit)
		END AS Descrizione
	FROM [dbo].[tb_auate_cod_ateco_ct] T
	WHERE
		T.auate_anno_riferimento = @AnnoRiferimento
	ORDER BY 3 ASC;
END

