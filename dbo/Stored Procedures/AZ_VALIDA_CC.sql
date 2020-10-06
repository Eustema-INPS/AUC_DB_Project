-- ======================================================================
-- Author:		Raffaele
-- Create date: Marzo 2012
-- Description:	
-- La Stored determina il valore del codice di controllo in funzione del valore assunto da un intero
-- e aggiorna il corrispondente record in funzione del parametro indicato dalla tabella fornita.
-- ======================================================================

CREATE PROCEDURE [dbo].[AZ_VALIDA_CC]
	@codiceAzienda int,
	@tipoTabella varchar(5)   -- se vale AUSCA aggiorna AUSCA, se vale AUPOC aggiorna AUPOC
AS
BEGIN
	SET NOCOUNT ON;	
	
	declare @stringa_appo varchar(10)
	declare @stringaLettere varchar(10) 
	
	declare @sommaCifrePari int
	declare @sommaCifreDispari int

	declare @sommaPrimaCifra int
	declare @sommaSecondaCifra int

	declare @PrimaCifra int
	declare @SecondaCifra int

	declare @PrimaLettera varchar(1)	
	declare @SecondaLettera varchar(1)	
	
	declare	@codiceControllo varchar(2)

--	set @stringaLettere = 'ABCDEFGHLM'
	set @stringaLettere = '0123456789'
	set @stringa_appo = '0000000000'

	set @stringa_appo = SUBSTRING (@stringa_appo,1,10-LEN(@codiceAzienda)) + convert(varchar, @codiceAzienda)

	set @sommaCifrePari = CONVERT(int,substring(@stringa_appo,9,1)) +
						  CONVERT(int,substring(@stringa_appo,7,1)) +
						  CONVERT(int,substring(@stringa_appo,5,1)) +
						  CONVERT(int,substring(@stringa_appo,3,1)) +
						  CONVERT(int,substring(@stringa_appo,1,1))
	
	set @sommaCifreDispari = CONVERT(int,substring(@stringa_appo,10,1)) +
						  CONVERT(int,substring(@stringa_appo,8,1)) +
						  CONVERT(int,substring(@stringa_appo,6,1)) +
						  CONVERT(int,substring(@stringa_appo,4,1)) +
						  CONVERT(int,substring(@stringa_appo,2,1))
	
    set @sommaPrimaCifra = @sommaCifrePari * 3 + @sommaCifreDispari * 2 + CONVERT(int,substring(@stringa_appo,10,1))
	set @sommaSecondaCifra = @sommaCifrePari * 2 + @sommaCifreDispari * 3 + CONVERT(int,substring(@stringa_appo,10,1))

    set @PrimaCifra = 10 - (@sommaPrimaCifra % 10)
    if (@PrimaCifra = 10) 
		set @PrimaCifra  = 0

	set @SecondaCifra = 10 - (@sommaSecondaCifra % 10)
	if (@SecondaCifra = 10) 
		set @SecondaCifra = 0

	set @PrimaCifra = @PrimaCifra + 1
	set @SecondaCifra = @SecondaCifra + 1
	
    set @PrimaLettera = SUBSTRING(@stringaLettere, @PrimaCifra, 1)
    set @SecondaLettera = SUBSTRING(@stringaLettere, @SecondaCifra, 1)
 
	if (@tipoTabella = 'AUSCA')
	begin
		set @CodiceControllo = @PrimaLettera + @SecondaLettera

		update tb_ausca_sog_contr_az
		set ausca_contro_codice = @CodiceControllo
		where ausca_codice_pk = @codiceAzienda
	end
    else
	begin
		if (@tipoTabella = 'AUPOC')
		begin
			set @CodiceControllo = @SecondaLettera + @PrimaLettera
			update tb_aupoc_pos_contr 
			set aupoc_contro_codice = @CodiceControllo
			where aupoc_codice_pk = @codiceAzienda
		end
	end
END
