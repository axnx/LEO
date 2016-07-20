USE [testERP]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ELOEXPORT](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[filename] [varchar](50) NOT NULL,
	[mandant] [varchar](50) NOT NULL,
	[belegkat] [varchar](50) NOT NULL,
	[belegtyp] [varchar](50) NOT NULL,
	[belegParentFolder] [varchar](50) NULL,
	[belegnr] [varchar](50) NOT NULL,
	[belegdatum] [varchar](50) NOT NULL,
	[belegFirma] [varchar](50) NOT NULL,
	[belegjahr] [varchar](50) NULL,
	[belegmonat] [varchar](50) NULL,
	[importiert] [int] NULL,
	[importiertAm] [datetime] NULL,
 CONSTRAINT [PK__ELOEXPOR__3213E83F0BDC4DB4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MyImport]    Script Date: 20.07.2016 15:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MyImport](
	[wert] [varchar](50) NULL,
	[datum] [date] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ELOEXPORT] ON 

GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (1, N'RE1234_1.txt', N'ABC GmbH', N'Kunden', N'Rechnungen', N'RE1234', N'RE1234_1', N'15.07.2016', N'DEF GmbH', N'2016', N'07', 1, CAST(N'2016-07-20 14:49:59.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (2, N'RE1234_2.txt', N'ABC GmbH', N'Kunden', N'Rechnungen', N'RE1234', N'RE1234_2', N'15.07.2016', N'DEF GmbH', N'2016', N'07', 1, CAST(N'2016-07-20 14:49:59.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (3, N'RE1235_1.txt', N'ABC GmbH', N'Lieferanten', N'Lieferschein', N'RE1235', N'RE1235_1', N'15.07.2016', N'CasoFlex GmbH', N'2016', N'06', 1, CAST(N'2016-07-20 14:49:59.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (4, N'RE1236_1.txt', N'ABC GmbH', N'Kunden', N'Rechnungen', N'RE1236', N'RE1236_1', N'15.07.2016', N'DEF GmbH', N'2016', N'07', 1, CAST(N'2016-07-20 14:49:59.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (5, N'RE1237_1.txt', N'ABC GmbH', N'Lieferanten', N'Rechnungen', N'RE1237', N'RE1237_1', N'15.07.2016', N'Humboldt GmbH', N'2016', N'06', 1, CAST(N'2016-07-20 14:50:00.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (15, N'RE1238_1.txt', N'DEFGB GmbH', N'Kunden', N'Rechnungen', N'RE1238', N'RE1238_1', N'15.07.2016', N'Tech-Service GmbH', N'2016', N'07', 1, CAST(N'2016-07-20 14:50:00.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (16, N'RE1239_1.txt', N'DEFGB GmbH', N'Kunden', N'Rechnungen', N'RE1239', N'RE1239_1', N'15.07.2016', N'kn&n GmbH', N'2016', N'07', 1, CAST(N'2016-07-20 14:50:00.000' AS DateTime))
GO
INSERT [dbo].[ELOEXPORT] ([id], [filename], [mandant], [belegkat], [belegtyp], [belegParentFolder], [belegnr], [belegdatum], [belegFirma], [belegjahr], [belegmonat], [importiert], [importiertAm]) VALUES (19, N'LS1235_1.txt', N'ABC GmbH', N'Lieferanten', N'Lieferschein', N'LS1235', N'LS1235_1', N'15.07.2016', N'CasoFlex GmbH', N'2016', N'06', 1, CAST(N'2016-07-20 14:49:59.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ELOEXPORT] OFF


