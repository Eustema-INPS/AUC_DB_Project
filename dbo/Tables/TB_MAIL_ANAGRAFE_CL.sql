CREATE TABLE [dbo].[TB_MAIL_ANAGRAFE_CL] (
    [COD_APPL_PK]  VARCHAR (4)   NOT NULL,
    [DESCR_APPL]   VARCHAR (100) NULL,
    [MAIL_ADDR]    VARCHAR (200) NULL,
    [COD_APPLPREC] VARCHAR (4)   NULL,
    [COD_APPL]     VARCHAR (4)   NOT NULL,
    [DATA_AGGIORN] DATETIME      NOT NULL,
    [COD_UTENTE]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_MAIL_ANAGRAFE_CL] PRIMARY KEY CLUSTERED ([COD_APPL_PK] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Codice dell''''applicazione', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'COD_APPL_PK';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Descrizione applicazione', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'DESCR_APPL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indirizzi email a cui inviare la segnalazione', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'MAIL_ADDR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Codice applicazione batch che deve essere eseguita prima dell''''applicazione in chiave', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'COD_APPLPREC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Codice applicazione che effettua l''aggiornamento', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'COD_APPL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data di aggiornamento', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'DATA_AGGIORN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Codice utente', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TB_MAIL_ANAGRAFE_CL', @level2type = N'COLUMN', @level2name = N'COD_UTENTE';

