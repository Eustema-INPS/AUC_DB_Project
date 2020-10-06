




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/04/2018
-- Description:	   Modifica il record selezionato dalla tabella "tb_aufun_funz_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaRecAUFUN]

/*@CF varchar (16),*/

@Cod int,
@descr varchar(50),
@raggr varchar(200),
@abil varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_aufun_funz_sistema]
SET [aufun_raggruppamento] = rtrim(@raggr),
    [aufun_descr] = rtrim(@descr),
    [aufun_flag_abilitato] = rtrim(@abil),
    [aufun_data_modifica] = Getdate(),
    [aufun_descr_utente] = rtrim(@utente)
	    
WHERE [aufun_codice_pk] = @Cod


/*EXEC AZ_1_Sincronizza @CodAz,1,26,null;*/


END





