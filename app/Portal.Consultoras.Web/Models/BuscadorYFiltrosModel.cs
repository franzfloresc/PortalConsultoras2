using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class BuscadorYFiltrosModel
    {
        public BuscadorYFiltrosModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
        public string CUV { get; set; }
        public string SAP { get; set; }
        public string Imagen { get; set; }
        public string Descripcion { get; set; }
        public double Valorizado { get; set; }
        public double Precio { get; set; }
        public string Catalogo { get; set; }
        public string CodigoEstrategia { get; set; }
        public string CodigoPalanca { get; set; }
        public int LimiteVenta { get; set; }
        public string DescripcionEstrategia { get; set; }
        public int MarcaId { get; set; }

        public string PrecioString { get; set; }
        public string ValorizadoString { get; set; }
        public int posicion { get; set; }
    }
}