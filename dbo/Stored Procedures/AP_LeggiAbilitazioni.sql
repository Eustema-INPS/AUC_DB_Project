-- ======================================================================
-- Author:		Maurizio Picone
-- Create date: 24 gennaio 2012
-- Description:	Legge le abilitazioni delle funzionalità per i WebServices
-- ======================================================================
CREATE PROCEDURE [dbo].[AP_LeggiAbilitazioni]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT [aufun_codice_pk]
      ,[aufun_funzione]
      ,[aufun_raggruppamento]
      ,[aufun_tipo_funzione]
      ,[aufun_descr]
      ,[aufun_flag_abilitato]
      ,[aufun_data_modifica]
      ,[aufun_descr_utente]
    FROM  [dbo].[tb_aufun_funz_sistema]
    WHERE [aufun_tipo_funzione] = 'W'
END
