using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaWeb
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }
        [DataMember]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public int StockInicial { get; set; }
        [DataMember]
        public int StockActual { get; set; }
        [DataMember]
        public string NombreImagen { get; set; }
        [DataMember]
        public string URL { get; set; }
        [DataMember]
        public int Prioridad { get; set; }
        [DataMember]
        public int CantidadPedido { get; set; }
        [DataMember]
        public string Cantidad { get; set; }

        public BEOfertaWeb()
        {

        }

        public BEOfertaWeb(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            PrecioCatalogo = row.ToDecimal("PrecioCatalogo");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            StockActual = row.ToInt32("StockActual");
            MarcaID = row.ToInt32("MarcaID");
            NombreImagen = row.ToString("NombreImagen");
            URL = row.ToString("URL");
            Prioridad = row.ToInt32("Prioridad");
            CantidadPedido = row.ToInt32("CantidadPedido");
        }

    }
}
