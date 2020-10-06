


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/10/2017
-- Description:		Modifica Indirizzo Soggetto Contribuente - Tabella "tb_ausca_sog_contr_az" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaIndirizzo]

/*@CF varchar (16),*/
@CodAz int,
@Reg  varchar (25),
@Prov varchar (2),
@CeI varchar (60),
@Loc varchar (50),
@Fraz varchar (100),
@Top varchar (50),
@cTop varchar (3),
@Ind varchar (255),
@Civ varchar (50),
@Cap varchar (10),
@Ist varchar (6),
@Bel varchar (4),
@utente varchar (50)


AS
BEGIN
	SET NOCOUNT ON;

DECLARE @codER int

UPDATE [dbo].[tb_ausca_sog_contr_az]
SET [ausca_regione] = rtrim(@Reg),
    [ausca_sigla_provincia] = rtrim(@Prov),

    [ausca_comune_esteso_ita] = rtrim(@CeI),
	[ausca_descr_comune] = rtrim(@CeI),
    [ausca_localita] = rtrim(@Loc),
    [ausca_frazione] = rtrim(@Fraz),
    [ausca_toponimo] = rtrim(@Top),
	[ausca_codice_toponimo] = rtrim(@cTop),
    [ausca_indirizzo] = rtrim(@Ind),
    [ausca_civico] = rtrim(@Civ),
    [ausca_cap] = rtrim(@Cap),
    [ausca_cod_com_ISTAT] = rtrim(@Ist),
    [ausca_cod_com_Belfiore] = rtrim(@Bel),
	[ausca_codice_comune] = rtrim(@Bel),
    [ausca_descr_utente] =  rtrim(@utente),
    [ausca_data_modifica] = Getdate() 
WHERE [ausca_codice_pk]= @CodAz


SET @codER = (SELECT auute_codice_pk from [tb_auute_ute_sistema]
WHERE auute_utenza = @utente)


EXEC AZ_1_Sincronizza @CodAz,1,@codER,null;



END

