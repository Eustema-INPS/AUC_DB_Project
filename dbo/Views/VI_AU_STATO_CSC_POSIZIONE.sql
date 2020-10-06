CREATE VIEW [dbo].[VI_AU_STATO_CSC_POSIZIONE]
AS
SELECT 
		[aupoc_posizione] as Posizione
	   ,aupco_cod_stat_contr as CSC
		,[auspc_descr] as Stato
FROM [dbo].[tb_aupoc_pos_contr]
left outer join tb_auspc_stato_pos_contr_ct on aupoc_auspc_codice_pk = auspc_codice_pk 
left outer join [tb_aupco_periodo_contr] on aupoc_codice_pk = aupco_aupoc_codice_pk
where aupoc_aurea_codice_pk = 1 and convert(date,getdate()) >= aupco_data_inizio_validita and
									aupco_data_fine_validita >= convert(date,getdate()) 
									and left([aupoc_posizione],1) <> 'Z' -- non cancellata logicamente

