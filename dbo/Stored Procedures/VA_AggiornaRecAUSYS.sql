



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/04/2018
-- Description:	   Modifica il record selezionato dalla tabella "tb_ausys_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaRecAUSYS]

/*@CF varchar (16),*/

@Cod int,
@descrB varchar(50),
@descrL varchar(200),
@valore varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_ausys_sistema]
SET [ausys_descr_breve] = rtrim(@descrB),
    [ausys_descr_lunga] = rtrim(@descrL),
    [ausys_valore] = rtrim(@valore),
    [ausys_data_modifica]= Getdate(),
    [ausys_descr_utente] = rtrim(@utente)
	    

WHERE [ausys_codice_pk]= @Cod


/*EXEC AZ_1_Sincronizza @CodAz,1,26,null;*/


END




