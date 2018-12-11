using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLDireccionEntrega : IDireccionEntregaBusinessLogic
    {
        public BEDireccionEntrega Editar(BEDireccionEntrega Direccion)
        {
            BEDireccionEntrega entity;
            using (var reader = new DADireccionEntega(Direccion.PaisID).Editar(Direccion))
            {
                entity = reader.MapToCollection<BEDireccionEntrega>().FirstOrDefault();
            };

            return entity;
        }

        public BEDireccionEntrega Insertar(BEDireccionEntrega Direccion)
        {
            BEDireccionEntrega entity;
            using (var reader = new DADireccionEntega(Direccion.PaisID).Insertar(Direccion))
            {
                entity = reader.MapToCollection<BEDireccionEntrega>().FirstOrDefault();
            };

            return entity;
        }
    }
}
