using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Portal.Consultoras.ServiceOFAppCatalogo.Entities;

namespace Portal.Consultoras.ServiceOFAppCatalogo
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IProductoService" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IProductoService
    {
        [OperationContract]
        List<Producto> ObtenerProductos(int tipoOfertaFinal, string codigoIso, int campaniaId, string codigoConsultora,
            int zonaId, string codigoRegion, string codigoZona, int tipoProductoMostrar);
    }
}
