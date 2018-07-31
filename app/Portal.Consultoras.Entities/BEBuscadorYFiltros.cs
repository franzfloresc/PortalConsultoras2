using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBuscadorYFiltros
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string SAP { get; set; }
        [DataMember]
        public string Imagen { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public double Valorizado { get; set; }
        [DataMember]
        public double Precio { get; set; }
        [DataMember]
        public string Catalogo { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoPalanca { get; set; }
        [DataMember]
        public int LimiteVenta { get; set; }

        public BEBuscadorYFiltros()
        { }

        public BEBuscadorYFiltros(IDataRecord row)
        {
            CUV = Convert.ToString(row["CUV"]);
            SAP = Convert.ToString(row["SAP"]);
            Imagen = Convert.ToString(row["FotoProducto"]);
            Descripcion = Convert.ToString(row["Descripcion"]);
            Valorizado = Convert.ToDouble(row["PrecioValorizado"]);
            Precio = Convert.ToDouble(row["PrecioCatalogo"]);
            Catalogo = Convert.ToString(row["CodigoCatalago"]);
            CodigoEstrategia = Convert.ToString(row["TipoEstrategiaCodigo"]);
            CodigoPalanca = Convert.ToString(row["CodigoEstrategia"]);
            LimiteVenta = Convert.ToInt32(row["limiteventa"]);
        }
    }
}
