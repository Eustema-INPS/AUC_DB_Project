CREATE PROCEDURE  [dbo].[EX_StatoSoggettoContribuente]
	@cf varchar(16)	

AS

BEGIN
	SET NOCOUNT ON;

    if @cf is null
	   return -1 --il cf non è stato fornito

IF ( EXISTS
	 (Select ausca_codice_pk FROM  tb_ausca_sog_contr_az
	  where ausca_codice_fiscale = @cf) 
	 ) 
	 begin
		create table #temp (cf varchar(16), posizione varchar(50), area int, stato int) on [primary]
		insert into #temp(cf, posizione, area, stato)
		select  ausca_codice_fiscale as cf,
				aupoc_posizione as Posizione,
				aupoc_aurea_codice_pk as area,
				aupoc_auspc_codice_pk as stato
		from tb_ausca_sog_contr_az WITH (READUNCOMMITTED)
		inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
		where ausca_codice_fiscale = @cf and substring(aupoc_posizione,1,1) <> 'Z' and aupoc_aurea_codice_pk  in (1,2)
		IF ( EXISTS
			 (Select cf FROM  #temp
				where cf = @cf) 
			) 
		 begin
			IF ( EXISTS
				 (Select cf FROM  #temp
					where cf = @cf and stato IN (1,5)) 
				) 
			 begin
				return 1 -- il cf ha almeno una posizione attiva o riattivata
		
			 end
			 else
				return 2 --il cf non posizioni	attive o riattivate
		 end
		 else
			return -3 --il cf non posizioni		
	 end
	 else
		return -2 --il cf non esiste		
END
