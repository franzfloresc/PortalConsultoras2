using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Collections.Generic;
using Portal.Consultoras.Common;
using System.Data;
using System.Linq;
using System.Configuration;
using JWT;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public class BLContenidoAppResumen : IContenidoAppResumenBusinessLogic
    {
        public List<BEContenidoAppResumen> GetContenidoApp(BEUsuario itmFilter)
        {
            var listaContenido = new List<BEContenidoAppResumen>();
            var daContenidoApp = new DAContenidoAppResumen();

            using (IDataReader reader = daContenidoApp.GetContenidoAppResumen())
                while (reader.Read())
                {
                    var itmResumen = listaContenido.Where(x => x.Codigo == reader.ToString("Codigo")).FirstOrDefault();
                    var itmDetalle = new BEContenidoAppDeta(reader);

                    if (itmResumen != null)
                        itmResumen.DetalleContenido.Add(itmDetalle);
                    else
                    {
                        itmResumen = new BEContenidoAppResumen(reader);
                        itmResumen.DetalleContenido.Add(itmDetalle);
                        listaContenido.Add(itmResumen);
                    }
                    itmResumen.CantidadContenido = itmResumen.DetalleContenido.Count;
                }



            var BannerBonifica = listaContenido.Where(x => x.Codigo == "BONIFICACIONES_RESUMEN").FirstOrDefault();

            if (BannerBonifica != null)
            {
                var secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";

                var data = new
                {
                    CodigoIso = itmFilter.CodigoISO,
                    Codigoconsultora = itmFilter.CodigoConsultora,
                    NumeroDocumento = itmFilter.NumeroDocumento.Length > 8 ? itmFilter.NumeroDocumento.Substring(2, 8) : itmFilter.NumeroDocumento
                };

            var token = JsonWebToken.Encode(data, secretKey, JwtHashAlgorithm.HS512);

            BannerBonifica.DetalleContenido.ForEach(x =>
            {
                x.RutaContenido = x.RutaContenido + token;
            });
        }

            return listaContenido;
        }
}
}
