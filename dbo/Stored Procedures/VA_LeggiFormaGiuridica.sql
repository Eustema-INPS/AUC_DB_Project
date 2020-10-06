

CREATE PROCEDURE [dbo].[VA_LeggiFormaGiuridica]

AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		T.aungi_codice_pk AS codPK, 
		T.aungi_codice_forma AS CodiceFormaGiuridica, 
		T.aungi_codice_forma + ' - ' + T.aungi_descr_breve AS DescrizioneFormaGiuridica, 
		CASE
			WHEN LEN(T.aungi_descr_lunga) > 60 THEN UPPER(SUBSTRING(T.aungi_descr_lunga, 1, 50) + '...')
			ELSE UPPER(T.aungi_descr_lunga)
		END AS DescrizioneLungaFormaGiuridica
	FROM 
		tb_aungi_nat_giur_ct AS T 
	WHERE 
		substring(T.aungi_codice_forma,1,1) <> 'X'

END

