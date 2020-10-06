CREATE TYPE [dbo].[PeriodoContributivo] AS TABLE (
    [Data_inizio_validita] DATETIME     NULL,
    [Data_fine_validita]   DATETIME     NULL,
    [Data_scad_autor]      DATETIME     NULL,
    [Giorni_proroga]       SMALLINT     NULL,
    [Cod_stat_contr]       VARCHAR (5)  NULL,
    [Codici_autor]         VARCHAR (60) NULL,
    [Lavoratori_autonomi]  SMALLINT     NULL,
    [Data_inserimento]     VARCHAR (50) NULL,
    [Descr_utente]         VARCHAR (50) NULL,
    [Ateco_91]             VARCHAR (15) NULL,
    [Ateco_2007]           VARCHAR (15) NULL);

