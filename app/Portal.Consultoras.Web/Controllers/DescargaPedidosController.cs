using AutoMapper;

using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;

using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Controllers
{
    public class DescargaPedidosController : BaseController
    {
        [HttpGet]
        public async Task<ActionResult> DescargarPedidos()
        {
            var descargarPedidoModel = new DescargarPedidoModel();
            var usuario = UserData() ?? new UsuarioModel();

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "DescargaPedidos/DescargarPedidos"))
                    return RedirectToAction("Index", "Bienvenida");

                descargarPedidoModel.listaPaises = await DropDowListPaises(usuario.PaisID);
                descargarPedidoModel.PedidoFICActivo = usuario.PedidoFICActivo;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return View(descargarPedidoModel);
        }

        private async Task<IEnumerable<PaisModel>> DropDowListPaises(int paisID)
        {
            using (var sv = new ZonificacionServiceClient())
            {
                var lst = await sv.SelectPaisesAsync();
                return Mapper.Map<IEnumerable<PaisModel>>(lst.Where(x => x.PaisID == paisID));
            }
        }

        [HttpPost]
        public JsonResult RealizarDescarga(DescargarPedidoModel model)
        {
            string mensaje = string.Empty;
            try
            {
                if (model.FechaFacturacion.ToShortDateString() == "01/01/0001")
                    mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";
                if ((DateTime)SqlDateTime.MinValue > model.FechaFacturacion)
                    mensaje += "La Fecha de Facturación Miníma aceptada es " + SqlDateTime.MinValue + ". \n";
                if (mensaje != string.Empty) return ErrorJson(mensaje);

                if (model.TipoCronogramaID == 5)
                {
                    var fechaproceso = model.FechaFacturacion.ToString("yyyyMMdd");
                    using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                    {
                        sv.GetInformacionCursoLiderDescarga(UserData().PaisID, UserData().CodigoISO, fechaproceso, UserData().CodigoUsuario);
                    }
                    return SuccessJson("El proceso de generación de lideres ha finalizado satisfactoriamente.");
                }

                int tipoCronogramaId = model.TipoCronogramaID == 3 ? 2 : model.TipoCronogramaID;
                int marcarPedido = model.TipoCronogramaID == 2 ? 0 : 1;
                string descProceso = ((Enumeradores.TipoDescargaPedidos)model.TipoCronogramaID).ToString();

                string[] file;
                using (var pedidoService = new PedidoServiceClient())
                {
                    int contadorCarga = pedidoService.ValidarCargadePedidos(model.PaisID, tipoCronogramaId, marcarPedido, model.FechaFacturacion);
                    if(contadorCarga != 0) return ErrorJson("Existe una carga de pedidos en proceso para la fecha y tipo de cronograma seleccionado.");
                    
                    file = pedidoService.DescargaPedidosWeb(model.PaisID, model.FechaFacturacion, tipoCronogramaId, marcarPedido == 1, userData.NombreConsultora, descProceso);
                }
                if (file.Length != 3) return SuccessJson("El proceso de carga de pedidos ha finalizado satisfactoriamente.");

                return Json(new {
                    success = true,
                    message = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                    cabecera = System.IO.Path.GetFileName(file[0]),
                    detalle = System.IO.Path.GetFileName(file[1]),
                    detalleAct = System.IO.Path.GetFileName(file[2]),
                    rutac = file[0],
                    rutad = file[1],
                    rutae = file[2],
                    IsFox = true
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return ErrorJson(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult RealizarDescargaDDParcial(DescargarPedidoModel model)
        {
            string mensaje = string.Empty;
            try
            {
                if (model.FechaFacturacion.ToShortDateString() == "01/01/0001")
                    mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

                if ((DateTime)SqlDateTime.MinValue > model.FechaFacturacion)
                    mensaje += "La Fecha de Facturación Miníma aceptada es " + SqlDateTime.MinValue + ". \n";

                if (mensaje != string.Empty)
                {
                    return Json(new
                    {
                        success = false,
                        mensaje = mensaje
                    });
                }

                string[] file;

                using (var pedidoService = new PedidoServiceClient())
                {
                    int contadorCarga = pedidoService.ValidarCargadePedidos(model.PaisID, model.TipoCronogramaID, 0, model.FechaFacturacion);

                    if (contadorCarga == 0)
                    {
                        string usuario = UserData().NombreConsultora;
                        file = pedidoService.DescargaPedidosDD(model.PaisID, model.FechaFacturacion, model.TipoCronogramaID, false, usuario);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            mensaje = "Existe una carga de pedidos en proceso para la fecha y tipo de cronograma seleccionado."
                        });
                    }
                }

                if (file.Length != 2)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente."
                    });
                }

                return Json(new
                {
                    success = true,
                    mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                    cabecera = System.IO.Path.GetFileName(file[0]),
                    detalle = System.IO.Path.GetFileName(file[1]),
                    rutac = file[0],
                    rutad = file[1],
                    IsFox = true
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);

                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult RealizarDescargaFIC(DescargarPedidoModel model)
        {
            string mensaje = string.Empty;
            try
            {
                if (model.FechaFacturacion.ToShortDateString() == "01/01/0001")
                    mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

                if ((DateTime)SqlDateTime.MinValue > model.FechaFacturacion)
                    mensaje += "La Fecha de Facturación Miníma aceptada es " + SqlDateTime.MinValue + ". \n";

                if (mensaje != string.Empty)
                {
                    return Json(new
                    {
                        success = false,
                        mensaje = mensaje
                    });
                }

                string[] file;

                using (var pedidoService = new PedidoServiceClient())
                {
                    string usuario = UserData().NombreConsultora;
                    file = pedidoService.DescargaPedidosFIC(model.PaisID, model.FechaFacturacion, 4, usuario);

                }

                if (file.Length != 2)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente."
                    });
                }

                return Json(new
                {
                    success = true,
                    mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                    cabecera = System.IO.Path.GetFileName(file[0]),
                    detalle = System.IO.Path.GetFileName(file[1]),
                    rutac = file[0],
                    rutad = file[1],
                    IsFox = true
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult DescargarPedidosHeader(string header)
        {
            string path = @"D:\Files\Belcorp\Pedidos\";
            string httpPath = path + header;
            if (System.IO.File.Exists(httpPath))
            {
                HttpContext.Response.Clear();
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + header);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.TransmitFile(httpPath);
                HttpContext.Response.Flush();
                HttpContext.Response.End();
            }

            return View();
        }

        public ActionResult DescargarPedidosDetail(string detail)
        {
            string path = @"D:\Files\Belcorp\Pedidos\";
            string httpPath = path + detail;
            if (System.IO.File.Exists(httpPath))
            {
                HttpContext.Response.Clear();
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + detail);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.TransmitFile(httpPath);
                HttpContext.Response.Flush();
                HttpContext.Response.End();
            }

            return View();
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerUltimaDescargaPedido()
        {
            var usuario = UserData() ?? new UsuarioModel();

            try
            {
                var lst = new List<BEPedidoDescarga>();

                using (var srv = new PedidoServiceClient())
                {
                    var ultimaDescargaPedido = await srv.ObtenerUltimaDescargaPedidoAsync(usuario.PaisID);
                    lst.Add(ultimaDescargaPedido);
                }

                var data = new
                {
                    total = 1,
                    page = 1,
                    records = lst.Count,
                    rows = (from tbl in lst
                            select new
                            {
                                FechaHoraInicio = tbl.FechaHoraInicio.ToString(),
                                FechaHoraFin = tbl.FechaHoraFin.ToString(),
                                Estado = tbl.Estado,
                                Mensaje = tbl.Mensaje,
                                NumeroPedidos = string.Format(" Web: {0}<br> DD: {1}", tbl.NumeroPedidosWeb, tbl.NumeroPedidosDD),
                                TipoProceso = tbl.TipoProceso,
                                FechaFacturacion = tbl.FechaFacturacion.ToShortDateString(),
                                Desmarcado = (tbl.Desmarcado) ? "Pedido Desmarcado" : string.Empty,
                                NroLote = tbl.NroLote
                            })
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeshacerUltimaDescargaPedidos()
        {
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.DeshacerUltimaDescargaPedido(userData.PaisID);
            }

            return Json(new
            {
                success = true,
                mensaje = "Se desmarcó correctamente la última descarga."
            });
        }

        public ActionResult ObtenerUltimaDescargaExitosa()
        {
            BEPedidoDescarga ultimaDescarga;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                ultimaDescarga = sv.ObtenerUltimaDescargaExitosa(userData.PaisID);
            }

            return Json(new
            {
                success = true,
                descarga = new
                {
                    FechaEnvio = ultimaDescarga.FechaEnvio.ToString(),
                    FechaProceso = ultimaDescarga.FechaProceso.ToString()
                }
            });
        }

        [HttpPost]
        public async Task<JsonResult> DescargarArchivoCliente(int nroLote)
        {
            var usuario = UserData() ?? new UsuarioModel();

            try
            {
                using (var srv = new PedidoServiceClient())
                {
                    await srv.DescargaPedidosClienteAsync(usuario.PaisID, nroLote, usuario.CodigoUsuario);
                }

                var data = new
                {
                    success = true,
                    mensaje = "El proceso de carga de pedidos por cliente ha finalizado satisfactoriamente."
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);

                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
