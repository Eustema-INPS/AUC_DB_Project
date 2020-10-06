
-- ======================================================================
-- Author:		Maurizio Picone
-- Create date: 24 gennaio 2012
-- Description:	Legge le abilitazioni delle funzionalità per i WebServices
-- ======================================================================
CREATE PROCEDURE [dbo].[AP_ElencoCariche]
AS
BEGIN
	SET NOCOUNT ON;


  select    tb_autis_tipo_sog_col_ct.autis_codice_carica as autis_codice_carica,
   tb_autis_tipo_sog_col_ct.autis_descr as autis_descr
  FROM  tb_autis_tipo_sog_col_ct  as  tb_autis_tipo_sog_col_ct 
  union
  select   '0' as autis_codice_carica,' -- Selezionare Ruolo -- ' as autis_descr
    FROM  tb_autis_tipo_sog_col_ct  as  tb_autis_tipo_sog_col_ct_1
  order by autis_descr


END

