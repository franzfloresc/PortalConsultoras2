using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogParametroDiasCargaPedido
    {
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigosRegionZona { get; set; }
        [DataMember]
        public Int16 DiasParametroCargaAnterior { get; set; }
        [DataMember]
        public Int16 DiasParametroCargaActual { get; set; }

        public BELogParametroDiasCargaPedido(IDataRecord row)
        {
            Fecha = row.ToString("Fecha");
            CodigoUsuario = row.ToString("CodigoUsuario");
            CodigosRegionZona = row.ToString("CodigosRegionZona");
            DiasParametroCargaAnterior = row.ToInt16("DiasParametroCargaAnterior");
            DiasParametroCargaActual = row.ToInt16("DiasParametroCargaActual");
        }
    }
}
