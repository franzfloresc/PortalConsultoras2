using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Collections.Generic;
using Portal.Consultoras.Common;
using System.Data;
using System.Linq;
using System.Configuration;
using JWT;
using System;
using System.Net;
using Portal.Consultoras.Common.Cryptography;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public class BLContenidoApp : IContenidoAppResumenBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;

        public BLContenidoApp() : this(new BLTablaLogicaDatos())
        {

        }

        public BLContenidoApp(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
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
            var TuVozOnline = listaContenido.FirstOrDefault(x => x.Codigo == Constantes.CodigoContenido.TuVozOnline);

            if (TuVozOnline != null)
            {
                var config = GetPanelConfig(itmFilter.PaisID);
                TuVozOnline.DetalleContenido.ForEach(x => {
                    x.RutaContenido = GetUrl(x.RutaContenido, config.Value, config.Key, itmFilter);
                });
            }

            return listaContenido;
        }

        public KeyValuePair<string, string> GetPanelConfig(int paisId)
        {
            var datos = _tablaLogicaDatosBusinessLogic.GetListCache(paisId, ConsTablaLogica.TuVozOnline.Id);
            var dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelId);
            var panelId = dato != null ? dato.Valor : string.Empty;

            dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelKey);
            var panelKey = dato != null ? dato.Valor : string.Empty;

            return new KeyValuePair<string, string>(panelKey, panelId);
        }

        public string GetUrl(string baseUrl, string panelId, string panelKey, BEUsuario usuarioItem)
        {
            var currentTimeSeconds = Util.ToUnixTimespan(DateTime.Now);

            var parameters = string.Format(Constantes.DatosTuVozOnline.FormatUrl,
                currentTimeSeconds,
                usuarioItem.PrimerNombre,//user.PrimerNombre,
                usuarioItem.PrimerApellido, //user.PrimerApellido,
                usuarioItem.EMail,//user.EMail,
                DateTime.Now.Year,
                "Yes",
                usuarioItem.FechaNacimiento,//user.FechaNacimiento,
                usuarioItem.CodigoISO//user.CodigoISO
            );

            return string.Format(baseUrl,
                WebUtility.UrlEncode(DesAlgorithm.Encrypt(parameters, panelKey)),
                HmacShaAlgorithm.GetHash(parameters, panelKey),
                panelId
            );
        }

    }
}
