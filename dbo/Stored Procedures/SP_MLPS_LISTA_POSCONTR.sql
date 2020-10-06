


-- ===================================================================
-- Author:		Dimpflmeier & Palmieri 
-- Create date: 01/07/2016
-- Description:	Estrazione posizioni contributive IVA per codice fiscale
 
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_MLPS_LISTA_POSCONTR] 

	@codice_fiscale_azienda varchar(16)
	
AS
BEGIN
	SET NOCOUNT ON;
	
   SELECT 	 [aupoc_posizione]    
   FROM  [dbo].[tb_aupoc_pos_contr]
   WITH (READUNCOMMITTED) Inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
  	 
  WHERE 
	  ausca_codice_fiscale = @codice_fiscale_azienda 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z'

  ORDER BY aupoc_posizione

END

