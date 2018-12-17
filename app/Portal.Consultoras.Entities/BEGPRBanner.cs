using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGPRBanner
    {
        [DataMember]
        public string BannerTitulo { get; set; }
        [DataMember]
        public string BannerMensaje { get; set; }
        [DataMember]
        public Enumeradores.RechazoBannerUrl BannerUrl { get; set; }
        [DataMember]
        public bool RechazadoXdeuda { get; set; }
        [DataMember]
        public bool MostrarBannerRechazo { get; set; }

        private string textovinculo = string.Empty;
        [DataMember]
        public string Textovinculo
        {
            get
            {
                if (BannerUrl == Enumeradores.RechazoBannerUrl.Deuda)
                    textovinculo = "MIRA LOS LUGARES DE PAGO";
                else if (BannerUrl == Enumeradores.RechazoBannerUrl.ModificaPedido)
                    textovinculo = "MODIFICA TU PEDIDO";

                return textovinculo;
            }
            set { textovinculo = value; }
        }
    }
}
