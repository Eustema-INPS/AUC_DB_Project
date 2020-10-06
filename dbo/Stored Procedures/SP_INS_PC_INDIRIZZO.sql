


-- =====================================================================
-- Author:		Bellantoni e Picone
-- Create date: 15/11/2012
-- Description:	Inserimento Indirizzo AUIND per Posizioni Contributive
-- Modifica Peter per AI 2050: 2014.09.22
-- =====================================================================
CREATE PROCEDURE [dbo].[SP_INS_PC_INDIRIZZO] 

        @auind_indirizzo varchar(255) = null
       ,@auind_civico varchar(50) = null
       ,@auind_descrizione_comune varchar(50) = null
       ,@auind_sigla_provincia varchar(2) = null
       ,@auind_CAP varchar(10) = null
       ,@auind_tabella_codice_pk int
       ,@appname varchar(50)
       --AI 2050: aggiunto = NULL
       ,@auind_codice_toponimo varchar(3) = NULL
       ,@auind_toponimo varchar(50) = NULL
       ,@auind_localita varchar(50) = NULL
       ,@auind_frazione varchar(100) = NULL
       ,@auind_telefono1 varchar(20) = NULL
       ,@auind_telefono2 varchar(20) = NULL
       ,@auind_email varchar(162) = NULL
       ,@auind_pec varchar(162) = NULL
       ,@auind_codice_qualita_ind varchar(1) = NULL       
	   --AI 2050.
	   --AI 2050:
	   ,@auind_gestore_indirizzo varchar(10) = null 
		,@auind_fax varchar(20) = NULL
		,@auind_codice_comune varchar(5) = NULL
		,@auind_codice_comune_istat varchar(6) = NULL
		,@auind_codice_stato_estero varchar(5) = NULL
		,@auind_descr_stato_estero varchar(50) = NULL
		,@auind_aurea_codice_pk int = NULL
	   --AI 2050.
--Peter 2015.05.18: possibilità di fornire nome tabella da fuori; il default è AUPOC, come prima
		,@auind_tabella varchar(5) = NULL
--Peter 2015.05.18.
AS
BEGIN
SET NOCOUNT ON;

			--2016.05.11:
			if (@auind_telefono1 IS NULL OR ltrim(rtrim(@auind_telefono1)) = '') begin set @auind_telefono1 = '000000' end
			if (@auind_telefono2 IS NULL OR ltrim(rtrim(@auind_telefono2)) = '') begin set @auind_telefono2 = '000000' end
			if (@auind_fax IS NULL OR ltrim(rtrim(@auind_fax)) = '') begin set @auind_fax = '000000' end
			--2016.05.11.


INSERT INTO [dbo].[tb_auind_indirizzi]
           ([auind_lingua]
           ,[auind_tabella]
           ,[auind_tabella_codice_pk]
           ,[auind_sede_indirizzo]
           ,[auind_codice_toponimo]
           ,[auind_toponimo]
           ,[auind_indirizzo]
           ,[auind_civico]
           ,[auind_localita]
           ,[auind_frazione]
           ,[auind_codice_comune]
           ,[auind_codice_comune_istat]
           ,[auind_descr_comune]
           ,[auind_sigla_provincia]
           ,[auind_cap]
           ,[auind_codice_stato_estero]
           ,[auind_descr_stato_estero]
           ,[auind_telefono1]
           ,[auind_telefono2]
           ,[auind_telefono3]
           ,[auind_fax]
           ,[auind_email]
           ,[auind_pec]
           ,[auind_chiave_interna]
           ,[auind_chiave_esterna]
           ,[auind_gestore_indirizzo]
           ,[auind_stato_indirizzo]
           ,[auind_codice_qualita_ind]
           ,[auind_flag_operativo]
           ,[auind_data_modifica]
           ,[auind_descr_utente]
           ,[auind_codice_pk_db2]
		   --AI 2050:
		   ,[auind_aurea_codice_pk]
		   --AI 2050.
		   )

     VALUES
           (
            NULL
--Peter 2015.05.18: possibilità di fornire nome tabella da fuori; il default è AUPOC, come prima
		   ,ISNULL(@auind_tabella, 'AUPOC')
           --,'AUPOC'
--Peter 2015.05.18.
           ,@auind_tabella_codice_pk
           ,NULL
           ,@auind_codice_toponimo
           ,@auind_toponimo 
           ,@auind_indirizzo 
           ,@auind_civico 
           ,@auind_localita 
           ,@auind_frazione 
			,@auind_codice_comune
			,@auind_codice_comune_istat
           ,@auind_descrizione_comune 
           ,@auind_sigla_provincia
           ,@auind_cap
			,@auind_codice_stato_estero
			,@auind_descr_stato_estero
           ,@auind_telefono1
           ,@auind_telefono2
           ,NULL
		   ,@auind_fax
           ,@auind_email
           ,@auind_pec
           ,NULL
           ,NULL
		   --AI 2050:
		   --,'AGRICOLI'
		   ,ISNULL(@auind_gestore_indirizzo, 'AGRICOLI') 
		   --AI 2050.
           ,NULL
           ,@auind_codice_qualita_ind
           ,NULL
           ,GETDATE()
           ,@appname
           ,NULL
		   --AI 2050:
		   ,@auind_aurea_codice_pk
		   --AI 2050.
		   )
END

