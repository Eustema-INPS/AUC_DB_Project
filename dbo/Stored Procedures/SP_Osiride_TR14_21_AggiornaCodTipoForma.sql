CREATE PROCEDURE [dbo].[SP_Osiride_TR14_21_AggiornaCodTipoForma] 
AS
BEGIN

	SET NOCOUNT ON;
	
	UPDATE TB_AUT14_OSIRIDE_TR14 
	SET AUT14_R14_TIPO_RUOLO  = auara_c_tipo,
		AUT14_R14_FORMA_RUOLO = CASE IsNull(tb_auara_arl_ausca.auara_c_forma,'XXX') WHEN 'XXX' THEN ' ' ELSE right(tb_auara_arl_ausca.auara_c_forma,1) END
	FROM TB_AUT14_OSIRIDE_TR14 
	INNER JOIN tb_ausca_sog_contr_az ON TB_AUT14_OSIRIDE_TR14.AUT14_R14_codice_fiscale = tb_ausca_sog_contr_az.ausca_codice_fiscale 
	INNER JOIN tb_auara_arl_ausca ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_auara_arl_ausca.auara_ausca_codice_pk ;
	
	UPDATE TB_AUT14_OSIRIDE_TR14 
	SET AUT14_R14_TIPO_RUOLO  = auaru_c_tipo,
		AUT14_R14_FORMA_RUOLO = CASE IsNull(tb_auaru_arl_auulo.auaru_c_forma,'XXX') WHEN 'XXX' THEN ' ' ELSE right(tb_auaru_arl_auulo.auaru_c_forma,1) END
	FROM TB_AUT14_OSIRIDE_TR14 
	INNER JOIN   tb_auaru_arl_auulo ON TB_AUT14_OSIRIDE_TR14.AUT14_R14_auulo_codice_pk = tb_auaru_arl_auulo.auaru_auulo_codice_pk;
			 
END
