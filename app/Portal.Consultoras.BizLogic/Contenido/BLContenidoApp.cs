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
    public class BLContenidoApp : IContenidoAppResumenBusinessLogic
    {
        public void CheckContenidoApp(BEUsuario itmFilter, int idContenidoDetalle)
        {
            var daContenidoApp = new DAContenidoAppResumen(itmFilter.PaisID);
            daContenidoApp.CheckContenidoApp(itmFilter.CodigoConsultora, idContenidoDetalle);
        }

        public List<BEContenidoApp> GetContenidoApp(BEUsuario itmFilter, string codigoBanner)
        {
            var daContenidoApp = new DAContenidoAppResumen(itmFilter.PaisID);
            List<BEContenidoApp> listaContenido = null;
            List<BEContenidoAppDetalle> contenidoDetalle = null;

            using (IDataReader reader = daContenidoApp.GetBannerCodigo(codigoBanner,itmFilter))
            {
                listaContenido = reader.MapToCollection<BEContenidoApp>(closeReaderFinishing: false);
                reader.NextResult();
                contenidoDetalle = reader.MapToCollection<BEContenidoAppDetalle>(closeReaderFinishing: false);
            }

            if (listaContenido == null) listaContenido = new List<BEContenidoApp>();
            if (contenidoDetalle == null) contenidoDetalle = new List<BEContenidoAppDetalle>();

            listaContenido.ForEach(x =>
            {
                var lstDetalle = contenidoDetalle.Where(y => y.IdContenido == x.IdContenido).ToList();
                if (lstDetalle == null) lstDetalle = new List<BEContenidoAppDetalle>();
                x.DetalleContenido = lstDetalle;
                x.CantidadContenido = lstDetalle.Count;
            });



            var BannerBonifica = listaContenido.FirstOrDefault(x => x.Codigo == Constantes.CodigoContenido.Lanzamiento);

            if (BannerBonifica != null)
            {
                var secretKey = WebConfig.JsonWebTokenSecret;

                var data = new
                {
                    CodigoIso = itmFilter.CodigoISO,
                    Codigoconsultora = itmFilter.CodigoConsultora,
                    NumeroDocumento = itmFilter.NumeroDocumento.Length > 8 ? itmFilter.NumeroDocumento.Substring(2, 8) : itmFilter.NumeroDocumento
                };

                var token = JsonWebToken.Encode(data, secretKey, JwtHashAlgorithm.HS512);

                //Forma la URL de las imagenes
                BannerBonifica.DetalleContenido.ForEach(x =>
                {
                    x.RutaContenido = string.Concat(x.RutaContenido, token);
                });
            }

            //Forma la URL de las imagenes
            var restoContenido = listaContenido.Where(x => x.Codigo != Constantes.CodigoContenido.Lanzamiento).ToList();

            if (restoContenido != null)
            {
                restoContenido.ForEach(x =>
                {
                    x.DetalleContenido.ForEach(y =>
                    {
                        y.RutaContenido = string.Format(x.RutaImagen ?? y.RutaContenido, WebConfig.RutaCDN, itmFilter.CodigoISO, y.RutaContenido);
                    });
                    x.UrlMiniatura = string.IsNullOrEmpty(x.UrlMiniatura) ? string.Empty : string.Format(x.UrlMiniatura, WebConfig.RutaCDN, itmFilter.CodigoISO);
                });
            }

            return listaContenido;
        }
    }
}
