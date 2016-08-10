using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            CUV = Convert.ToString(row["CUV"]);
            Descripcion = Convert.ToString(row["Descripcion"]);
            PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);
            PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            StockActual = Convert.ToInt32(row["StockActual"]);
            MarcaID = Convert.ToInt32(row["MarcaID"]);
            NombreImagen = Convert.ToString(row["NombreImagen"]);
            URL = Convert.ToString(row["URL"]);
            Prioridad = Convert.ToInt32(row["Prioridad"]);
            CantidadPedido = Convert.ToInt32(row["CantidadPedido"]);
        }

    }
}
