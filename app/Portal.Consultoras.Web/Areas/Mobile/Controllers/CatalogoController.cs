using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using Common.Logging.Configuration;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            var catalogoModel = new CatalogoMobileModel();
            var campaniaActual = userData.CampaniaID.ToString();

            catalogoModel.CampaniaActual = campaniaActual;
            catalogoModel.CampaniaAnterior = CalcularCampaniaAnterior(campaniaActual);
            catalogoModel.CampaniaSiguiente = CalcularCampaniaSiguiente(campaniaActual);

            List<BECliente> lst;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            catalogoModel.ListaCliente = lst;
            catalogoModel.Campania = campaniaActual;

            catalogoModel.PaisID = UserData().PaisID; //R20160204
            catalogoModel.CodigoZona = UserData().CodigoZona; //R20160204

            return View(catalogoModel);
        }

        public JsonResult Detalle(int campaniaId)
        {
            var catalogoModel = new CatalogoMobileModel();
            try
            {
                var userData = UserData();
                int campania = campaniaId;
                string iso = userData.CodigoISO;
                string nombrePais = ObtenerNombrePais(userData.CodigoISO);
                string campaniaAnio = "c" + campaniaId.ToString().Substring(4, 2) + "." + campaniaId.ToString().Substring(0, 4);

                List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(userData.PaisID).ToList();
                    catalogoModel.EstadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel), campania);
                    catalogoModel.EstadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika), campania);
                    catalogoModel.EstadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone), campania);
                }
                if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(iso))
                {
                    string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                    foreach (var pais in paises)
                    {
                        if (pais.Contains(iso))
                        {
                            string[] PaisCamp = pais.Split(',');
                            if (PaisCamp.Length > 0)
                            {
                                int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                                if (Convert.ToInt32(UserData().CampaniaID) >= CampaniaInicio) catalogoModel.EstadoEsika = "1";
                            }
                        }
                    }
                }

                catalogoModel.LinkLbel = "lbel." + nombrePais + "." + campaniaAnio;
                catalogoModel.LinkEsika = "esika." + nombrePais + "." + campaniaAnio;
                catalogoModel.LinkCyzone = "cyzone." + nombrePais + "." + campaniaAnio;
                catalogoModel.Campania = campaniaId.ToString();

                return Json(new
                {
                    success = true,
                    message = "ok",
                    data = catalogoModel
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = catalogoModel
                });
            }
        }

        public PartialViewResult DetalleEnvioCorreo(int campaniaId)
        {
            var catalogoModel = new CatalogoMobileModel();
            var userData = UserData();

            #region Obtener Clientes de la Consultora

            List<BECliente> lst;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            catalogoModel.ListaCliente = lst;
            catalogoModel.Campania = campaniaId.ToString();

            #endregion

            #region Validar que catalogos se muestran

            List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(userData.PaisID).ToList();
            }

            int campania = userData.CampaniaID;
            string iso = userData.CodigoISO;

            string estadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel), campania);
            string estadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika), campania);
            string estadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone), campania);
            string catalogoUnificado = "0";

            if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(iso))
            {
                string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                if (paises.Length > 0)
                {
                    foreach (var pais in paises)
                    {
                        if (pais.Contains(iso))
                        {
                            string[] PaisCamp = pais.Split(',');
                            if (PaisCamp.Length > 0)
                            {
                                int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                                if (Convert.ToInt32(UserData().CampaniaID) >= CampaniaInicio)
                                {
                                    estadoEsika = "1";
                                    catalogoUnificado = "1";
                                }
                            }
                        }
                    }
                }
            }

            catalogoModel.EstadoLbel = estadoLbel;
            catalogoModel.EstadoEsika = estadoEsika;
            catalogoModel.EstadoCyzone = estadoCyzone;
            catalogoModel.CatalogoUnificado = catalogoUnificado;

            #endregion

            return PartialView("DetalleEnvioCorreo", catalogoModel);
        }

        private string ObtenerNombrePais(string paisIso)
        {
            string resultado = string.Empty;

            switch (paisIso)
            {
                case Constantes.CodigosISOPais.Argentina:
                    resultado = "argentina";
                    break;
                case Constantes.CodigosISOPais.Bolivia:
                    resultado = "bolivia";
                    break;
                case Constantes.CodigosISOPais.Chile:
                    resultado = "chile";
                    break;
                case Constantes.CodigosISOPais.Colombia:
                    resultado = "colombia";
                    break;
                case Constantes.CodigosISOPais.CostaRica:
                    resultado = "costarica";
                    break;
                case Constantes.CodigosISOPais.Dominicana:
                    resultado = "republicadominicana";
                    break;
                case Constantes.CodigosISOPais.Ecuador:
                    resultado = "ecuador";
                    break;
                case Constantes.CodigosISOPais.Salvador:
                    resultado = "elsalvador";
                    break;
                case Constantes.CodigosISOPais.Guatemala:
                    resultado = "guatemala";
                    break;
                case Constantes.CodigosISOPais.Mexico:
                    resultado = "mexico";
                    break;
                case Constantes.CodigosISOPais.Panama:
                    resultado = "panama";
                    break;
                case Constantes.CodigosISOPais.Peru:
                    resultado = "peru";
                    break;
                case Constantes.CodigosISOPais.PuertoRico:
                    resultado = "puertorico";
                    break;
                case Constantes.CodigosISOPais.Venezuela:
                    resultado = "venezuela";
                    break;
                default:
                    resultado = "sinpais";
                    break;
            }

            return resultado;
        }

        private string CalcularCampaniaAnterior(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == "01")
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) - 1) + UserData().NroCampanias.ToString();
            return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) - 1).ToString().PadLeft(2, '0');
        }

        private string CalcularCampaniaSiguiente(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == UserData().NroCampanias.ToString())
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) + 1) + "01";
            return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) + 1).ToString().PadLeft(2, '0');
        }

        private string CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            string resultado = null;
            if (catalogo.Estado == 2)
            {
                if (campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin)
                {
                    resultado = "0";
                }
                else if (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 && campania >= catalogo.CampaniaInicio)
                {
                    resultado = "0";
                }
                else
                {
                    resultado = "1";
                }
            }
            else
            {
                resultado = catalogo.Estado.ToString();
            }

            return resultado;

        }
    }
}
