




-- =============================================
-- Author:		Peter Dimpflmeier
-- Create date: 2016.01.20
-- Description:	AI 2069
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AUPNR]
	-- Add the parameters for the stored procedure here
	@codiceFiscale [varchar](16),
	@tipoProc [varchar](2),
	@dataInizio [datetime],
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

declare @ausca_codice_pk int = NULL
SET @ausca_codice_pk = (select ausca_codice_pk from [dbo].[tb_ausca_sog_contr_az] where ausca_codice_fiscale = @codiceFiscale)

IF @ausca_codice_pk IS NOT NULL
BEGIN

INSERT INTO [dbo].[tb_aupnr_procedure_per_nrc]
           ([aupnr_codice_fiscale]
           ,[aupnr_tipo_procedura]
           ,[aupnr_data_inizio]
           ,[aupnr_data_fine]
           ,[aupnr_gestione_pc]
           ,[aupnr_presenza_pc]
           ,[aupnr_posizione]
           ,[aupnr_data_invio_email]
           ,[aupnr_ausca_codice_pk]
           ,[aupnr_aupoc_codice_pk]
           ,[aupnr_data_modifica]
           ,[aupnr_descr_utente]
           ,[aupnr_ritorno_in_bonis]
           ,[aupnr_data_ritorno_in_bonis])
     VALUES
           (
		   @codiceFiscale,
           @tipoProc,
		   @dataInizio,
		   @dataFine,
		   0,
		   1,
		   null,
           null,
           @ausca_codice_pk, 
           null, 
           getdate(),
           isnull(@utente, 'Inserimento Utente'),
           @ritornoInBonis_SN, 
           @dataRitornoInBonis
		   )

	set @righeModificate = @@ROWCOUNT

END
	
ELSE
BEGIN
    --codice fiscale non presente in AUSCA
	set @righeModificate = -1
END

END





