


CREATE PROCEDURE [dbo].[AZ_DettaglioStoricoVariazCF]
	@codice_pk int
AS
BEGIN

	SET NOCOUNT ON;

select * from tb_auscf_storico_cf_posizione


WHERE auscf_aupoc_codice_pk = @codice_pk
	
	
			
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END




