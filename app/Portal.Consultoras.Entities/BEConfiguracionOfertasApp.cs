using Portal.Consultoras.Common;
using System.Runtime.Serialization;
using System.Data;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionOfertasApp
    {
        [DataMember]
        public string TipoOferta { get; set; }

        [DataMember]
        public string Titulo { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string BannerOferta { get; set; }

        [DataMember]
        public string ColorFondo { get; set; }

        [DataMember]
        public string ColorTexto { get; set; }

        [DataMember]
        public int CantidadMostrarCarrusel { get; set; }

        public BEConfiguracionOfertasApp(IDataRecord row)
        {
            TipoOferta = row.ToString("Codigo");
            Titulo = row.ToString("AppTitulo");
            Orden = row.ToInt32("AppOrden");
            BannerOferta = row.ToString("AppBannerInformativo");
            ColorFondo = row.ToString("AppColorFondo");
            ColorTexto = row.ToString("AppColorTexto");
            CantidadMostrarCarrusel = row.ToInt32("AppCantidadProductos");
        }
    }
}
