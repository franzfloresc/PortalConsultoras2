using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Collections.Generic;
using Portal.Consultoras.Common;
using System.Data;
using System.Linq;
using JWT;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public class BLContenidoApp : IContenidoAppResumenBusinessLogic
    {
        private readonly ITuVozOnlineBusinessLogic _tuVozOnlineBusinessLogic;

        public BLContenidoApp() : this(new BLTuVozOnline())
        {

        }

        public BLContenidoApp(ITuVozOnlineBusinessLogic tuVozOnlineBusinessLogic)
        {
            _tuVozOnlineBusinessLogic = tuVozOnlineBusinessLogic;
        }

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

            using (IDataReader reader = daContenidoApp.GetBannerCodigo(codigoBanner, itmFilter))
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

            //Forma la URL de las imagenes
            var restoContenido = listaContenido.Where(x => x.Codigo != Constantes.CodigoContenido.Lanzamiento && x.Codigo != Constantes.CodigoContenido.TuVozOnline).ToList();

            if (restoContenido.Any())
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

            //Personalizacion para URL de banner de lanzamiento
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

            //Personalizacion para URL de tu voz ONLINE
            var tuVozOnline = listaContenido.FirstOrDefault(x => x.Codigo == Constantes.CodigoContenido.TuVozOnline);

            if (tuVozOnline != null)
            {
                var blUsuario = new BLUsuario();
                var objUsuario = blUsuario.Select(itmFilter.PaisID, itmFilter.CodigoConsultora);
                itmFilter.EMailActivo = objUsuario.EMailActivo;
                itmFilter.DocumentoIdentidad = objUsuario.NumeroDocumento;
                itmFilter.Segmento = objUsuario.Segmento;
                itmFilter.EsConsultoraOficina = objUsuario.EsConsultoraOficina;
                itmFilter.AnoCampaniaIngreso = objUsuario.AnoCampaniaIngreso;
                itmFilter.FechaIngreso = objUsuario.FechaIngreso;

                var config = _tuVozOnlineBusinessLogic.GetPanelConfig(itmFilter.PaisID);
                tuVozOnline.DetalleContenido.ForEach(x => {
                    x.RutaContenido = _tuVozOnlineBusinessLogic.GetUrl(config, itmFilter);
                });
            }

            return listaContenido;
        }
    }
}
