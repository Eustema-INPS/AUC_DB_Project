CREATE TABLE [dbo].[datafilenogrowht] (
    [name]              [sysname]      NOT NULL,
    [Size]              INT            NULL,
    [Used]              INT            NULL,
    [FreeSpace]         INT            NULL,
    [VolumeCapacityGB]  BIGINT         NULL,
    [VolumeFreeSpaceGB] BIGINT         NULL,
    [filename]          NVARCHAR (260) NOT NULL,
    [EmptyFile]         NVARCHAR (162) NOT NULL,
    [RemoveFile]        NVARCHAR (286) NULL
);

