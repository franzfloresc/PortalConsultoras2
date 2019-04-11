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
        public int CheckContenidoApp(BEUsuario itmFilter, int idContenidoDetalle)
        {
            var daContenidoApp = new DAContenidoAppResumen(itmFilter.PaisID);
            return daContenidoApp.CheckContenidoApp(itmFilter.CodigoConsultora, idContenidoDetalle);
        }

        public List<BEContenidoApp> GetContenidoApp(BEUsuario itmFilter)
        {
            var daContenidoApp = new DAContenidoAppResumen(itmFilter.PaisID);
            var listaContenido = new List<BEContenidoApp>();
            var contenidoDetalle = new List<BEContenidoAppDetalle>();

            using (IDataReader reader = daContenidoApp.GetContenidoApp(itmFilter.CodigoConsultora))
            {
                listaContenido = reader.MapToCollection<BEContenidoApp>(closeReaderFinishing: false);
                reader.NextResult();
                contenidoDetalle = reader.MapToCollection<BEContenidoAppDetalle>(closeReaderFinishing: false);
            }

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
                var secretKey = WebConfig.GetByTagName("JsonWebTokenSecretKey") ?? string.Empty;

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
                        y.RutaContenido = string.Format(x.RutaImagen ?? string.Empty, WebConfig.GetByTagName("RutaCDN"), itmFilter.CodigoISO, y.RutaContenido);
                    });
                    x.UrlMiniatura = string.IsNullOrEmpty(x.UrlMiniatura) ? string.Empty : string.Format(x.UrlMiniatura, WebConfig.GetByTagName("RutaCDN"), itmFilter.CodigoISO);
                });
            }

            return listaContenido;
        }
    }
}
