

CREATE PROCEDURE [dbo].[AZ_DettaglioStoricoDenomin]
	@codice_pk int
AS
BEGIN

	SET NOCOUNT ON;

select * from TB_AUSDP_STORICO_DENOM_POSIZIONE


WHERE ausdp_aupoc_codice_pk = @codice_pk
	
	
			
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END




