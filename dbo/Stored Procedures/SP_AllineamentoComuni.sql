
-- =============================================
-- Author:		IP
-- Create date: 11/09/2019
-- Update date: 13/09/2019
-- Description:	Allineamento e Bonifica indirizzo /comune
-- =============================================
CREATE PROCEDURE [dbo].[SP_AllineamentoComuni]
AS
BEGIN
	SET NOCOUNT ON;	

------------------------------------
----         Fase 1             ----
--  Allineamento COMMON con      ---
--  tb_aualc_Allineamento_Comuni ---
------------------------------------
IF OBJECT_ID('tempdb.dbo.#temp_aualc', 'U') IS NOT NULL  DROP TABLE #temp_aualc; 

CREATE TABLE #temp_aualc (		
	[Comune_AUC] [varchar](60) NULL,
	[ComuneI] [varchar](60) NULL,
	[ComuneT] [varchar](60) NULL,
	[Belfiore] [char](4) NOT NULL,
	[PROV] [char](3) NOT NULL,
	[regione] [char](2) NOT NULL,
	[regione_inps] [char](2) NOT NULL,
	[stato] [int] NULL	,
	[flag_presente] [int] NULL	
) ON [PRIMARY]

-- Popolo la temporanea con AgendaSedi della Mitelli (di fatto una copia speculare della mitelli)
INSERT INTO #temp_aualc ([Comune_AUC],[ComuneI],[ComuneT],[Belfiore],[PROV],[regione],[regione_inps])
  SELECT [Comune_AUC],[ComuneI],[ComuneT],[Belfiore],[PROV],[regione],[regione_inps]	  
  FROM [AgendaSedi].[dbo].[competenze_AUC]
  GROUP BY [Belfiore],[PROV],[Comune_AUC],[ComuneI],[ComuneT],[cod6],[sede],[regione],[regione_inps]

-- Vengono marcati con aualc_flag_presente = 1 i record presenti sulla aualc
UPDATE #temp_aualc
SET flag_presente = 1
FROM #temp_aualc 
INNER JOIN tb_aualc_Allineamento_Comuni ON #temp_aualc.Belfiore = tb_aualc_Allineamento_Comuni.aualc_Belfiore

-- Inserisco i record NON PRESENTI
INSERT INTO [dbo].[tb_aualc_Allineamento_Comuni] (
	        [aualc_Comune_AUC]
           ,[aualc_ComuneI]
           ,[aualc_ComuneT]
           ,[aualc_Belfiore]
           ,[aualc_PROV]
           ,[aualc_regione]
           ,[aualc_regione_inps] 		   
           ,[aualc_data_modifica]
           ,[aualc_descr_utente])
SELECT 	[Comune_AUC],
		[ComuneI],
		[ComuneT],
		[Belfiore],
		[PROV] ,
		[regione],
		[regione_inps],
		Getdate(),
		'AdminPlus'
FROM #temp_aualc
WHERE isnull(flag_presente,0) <> 1 

-- Aggiorno i record già presenti
UPDATE tb_aualc_Allineamento_Comuni
SET aualc_Comune_AUC = Comune_AUC,
	aualc_ComuneI = ComuneI, 
	aualc_ComuneT = ComuneT, 
	aualc_PROV = PROV, 
	aualc_regione =regione, 
	aualc_regione_inps = regione_inps,
	aualc_data_modifica = GetDate(),
    aualc_descr_utente = 'AdminPlus'
FROM #temp_aualc 
INNER JOIN tb_aualc_Allineamento_Comuni ON #temp_aualc.Belfiore = tb_aualc_Allineamento_Comuni.aualc_Belfiore
WHERE isnull(flag_presente,0) = 1 

-- Arricchisco la aualc con i Codici ISTAT
UPDATE tb_aualc_Allineamento_Comuni
SET [aualc_ISTAT_Codice_Regione] = VI_ISTAT_COMUNI.[Codice Regione] ,
    [aualc_ISTAT_Codice_Comune]  = VI_ISTAT_COMUNI.CodiceComune
