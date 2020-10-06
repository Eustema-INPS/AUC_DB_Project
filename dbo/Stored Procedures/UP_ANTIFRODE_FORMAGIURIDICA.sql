

CREATE PROCEDURE [dbo].[UP_ANTIFRODE_FORMAGIURIDICA] 
	@forma_giuridica varchar(100)
AS
BEGIN
	SET NOCOUNT ON;
   
	SELECT [aungi_descr_lunga]
      
	FROM  [dbo].[tb_aungi_nat_giur_ct]
  
	 WHERE aungi_descr_lunga = @forma_giuridica
		and [aungi_iscr_ccia] = 1
END
