﻿using AutoMapper;
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

namespace Portal.Consultoras.Web.Controllers
{
    public class DescargaPedidosController : BaseController
    {
        public ActionResult DescargarPedidos()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "DescargaPedidos/DescargarPedidos"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var descargarPedidoModel = new DescargarPedidoModel()
            {
                listaPaises = DropDowListPaises(),
                PedidoFICActivo = userData.PedidoFICActivo
            };
            return View(descargarPedidoModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList().FindAll(x => x.PaisID == UserData().PaisID);
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
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

                if (mensaje != string.Empty)
                {
                    return Json(new
                    {
                        success = false,
                        mensaje = mensaje
                    });
                }

                string fechaproceso;
                if (model.TipoCronogramaID == 5)
                {
                    using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                    {
                        string anio;
                        string mes;
                        string dia;
                        anio = model.FechaFacturacion.Year.ToString();
                        mes = model.FechaFacturacion.Month.ToString();
                        if (mes.Length == 1)
                        {
                            mes = "0" + mes;
                        }
                        dia = model.FechaFacturacion.Day.ToString();
                        if (dia.Length == 1)
                        {
                            dia = "0" + dia;
                        }

                        fechaproceso = anio + mes + dia;
                        sv.GetInformacionCursoLiderDescarga(UserData().PaisID, UserData().CodigoISO, fechaproceso, UserData().CodigoUsuario);
                    }

                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de generación de lideres ha finalizado satisfactoriamente."
                    });

                }
                else
                {

                    string[] file = null;

                    using (var pedidoService = new PedidoServiceClient())
                    {
                        int ContadorCarga = pedidoService.ValidarCargadePedidos(model.PaisID, model.TipoCronogramaID == 3 ? 2 : model.TipoCronogramaID, model.TipoCronogramaID == 1 ? 1 : (model.TipoCronogramaID == 3 ? 1 : 0), model.FechaFacturacion);

                        if (ContadorCarga == 0)
                        {
                            string usuario = UserData().NombreConsultora;
                            file = pedidoService.DescargaPedidosWeb(model.PaisID, model.FechaFacturacion, model.TipoCronogramaID == 3 ? 2 : model.TipoCronogramaID, model.TipoCronogramaID == 1 || (model.TipoCronogramaID == 3), usuario, ((Enumeradores.TipoDescargaPedidos)model.TipoCronogramaID).ToString());
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

                    bool fox = false;
                    if (file.Length != 3)
                    {
                        return Json(new
                        {
                            success = true,
                            mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente."
                        });
                    }
                    else
                    {
                        fox = true;

                        return Json(new
                        {
                            success = true,
                            mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                            cabecera = System.IO.Path.GetFileName(file[0]),
                            detalle = System.IO.Path.GetFileName(file[1]),
                            detalleAct = System.IO.Path.GetFileName(file[2]),

                            rutac = file[0],
                            rutad = file[1],
                            rutae = file[2],
                            IsFox = fox
                        });
                    }
                }
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

                string[] file = null;

                using (var pedidoService = new PedidoServiceClient())
                {
                    int ContadorCarga = pedidoService.ValidarCargadePedidos(model.PaisID, model.TipoCronogramaID, 0, model.FechaFacturacion);

                    if (ContadorCarga == 0)
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

                bool fox = false;

                if (file.Length != 2)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente."
                    });
                }
                else
                {
                    fox = true;

                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                        cabecera = System.IO.Path.GetFileName(file[0]),
                        detalle = System.IO.Path.GetFileName(file[1]),
                        rutac = file[0],
                        rutad = file[1],
                        IsFox = fox
                    });
                }

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

                string[] file = null;

                using (var pedidoService = new PedidoServiceClient())
                {
                    string usuario = UserData().NombreConsultora;
                    file = pedidoService.DescargaPedidosFIC(model.PaisID, model.FechaFacturacion, 4, usuario);

                }

                bool fox = false;
                if (file.Length != 2)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente."
                    });
                }
                else
                {
                    fox = true;

                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                        cabecera = System.IO.Path.GetFileName(file[0]),
                        detalle = System.IO.Path.GetFileName(file[1]),
                        rutac = file[0],
                        rutad = file[1],
                        IsFox = fox
                    });
                }
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
        public ActionResult ObtenerUltimaDescargaPedido()
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoDescarga> lst = new List<BEPedidoDescarga>();
                BEPedidoDescarga UltimaDescargaPedido = new BEPedidoDescarga();
                using (PedidoServiceClient srv = new PedidoServiceClient())
                {
                    UltimaDescargaPedido = srv.ObtenerUltimaDescargaPedido(userData.PaisID);
                }
                lst.Add(UltimaDescargaPedido);

                var data = new
                {
                    total = 1,
                    page = 1,
                    records = 3,
                    rows = from item in lst
                           select new
                           {
                               id = item.NroLote,
                               cell = new string[]
                               {
                                   item.FechaHoraInicio.ToString(),
                                   item.FechaHoraFin.ToString(),
                                   item.Estado,
                                   item.Mensaje,
                                   string.Format(" Web: {0}<br> DD: {1}", item.NumeroPedidosWeb.ToString(), item.NumeroPedidosDD.ToString()),
                                   item.TipoProceso,
                                   item.FechaFacturacion.ToShortDateString(),
                                   (item.Desmarcado) ?"Pedido Desmarcado": string.Empty
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
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
            BEPedidoDescarga UltimaDescarga = new BEPedidoDescarga();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UltimaDescarga = sv.ObtenerUltimaDescargaExitosa(userData.PaisID);
            }

            return Json(new
            {
                success = true,
                descarga = new
                {
                    FechaEnvio = UltimaDescarga.FechaEnvio.ToString(),
                    FechaProceso = UltimaDescarga.FechaProceso.ToString()
                }
            });
        }
    }
}
