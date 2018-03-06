﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic.Estrategia
{
    public interface IUpSellingBusinessLogic
    {
        IEnumerable<UpSelling> Obtener(string codigoCampana, bool incluirDetalle);
        UpSelling Actualizar(UpSelling upSelling, bool soloCabecera);
        UpSelling Insertar(UpSelling upSelling);
        int Eliminar(int upSellingId);
        IEnumerable<OfertaFinalMontoMeta> ObtenerOfertaFinalMontoMeta(int upSellingId);
    }
}