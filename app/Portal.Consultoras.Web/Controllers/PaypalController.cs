using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PaypalController : BaseController
    {
        public ActionResult Index()
        {

            ViewBag.CodigoConsultora = userData.CodigoConsultora;
            ViewBag.SaldoActual = GetSaldoActualConsultora();
            ViewBag.CodigoTerritorio = userData.CodigoTerritorio;
            var lst = GetParametrosConfiguracion();
            ViewBag.CodigoConsultora = userData.CodigoConsultora;
            ViewBag.Nombre = userData.NombreConsultora;
            ViewBag.FURL = lst[0].chrValor;
            ViewBag.LOGN = lst[1].chrValor;
            ViewBag.METH = lst[2].chrValor;
            ViewBag.PTNR = lst[3].chrValor;
            ViewBag.PURL = lst[4].chrValor;
            ViewBag.RURL = lst[5].chrValor;
            ViewBag.TYPE = lst[6].chrValor;
            ViewBag.EMAIL = userData.EMail;
            ViewBag.PaisID = userData.PaisID;

            return View();
        }

        public ActionResult TransaccionSuccess()
        {
            return View();
        }

        public ActionResult ReporteAbonos()
        {
            return View();
        }

        public ActionResult TransaccionError()
        {
            return View();
        }

        public decimal GetSaldoActualConsultora()
        {
            decimal saldo = 0;
            try
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    saldo = sv.GetSaldoActualConsultora(userData.PaisID, userData.CodigoConsultora);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return saldo;
        }

        public List<ServiceContenido.BEPayPalConfiguracion> GetParametrosConfiguracion()
        {
            List<ServiceContenido.BEPayPalConfiguracion> lst = new List<ServiceContenido.BEPayPalConfiguracion>();
            try
            {
                using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                {
                    lst = sv.GetConfiguracionPayPal(userData.PaisID).ToList();
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return lst;
        }

        public JsonResult InsertDatosPago(string NroTarjeta, decimal Monto)
        {
            try
            {
                bool rslt;
                using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                {
                    rslt = sv.ExistePagoPendiente(userData.PaisID, Monto, NroTarjeta, DateTime.Now);
                }
                if (!rslt)
                {
                    using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        sv.InsDatosPago(userData.PaisID, userData.CodigoConsultora, userData.CodigoTerritorio, Monto, NroTarjeta, DateTime.Now, 1);
                        return Json(new
                        {
                            success = true,
                            message = "Exito"
                        });
                    }
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "Pendiente"
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente"
                });
            }
        }

        public ActionResult ConsultarAbonos(string sidx, string sord, int page, int rows, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrCodigoTransaccion)
        {
            if (ModelState.IsValid)
            {
                int paisId = userData.PaisID;
                List<BEPayPalConfiguracion> lst;
                using (ServiceContenido.ContenidoServiceClient srv = new ServiceContenido.ContenidoServiceClient())
                {
                    lst = srv.GetReporteAbonos(paisId, "0282", chrCodigoConsultora, intDia, intMes, intAnho, chrCodigoTransaccion).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEPayPalConfiguracion> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.chrCodigoConsultora);
                            break;
                        case "NombreConsultora":
                            items = lst.OrderBy(x => x.vchNombreCompleto);
                            break;
                        case "FechaAbono":
                            items = lst.OrderBy(x => x.datSYSFechaCreacion);
                            break;
                        case "MontoAbono":
                            items = lst.OrderBy(x => x.mnyMontoAbono);
                            break;
                        case "CodigoAutorizacionBancaria":
                            items = lst.OrderBy(x => x.chrRETCodigoAutorizacionBancaria);
                            break;
                        case "CodigoTransaccion":
                            items = lst.OrderBy(x => x.chrRETCodigoTransaccion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.chrCodigoConsultora);
                            break;
                        case "NombreConsultora":
                            items = lst.OrderByDescending(x => x.vchNombreCompleto);
                            break;
                        case "FechaAbono":
                            items = lst.OrderByDescending(x => x.datSYSFechaCreacion);
                            break;
                        case "MontoAbono":
                            items = lst.OrderByDescending(x => x.mnyMontoAbono);
                            break;
                        case "CodigoAutorizacionBancaria":
                            items = lst.OrderByDescending(x => x.chrRETCodigoAutorizacionBancaria);
                            break;
                        case "CodigoTransaccion":
                            items = lst.OrderByDescending(x => x.chrRETCodigoTransaccion);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.chrRETCodigoTransaccion,
                               cell = new string[]
                               {
                                   a.chrCodigoConsultora,
                                   a.vchNombreCompleto,
                                   a.datSYSFechaCreacion.ToString(),
                                   a.mnyMontoAbono.ToString("#0.00"),
                                   a.chrRETCodigoAutorizacionBancaria,
                                   a.chrRETCodigoTransaccion
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ObtenerAnios(int paisID)
        {
            List<string> lst = new List<string>();

            int anho = DateTime.Now.Year;
            int fin = anho + 14;

            for (var i = anho; i <= fin; i++)
            {
                lst.Add((i).ToString());
            }

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ProcesoDescarga()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Paypal/ProcesoDescarga"))
                return RedirectToAction("Index", "Bienvenida");

            ViewBag.NombrePais = userData.NombrePais;
            return View();
        }

        [HttpPost]
        public JsonResult RealizarDescarga(string fechaEjecucion)
        {
            if (string.IsNullOrEmpty(fechaEjecucion))
            {
                return Json(new
                {
                    success = false,
                    mensaje = "Fecha de Ejecucion Vacia o nula",
                }, JsonRequestBehavior.AllowGet);
            }
            try
            {
                string[] resultado;

                DateTime fecha = DateTime.Parse(fechaEjecucion);

                using (var ws = new ContenidoServiceClient())
                {
                    resultado = ws.DescargaPaypal(userData.PaisID, userData.CodigoUsuario, fecha);
                }

                if (!string.IsNullOrEmpty(resultado[0]))
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de Paypal ha finalizado satisfactoriamente.",
                        rutaPaypal = resultado[0],
                        linkPaypal = resultado[1]
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = false,
                    mensaje = "El proceso de carga de Paypal no ha generado archivos."
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = "Ocurrio un Error inesperado.",
                    exception = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
