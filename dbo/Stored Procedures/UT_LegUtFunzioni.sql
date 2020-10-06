-- =============================================
-- Author:		Natale Saviano
-- Create date: 01 luglio 2011
-- Description:Lettura della tabella funzioni tramite la relazione utente-funzioni con parametro
-- =============================================
CREATE PROCEDURE [dbo].[UT_LegUtFunzioni]
	-- Add the parameters for the stored procedure here
	@ute_codice int,
	@fun_flag varchar(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
  SELECT   aufun_codice_pk AS DB_aufun_codice,
           aufun_funzione AS DB_funzione,
           aufun_raggruppamento AS DB_raggruppamento,
           aufun_tipo_funzione AS DB_tipo_funzione,
           aufun_descr AS DB_descr,
           aufun_flag_abilitato AS DB_flag_abilitato,
           aufun_data_modifica AS DB_data_modifica,
           aufun_descr_utente AS DB_descr_utente,
  (select COUNT(*) from  tb_auref_rel_entita_funz WHERE auref_aufun_codice_pk = aufun_codice_pk AND auref_auten_codice_pk = @ute_codice) AS DB_rel_entita_funz
  FROM tb_aufun_funz_sistema
  WHERE aufun_flag_abilitato = @fun_flag
  
END
