using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoWebPromocion
    {
        public BEPedidoWebPromocion()
        {

        }

        public BEPedidoWebPromocion(IDataRecord row)
        {
            CuvPromocion = row.ToString("CuvPromocion");
            CuvCondicion = row.ToString("CuvCondicion");
            CampaniaID = row.ToInt32("CampaniaID");
        }
        [DataMember]
        public string CuvPromocion { get; set; }
        [DataMember]
        public string CuvCondicion { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
    }

    public class Promocion
    {
        public int Cantidad { get; set; }
        public string CuvPromocion { get; set; }
        public List<String> Condiciones { get; set; }
    }

    public class Condicion
    {
        public int Cantidad { get; set; }
        public int CantidadAsignada { get; set; }
        public string CuvCondicion { get; set; }
        public bool EstaAsignada { get; set; }
        public List<String> Promociones { get; set; }
    }
}
