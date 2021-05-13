USE [CloudSmiths]
GO

/****** Object:  StoredProcedure [dbo].[UpdateCounter]    Script Date: 2021/05/13 20:28:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateCounter]
	@IDNumber varchar(13),
	@Counter int
AS
BEGIN
update IDNumber set Counter = @Counter
where IDNo = @IDNumber
END

GO


