
-- ===================================================================
-- Author:		Dimpflmeier
-- Create date: 12/10/2017
-- Description:	Estrazione periodi contributivi di una posizione IVA
-- Modificata:  
-- Data:	    
-- Descrizione: 
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_MLPS_LISTA_PERIODI_CONTRIB] 

	@posizione varchar(50),
	@data_Inizio_riferimento date,
	@data_Fine_riferimento date
	
AS
BEGIN
	SET NOCOUNT ON;
(   SELECT 	 
			[aucsc_codice],
			[aucsc_settore], 
			[aucsc_classe], 
			[aucsc_categoria],
			[aupco_data_inizio_validita],
			[aupco_data_fine_validita],
			[aupco_codici_autor]
   FROM  [dbo].[tb_aupoc_pos_contr] 
   inner join [dbo].[tb_aupco_periodo_contr] WITH (READUNCOMMITTED) on aupoc_codice_pk = aupco_aupoc_codice_pk
   inner join [dbo].[tb_aucsc_cod_stat_contr_ct] WITH (READUNCOMMITTED) on aupco_aucsc_codice_pk = aucsc_codice_pk
   WHERE 
	  aupoc_posizione = @posizione 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z' -- non cancellata logicamente
	  and aupoc_auspc_codice_pk IN (1, 4, 5) -- attiva o riattiva o sospesa
	  and aupco_data_inizio_validita <= @data_Fine_riferimento
	  and aupco_data_fine_validita >= @data_Inizio_riferimento
)

   ORDER BY aupco_data_inizio_validita

END

