
-- ===============================================================================================
-- Author:		Raffaele Palmieri
-- Create date: 10/06/2019
-- La Stored inserisce nella Tabella [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] i record di Ausco che devono essere verificati su ARCA.
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_RICHIESTA_ARCA_PER_AUSCO] 
	AS
BEGIN

	SET NOCOUNT ON;
	
	-- Preselezione dei dati da inviare 
	update tb_ausco_sog_contr_col
	set ausco_stato_lavorazione_arca = 'DI' -- Da inviare
	 where len(ausco_codice_fiscale) = 16 and substring(ausco_codice_fiscale,1,1) >='a' and substring(ausco_codice_fiscale,1,1) <='z'
	and (ausco_stato_lavorazione_arca is null) 

	-- Eventuale scarto record già presenti nella tabella di interfaccia
	update tb_ausco_sog_contr_col
	set ausco_stato_lavorazione_arca = 'GP' -- Da scartare perchè già presente
	from tb_ausco_sog_contr_col
	inner join [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] on ausco_codice_pk = auias_chiave_auc and auias_provenienza = 'AUSCO'
	where ausco_stato_lavorazione_arca = 'DI' --inserita il 9 gennaio, da verificare
	------------------
	--SELECT * from tb_ausco_sog_contr_col
	--inner join [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] on ausco_codice_pk = auias_chiave_auc and auias_provenienza = 'AUSCO'
	--where ausco_stato_lavorazione_arca = 'DI' --inserita il 9 gennaio, da verificare

	--SELECT COUNT(*), ausco_stato_lavorazione_arca
	--from tb_ausco_sog_contr_col
	--GROUP BY ausco_stato_lavorazione_arca

	-- Inserimento dati da certificare
	INSERT INTO [dbo].[TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]
			   ([AUIAS_CHIAVE_AUC]
			   ,[AUIAS_PROVENIENZA]
			   ,[AUIAS_CODICE_FISCALE]
			   ,AUIAS_I_CfCcc1_Ev0_ARCA
			   ,AUIAS_I_Progr_Ev0_ARCA
			   ,[AUIAS_I_DENOMINAZIONE]
			   ,[AUIAS_I_COGNOME]
			   ,[AUIAS_I_NOME]
			   ,[AUIAS_I_SESSO]
			   ,[AUIAS_I_FRAZIONE]
			   ,[AUIAS_I_TOPONIMO]
			   ,[AUIAS_I_INDIRIZZO]
			   ,[AUIAS_I_CIVICO]
			   ,[AUIAS_I_CAP]
			   ,[AUIAS_I_COMUNE]
			   ,[AUIAS_I_PROVINCIA]
			   ,[AUIAS_I_COD_COMUNE_BELF]
			   ,[AUIAS_I_DATA_NASCITA]
			   ,[AUIAS_I_DATA_MORTE]
			   ,[AUIAS_I_COMUNE_NASCITA]
			   ,[AUIAS_I_PROVINCIA_NASCITA]
			   ,[AUIAS_I_COD_COMUNE_BELF_NASCITA]
			   ,[AUIAS_I_COD_NAZIONE_BELF_NASCITA]
			   ,[AUIAS_I_SIGLA_NAZIONE_NASCITA]
			   ,[AUIAS_I_DESCR_NAZIONE_NASCITA]
			   ,[AUIAS_I_NAZIONALITA]
			   ,[AUIAS_I_TELEFONO]
			   ,[AUIAS_I_EMAIL]
			   ,[AUIAS_I_PEC]
			)
	select ausco_codice_pk
			,'AUSCO'
			,ausco_codice_fiscale
			,Ausco_CfCcc1_Ev0_ARCA
			,Ausco_Progr_Ev0_ARCA
			,ausco_denominazione
			,ausco_cognome
			,ausco_nome
			,ausco_sesso
			,ausco_residenza_frazione
			,ausco_toponimo
			,ausco_indirizzo
			,ausco_civico
			,ausco_cap
			,ausco_localita
			,ausco_provincia
			,ausco_cod_comune_belf
			,convert(date,ausco_data_nascita)
			,convert(date,ausco_data_morte)
			,ausco_comune_nascita
			,ausco_prov_nascita
			,ausco_codice_comune_nasc
			,ausco_codice_stato_estero_nasc
			,substring(ausco_sigla_nazione,1,3)
			,ausco_descr_stato_nascita
			,ausco_cittadinanza
			,ausco_telefono
			,ausco_email
			,ausco_pec
	 from tb_ausco_sog_contr_col
	 where len(ausco_codice_fiscale) = 16 and substring(ausco_codice_fiscale,1,1) >='a' and substring(ausco_codice_fiscale,1,1) <='z'
	and (ausco_stato_lavorazione_arca = 'DI') 


	-- Preselezione dei dati da inviare

	create table #temp(codice int) on [primary];

	insert into #temp (codice)
	select ausco_codice_pk from tb_ausco_sog_contr_col
	inner join [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] on ausco_codice_pk = auias_chiave_auc and auias_provenienza = 'AUSCO'
	where len(ausco_codice_fiscale) = 16 and substring(ausco_codice_fiscale,1,1) >='a' and substring(ausco_codice_fiscale,1,1) <='z'
	and (ausco_stato_lavorazione_arca = 'DI')

	update tb_ausco_sog_contr_col
	set ausco_stato_lavorazione_arca = 'IN' -- Da inviare
	from tb_ausco_sog_contr_col
	inner join #temp on codice = ausco_codice_pk

--	update tb_ausco_sog_contr_col
--	set ausco_stato_lavorazione_arca = 'IN' -- Da inviare
--	from tb_ausco_sog_contr_col
--select ausco_codice_pk, ausco_stato_lavorazione_arca from tb_ausco_sog_contr_col
	--inner join [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] on ausco_codice_pk = auias_chiave_auc and auias_provenienza = 'AUSCO'
	--where len(ausco_codice_fiscale) = 16 and substring(ausco_codice_fiscale,1,1) >='a' and substring(ausco_codice_fiscale,1,1) <='z'
	--and (ausco_stato_lavorazione_arca = 'DI') 


	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END

