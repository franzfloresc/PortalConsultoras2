using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.CertificadoComercial;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CertificadoComercialController : BaseController
    {
        public ActionResult Index()
        {
            var listaCertificados = new List<CertificadoComercialModel>();

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CertificadoComercial/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var certificadoNoAdeudo = ObtenerCertificadoNoAdeudo();
                listaCertificados.Add(certificadoNoAdeudo);

                var certificadoComercial = ObtenerCertificadoComercial();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(listaCertificados);
        }

        #region Certificado Paz y Salvo / No Adeudo
        private CertificadoComercialModel ObtenerCertificadoNoAdeudo()
        {          
            var certificado = new CertificadoComercialModel();

            var certificadoComercialId = 0;
            var nombre = "";
            var mensajeError = "";

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un Paz y Salvo";
                        break;
                    }

                    certificadoComercialId = 1;
                    nombre = "Paz y Salvo";


                    break;
                case Constantes.PaisID.Ecuador:
                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un No Adeudo";
                        break;
                    }

                    certificadoComercialId = 1;
                    nombre = "No Adeudo";
                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoComercialId = certificadoComercialId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;

            return certificado;            
        }

        #endregion

        #region Certificado Comercial

        private CertificadoComercialModel ObtenerCertificadoComercial()
        {
            var certificado = new CertificadoComercialModel();

            var certificadoComercialId = 0;
            var nombre = "";
            var mensajeError = "";

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                case Constantes.PaisID.Ecuador:
                    certificadoComercialId = 1;
                    nombre = "Certificación Comercial";


                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoComercialId = certificadoComercialId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;

            return certificado;
        }

        #endregion
    }
}