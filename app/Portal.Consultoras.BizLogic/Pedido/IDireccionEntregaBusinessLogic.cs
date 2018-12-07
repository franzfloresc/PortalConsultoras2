using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IDireccionEntregaBusinessLogic
    {
        BEDireccionEntrega Insertar (BEDireccionEntrega Direccion);
        BEDireccionEntrega Editar   (BEDireccionEntrega Direccion);
    }
}
