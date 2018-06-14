using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        protected ISessionManager sessionManager;
        protected ILogManager logManager;
        protected UsuarioModel userData;
        protected RevistaDigitalModel revistaDigital;
        protected ConfiguracionManagerProvider _configuracionManager;

        public BaseProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            logManager = LogManager.LogManager.Instance;
            userData = sessionManager.GetUserData();
            revistaDigital = sessionManager.GetRevistaDigital();
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public void GetLimitNumberPhone(int paisId, out int limiteMinimoTelef, out int limiteMaximoTelef)
        {
            switch (paisId)
            {
                case Constantes.PaisID.Mexico:
                    limiteMinimoTelef = 5;
                    limiteMaximoTelef = 15;
                    break;
                case Constantes.PaisID.Peru:
                    limiteMinimoTelef = 7;
                    limiteMaximoTelef = 9;
                    break;
                case Constantes.PaisID.Colombia:
                    limiteMinimoTelef = 10;
                    limiteMaximoTelef = 10;
                    break;
                case Constantes.PaisID.Guatemala:
                case Constantes.PaisID.ElSalvador:
                case Constantes.PaisID.Panama:
                case Constantes.PaisID.CostaRica:
                    limiteMinimoTelef = 8;
                    limiteMaximoTelef = 8;
                    break;
                case Constantes.PaisID.Ecuador:
                    limiteMinimoTelef = 9;
                    limiteMaximoTelef = 10;
                    break;
                default:
                    limiteMinimoTelef = 0;
                    limiteMaximoTelef = 15;
                    break;
            }
        }
        
        public string RemplazaTag(string cadena, string tag, string valor)
        {
            cadena = cadena ?? "";
            tag = tag ?? "";
            valor = valor ?? "";

            cadena = cadena.Replace(tag, valor);
            cadena = cadena.Replace(tag.ToLower(), valor);
            cadena = cadena.Replace(tag.ToUpper(), valor);

            return cadena;
        }
        
        public string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.KeyPaisFormatDecimal);
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        public string ObtenerRutaImagenResize(string rutaImagen, string rutaNombreExtension)
        {
            string ruta = "";

            if (string.IsNullOrEmpty(rutaImagen))
                return ruta;

            var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

            if (rutaImagen.ToLower().Contains(valorAppCatalogo))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                ruta = ConfigS3.GetUrlFileS3(carpetaPais, soloImagen + rutaNombreExtension + soloExtension);
            }
            else
            {
                ruta = Util.GenerarRutaImagenResize(rutaImagen, rutaNombreExtension);
            }

            return ruta;
        }
        
    }

}