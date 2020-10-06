


-- =====================================================================
-- Author:		Bellantoni e Picone
-- Create date: 15/11/2012
-- Description:	Inserimento Indirizzo AUIND per Posizioni Contributive
-- Author:			Peter
-- Modified date:	23 agosto 2013
-- Description:     modifiche per Action Item 2036
-- =====================================================================
CREATE PROCEDURE [dbo].[SP_UPDINDIRIZZO_AGR] 

	--AI 2036: aggiunta clausola "= null" per gestire il caso in cui la corrispondente colonna non cambia valore
        @auind_codice_toponimo varchar(3) = null
       ,@auind_toponimo varchar(50) = null
       ,@auind_indirizzo varchar(255) = null
       ,@auind_civico varchar(50) = null
       ,@auind_localita varchar(50) = null
       ,@auind_frazione varchar(100) = null
       ,@auind_descrizione_comune  varchar(50) = null
       ,@auind_sigla_provincia varchar(2) = null
       ,@auind_CAP varchar(10) = null
       ,@auind_telefono1 varchar(20) = null
       ,@auind_telefono2 varchar(20) = null
       ,@auind_email varchar(162) = null
       ,@auind_pec varchar(162) = null
       ,@auind_codice_qualita_ind varchar(1) = null
       ,@auind_tabella_codice_pk int
       ,@appname varchar(50)
		--AI 2050:
		,@auind_fax varchar(20) = NULL
		,@auind_codice_comune varchar(5) = NULL
		,@auind_codice_comune_istat varchar(6) = NULL
		,@auind_codice_stato_estero varchar(5) = NULL
		,@auind_descr_stato_estero varchar(50) = NULL
		,@auind_aurea_codice_pk int = NULL
		--AI 2050.
--Peter 2015.05.18: se fornito il nome tabella, la modifica deve essere limitata a quella tabella
		,@auind_tabella varchar(5) = NULL
        ,@auind_gestore_indirizzo varchar(10) = null 
--Peter 2015.05.18.
AS
BEGIN
SET NOCOUNT ON;


--2016.05.13:
if (@auind_telefono1 IS NULL OR ltrim(rtrim(@auind_telefono1)) = '') begin set @auind_telefono1 = '000000' end
if (@auind_telefono2 IS NULL OR ltrim(rtrim(@auind_telefono2)) = '') begin set @auind_telefono2 = '000000' end
if (@auind_fax IS NULL OR ltrim(rtrim(@auind_fax)) = '') begin set @auind_fax = '000000' end
--2016.05.13.


UPDATE [dbo].[tb_auind_indirizzi]
SET     
	   
	   --AI 2036: aggiunte condizioni ISNULL per gestire il caso di parametri non valorizzati
	   
        auind_codice_toponimo = ISNULL(@auind_codice_toponimo, auind_codice_toponimo)
       ,auind_toponimo = ISNULL(@auind_toponimo ,auind_toponimo)
       ,auind_indirizzo = ISNULL(@auind_indirizzo, auind_indirizzo)
       ,auind_civico = ISNULL(@auind_civico ,auind_civico)
       ,auind_localita = ISNULL(@auind_localita ,auind_localita)
       ,auind_frazione = ISNULL(@auind_frazione ,auind_frazione)
       ,auind_descr_comune = ISNULL(@auind_descrizione_comune ,auind_descr_comune)
       ,auind_sigla_provincia= ISNULL(@auind_sigla_provincia,auind_sigla_provincia)
       ,auind_CAP = ISNULL(@auind_CAP ,auind_CAP)
       ,auind_telefono1 = ISNULL(@auind_telefono1 ,auind_telefono1)
       ,auind_telefono2 = ISNULL(@auind_telefono2 ,auind_telefono2)
       ,auind_email = ISNULL(@auind_email ,auind_email)
       ,auind_pec = ISNULL(@auind_pec ,auind_pec)
       ,auind_codice_qualita_ind = ISNULL(@auind_codice_qualita_ind ,auind_codice_qualita_ind)
       ,auind_descr_utente = @appname 
       ,auind_data_modifica = GETDATE()

	   --AI 2050:
		,auind_fax = ISNULL(@auind_fax, auind_fax)
		,auind_codice_comune = ISNULL(@auind_codice_comune, auind_codice_comune)
		,auind_codice_comune_istat = ISNULL(@auind_codice_comune_istat, auind_codice_comune_istat)
		,auind_codice_stato_estero = ISNULL(@auind_codice_stato_estero, auind_codice_stato_estero)
		,auind_descr_stato_estero = ISNULL(@auind_descr_stato_estero, auind_descr_stato_estero)
		,auind_aurea_codice_pk = ISNULL(@auind_aurea_codice_pk, auind_aurea_codice_pk)

		--AI 2050.


WHERE auind_tabella_codice_pk=@auind_tabella_codice_pk
--Peter 2015.05.18: se fornito il nome tabella, la modifica deve essere limitata a quella tabella
AND auind_tabella = ISNULL(@auind_tabella, auind_tabella)
--Peter 2015.05.18.
       
END

