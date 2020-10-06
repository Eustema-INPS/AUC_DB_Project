

CREATE PROCEDURE [dbo].[SP_REP_MATRICOLE_TC9]
	@cod_operazione int
AS
BEGIN
	SET NOCOUNT ON;	


		create table #temp_es(
		cf varchar(16),
		rag_soc varchar(405),
		matricola varchar(50)
		) on [primary];

-- Inserimento nella tabella temporanea (3)

			insert into #temp_es
			(
			cf,
			rag_soc,
			matricola)
			SELECT		tb_ausca_sog_contr_az.ausca_codice_fiscale AS 'CF azienda', 
						tb_ausca_sog_contr_az.ausca_denominazione AS 'Rag Sociale Azienda', 
						  aupoe_posizione AS 'Matricola Posizione'
			from [tb_aupoe_PosizioniErrate] inner join
			         tb_ausca_sog_contr_az on [tb_aupoe_PosizioniErrate].aupoe_codice_fiscale = tb_ausca_sog_contr_az.ausca_codice_fiscale 
								  INNER JOIN
								  tb_audop_dettaglio_operazioni on AUDOP_dato = aupoe_posizione 
			WHERE     (AUOPE_CODICE_PK = @cod_operazione) 

-- NB il numero di record inseriti deve essere pari a quello ottenuto precedentemente


-- Query di eliminazione del carattere <;> all'interno della denominazione che non consente la corretta gestione in excel delle colonne

update #temp_es
set rag_soc = replace(rag_soc,';','.')

update #temp_es
set rag_soc = replace(rag_soc,'"',' ')

-- Query di selezione record per l'output

select 
cf AS 'CF azienda',
rag_soc AS 'Denominazione Azienda', 
matricola AS 'Matricola Posizione'

  from #temp_es 
END

