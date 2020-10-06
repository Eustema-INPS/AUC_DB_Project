-- ======================================================================
-- Author:		Maurizio Picone
-- Create date: 15/11/2011
-- Description:	
-- LA STORED SINCRONIZZA LA TABELLA DELLE VARIAZIONI ANAGRAFICA AZIENDA (tb_auvar_var_dati)      
-- CON LA TABELLA MADRE (tb_ausca_sog_contr_az) TENENDO CONTO DEI CAMPI ELENCATI NELLA 
-- TABELLA DEI CAMPI SENSIBILI (tb_aueva_elenco_variabili)
-- ======================================================================

CREATE PROCEDURE [dbo].[AZ_SincronizzaVariazioni]
	@codiceAzienda int,
	@auvar_auten_codice_pk int,
	@auvar_codice_entita_rif int
AS
BEGIN
	SET NOCOUNT ON;	

-- =====================================================================
-- Reperimento dell'elenco variabili da monitorare [tb_aueva_elenco_variabili]
-- ======================================================================
	DECLARE CURSORE_CAMPI Cursor
	FOR
    SELECT [aueva_nome_var] FROM [dbo].[tb_aueva_elenco_variabili] 
       
       
    -- ===============================================
    -- Ciclo sull'elenco dei campi e creazione query
    -- ===============================================
    OPEN CURSORE_CAMPI 
      
    DECLARE @NomeCampo Varchar(100)    
    DECLARE @QUERY VARCHAR(5000)          
    DECLARE @contatore int
    SET @contatore = 0
    
    FETCH NEXT FROM CURSORE_CAMPI INTO @NomeCampo
	WHILE (@@FETCH_STATUS = 0)		
	BEGIN	       
	        SET @QUERY = ''
          
			SET @QUERY = '
			DECLARE @CONTENUTO_CAMPO_AUSCA'+CONVERT(VARCHAR,@contatore)+' VARCHAR(305)
			DECLARE @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' VARCHAR(100)
			DECLARE @CONTEGGIO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' INT
			'
		       
            SET @QUERY += '
            SET @CONTEGGIO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' = 
               (SELECT COUNT(auvar_valore_modificato) AS CONTEGGIO
			    FROM tb_auvar_var_dati 
				WHERE auvar_aueva_nome_var='''+@NomeCampo+''' AND auvar_ausca_codice_pk = ' + CONVERT(VARCHAR(10),@codiceAzienda) + ')
				
				
			IF @CONTEGGIO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' > 0
			BEGIN					
				 SET @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' =
				   (SELECT TOP 1 auvar_valore_modificato as VALORE_MODIFICATO
					FROM tb_auvar_var_dati 
					WHERE auvar_aueva_nome_var='''+ @NomeCampo +''' AND auvar_ausca_codice_pk = ' + CONVERT(VARCHAR(10),@codiceAzienda) + ' 
					GROUP by auvar_valore_modificato,auvar_data_variazione
					ORDER BY auvar_data_variazione DESC)
	        END
		    ELSE SET @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' = '' ''		
		   
	        

			SET @CONTENUTO_CAMPO_AUSCA'+CONVERT(VARCHAR,@contatore)+' = CONVERT(VARCHAR,
				(SELECT '+ @NomeCampo +' FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk =' + CONVERT(VARCHAR(10),@codiceAzienda) + '))
				
				PRINT ''-----------------------------------------------''
                PRINT '''+ @NomeCampo +' SU AUSCA:'' + @CONTENUTO_CAMPO_AUSCA'+CONVERT(VARCHAR,@contatore)+'
                PRINT '''+ @NomeCampo +' SU AUVAR:'' + @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+'
                PRINT ''-----------------------------------------------''
                
				IF CONVERT(VARCHAR, @CONTENUTO_CAMPO_AUSCA'+CONVERT(VARCHAR,@contatore)+') <> CONVERT(VARCHAR, @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+') 
				BEGIN		
				    IF @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' = '' '' SET @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' = NULL
				    ELSE SET @CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+' = CONVERT(VARCHAR(100),@CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+')
				    
					INSERT INTO [tb_auvar_var_dati]
						   ([auvar_ausca_codice_pk]
						   ,[auvar_aueva_nome_var]
						   ,[auvar_valore_originale]
						   ,[auvar_valore_modificato]
						   ,[auvar_data_variazione]
						   ,[auvar_auten_codice_pk]
						   ,[auvar_codice_entita_rif])
					 VALUES
						   ('+ CONVERT(VARCHAR(10),@codiceAzienda) +'
						   ,'''+ @NomeCampo +'''
						   ,@CONTENUTO_CAMPO_AUVAR'+CONVERT(VARCHAR,@contatore)+'
						   ,CONVERT(VARCHAR(100),@CONTENUTO_CAMPO_AUSCA'+CONVERT(VARCHAR,@contatore)+')
						   ,GETDATE()
						   ,'+CONVERT(VARCHAR(10),@auvar_auten_codice_pk)+'
						   ,'+CONVERT(VARCHAR(10),@auvar_codice_entita_rif)+')
				END' 
			
            PRINT(@QUERY)			
            EXEC(@QUERY) 
                  
 		    SET @contatore +=1		        
		    FETCH NEXT FROM CURSORE_CAMPI INTO @NomeCampo
	END
		
	CLOSE CURSORE_CAMPI
	DEALLOCATE CURSORE_CAMPI
END