FROM tb_aualc_Allineamento_Comuni 
LEFT OUTER JOIN VI_ISTAT_COMUNI ON tb_aualc_Allineamento_Comuni.aualc_Belfiore = VI_ISTAT_COMUNI.CodiceBelfiore

-- Accodo nella TB_AUMAC_MANCATA_ASSOCIAZIONE_COMUNI i record ai quali non sono riuscito ad associare
-- il Codice Regione e il Codice Comune STAT 
-- Popolo la temporanea con tutti i record non associati nella aualc
TRUNCATE TABLE #temp_aualc
	
INSERT INTO  #temp_aualc (	
	[Comune_AUC] ,
	[ComuneI] ,
	[ComuneT] ,
	[Belfiore] ,
	[PROV] ,
	[regione] ,
	[regione_inps] ) 
SELECT [aualc_Comune_AUC]
		,[aualc_ComuneI]
		,[aualc_ComuneT]
		,[aualc_Belfiore]
		,[aualc_PROV]
		,[aualc_regione]
		,[aualc_regione_inps]
FROM [dbo].[tb_aualc_Allineamento_Comuni]
WHERE [aualc_ISTAT_Codice_Regione] is null
AND   [aualc_ISTAT_Codice_Comune]   is null
GROUP BY [aualc_Comune_AUC]
		,[aualc_ComuneI]
		,[aualc_ComuneT]
		,[aualc_Belfiore]
		,[aualc_PROV]
		,[aualc_regione]
		,[aualc_regione_inps]

-- Inserimento nella aummac
INSERT INTO [dbo].[tb_aumac_Mancata_Associazione_Comuni]
           ([aumac_Comune_AUC]
           ,[aumac_ComuneI]
           ,[aumac_ComuneT]
           ,[aumac_Belfiore]
           ,[aumac_PROV]
		   ,[aumac_Flag_Agenda_Sedi]
		   ,[aumac_data_modifica]
		   ,[aumac_descr_utente]
           )
   SELECT 	[Comune_AUC] ,
   	[ComuneI] ,
   	[ComuneT] ,
   	[Belfiore] ,
   	[PROV] ,
   	'S', 
   	Getdate(),
   	'AdminPlus'		
   FROM #temp_aualc  
   LEFT OUTER JOIN [tb_aumac_Mancata_Associazione_Comuni] ON [aumac_Comune_AUC] = Comune_AUC
   AND [aumac_PROV] = PROV
   WHERE [tb_aumac_Mancata_Associazione_Comuni].aumac_codice_pk  is null

UPDATE tb_aumac_Mancata_Associazione_Comuni
SET aumac_ISTAT_Codice_Comune = CodIstatComune                   
FROM tb_aumac_Mancata_Associazione_Comuni 
LEFT OUTER JOIN VI_ISTAT_COMUNI_SOPPRESSI ON tb_aumac_Mancata_Associazione_Comuni.aumac_Comune_AUC = VI_ISTAT_COMUNI_SOPPRESSI.Denominazione 
AND  tb_aumac_Mancata_Associazione_Comuni.aumac_PROV = VI_ISTAT_COMUNI_SOPPRESSI.SiglaProvincia
WHERE CodIstatComune is not null

IF OBJECT_ID('tempdb.dbo.#temp_Regione', 'U') IS NOT NULL  DROP TABLE #temp_Regione; 

CREATE TABLE #temp_Regione (		
	[Codice_Regione] [varchar](2) ,
	[PROV] [Varchar](3) 
) ON [PRIMARY]

-- Popolo la temporanea con AgendaSedi della Mitelli (di fatto una copia speculare della mitelli)
--SELECT * FROM #temp_Regione;
INSERT INTO #temp_Regione ([Codice_Regione],[PROV])
	SELECT [aualc_ISTAT_Codice_Regione],aualc_PROV
	FROM [AUC].[dbo].[tb_aualc_Allineamento_Comuni]
	GROUP BY [aualc_ISTAT_Codice_Regione],aualc_PROV
	ORDER BY [aualc_ISTAT_Codice_Regione],aualc_PROV

