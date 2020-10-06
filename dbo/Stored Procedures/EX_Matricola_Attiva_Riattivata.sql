CREATE PROCEDURE [dbo].[EX_Matricola_Attiva_Riattivata]
	@Matricola	As Varchar(50),
	@Periodo_da As date,
	@Periodo_a  As date
AS
BEGIN
  SET NOCOUNT ON;
  
  Declare @PkMatricola As BigInt

  if @Periodo_da is null set @Periodo_da = '1900-01-01'
  if @Periodo_a  is null set @Periodo_a = '2999-12-31'   
  
  SET @PkMatricola = (SELECT [aupoc_codice_pk] FROM [dbo].[tb_aupoc_pos_contr] where [aupoc_posizione] =  @Matricola and aupoc_aurea_codice_pk = 1)

  if @PkMatricola is not null 	
		SELECT dbo.fn_torna_attiva_nel_periodo(@Periodo_da,@Periodo_a , @PkMatricola  ) As ReturnCode;
  else
		SELECT '-'

END
