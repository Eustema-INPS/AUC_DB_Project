

-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.07.21
-- Description:	Stored di selezione delle Operazioni Societarie (non cancellate) associate ad una posizione
-- =============================================
CREATE PROCEDURE [dbo].[SP_OS_SEL_LISTA_OPER_SOC]
	@posizione_riferimento varchar(50),
	@codice_operazione int = null

AS
BEGIN

declare @chiave_aupoc int

	SET NOCOUNT ON;


	set @chiave_aupoc = (select aupoc_codice_pk from tb_aupoc_pos_contr WITH (READUNCOMMITTED)
		where aupoc_posizione = @posizione_riferimento and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z') 
	IF ( @chiave_aupoc is not null and @chiave_aupoc <> 0)
	BEGIN
		SELECT [auoso_codice_pk]
		  ,[auoso_tipo_operazione]
		  ,[auoso_codice_fiscale_riferimento]
		  ,[auoso_posizione_riferimento]
		  ,[auoso_descr_operazione]
		  ,convert(date,[auoso_data_operazione]) as auoso_data_operazione
		  ,[auoso_stato_operazione]
		  ,[auoso_CSC_posizione_riferimento]
		  ,[auoso_CA_posizione_riferimento]
		  ,[auoso_codice_fiscale_delegato]
		  ,[auoso_codice_operatore]
		  ,[auoso_azione_effettuata]
		  ,convert(date,[auoso_data_azione]) as auoso_data_azione
		  ,[auoso_note]
		FROM [AUC].[dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA]
		where [auoso_posizione_riferimento] = @posizione_riferimento and [auoso_azione_effettuata] <> 'C'
		and (@codice_operazione IS NULL or ([auoso_codice_pk] = @codice_operazione))
	END
	ELSE
	-- non esiste posizione su AUPOC  la stored ritorna False
		RETURN 1
END

