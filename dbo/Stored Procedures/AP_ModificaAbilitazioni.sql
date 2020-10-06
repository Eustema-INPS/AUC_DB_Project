-- ======================================================================
-- Author:		Maurizio Picone
-- Create date: 24 Gennaio 2012
-- Description:	Modifica le abilitazioni delle funzionalita' per i webservices
--=======================================================================
CREATE PROCEDURE [dbo].[AP_ModificaAbilitazioni] 
	@aufun_codice_pk int, 
	@abilitata varchar(1),
	@utente varchar(50)
AS
BEGIN
   UPDATE  [dbo].[tb_aufun_funz_sistema]
   SET 
      [aufun_flag_abilitato] = @abilitata,
      [aufun_data_modifica] = getdate(),
      [aufun_descr_utente] = @utente
 WHERE aufun_codice_pk = @aufun_codice_pk

END
