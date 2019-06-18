USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[GetIncentivoPaisCampania]    Script Date: 17/6/2019 15:34:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetIncentivoPaisCampania]
  @PaisID int = 0,
  @CampaniaID int = 0
as
select i.IncentivoID, 
i.PaisID, 
p.Nombre,
i.CampaniaIDInicio, 
c1.NombreCorto As NombreCortoInicio,
i.CampaniaIDFin,
c2.NombreCorto As NombreCortoFin,
i.Titulo, 
i.Subtitulo,
i.ArchivoPortada, 
i.ArchivoPDF,
i.Url,
i.Zona,
i.Segmento
from Incentivo i
inner join pais p 
on i.paisid = p.paisid
inner join ods.campania c1
on i.CampaniaIDInicio = c1.Codigo
inner join ods.campania c2
on i.CampaniaIDFin = c2.Codigo
where (@PaisID = 0 or (i.PaisID = @PaisID))
and (@CampaniaID = 0 or (@CampaniaID >= i.CampaniaIDInicio AND @CampaniaID <= i.CampaniaIDFin))
--and i.ConsultoraID = @ConsultoraID
order by 3, 4, 5