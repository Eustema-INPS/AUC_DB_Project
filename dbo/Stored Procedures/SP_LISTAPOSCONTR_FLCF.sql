-- ===================================================================
-- Author:		Maurizio Picone 
-- Create date: 6 agosto 2012
-- Description:	FL per codice fiscale azienda
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_LISTAPOSCONTR_FLCF] 

	@codice_fiscale_azienda varchar(16),
	@periodoDAL int,
	@periodoAL int

AS
BEGIN
  SET NOCOUNT ON;
	
  IF @periodoAL = 0 or @periodoAL IS NULL SET @periodoAL=999999
	
  SELECT 	
    [aufor_posizione], -- Matricola Azienda (oppure [aupoc_posizione])
	[aufor_annomese],
	[aufor_num_dip_dic],
	[aufor_num_dip_cert],
	[aufor_stato_certificazione],
	[aufor_tipo_dic],
	[aufor_aupoc_codice_pk],
	[aupoc_contro_codice]
	
  FROM  [dbo].[tb_aufor_forze_lavoro]
      
 	  inner join  [dbo].[tb_aupoc_pos_contr] -- Rel.5
	  on tb_aufor_forze_lavoro.aufor_aupoc_codice_pk = aupoc_codice_pk

	  inner join [dbo].[tb_ausca_sog_contr_az]
	  on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
	
  WHERE 
	  ausca_codice_fiscale = @codice_fiscale_azienda
	  and aufor_annomese >= @periodoDAL
	  and aufor_annomese <= @periodoAL
	  -- NO per WS -- and (aupoc_auspc_codice_pk = 1 or  aupoc_auspc_codice_pk = 5) -- "ATTIVA" o "RIATTIVATA"
  
  
  GROUP BY 	   
    [aufor_posizione],     
	[aufor_annomese],
	[aufor_num_dip_dic],
	[aufor_num_dip_cert],
	[aufor_tipo_dic],
	[aufor_stato_certificazione],
	[aufor_aupoc_codice_pk],
	[aupoc_contro_codice]
	
  ORDER BY aufor_annomese

END
