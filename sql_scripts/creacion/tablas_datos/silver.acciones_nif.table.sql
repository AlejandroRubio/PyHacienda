USE [RENTA_25]
GO

/****** Object:  Table [silver].[tipos_cambio]    Script Date: 17/05/2026 23:19:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [silver].[acciones_nif](
	[accion] [varchar](20) NOT NULL,
	[nif] [varchar](15) NOT NULL
 CONSTRAINT [pk_acciones_nif] PRIMARY KEY CLUSTERED 
(
	[accion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Acciona', 'A08001851');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Acciona Energía', 'A88268193');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Acerinox', 'A28250777');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('ACS', 'A28004885');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Aena', 'A86212420');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Amadeus IT Group', 'A84236934');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('ArcelorMittal', 'LU1598757687');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Atresmedia', 'A78839271');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Audax Renovables', 'A62338827');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('accion Sabadell', 'A08000143');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('accion Santander', 'A39000013');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Bankinter', 'A28157360');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('BBVA', 'A48265169');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('CaixaBank', 'A08663619');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Cellnex Telecom', 'A61263501');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('CIE Automotive', 'A48228359');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Colonial', 'A28027328');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Enagás', 'A80907397');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Endesa', 'A28023430');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('FCC', 'A28037224');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Ferrovial', 'A81939209');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Fluidra', 'A17728593');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Grifols', 'A58389123');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('IAG', 'ES0177542018');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Iberdrola', 'A48010615');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Inditex', 'A15075062');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Indra', 'A28599033');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Inmobiliaria del Sur', 'A41002205');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Lar España', 'A87093902');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Línea Directa', 'A80871031');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Logista', 'A79204351');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Mapfre', 'A28141935');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Merlin Properties', 'A86977790');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Meliá Hotels', 'A78304516');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Naturgy', 'A08015497');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('PharmaMar', 'A78367176');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Puig Brands', 'A08761094');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Redeia', 'A85309219');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Repsol', 'A78374725');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Renta Corporación', 'A62385729');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Sacyr', 'A28013811');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Solaria', 'A83511501');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Talgo', 'A85635030');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Telefónica', 'A28015865');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Tubacex', 'A01008548');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Tubos Reunidos', 'A48011584');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Unicaja accion', 'A93139053');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Viscofan', 'A31018344');
INSERT INTO [silver].[acciones_nif] ([accion],[nif]) VALUES ('Zardoya Otis', 'A28011153');

GO


