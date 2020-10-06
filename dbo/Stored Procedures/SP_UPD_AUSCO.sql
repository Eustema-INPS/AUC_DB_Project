

-- =============================================
-- Author:		Peter
-- AI 2050
-- Create date: 2014-07-17
-- Description:	La stored effettua l’aggiornamento di un record su AUSCO.
-- Modificatore: Raffaele
-- Data modifica: 2018-06-28
-- Descrizione: La modifica si effettua solo se il record non è certificato da Infocamere
-- Data modifica: 2018-07-04
-- Descrizione: La modifica totale si effettua solo se il record non è certificato sia da Infocamere che da ARCA
--              La modifica parziale da tutti solo se i dati presenti sono null
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_AUSCO] 
	-- Add the parameters for the stored procedure here
	@ausco_codice_pk int = NULL,
	@ausco_denominazione varchar(405) = NULL,
	@ausco_tipo_persona varchar(1) = NULL,
	@ausco_codice_fiscale varchar(16),
	@ausco_cognome varchar(255) = NULL,
	@ausco_nome varchar(150) = NULL,
	@ausco_data_nascita datetime = NULL,
	@ausco_comune_nascita varchar(50) = NULL,
	@ausco_prov_nascita varchar(2) = NULL,
	@ausco_stato_estero_nascita varchar(4) = NULL,
	@ausco_cittadinanza varchar(4) = NULL,
	@ausco_sesso varchar(1) = NULL,
	@ausco_codice_toponimo varchar(3) = NULL,
	@ausco_toponimo varchar(100) = NULL,
	@ausco_indirizzo varchar(100) = NULL,
	@ausco_civico varchar(50) = NULL,
	@ausco_localita varchar(50) = NULL,
	@ausco_codice_comune varchar(4) = NULL,
	@ausco_codice_comune_istat varchar(6) = NULL,
	@ausco_frazione [varchar](100) = NULL,
	@ausco_provincia varchar(2) = NULL,
	@ausco_cap varchar(5) = NULL,
	@ausco_telefono varchar(20) = NULL,
	@ausco_telefono2 varchar(20) = NULL,
	@ausco_fax varchar(20) = NULL,
	@ausco_email varchar(162) = NULL,
	@ausco_pec varchar(162) = NULL,
	@ausco_codice_stato_estero varchar(4) = NULL,
    @ausco_codice_qualita_ind varchar(1) = NULL,
	@ausco_descr_utente [varchar](50) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--2016.05.13:
if (@ausco_telefono IS NULL OR ltrim(rtrim(@ausco_telefono)) = '') begin set @ausco_telefono = '000000' end
if (@ausco_telefono2 IS NULL OR ltrim(rtrim(@ausco_telefono2)) = '') begin set @ausco_telefono2 = '000000' end
if (@ausco_fax IS NULL OR ltrim(rtrim(@ausco_fax)) = '') begin set @ausco_fax = '000000' end
--2016.05.13.

	
UPDATE dbo.tb_ausco_sog_contr_col
SET
ausco_denominazione         =  ISNULL(@ausco_denominazione           ,    ausco_denominazione              ),
ausco_tipo_persona          =  ISNULL(@ausco_tipo_persona            ,    ausco_tipo_persona               ),
ausco_cognome               =  ISNULL(@ausco_cognome                 ,    ausco_cognome                    ),
ausco_nome                  =  ISNULL(@ausco_nome                    ,    ausco_nome                       ),
ausco_data_nascita          =  ISNULL(@ausco_data_nascita            ,    ausco_data_nascita               ),
ausco_comune_nascita        =  ISNULL(@ausco_comune_nascita          ,    ausco_comune_nascita             ),
ausco_prov_nascita          =  ISNULL(@ausco_prov_nascita            ,    ausco_prov_nascita               ),
ausco_stato_estero_nascita  =  ISNULL(@ausco_stato_estero_nascita    ,    ausco_stato_estero_nascita       ),
ausco_cittadinanza          =  ISNULL(@ausco_cittadinanza            ,    ausco_cittadinanza               ),
ausco_sesso                 =  ISNULL(@ausco_sesso                   ,    ausco_sesso                      ),
ausco_codice_toponimo       =  ISNULL(@ausco_codice_toponimo         ,    ausco_codice_toponimo            ),
ausco_toponimo              =  ISNULL(@ausco_toponimo                ,    ausco_toponimo                   ),
ausco_indirizzo             =  ISNULL(@ausco_indirizzo               ,    ausco_indirizzo                  ),
ausco_civico                =  ISNULL(@ausco_civico                  ,    ausco_civico                     ),
ausco_localita              =  ISNULL(@ausco_localita                ,    ausco_localita                   ),
ausco_codice_comune         =  ISNULL(@ausco_codice_comune           ,    ausco_codice_comune              ),
ausco_codice_comune_istat   =  ISNULL(@ausco_codice_comune_istat     ,    ausco_codice_comune_istat        ),
ausco_frazione              =  ISNULL(@ausco_frazione                ,    ausco_frazione                   ),
ausco_provincia             =  ISNULL(@ausco_provincia               ,    ausco_provincia                  ),
ausco_cap                   =  ISNULL(@ausco_cap                     ,    ausco_cap                        ),
ausco_telefono              =  ISNULL(@ausco_telefono                ,    ausco_telefono                   ),
ausco_telefono2             =  ISNULL(@ausco_telefono2               ,    ausco_telefono2                  ),
ausco_fax                   =  ISNULL(@ausco_fax                     ,    ausco_fax                        ),
ausco_email                 =  ISNULL(@ausco_email                   ,    ausco_email                      ),
ausco_pec                   =  ISNULL(@ausco_pec                     ,    ausco_pec                        ),
ausco_codice_stato_estero   =  ISNULL(@ausco_codice_stato_estero     ,    ausco_codice_stato_estero        ),
ausco_codice_qualita_ind    =  ISNULL(@ausco_codice_qualita_ind      ,    ausco_codice_qualita_ind         ),
ausco_descr_utente			=  ISNULL(@ausco_descr_utente            ,    ausco_descr_utente               ),
ausco_data_modifica = getdate()

WHERE 
(ausco_codice_pk             = @ausco_codice_pk OR
ausco_codice_fiscale        = @ausco_codice_fiscale) and
ausco_aurea_codice_pk <> 8 and ausco_aurea_codice_pk <> 9


UPDATE dbo.tb_ausco_sog_contr_col
SET
ausco_telefono              =  ISNULL(@ausco_telefono                ,    ausco_telefono                   ),
ausco_telefono2             =  ISNULL(@ausco_telefono2               ,    ausco_telefono2                  ),
ausco_email                 =  ISNULL(@ausco_email                   ,    ausco_email                      ),
ausco_pec                   =  ISNULL(@ausco_pec                     ,    ausco_pec                        ),
ausco_descr_utente			=  ISNULL(@ausco_descr_utente            ,    ausco_descr_utente               ),
ausco_data_modifica = getdate()

WHERE 
(ausco_codice_pk             = @ausco_codice_pk OR
ausco_codice_fiscale        = @ausco_codice_fiscale) 


--((ausco_cert_auten_cod_pk <> 2 and ausco_cert_cod_entita_rif <> 1) or 
--(ausco_cert_auten_cod_pk is null) or ausco_cert_cod_entita_rif is null)
           
;
	
END

