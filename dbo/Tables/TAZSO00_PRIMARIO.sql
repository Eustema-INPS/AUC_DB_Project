CREATE TABLE [dbo].[TAZSO00_PRIMARIO] (
    [posizione] VARCHAR (10) NULL,
    [sotipcen]  VARCHAR (1)  NULL,
    [sodatcen]  DATE         NULL,
    [SOTIPINT]  CHAR (1)     NULL,
    [SOUSERID]  CHAR (8)     NULL,
    [SOTDISP]   CHAR (6)     NULL,
    [SODATVAR]  DECIMAL (8)  NULL,
    [SOORAVAR]  DECIMAL (6)  NULL,
    [FLG_ELAB]  BIT          CONSTRAINT [DF_TAZSO00_PRIMARIO_FLG_ELAB] DEFAULT ((0)) NULL
);

