using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEOrdenFiltrosCaminoBrillante
    {
        [DataMember]
        [Column("DatosOrden")]
        public BEDatosOrden DatosOrden { get; set; }        
        [DataMember]
        [Column("DatosFiltro")]
        public BEDatosFiltros DatosFiltro { get; set; }
    }

    public class BEDatosOrden
    {
        [DataMember]
        [Column("CodigoOrden")]
        public string CodigoOrden { get; set; }
        [DataMember]
        [Column("DescripcionOrden")]
        public string DescripcionOrden { get; set; }
    }

    public class BEDatosFiltros
    {
        [DataMember]
        [Column("CodigoFiltro")]
        public string CodigoFiltro { get; set; }
        [DataMember]
        [Column("DescripcionFiltro")]
        public string DescripcionFiltro { get; set; }
    }
}