--SELECT * FROM #temp_Regione ;

UPDATE tb_aumac_Mancata_Associazione_Comuni
SET aumac_ISTAT_Codice_Regione = [Codice_Regione]                   
FROM tb_aumac_Mancata_Associazione_Comuni 
INNER JOIN #temp_Regione ON aumac_PROV = PROV;

DROP TABLE #temp_Regione;

--- Cancellazione nella aualc dei comuni soppressi
DELETE FROM tb_aualc_Allineamento_Comuni
FROM #temp_aualc 
INNER JOIN tb_aualc_Allineamento_Comuni ON #temp_aualc.Belfiore = tb_aualc_Allineamento_Comuni.aualc_Belfiore

DROP TABLE #temp_aualc

-------------------------------------------------------
----                Fase 2                         ----
--  Infasamento dei comuni non trovati su AUSCA     ---
-------------------------------------------------------
IF OBJECT_ID('tempdb.dbo.#temp_ausca', 'U') IS NOT NULL  DROP TABLE #temp_ausca; 

-- Caricamento della temporanea di ausca
CREATE TABLE #temp_ausca(
	[codice_pk] [int] NOT NULL,
	[descr_comune] [varchar](30) NULL,
	[sigla_provincia] [varchar](2) NULL,
	[comune_esteso_ita] [varchar](60) NULL,
	[comune_esteso_ted] [varchar](60) NULL,
	[cod_com_ISTAT] [varchar](6) NULL,
	[cod_com_Belfiore] [varchar](4) NULL,
	[flag] [int] NULL
) 

IF OBJECT_ID('NonClustIdxTempAusca', 'U') IS NOT NULL  
	DROP INDEX [NonClustIdxTempAusca] ON  #temp_ausca; 
