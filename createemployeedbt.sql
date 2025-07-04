USE [exam]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 03.07.2025 23:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[position] [nvarchar](50) NOT NULL,
	[salary] [decimal](6, 0) NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Worker_position]    Script Date: 03.07.2025 23:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worker_position](
	[worker_id] [int] NOT NULL,
	[position_id] [int] NOT NULL,
 CONSTRAINT [PK_Worker_position] PRIMARY KEY CLUSTERED 
(
	[worker_id] ASC,
	[position_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Workers]    Script Date: 03.07.2025 23:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[patronymic] [varchar](50) NULL,
	[hire_date] [datetime] NOT NULL,
	[dismissal_date] [datetime] NULL,
 CONSTRAINT [PK_Workers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Worker_position]  WITH CHECK ADD  CONSTRAINT [FK_Worker_position_Position] FOREIGN KEY([position_id])
REFERENCES [dbo].[Position] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Worker_position] CHECK CONSTRAINT [FK_Worker_position_Position]
GO
ALTER TABLE [dbo].[Worker_position]  WITH CHECK ADD  CONSTRAINT [FK_Worker_position_Workers] FOREIGN KEY([worker_id])
REFERENCES [dbo].[Workers] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Worker_position] CHECK CONSTRAINT [FK_Worker_position_Workers]
GO
ALTER TABLE [dbo].[Position]  WITH CHECK ADD  CONSTRAINT [CK_Position] CHECK  (([salary]<=(100000)))
GO
ALTER TABLE [dbo].[Position] CHECK CONSTRAINT [CK_Position]
GO
