



-- ====================================================================
-- Author:		Peter Dimpflmeier

-- Description:	estrae le posizioni "navali" per un codice fiscale
-- ====================================================================

CREATE PROCEDURE [dbo].[SP_POSIZIONI_NAVALI_CF] 
	@codiceFiscale varchar(16)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
      [aupoc_posizione] as posizione
      
  FROM  [dbo].[tb_aupoc_pos_contr]
  
  inner join [dbo].[tb_ausca_sog_contr_az] 
  ON	[ausca_codice_pk] = [aupoc_ausca_codice_pk]
  
  WHERE ausca_codice_fiscale = @codiceFiscale
  AND aupoc_navale = 'S'

  ORDER BY aupoc_posizione

END

