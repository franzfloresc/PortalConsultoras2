using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        //protected ISessionManager sessionManager;
        //protected ILogManager logManager;
        //protected UsuarioModel userData;
        //protected RevistaDigitalModel revistaDigital;
        protected ConfiguracionManagerProvider _configuracionManager;

        public BaseProvider()
        {
            //sessionManager = SessionManager.SessionManager.Instance;
            //logManager = LogManager.LogManager.Instance;
            //userData = sessionManager.GetUserData();
            //revistaDigital = sessionManager.GetRevistaDigital();
            _configuracionManager = new ConfiguracionManagerProvider();
        }
        
        public string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.KeyPaisFormatDecimal);
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        public string ObtenerRutaImagenResize(string rutaImagen, string rutaNombreExtension, string codigoIso)
        {
            string ruta = "";

            if (string.IsNullOrEmpty(rutaImagen))
                return ruta;

            var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

            if (rutaImagen.ToLower().Contains(valorAppCatalogo))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

                ruta = ConfigS3.GetUrlFileS3(carpetaPais, soloImagen + rutaNombreExtension + soloExtension);
            }
            else
            {
                ruta = Util.GenerarRutaImagenResize(rutaImagen, rutaNombreExtension);
            }

            return ruta;
        }

        #region Zonificacion
        public IEnumerable<RegionModel> DropDownListRegiones(int paisId)
        {
            IList<BERegion> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllRegiones(paisId);
            }
            return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        }

        public IEnumerable<ZonaModel> DropDownListZonas(int paisId)
        {
            IList<BEZona> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllZonas(paisId);
            }
            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        }
        #endregion
    }

}