CREATE UNIQUE NONCLUSTERED INDEX [NonClustIdxTempAusca] ON  #temp_ausca
( [codice_pk] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--GO

INSERT INTO #temp_ausca
           ([codice_pk]
           ,[descr_comune]
           ,[sigla_provincia]
           ,[comune_esteso_ita]
           ,[comune_esteso_ted]
           ,[cod_com_ISTAT]
           ,[cod_com_Belfiore]
           ,[flag])
SELECT  [ausca_codice_pk]
       ,[ausca_descr_comune]
       ,[ausca_sigla_provincia]
       ,[ausca_comune_esteso_ita]
       ,[ausca_comune_esteso_ted]
       ,[ausca_cod_com_ISTAT]
       ,[ausca_cod_com_Belfiore]
       ,0
FROM tb_ausca_sog_contr_az with(nolock)

-- Verifico quanti record di ausca sono sulla aualc
UPDATE #temp_ausca 
SET flag = 1 
FROM #temp_ausca T
INNER JOIN tb_aualc_Allineamento_Comuni AC ON T.descr_comune = AC.aualc_Comune_AUC 
AND T.sigla_provincia = AC.aualc_PROV
--AND T.cod_com_Belfiore = AC.aualc_Belfiore ;

UPDATE  #temp_ausca 
SET flag = 2
FROM  #temp_ausca T with(nolock)
INNER JOIN tb_aumac_Mancata_Associazione_Comuni A ON T.descr_comune = A.aumac_Comune_AUC 
AND T.sigla_provincia = A.aumac_PROV
--AND T.cod_com_Belfiore = A.aumac_Belfiore
AND T.flag = 0

INSERT INTO [dbo].[tb_aumac_Mancata_Associazione_Comuni]
           ([aumac_Comune_AUC]
           ,[aumac_ComuneI]
           ,[aumac_ComuneT]
           ,[aumac_Belfiore]
           ,[aumac_PROV]
		   ,[aumac_Flag_Agenda_Sedi]
		   ,[aumac_data_modifica]
		   ,[aumac_descr_utente]
           )
  SELECT descr_comune As [aualc_Comune_AUC], 
  		descr_comune As [aualc_Comune_AUC],
  		descr_comune As [aualc_ComuneT],
  		cod_com_belfiore  As [aualc_Belfiore], 
  		sigla_provincia   As [aualc_PROV],
  		'N' ,
  		Getdate() ,
  		'AdminPlus'  		
  FROM #temp_ausca with(nolock)
  WHERE flag = 0
  GROUP BY descr_comune, sigla_provincia,cod_com_belfiore
  ORDER BY sigla_provincia, descr_comune

--DROP INDEX [NonClusteredIndex-20190205-153543] ON  #temp_ausca; 
DROP INDEX [NonClustIdxTempAusca] ON  #temp_ausca; 
DROP TABLE #temp_ausca ;	

--------------------------------
----	   Fase 3           ----
-- Allineamento AUMAC/AUALC  ---
--------------------------------
	UPDATE tb_aumac_Mancata_Associazione_Comuni
	SET [aumac_Comune_AUC_New]           = aualc_Comune_AUC ,
		[aumac_ComuneI_New]              = aualc_ComuneI ,
		[aumac_ComuneT_New]              = aualc_ComuneT ,
		[aumac_Belfiore_New]             = aualc_Belfiore ,
		[aumac_PROV_New]                 = aualc_PROV ,
		[aumac_regione_New]              = aualc_regione ,
		[aumac_regione_inps_New]         = aualc_regione_inps ,
		[aumac_ISTAT_Codice_Regione_New] = aualc_ISTAT_Codice_Regione,
		[aumac_ISTAT_Codice_Comune_New]  = aualc_ISTAT_Codice_Comune 
	FROM tb_aumac_Mancata_Associazione_Comuni 
	INNER JOIN tb_aualc_Allineamento_Comuni ON tb_aumac_Mancata_Associazione_Comuni.aumac_Comune_AUC = tb_aualc_Allineamento_Comuni.aualc_Comune_AUC 
	AND tb_aumac_Mancata_Associazione_Comuni.aumac_PROV = tb_aualc_Allineamento_Comuni.aualc_PROV	

	--------------------------
	----   Fase 4         ----
	-- Aggiornamento AUSCA ---
	-- Temporaneamente sospesa --
	--------------------------	
	--UPDATE tb_ausca_sog_contr_az
	--SET 
	--	ausca_comune_esteso_ita   = aualc_ComuneI , 
	--	ausca_comune_esteso_ted   = aualc_ComuneT , 
	--	ausca_cod_com_Belfiore    = aualc_Belfiore , 
	--	ausca_regione             = aualc_regione, 
	--	ausca_cod_regione_ISTAT   = aualc_ISTAT_Codice_Regione , 
	--	ausca_cod_com_ISTAT       = aualc_ISTAT_Codice_Comune , 
	--	ausca_regione_Agenda_Sedi = aualc_regione ,
	--	ausca_regione_inps        = aualc_regione_inps 
	--FROM tb_ausca_sog_contr_az 
	--INNER JOIN tb_aualc_Allineamento_Comuni ON ausca_descr_comune = aualc_Comune_AUC 
	--AND  ausca_sigla_provincia = aualc_PROV ;

	-- Carico in una tabella temporanea il codice di ausca che andrò a modificare
	IF OBJECT_ID('tempdb.dbo.#temp_auscaPK', 'U') IS NOT NULL  DROP TABLE #temp_auscaPK; 

	CREATE TABLE #temp_auscaPK ([codice_pk] [int] NOT NULL) ON [PRIMARY]
	INSERT INTO #temp_auscaPK  ([codice_pk] )
		SELECT [ausca_codice_pk]	
		FROM tb_aumac_Mancata_Associazione_Comuni 
		INNER JOIN tb_ausca_sog_contr_az ON tb_aumac_Mancata_Associazione_Comuni.aumac_Comune_AUC = tb_ausca_sog_contr_az.ausca_descr_comune 
		AND  tb_aumac_Mancata_Associazione_Comuni.aumac_PROV = tb_ausca_sog_contr_az.ausca_sigla_provincia
		WHERE(tb_aumac_Mancata_Associazione_Comuni.aumac_flag_associazione = 1) ;
	
	-- Aggiornamento di AUSCA in join con AUMAC
	UPDATE tb_ausca_sog_contr_az
	SET ausca_descr_comune        = aumac_Comune_AUC_New, 
		ausca_comune_esteso_ita   = aumac_ComuneI_New , 
		ausca_comune_esteso_ted   = aumac_ComuneT_New , 
		ausca_cod_com_Belfiore    = aumac_Belfiore_New , 
		ausca_sigla_provincia     = aumac_PROV_New , 
		ausca_regione             = aumac_regione_New, 
		ausca_cod_regione_ISTAT   = aumac_ISTAT_Codice_Regione_New , 
		ausca_cod_com_ISTAT       = aumac_ISTAT_Codice_Comune_New , 
		ausca_regione_Agenda_Sedi = aumac_regione_New ,
		ausca_regione_inps        = aumac_regione_inps_New ,
		ausca_data_modifica       = Getdate() ,
		ausca_descr_utente        = 'AdminPlus'
	FROM tb_aumac_Mancata_Associazione_Comuni 
	INNER JOIN tb_ausca_sog_contr_az ON tb_aumac_Mancata_Associazione_Comuni.aumac_Comune_AUC = tb_ausca_sog_contr_az.ausca_descr_comune 
	AND  tb_aumac_Mancata_Associazione_Comuni.aumac_PROV = tb_ausca_sog_contr_az.ausca_sigla_provincia
	WHERE(tb_aumac_Mancata_Associazione_Comuni.aumac_flag_associazione = 1) ;

	--------------------------
	----   Fase 5         ----
	-- Variazioni su AUVAR ---
	--------------------------
	Declare @InnerCursor AS CURSOR ;
	Declare @return_value int
	Declare @CodicePK As BigInt;
	
	SET @InnerCursor = CURSOR FOR	
		SELECT [codice_pk] FROM #temp_auscaPK

	OPEN @InnerCursor;
	FETCH NEXT FROM @InnerCursor INTO @CodicePK ;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC @return_value = [dbo].[AZ_1_Sincronizza]
				@codiceAzienda = @CodicePK,
				@auvar_auten_codice_pk = 1,
				@auvar_codice_entita_riferimento = 26,
				@descrUtente = 'AdminPlus'

		--SELECT  'Return Value' = @return_value			
		FETCH NEXT FROM @InnerCursor INTO @CodicePK ;

	END

	CLOSE @InnerCursor;
	DEALLOCATE @InnerCursor;
	DROP TABLE #temp_auscaPK ;	

	-- Bonifica AUIND
	--UPDATE tb_auind_indirizzi
	--SET auind_descr_comune        = aumac_Comune_AUC_New, 
	--	auind_sigla_provincia     = aumac_PROV_New , 
	--	auind_data_modifica       = Getdate() ,
	--	auind_descr_utente        = 'AdminPlus'
	--FROM tb_auind_indirizzi 
	--INNER JOIN tb_aumac_Mancata_Associazione_Comuni ON tb_auind_indirizzi.auind_descr_comune = tb_aumac_Mancata_Associazione_Comuni.aumac_Comune_AUC 
	--AND tb_auind_indirizzi.auind_sigla_provincia = tb_aumac_Mancata_Associazione_Comuni.aumac_PROV
	--WHERE (tb_auind_indirizzi.auind_descr_comune IS NOT NULL) 
	--AND (tb_auind_indirizzi.auind_descr_comune <> '                              ') 
	--AND (tb_auind_indirizzi.auind_descr_comune <> '-                             ')
	--AND (tb_aumac_Mancata_Associazione_Comuni.aumac_flag_associazione = 1)
	--AND (auind_descr_comune <> aumac_Comune_AUC_New)
		
END
