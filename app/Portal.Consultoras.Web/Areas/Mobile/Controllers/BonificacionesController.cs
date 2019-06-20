using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BonificacionesController : BaseMobileController
    {
        public ActionResult Index()
        {
            bool isDigital = IndicadorConsultoraDigital();

            if (isDigital)
            {
                string NumeroDocumento = userData.DocumentoIdentidad;

                if (userData.CodigoISO == Constantes.CodigosISOPais.Peru)
                {
                    NumeroDocumento = userData.DocumentoIdentidad.Substring(NumeroDocumento.Length - 8);
                }

                BonificacionesModel model = new BonificacionesModel
                {
                    CodigoIso = userData.CodigoISO,
                    Codigoconsultora = userData.CodigoConsultora,
                    NumeroDocumento = NumeroDocumento
                };

                string secretKey = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);

                var token = JWT.JsonWebToken.Encode(model, secretKey, JWT.JwtHashAlgorithm.HS256);

                ViewBag.Token = token;

                return View("IndexExterno");
            }
            else
            {
                return View();
            }
        }

        public ActionResult IndexExterno()
        {
            try
            {
                string NumeroDocumento = userData.DocumentoIdentidad;

                if (userData.CodigoISO == Constantes.CodigosISOPais.Peru)
                {
                    NumeroDocumento = userData.DocumentoIdentidad.Substring(NumeroDocumento.Length - 8);
                }

                BonificacionesModel model = new BonificacionesModel
                {
                    CodigoIso = userData.CodigoISO,
                    Codigoconsultora = userData.CodigoConsultora,
                    NumeroDocumento = NumeroDocumento
                };

                string secretKey = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);

                var token = JWT.JsonWebToken.Encode(model, secretKey, JWT.JwtHashAlgorithm.HS256);

                ViewBag.Token = token;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View();

        }
    }

}