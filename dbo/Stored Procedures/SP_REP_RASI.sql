

CREATE PROCEDURE [dbo].[SP_REP_RASI]
       @cod_operazione int
AS
BEGIN
       SET NOCOUNT ON;     


             create table #temp_es(
             cf varchar(16),
             rag_soc varchar(405),
             codice_aupoc int,
             matricola varchar(50),
             denom varchar(405),
             prov varchar(2),
             comune varchar(50),
             csc varchar(5),
             csc1 varchar(80),
             csc2 varchar(80),
             csc3 varchar(80),
             stato varchar(50),
             data datetime,
             dip int,
             annomese int) on [primary];

-- Inserimento nella tabella temporanea (3)

                    insert into #temp_es
                    (
                    cf,
                    rag_soc,
                    codice_aupoc,
                    matricola,
                    denom,
                    prov ,
                    comune,
                    csc ,
                    csc1,
                    csc2,
                    csc3,
                    stato,
                    data)

                    SELECT       tb_ausca_sog_contr_az.ausca_codice_fiscale AS 'CF azienda', 
                                        tb_ausca_sog_contr_az.ausca_denominazione AS 'Rag Sociale Azienda', 
                                        aupoc_codice_pk,
                                          tb_aupoc_pos_contr.aupoc_posizione AS 'Matricola Posizione', 
                                                        tb_aupoc_pos_contr.aupoc_denom_posiz_contr AS 'Denominazione Posizione', 
                                                        tb_auind_indirizzi.auind_sigla_provincia AS 'Provincia Posizione', 
                                                        tb_auind_indirizzi.auind_descr_comune AS 'Comune Posizione', 
                                                        tb_aupco_periodo_contr.aupco_cod_stat_contr AS 'CSC', 
                                                        tb_aucsc_cod_stat_contr_ct.aucsc_settore AS 'Settore CSC', 
                                                        tb_aucsc_cod_stat_contr_ct.aucsc_classe AS 'Classe CSC', 
                                                        tb_aucsc_cod_stat_contr_ct.aucsc_categoria AS 'Categoria CSC', 
                                                        CASE aupoc_auspc_codice_pk WHEN 1 THEN 'Attiva' WHEN 2 THEN 'Cessata Provvisoria' WHEN 3 THEN 'Cessata Definitiva' WHEN 4 THEN 'Sospesa' WHEN 5 THEN 'Riattivata' WHEN 6 THEN 'Fallita'
                                                         ELSE 'Non definito' END AS 'Stato', 
                                                         tb_aupoc_pos_contr.aupoc_data_ultimo_stato AS 'Data stato'
                    FROM         tb_ausca_sog_contr_az INNER JOIN
                                                        tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN
                                                        tb_audop_dettaglio_operazioni on AUDOP_dato = aupoc_posizione left outer join
                                                        tb_aupco_periodo_contr ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk LEFT OUTER JOIN
                                                        tb_aucsc_cod_stat_contr_ct ON tb_aupco_periodo_contr.aupco_cod_stat_contr = tb_aucsc_cod_stat_contr_ct.aucsc_codice LEFT OUTER JOIN
                                                        tb_auind_indirizzi ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_auind_indirizzi.auind_tabella_codice_pk
                    WHERE     (AUOPE_CODICE_PK = @cod_operazione) and
                    (tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1) AND (SUBSTRING(tb_aupoc_pos_contr.aupoc_posizione, 1, 1) <> 'Z') AND 
                    (tb_auind_indirizzi.auind_tabella = 'AUPOC') 
                    AND (GETDATE() >= tb_aupco_periodo_contr.aupco_data_inizio_validita) 
                    AND (GETDATE() <= tb_aupco_periodo_contr.aupco_data_fine_validita)

-- NB il numero di record inseriti deve essere pari a quello ottenuto precedentemente



-- aggiornamento con la data di inizio attività
update #temp_es
set data = aupoc_data_inizio_attivita
from #temp_es inner join tb_aupoc_pos_contr on codice_aupoc = aupoc_codice_pk
where data is null

-- Query di eliminazione del carattere <;> all'interno della denominazione che non consente la corretta gestione in excel delle colonne

update #temp_es
set rag_soc = replace(rag_soc,';','.'),
denom = replace(denom,';','.')

update #temp_es
set rag_soc = replace(rag_soc,'"',' '),
denom = replace(denom,'"',' ')

-- Query di selezione record per l'output

select 
cf AS 'CF azienda',
rag_soc AS 'Denominazione Azienda', 
matricola AS 'Matricola Posizione', 
                                    denom AS 'Denominazione Posizione', 
                      stato AS 'Stato', 
                                 convert(varchar(10),data,103) AS 'Data stato',
                      prov AS 'Provincia Posizione', 
                                    comune AS 'Comune Posizione'

  from #temp_es 
END
