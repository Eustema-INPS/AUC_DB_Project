


-- =============================================
-- Author:		Peter Dimpflmeier
-- Create date: 2016.01.22
-- Description:	AI 2069
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_AUPNR]
	-- Add the parameters for the stored procedure here
	@codiceFiscale [varchar](16),
	@gestionePC int = null,
	@tipoProc [varchar](2) = null,
	@dataFine [datetime] = null,
	@ritornoInBonis [varchar](1) = null,
	@dataRitornoInBonis [datetime] = null,
	@utente [varchar](20) = null,
	@righeModificate [int] = null out

AS
BEGIN
	
	SET NOCOUNT ON;

declare @ritornoInBonis_SN varchar(1) = NULL
if @ritornoInBonis = '0' begin set @ritornoInBonis_SN = 'N' end
if @ritornoInBonis = '1' begin set @ritornoInBonis_SN = 'S' end


UPDATE [tb_aupnr_procedure_per_nrc]
SET            
[aupnr_tipo_procedura] = isnull(@tipoProc,[aupnr_tipo_procedura]),
[aupnr_data_fine] = isnull(@dataFine,[aupnr_data_fine]),
[aupnr_data_modifica] = getdate(), 
[aupnr_descr_utente] = isnull(@utente,'Modifica Utente' ),
[Aupnr_ritorno_in_bonis] = isnull(@ritornoInBonis_SN,[Aupnr_ritorno_in_bonis]),
[Aupnr_data_ritorno_in_bonis] = isnull(@dataRitornoInBonis,[Aupnr_data_ritorno_in_bonis])

WHERE
aupnr_codice_fiscale = @codiceFiscale
		   

set @righeModificate = @@ROWCOUNT

END




