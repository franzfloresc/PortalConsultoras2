using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFechaFacturacion
    {
        public BEFechaFacturacion()
        {

        }
            public BEFechaFacturacion(IDataRecord row)
        {
            CampaniaPartida = row.ToString("CampaniaPartida");
            Facturacion = row.ToString("Facturacion");
            FechaLimitePago = row.ToString("FechaLimitePago");
            InicioFacturacion = row.ToString("InicioFacturacion");
            FinFacturacion = row.ToString("FinFacturacion");
            Codigo = row.ToString("Codigo");
            CampaniaId = row.ToInt32("CampaniaId");
            CantidadFechaFacturacion = row.ToInt32("CantidadFechaFacturacion");
        }


        [DataMember]
        [Column("CampaniaPartida")]
        public string CampaniaPartida { get; set; }

        [DataMember]
        [Column("Facturacion")]
        public string Facturacion { get; set; }

        [DataMember]
        [Column("FechaLimitePago")]
        public string FechaLimitePago { get; set; }

        [DataMember]
        [Column("InicioFacturacion")]
        public string InicioFacturacion { get; set; }

        [DataMember]
        [Column("FinFacturacion")]
        public string FinFacturacion { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }

        [DataMember]
        [Column("CampaniaId")]
        public int CampaniaId { get; set; }

        [DataMember]
        [Column("CantidadFechaFacturacion")]
        public int CantidadFechaFacturacion { get; set; }


        [DataMember]
        [Column("ListFechaFacturacionActual")]
        public List<BEFechaFacturacion> ListFechaFacturacionActual { get; set; }

        [DataMember]
        [Column("ListFechaFacturacionAnterior")]
        public List<BEFechaFacturacion> ListFechaFacturacionAnterior { get; set; }

        [DataMember]
        [Column("ListFechaFacturacionProxima")]
        public List<BEFechaFacturacion> ListFechaFacturacionProxima { get; set; }


    }
}
