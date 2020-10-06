
CREATE FUNCTION [dbo].[fn_torna_stringaUnitaOp] (@aupoc_codice INT,@Periodo_da datetime, @Periodo_a datetime, @tipo char) 
RETURNS varchar(max)
AS

BEGIN
   
   DECLARE @StringaUnitaOp VARCHAR(max) ;
   if @tipo='O'
    select @StringaUnitaOp= COALESCE(@StringaUnitaOp + ', ', '') + auuop_identificativo
		FROM [tb_auuop_unita_operativa] WHERE [auuop_aupoc_codice_pk]=@aupoc_codice and 
			auuop_unita_operativa = 'S' and
			@Periodo_da<=auuop_data_fine_accentr
			and @Periodo_a>=auuop_data_inizio_accentr
	else
    select @StringaUnitaOp= COALESCE(@StringaUnitaOp + ', ', '') + auuop_identificativo
		FROM [tb_auuop_unita_operativa] WHERE [auuop_aupoc_codice_pk]=@aupoc_codice and 
			auuop_unita_produttiva = 'S' and
			@Periodo_da<=auuop_data_fine_accentr
			and @Periodo_a>=auuop_data_inizio_accentr

    return @StringaUnitaOp
END
