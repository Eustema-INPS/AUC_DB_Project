﻿-- ==========================================================
-- Author:		maurizio picone
-- Create date: 20 agosto
-- Description:	Ultime forze lavoro per l'azienda passata
-- ==========================================================
CREATE PROCEDURE [dbo].[AZ_ForzeLavoroAzienda_OLD] 
	@ausca_codice_pk int
AS
BEGIN
	SELECT 
	[ausca_codice_fiscale],
	[ausca_denominazione],
	
	[aufor_posizione], 
	[aufor_annomese], 
	[aufor_num_dip_dic], 
	[aufor_num_dip_dic_mod], 
	[aufor_num_dip_cert], 
	[aufor_num_dip_cert_mod], 
	[aufor_tipo_dic], 
	[aufor_stato_certificazione]
	 
	FROM [tb_aufor_forze_lavoro] 

 	inner join  [dbo].[tb_aupoc_pos_contr] 
	on tb_aufor_forze_lavoro.aufor_aupoc_codice_pk = aupoc_codice_pk

    inner join  [dbo].[tb_ausca_sog_contr_az] 
	on tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk

	WHERE 
	(tb_ausca_sog_contr_az.ausca_codice_pk = @ausca_codice_pk) 
	AND 
	(aupoc_auspc_codice_pk = 1 or  aupoc_auspc_codice_pk = 5) -- "ATTIVA" o "RIATTIVATA"

	ORDER BY aufor_posizione DESC, aufor_annomese DESC
END
