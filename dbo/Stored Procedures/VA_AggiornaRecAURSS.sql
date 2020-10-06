




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  20/10/2017
-- Description:	   Modifica il record selezionato dalla tabella "tb_aurss_rel_sog_sog"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaRecAURSS]

/*@CF varchar (16),*/

@CodAz int,
@dataInizioV varchar(10),
@dataFineV varchar(10),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_aurss_rel_sog_sog]
SET [aurss_data_inizio_validita] = Convert(DateTime,@dataInizioV + ' 00:00',103),
    [aurss_data_di_fine_validita] = Convert(DateTime,@dataFineV + ' 00:00',103),
	[aurss_data_modifica]= Getdate(),
    [aurss_descr_utente] = rtrim(@utente)
	    
    /*[ausca_descr_utente] =  rtrim(@utente),
    [ausca_data_modifica] = Getdate() */

WHERE [aurss_codice_pk]= @CodAz


/*EXEC AZ_1_Sincronizza @CodAz,1,26,null;*/


END



