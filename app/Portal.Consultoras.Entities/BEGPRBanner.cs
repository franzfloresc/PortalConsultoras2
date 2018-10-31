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
        [DataMember]
        public string Textovinculo
        {
            get
            {
                string _Textovinculo = string.Empty;

                if (BannerUrl == Enumeradores.RechazoBannerUrl.Deuda)
                    _Textovinculo = "MIRA LOS LUGARES DE PAGO";
                else if (BannerUrl == Enumeradores.RechazoBannerUrl.ModificaPedido)
                    _Textovinculo = "MODIFICA TU PEDIDO";

                return _Textovinculo;
            }
            set { }
        }
    }
}
