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

            ViewBag.CodigoConsultora = UserData().CodigoConsultora;
            ViewBag.SaldoActual = GetSaldoActualConsultora();
            ViewBag.CodigoTerritorio = UserData().CodigoTerritorio;
            var lst = GetParametrosConfiguracion();
            ViewBag.CodigoConsultora = UserData().CodigoConsultora;
            ViewBag.Nombre = UserData().NombreConsultora;
            ViewBag.FURL = lst[0].chrValor.ToString();
            ViewBag.LOGN = lst[1].chrValor.ToString();
            ViewBag.METH = lst[2].chrValor.ToString();
            ViewBag.PTNR = lst[3].chrValor.ToString();
            ViewBag.PURL = lst[4].chrValor.ToString();
            ViewBag.RURL = lst[5].chrValor.ToString();
            ViewBag.TYPE = lst[6].chrValor.ToString();
            ViewBag.EMAIL = UserData().EMail.ToString();
            ViewBag.PaisID = UserData().PaisID;

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
            decimal Saldo = 0;
            try
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    Saldo = sv.GetSaldoActualConsultora(UserData().PaisID, UserData().CodigoConsultora);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return Saldo;
        }

        public List<ServiceContenido.BEPayPalConfiguracion> GetParametrosConfiguracion()
        {
            List<ServiceContenido.BEPayPalConfiguracion> lst = new List<ServiceContenido.BEPayPalConfiguracion>();
            try
            {
                using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                {
                    lst = sv.GetConfiguracionPayPal(UserData().PaisID).ToList();
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return lst;
        }

        public JsonResult InsertDatosPago(string NroTarjeta, decimal Monto)
        {
            bool rslt = false;
            try
            {
                using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                {
                    rslt = sv.ExistePagoPendiente(UserData().PaisID, Monto, NroTarjeta, DateTime.Now);
                }
                if (!rslt)
                {
                    using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        int rpta = sv.InsDatosPago(UserData().PaisID, UserData().CodigoConsultora, UserData().CodigoTerritorio, Monto, NroTarjeta, DateTime.Now, 1);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                int paisID = UserData().PaisID;
                List<BEPayPalConfiguracion> lst;
                using (ServiceContenido.ContenidoServiceClient srv = new ServiceContenido.ContenidoServiceClient())
                {
                    lst = srv.GetReporteAbonos(paisID, "0282", chrCodigoConsultora, intDia, intMes, intAnho, chrCodigoTransaccion).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                
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
                               id = a.chrRETCodigoTransaccion.ToString(),
                               cell = new string[]
                               {
                                   a.chrCodigoConsultora.ToString(),
                                   a.vchNombreCompleto.ToString(),
                                   a.datSYSFechaCreacion.ToString(),
                                   a.mnyMontoAbono.ToString("#0.00"),
                                   a.chrRETCodigoAutorizacionBancaria.ToString(),
                                   a.chrRETCodigoTransaccion.ToString()
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

            int Anho = DateTime.Now.Year;
            int fin = Anho + 14;

            for (var i = Anho; i <= fin; i++)
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

            ViewBag.NombrePais = UserData().NombrePais;
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
                string[] resultado = null;

                DateTime fecha = DateTime.Parse(fechaEjecucion);

                using (var ws = new ContenidoServiceClient())
                {
                    resultado = ws.DescargaPaypal(UserData().PaisID, UserData().CodigoUsuario, fecha);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoUsuario, UserData().CodigoISO);
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
