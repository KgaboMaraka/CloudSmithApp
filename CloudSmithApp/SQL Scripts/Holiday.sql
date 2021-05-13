USE [CloudSmiths]
GO

/****** Object:  Table [dbo].[Holiday]    Script Date: 2021/05/13 20:26:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Holiday](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDNo] [varchar](13) NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[Date] [date] NULL,
	[Type] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

