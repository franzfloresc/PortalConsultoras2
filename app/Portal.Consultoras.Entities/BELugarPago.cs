using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELugarPago
    {
        [DataMember]
        public int LugarPagoID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }

        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public string Nombre { set; get; }
        [DataMember]
        public string UrlSitio { set; get; }
        [DataMember]
        public string ArchivoLogo { set; get; }
        [DataMember]
        public string ArchivoLogoAnterior { set; get; }
        [DataMember]
        public string ArchivoInstructivo { set; get; }
        [DataMember]
        public string TextoPago { set; get; }
        [DataMember]
        public int Posicion { set; get; }

        public BELugarPago()
        { }

        public BELugarPago(IDataRecord row)
        {
            LugarPagoID = row.ToInt32("LugarPagoID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("PaisNombre");
            NombreCorto = row.ToString("NombreCorto");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Nombre = row.ToString("Nombre");
            UrlSitio = row.ToString("UrlSitio");
            ArchivoLogo = row.ToString("ArchivoLogo");
            ArchivoInstructivo = row.ToString("ArchivoInstructivo");
            TextoPago = row.ToString("TextoPago");
            Posicion = row.ToInt32("Posicion");
        }
    }
}
