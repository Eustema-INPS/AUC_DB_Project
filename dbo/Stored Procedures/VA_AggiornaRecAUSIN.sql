





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  15/05/2018
-- Description:	   Modifica il record selezionato dalla tabella "tb_aufun_funz_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaRecAUSIN]

/*@CF varchar (16),*/

@Cod int,
@descs varchar(30),
@codr varchar(2),
@descreg varchar(100),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_ausin_sedi_inps_ct]
SET [ausin_descr] = rtrim(@descs),
    [ausin_codice_regione] = rtrim(@codr),
	[ausin_descrizione_regione] = rtrim(@descreg),
    [ausin_data_modifica] = Getdate(),
    [ausin_descr_utente] = rtrim(@utente)
	    
WHERE [ausin_codice_pk] = @Cod


/*EXEC AZ_1_Sincronizza @CodAz,1,26,null;*/


END






