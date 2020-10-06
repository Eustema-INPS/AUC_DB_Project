

CREATE PROCEDURE [dbo].[SP_ElencoPosizioniPerDeleghe] @List AS dbo.ElencoPosizioniPerDeleghe READONLY
	
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT Posizione INTO #TempDeleghe FROM @List;

  SELECT  
	[#TempDeleghe].Posizione As Posizione,
	CASE isnull(tb_aupoc_pos_contr.aupoc_denom_posiz_contr,'---') 
		WHEN '---' THEN ' ' ELSE tb_aupoc_pos_contr.aupoc_denom_posiz_contr 
	END AS Denominazione, 

    CASE isnull(tb_auind_indirizzi.auind_descr_comune,'---') 
		WHEN '---' THEN ' ' ELSE tb_auind_indirizzi.auind_descr_comune 
	END AS Comune, 
	
    CASE isnull(tb_auind_indirizzi.auind_sigla_provincia,'--') 		 
		WHEN '--' THEN ' ' ELSE tb_auind_indirizzi.auind_sigla_provincia 
	END AS Provincia

	FROM tb_aupoc_pos_contr LEFT OUTER JOIN tb_auind_indirizzi ON 
		tb_aupoc_pos_contr.aupoc_codice_pk = tb_auind_indirizzi.auind_tabella_codice_pk RIGHT OUTER JOIN [#TempDeleghe] ON
		tb_aupoc_pos_contr.aupoc_posizione = [#TempDeleghe].Posizione
	WHERE (tb_auind_indirizzi.auind_tabella = 'AUPOC') OR(ISNULL(tb_auind_indirizzi.auind_tabella, '---') = '---');	

END
