


-- =============================================
-- Autore:		Raffaele Palmieri
-- Data:		20/7/2018
-- Per la posizione fornita ritorna un insieme di dati relativi alla posizione 
-- ed un flag che indica se esistono unità produttive valide nel periodo
-- Viene richiamata da Maurizio Barbaro
-- La stored se non trova la posizione o non esistono periodo validi non torna nulla
-- =============================================
CREATE PROCEDURE [dbo].[EX_MATRICOLA_FLAG_UP_VALIDE] @posizione varchar(10), @data_inizio date, @data_fine date
AS
-- declare @aupoc_codice_pk integer;
SET NOCOUNT ON;

BEGIN
	SELECT				
						aupoc_posizione as Posizione,
						ausca_codice_fiscale as CodiceFiscale,
						auspc_descr as StatoPosizione,
						convert(date,aupoc_data_ultimo_stato) as DataUltimoStato,
						convert(date,aupoc_data_inizio_attivita) as DataInizioAttivita,
						ausin_codice_sede as CodiceSedeINPS,
						aupco_cod_stat_contr as CSC,
						aupco_codici_autor as CA,
						auate_cod_ateco_complessivo as ATECO07,
						auate_cod_sottocategoria_tit as DescrAteco07,
						CASE WHEN EXISTS
						(select 1 from  tb_auuop_unita_operativa where  [auuop_aupoc_accentrante] = @posizione
								and auuop_unita_produttiva = 'S' and
								@data_inizio<=auuop_data_fine_accentr
								and @data_fine>=auuop_data_inizio_accentr )
							then 'S'
							else 'N'
							END as PresenzaUP
--						fn_torna_Presenza_UP(@aupoc_posizione, @data_inizio, @data_fine)
						FROM tb_aupoc_pos_contr 
						inner join tb_auspc_stato_pos_contr_ct on auspc_codice_pk = aupoc_auspc_codice_pk
						inner join tb_ausca_sog_contr_az on ausca_codice_pk = aupoc_ausca_codice_pk
						inner join tb_ausin_sedi_inps_ct on aupoc_ausin_codice_pk = ausin_codice_pk
						inner join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
						left outer join tb_auate_cod_ateco_ct on auate_codice_pk = [aupco_auate_2007_codice_pk]
						 where 1=1
						 AND @POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione
						and convert(date,getdate()) <= aupco_data_fine_validita AND
						aupco_data_inizio_validita <= convert(date,getdate()) 						 
END


