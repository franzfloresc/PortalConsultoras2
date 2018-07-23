using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogActualizacionFacturacion
    {
        [DataMember]
        public string TipoRegistro { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigosZonaRegion { get; set; }
        [DataMember]
        public string CodigosZonaRegionIncompleto { get; set; }
        [DataMember]
        public string FechaFacturacion { get; set; }
        [DataMember]
        public string FechaFinFacturacion { get; set; }
        [DataMember]
        public string FechaRefacturacion { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string CampaniaCodigo { get; set; }

        public BELogActualizacionFacturacion(IDataRecord row)
        {
            TipoRegistro = row.ToString("TipoRegistro");
            CodigoUsuario = row.ToString("CodigoUsuario");
            Fecha = row.ToString("Fecha");
            CodigosZonaRegion = row.ToString("CodigosZonaRegion");
            CodigosZonaRegionIncompleto = row.ToString("CodigosZonaRegionIncompleto");
            FechaFacturacion = row.ToString("FechaFacturacion");
            FechaFinFacturacion = row.ToString("FechaFinFacturacion");
            FechaRefacturacion = row.ToString("FechaRefacturacion");
            Mensaje = row.ToString("Mensaje");
            CampaniaCodigo = row.ToString("CampaniaCodigo");
        }
    }
}
