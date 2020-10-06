-- =======================================================
-- Author:		Letizia
-- Create date: 2013.07.17
-- Description:	verifica se esiste riga con posizione e anno mese specificato
-- =======================================================
CREATE PROCEDURE [dbo].[SP_FINDFORZALAVORO]
	@aufor_posizione varchar(50), 
    @aufor_annomese int
    
AS
BEGIN
   Select [tb_aufor_forze_lavoro].aufor_codice_pk
   from 
   [tb_aufor_forze_lavoro] 
   WHERE aufor_posizione = @aufor_posizione AND aufor_annomese = @aufor_annomese
END

