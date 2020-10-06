-- ======================================================================
-- Author:		Maurizio Picone
-- Create date: 24 gennaio 2012
-- Description:	Legge le abilitazioni delle funzionalità per i WebServices
-- ======================================================================
CREATE PROCEDURE [dbo].[AP_ElencoAreaDesc]
AS
BEGIN
	SET NOCOUNT ON;


  select   tb_aurea_area_gestione.aurea_codice_pk,
  tb_aurea_area_gestione.aurea_descrizione
  FROM tb_aurea_area_gestione

END

