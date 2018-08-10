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
        public string MarcaId { get; set; }
        public string TipoPersonalizacion { get; set; }
        public string CodigoEstrategia { get; set; }
        public int CodigoTipoEstrategia { get; set; }
        public string LimiteVenta { get; set; }
        public int Stock { get; set; }
     
    }
}