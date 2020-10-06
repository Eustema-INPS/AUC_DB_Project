-- =========================================================================
-- Author:		Bellantoni & Picone
-- Create date: 6 Novembre 2012
-- Description:	Controlla se una Matricola appartiene alla sede passata
-- =========================================================================
CREATE PROCEDURE [dbo].[SP_CHECKCONGRUENZA_SEDE] 

--AI 2032:
--@codice_sede varchar(4),
@codice_sede varchar(4) = null,
--AI 2032.
@aupoc_posizione varchar(50)

AS
BEGIN
--AI 2032:
	--SELECT ausin_codice_pk, aupoc_ausca_codice_pk, ausca_codice_fiscale
	SELECT ausin_codice_pk, aupoc_ausca_codice_pk, ausca_codice_fiscale, aupoc_cod_sede_INPS
--AI 2032.

	FROM tb_aupoc_pos_contr 

	INNER JOIN tb_ausin_sedi_inps_ct 
	ON aupoc_ausin_codice_pk = ausin_codice_pk
	
	INNER JOIN tb_ausca_sog_contr_az
	ON ausca_codice_pk = aupoc_ausca_codice_pk

	where  
	--AI 2032:
	--ausin_codice_sede = @codice_sede
	(@codice_sede IS NULL OR ausin_codice_sede = @codice_sede )
	--AI 2032.
	AND 
	aupoc_posizione = @aupoc_posizione	
END
