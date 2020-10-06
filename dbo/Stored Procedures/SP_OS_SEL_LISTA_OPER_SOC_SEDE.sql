


-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.09.20
-- Description:	Stored di selezione delle Operazioni Societarie (non cancellate) associate ad una sede INPS
-- =============================================
CREATE PROCEDURE [dbo].[SP_OS_SEL_LISTA_OPER_SOC_SEDE]
	@sedeINPS varchar(4),
	@statiOS as dbo.OS_Stati READONLY

AS
BEGIN

	SET NOCOUNT ON;

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
		inner join tb_aupoc_pos_contr on aupoc_posizione = [auoso_posizione_riferimento]
		inner join tb_ausin_sedi_inps_ct on aupoc_ausin_codice_pk = ausin_codice_pk
		inner join @statiOS as stati on auoso_stato_operazione = stati.stato
		where [auoso_azione_effettuata] <> 'C' and ausin_codice_sede = @sedeINPS
		--and [auoso_stato_operazione] = ISNULL(@stato, [auoso_stato_operazione])
END


