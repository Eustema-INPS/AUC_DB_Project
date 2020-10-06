CREATE PROCEDURE [dbo].[SP_UNITAOPERATIVE]
	@aupoc_posizione varchar(50) = null,
	@aupoc_codice_pk int = null,
	@aupoc_controcodice varchar(6) = null,
    @SoloAttive varchar(1) = null,
	@auuop_identificativo varchar(10) = null
	--AI 2044:
	,@data_dal datetime = null
	,@data_al datetime = null
    --AI 2044.
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	IF (@aupoc_posizione is not null)
		BEGIN
			SELECT
			auuop_codice_pk ,
			auuop_identificativo,
			auuop_denominazione,
			auind_toponimo,
			auind_indirizzo,
			auind_civico,
			auind_descr_comune,
			auind_sigla_provincia,
			auind_cap,
			auind_telefono1,
			auind_telefono2,
			auind_fax,
			auind_email,
			auuop_numero_dipendenti,
			auuop_data_inizio_accentr,
			auuop_data_fine_accentr,
			auuop_unita_operativa,
			auuop_unita_produttiva

			FROM tb_auuop_unita_operativa
			INNER JOIN tb_aupoc_pos_contr ON	auuop_aupoc_codice_pk = aupoc_codice_pk
			LEFT OUTER JOIN tb_auind_indirizzi ON
				UPPER(auind_tabella) = 'AUUOP' AND auind_tabella_codice_pk = auuop_codice_pk
			WHERE (aupoc_posizione = nullif(@aupoc_posizione, '1300483384'))
			AND (@aupoc_codice_pk IS NULL OR auuop_aupoc_codice_pk = @aupoc_codice_pk)
			AND (@auuop_identificativo IS NULL OR auuop_identificativo = @auuop_identificativo)
			AND (@SoloAttive IS NULL OR (auuop_data_inizio_accentr <= convert(date,GETDATE(),103) AND convert(date,GETDATE(),103) <= auuop_data_fine_accentr))
			--AI 2044:
			AND (@data_al IS NULL OR auuop_data_inizio_accentr <= @data_al)
			AND (@data_dal IS NULL OR @data_dal <= auuop_data_fine_accentr)
			--AI 2044.
			ORDER BY
			Convert(int,auuop_identificativo)
		END
	ELSE
		BEGIN
			SELECT
			auuop_codice_pk,
			auuop_identificativo,
			auuop_denominazione,
			auind_toponimo,
			auind_indirizzo,
			auind_civico,
			auind_descr_comune,
			auind_sigla_provincia,
			auind_cap,
			auind_telefono1,
			auind_telefono2,
			auind_fax,
			auind_email,
			auuop_numero_dipendenti,
			auuop_data_inizio_accentr,
			auuop_data_fine_accentr,
			auuop_unita_operativa,
			auuop_unita_produttiva
			FROM tb_auuop_unita_operativa INNER JOIN tb_aupoc_pos_contr ON
					auuop_aupoc_codice_pk = aupoc_codice_pk
			LEFT OUTER JOIN tb_auind_indirizzi ON
			UPPER(auind_tabella) = 'AUUOP' AND auind_tabella_codice_pk = auuop_codice_pk
			WHERE
				  --(@aupoc_posizione IS NULL OR aupoc_posizione = @aupoc_posizione)   AND 
			(@aupoc_codice_pk IS NULL OR auuop_aupoc_codice_pk = @aupoc_codice_pk)
			AND (@auuop_identificativo IS NULL OR auuop_identificativo = @auuop_identificativo)
			AND (@SoloAttive IS NULL OR (auuop_data_inizio_accentr <= convert(date,GETDATE(),103) AND convert(date,GETDATE(),103) <= auuop_data_fine_accentr))
			--AI 2044:
			AND (@data_al IS NULL OR auuop_data_inizio_accentr <= @data_al)
			AND (@data_dal IS NULL OR @data_dal <= auuop_data_fine_accentr)
			--AI 2044.
			ORDER BY Convert(int,auuop_identificativo)
		END
END
