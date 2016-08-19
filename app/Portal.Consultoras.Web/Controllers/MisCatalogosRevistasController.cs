using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisCatalogosRevistasController : BaseController
    {
        public ActionResult Index()
        {
            var clienteModel = new ClienteModel();
            clienteModel.PaisID = userData.PaisID;
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = CalcularCampaniaAnterior(clienteModel.CampaniaActual);
            clienteModel.CampaniaSiguiente = CalcularCampaniaSiguiente(clienteModel.CampaniaActual);
            clienteModel.CodigoZona = userData.CodigoZona; //R20160204

            ViewBag.CodigoISO = userData.CodigoISO;
            if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Registrada ||
                userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Retirada)
                ViewBag.EsConsultoraNueva = true;
            else
                ViewBag.EsConsultoraNueva = false;
                
            return View(clienteModel);
        }

        public JsonResult Detalle(int campania)
        {
            string ISO = userData.CodigoISO;
            // RQ 2295 Mejoras en Catalogos Belcorp
            List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(userData.PaisID).ToList();
            }

            campania = campania <= 0 ? userData.CampaniaID : campania;
            string estadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel).FirstOrDefault(), campania);
            string estadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika).FirstOrDefault(), campania);
            string estadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone).FirstOrDefault(), campania);
            string estadoFinart = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Finart).FirstOrDefault(), campania);
            string catalogoUnificado = "0";

            if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(ISO))
            {
                string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                if (paises.Length > 0)
                {
                    foreach (var pais in paises)
                    {
                        if (pais.Contains(ISO))
                        {
                            string[] PaisCamp = pais.Split(',');
                            if (PaisCamp.Length > 0)
                            {
                                int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                                if (campania >= CampaniaInicio)
                                {
                                    estadoEsika = "1";
                                    catalogoUnificado = "1";
                                }
                            }
                        }
                    }
                }
            }

            var data = new
            {
                estadoLbel = estadoLbel,
                estadoEsika = estadoEsika,
                estadoCyzone = estadoCyzone,
                estadoFinart = estadoFinart,
                catalogoUnificado = catalogoUnificado
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        
        private string CalcularCampaniaAnterior(string CampaniaActual)
        {
            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == "01")
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) - 1).ToString() + userData.NroCampanias.ToString();
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(campAct) - 1).ToString().PadLeft(2, '0');
        }

        private string CalcularCampaniaSiguiente(string CampaniaActual)
        {
            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == userData.NroCampanias.ToString())
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) + 1).ToString() + "01";
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(campAct) + 1).ToString().PadLeft(2, '0');
        }

        private string CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            string resultado = catalogo.Estado.ToString();
            if (catalogo.Estado == 2)
            {
                resultado = "1";
                if ((campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin )
                    || (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 && campania >= catalogo.CampaniaInicio)
                    )
                {
                    resultado = "0";
                }
            }
            return resultado;
        }

    }
}
