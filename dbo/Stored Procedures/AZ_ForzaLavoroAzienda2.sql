-- =============================================
-- Author:		Picone
-- Create date: 2012
-- Description:	Estrazione dei dati relativi alle forze di lavoro
-- Author:		Raffaele
-- Create date: 18 dicembre 2012
-- Description:	Eliminato il controllo sullo stato della posizione contributiva
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ForzaLavoroAzienda2]
	@aufor_posizione varchar(50)
AS
BEGIN
		    SELECT TOP 1
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
			on [tb_aupoc_pos_contr].aupoc_codice_pk = [tb_aufor_forze_lavoro].aufor_aupoc_codice_pk

			inner join  [dbo].[tb_ausca_sog_contr_az] 
			on tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk

			WHERE 
			[aufor_posizione] = @aufor_posizione
--			AND (aupoc_auspc_codice_pk = 1 or aupoc_auspc_codice_pk = 5) 
			
			ORDER BY aufor_annomese DESC
END
