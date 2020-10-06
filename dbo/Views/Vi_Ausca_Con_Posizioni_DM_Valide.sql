
CREATE View [dbo].[Vi_Ausca_Con_Posizioni_DM_Valide] AS

SELECT tb_ausca_sog_contr_az.ausca_codice_pk, 
	   tb_ausca_sog_contr_az.ausca_codice_fiscale
FROM tb_ausca_sog_contr_az INNER JOIN tb_aupoc_pos_contr ON 
	 tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk INNER JOIN tb_auspc_stato_pos_contr_ct ON 
	 tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
WHERE  
	( tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1 ) 

AND ( tb_auspc_stato_pos_contr_ct.auspc_codice = 0 OR
      tb_auspc_stato_pos_contr_ct.auspc_codice = 3 OR
      tb_auspc_stato_pos_contr_ct.auspc_codice = 4
    ) 
    
AND ( SUBSTRING(LTRIM(tb_aupoc_pos_contr.aupoc_posizione), 1, 1) <> 'Z' ) ;

