using System;
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

        UpSellingRegalo ObtenerMontoMeta(int campaniaId, long consultoraId);
        int InsertarRegalo(UpSellingRegalo entidad);
        UpSellingRegalo ObtenerRegaloGanado(int campaniaId, long consultoraId);
        IEnumerable<UpSellingMontoMeta> ListarReporteMontoMeta(int upSellingId);
    }
}
