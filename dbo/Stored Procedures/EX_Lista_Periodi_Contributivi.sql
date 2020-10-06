
-- =============================================
-- Autore:		Raffaele Palmieri
-- Data:		9/5/2018
-- Per la posizione fornita ritorna un insieme di dati relativi ai periodi contributivi che hanno almeno un giorno  
-- di intersezione con il periodo fornito
-- Viene richiamata da Carmelo Russo
-- La stored se non trova la posizione o non esistono periodo validi non torna nulla
-- =============================================
CREATE PROCEDURE [dbo].[EX_Lista_Periodi_Contributivi] @aupoc_posizione varchar(50), @data_inizio date, @data_fine date
AS
-- declare @aupoc_codice_pk integer;
SET NOCOUNT ON;

BEGIN
	SELECT				
						aupoc_posizione as Posizione,
						@data_inizio as DataInizioInput,
						@data_fine as DataFineInput,
						convert(date,aupco_data_inizio_validita) as DataInizioOutput,
						convert(date,aupco_data_fine_validita) as DataFineOutput,
						aupco_cod_stat_contr as csc,
						aupco_codici_autor as CA,
						auate_cod_ateco_complessivo as Ateco2007
						FROM tb_aupoc_pos_contr 
						left outer join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
						left outer join tb_auate_cod_ateco_ct on [aupco_auate_2007_codice_pk] = auate_codice_pk
						 where 1=1
						 AND @AUPOC_POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione AND
						@data_inizio <= aupco_data_fine_validita AND
						aupco_data_inizio_validita <= @data_fine 						 
END

