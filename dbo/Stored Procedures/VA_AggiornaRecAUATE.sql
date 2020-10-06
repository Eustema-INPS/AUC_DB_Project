





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  14/05/2018
-- Description:	   Modifica il record selezionato dalla tabella "tb_auate_cod_ateco_ct"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaRecAUATE]

/*@CF varchar (16),*/

@Cod int,
@sez varchar(1),
@sezt varchar(200),
@div varchar(2),
@divt varchar(200),
@stct varchar(200),
@annor int,
@istatc varchar(15),
@utente varchar (50)




AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_auate_cod_ateco_ct]
SET [auate_cod_sezione] = rtrim(@sez),
    [auate_cod_sezione_tit]= rtrim(@sezt),
    [auate_cod_divisione]= rtrim(@div),
    [auate_cod_divisione_tit]= rtrim(@divt),
    [auate_cod_sottocategoria_tit]= rtrim(@stct),
    [auate_anno_riferimento]= rtrim(@annor),
    [auate_istat_code]= rtrim(@istatc),
    [auate_data_modifica] = Getdate(),
    [auate_descr_utente] = rtrim(@utente)
	    
WHERE [auate_codice_pk] = @Cod



/*EXEC AZ_1_Sincronizza @CodAz,1,26,null;*/


END






