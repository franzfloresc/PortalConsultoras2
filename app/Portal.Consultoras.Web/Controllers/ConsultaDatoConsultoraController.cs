using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultaDatoConsultoraController : BaseController
    {
        readonly PaqueteDocumentarioProvider _paqueteDocumentarioProvider;

        public ConsultaDatoConsultoraController()
        {
            _paqueteDocumentarioProvider = new PaqueteDocumentarioProvider();
        }

        public ActionResult ConsultaDatoConsultora()
        {
            var model = new ConsultaDatoConsultoraModel
            {
                listaPaises = DropDowListPaises(),
                PaisID = userData.PaisID,
                listaCampania = ObtenterCampaniasPorPais(userData.PaisID)
            };
            return View(model);
        }

        public ActionResult DatoConsultora(string paisID, string codigoConsultora, string documento)
        {
            JsonResult v_retorno = null;

            try
            {            
                var consultora = new ServiceUsuario.UsuarioServiceClient();
                var consultoraDato = consultora.DatoConsultoraSAC(paisID, codigoConsultora, documento);   
                if (consultoraDato != null)
                    ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigoConsultora, "Datos de Consultora");
                
                v_retorno = Json(consultoraDato, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                v_retorno = Json(null, JsonRequestBehavior.AllowGet);
            }

            return v_retorno;
        }

        #region EstadoConsultora
        public ActionResult EstadoConsultora(string paisID, string codigoConsultora)
        {
            try
            {
                UsuarioServiceClient consultora = new UsuarioServiceClient();
                BEConsultoraEstadoSAC consultoraEstado = consultora.ConsultoraEstadoSAC(paisID, codigoConsultora);
                ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigoConsultora, "Estado de Consultora");
                return Json(consultoraEstado, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ObtenerPackOfertasNuevasPorCampania(string campaniaId, string consultoraID)
        {
            try
            {
                PedidoServiceClient svc = new PedidoServiceClient();
                var lista = svc.GetProductosOfertaConsultoraNueva(userData.PaisID, Convert.ToInt32(campaniaId), Convert.ToInt32(consultoraID)).ToList();
                var data = new
                {
                    rows = from a in lista
                           select new
                           {
                               cell = new string[]
                               {
                                   a.OfertaNuevaId.ToString(),
                                   a.DescripcionProd
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion 

        public ActionResult EstadoCuenta(string sidx, string sord, int page, int rows, string codigoConsultora)
        {
            try
            {
                ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigoConsultora, "Estado de Cuenta");
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }            

            if (ModelState.IsValid)
            {

                long consulId = ObtenerConsultoraId(codigoConsultora);
                var lst = EstadodeCuenta(consulId);

                string deudaActualConultora;
                using (SACServiceClient client = new SACServiceClient())
                {
                    deudaActualConultora = client.GetDeudaActualConsultora(userData.PaisID, consulId);
                }

                string fechaVencimiento;
                string montoPagar;
                if (lst.Count == 0)
                {
                    fechaVencimiento = "";
                    montoPagar = userData.PaisID == 4 ? "0" : "0.0";
                }
                else
                {
                    if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                        fechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    else
                        fechaVencimiento = string.Empty;
                    montoPagar = userData.PaisID == 4
                        ? string.Format("{0:#,##0}", deudaActualConultora.Replace(',', '.'))
                        : string.Format("{0:#,##0.00}", deudaActualConultora);
                }
                var simbolo = string.Format("{0} ", userData.Simbolo);

                if (lst.Count != 0)
                {
                    lst.RemoveAt(lst.Count - 1);
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<EstadoCuentaModel> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Fecha":
                            items = lst.OrderBy(x => x.Fecha);
                            break;
                        case "Glosa":
                            items = lst.OrderBy(x => x.Glosa);
                            break;
                        case "Cargo":
                            items = lst.OrderBy(x => x.Cargo);
                            break;
                        case "Abono":
                            items = lst.OrderBy(x => x.Abono);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Fecha":
                            items = lst.OrderByDescending(x => x.Fecha);
                            break;
                        case "Glosa":
                            items = lst.OrderByDescending(x => x.Glosa);
                            break;
                        case "Cargo":
                            items = lst.OrderByDescending(x => x.Cargo);
                            break;
                        case "Abono":
                            items = lst.OrderByDescending(x => x.Abono);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

                BEPager pag = Paginador(grid, lst);

                items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);


                if (userData.PaisID == 4)
                {
                    var data = new
                    {
                        simbolo = simbolo,
                        fechaVencimiento = fechaVencimiento,
                        montoPagar = montoPagar,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   cell = new string[]
                                   {
                                a.Fecha.ToString("dd/MM/yyyy"),
                                a.Glosa,
                                string.Format("{0} ", userData.Simbolo) +
                                string.Format("{0:#,##0}", a.Cargo).Replace(',', '.'),
                                string.Format("{0} ", userData.Simbolo) +
                                string.Format("{0:#,##0}", a.Abono).Replace(',', '.')
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        simbolo = simbolo,
                        fechaVencimiento = fechaVencimiento,
                        montoPagar = montoPagar,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   cell = new string[]
                                   {
                                a.Fecha.ToString("dd/MM/yyyy"),
                                a.Glosa,
                                string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0.00}", a.Cargo),
                                string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0.00}", a.Abono)
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }

            }
            
            return RedirectToAction("Index", "Bienvenida");
        }

        #region pedido facturado

        public ActionResult PedidoFacturado(string sidx, string sord, int page, int rows, string codigoConsultora)
        {
            try
            {
                ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigoConsultora, "Pedido Facturado");
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            if (ModelState.IsValid)
            {
                List<ServicePedido.BEPedidoWeb> lst = new List<ServicePedido.BEPedidoWeb>();
                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosCabecera(userData.PaisID, codigoConsultora).ToList();
                    }
                }
                catch (Exception ex)
                {
                    Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                foreach (var pedido in lista)
                {
                    ServicePedido.BEPedidoWeb obePedidoWeb = new ServicePedido.BEPedidoWeb
                    {
                        CampaniaID = pedido.Campania,
                        ImporteTotal = pedido.ImporteTotal,
                        CantidadProductos = pedido.Cantidad
                    };

                    if (!string.IsNullOrEmpty(pedido.EstadoPedido))
                    {
                        string[] parametros = pedido.EstadoPedido.Split(';');
                        if (parametros.Length >= 3)
                        {
                            obePedidoWeb.EstadoPedidoDesc = OrigenDescripcion(parametros[0]);
                            obePedidoWeb.Direccion = parametros[1] == string.Empty ? "0" : parametros[1];
                            obePedidoWeb.CodigoUsuarioCreacion = parametros[2] == string.Empty ? "" : Convert.ToDateTime(parametros[2]).ToShortDateString();
                        }


                    }

                    lst.Add(obePedidoWeb);
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ServicePedido.BEPedidoWeb> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderBy(x => x.CampaniaID);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
                            break;
                        case "CantidadProductos":
                            items = lst.OrderBy(x => x.CantidadProductos);
                            break;
                        case "EstadoPedidoDesc":
                            items = lst.OrderBy(x => x.EstadoPedidoDesc);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderByDescending(x => x.CampaniaID);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                        case "CantidadProductos":
                            items = lst.OrderByDescending(x => x.Clientes);
                            break;
                        case "EstadoPedidoDesc":
                            items = lst.OrderByDescending(x => x.EstadoPedidoDesc);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                if (userData.PaisID == 4)
                {
                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.CampaniaID,
                                   cell = new string[]
                                   {
                                DescripcionCampania(a.CampaniaID.ToString()),
                                a.EstadoPedidoDesc,
                                (userData.Simbolo + " " + string.Format("{0:#,##0}", a.ImporteTotal).Replace(',', '.')),
                                a.CantidadProductos.ToString(),
                                a.CodigoUsuarioCreacion,
                                a.Direccion,
                                a.ImporteTotal.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.CampaniaID,
                                   cell = new string[]
                                   {
                                DescripcionCampania(a.CampaniaID.ToString()),
                                a.EstadoPedidoDesc,
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.ImporteTotal)),
                                a.CantidadProductos.ToString(),
                                a.CodigoUsuarioCreacion,
                                a.Direccion,
                                a.ImporteTotal.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult PedidoFacturadoProducto(string sidx, string sord, int page, int rows, string campaniaId, string codigoConsultora, string flete, string totalFacturado)
        {
            if (ModelState.IsValid)
            {
                decimal flete2 = flete == string.Empty ? 0 : Convert.ToDecimal(flete);
                decimal totalFacturadoD = totalFacturado == string.Empty ? 0 : Convert.ToDecimal(totalFacturado);
                string importeTotal;
                string fleteString;
                string totalFacturadoString;

                if (userData.PaisID == 4)
                {

                    fleteString = string.Format("{0:#,##0}", flete2).Replace(',', '.');
                    totalFacturadoString = string.Format("{0:#,##0}", totalFacturadoD).Replace(',', '.');
                    importeTotal = string.Format("{0:#,##0}", totalFacturadoD - flete2).Replace(',', '.');
                }
                else
                {
                    fleteString = string.Format("{0:#,##0.00}", flete2);
                    totalFacturadoString = string.Format("{0:#,##0.00}", totalFacturadoD);
                    importeTotal = string.Format("{0:#,##0.00}", totalFacturadoD - flete2);
                }


                List<ServicePedido.BEPedidoWebDetalle> lst = new List<ServicePedido.BEPedidoWebDetalle>();
                List<BEPedidoFacturado> lista;
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(userData.PaisID, campaniaId, "0", "0", codigoConsultora, 0).ToList();
                    }
                }
                catch (Exception ex)
                {
                    Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    lista = null;
                }

                lista = lista ?? new List<BEPedidoFacturado>();

                foreach (var pedido in lista)
                {
                    if (pedido.CUV.Trim().Length > 0 &&
                        pedido.Descripcion.Trim().Length > 0)
                        lst.Add(new ServicePedido.BEPedidoWebDetalle
                        {
                            CUV = pedido.CUV,
                            DescripcionProd = pedido.Descripcion,
                            Cantidad = pedido.Cantidad,
                            PrecioUnidad = pedido.PrecioUnidad,
                            ImporteTotal = pedido.ImporteTotal,
                            ImporteTotalPedido = pedido.MontoDescuento
                        });
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ServicePedido.BEPedidoWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;

                        case "DescripcionProd":
                            items = lst.OrderBy(x => x.DescripcionProd);
                            break;

                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;

                        case "PrecioUnidad":
                            items = lst.OrderBy(x => x.PrecioUnidad);
                            break;

                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;

                        case "DescripcionProd":
                            items = lst.OrderByDescending(x => x.DescripcionProd);
                            break;

                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;

                        case "PrecioUnidad":
                            items = lst.OrderByDescending(x => x.PrecioUnidad);
                            break;

                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                if (userData.PaisID == 4)
                {
                    var data = new
                    {
                        importeTotal = importeTotal,
                        flete = fleteString,
                        totalFacturado = totalFacturadoString,
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = "0",
                        rows = from a in items
                               select new
                               {
                                   id = a.CUV,
                                   cell = new string[]
                                   {
                                a.CUV,
                                a.DescripcionProd,
                                a.Cantidad.ToString(),
                                (userData.Simbolo + " " + string.Format("{0:#,##0}", a.PrecioUnidad).Replace(',', '.')),
                                (userData.Simbolo + " " + string.Format("{0:#,##0}", a.ImporteTotal).Replace(',', '.')),
                                (" " + a.ImporteTotal.ToString("#,##0").Replace(',', '.')),
                                (userData.Simbolo + " " +
                                 string.Format("{0:#,##0}", a.ImporteTotalPedido).Replace(',', '.')),
                                (userData.Simbolo + " " +
                                 string.Format("{0:#,##0}", a.ImporteTotal - a.ImporteTotalPedido).Replace(',', '.'))
                                   }
                               }
                    };

                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        importeTotal = importeTotal,
                        flete = fleteString,
                        totalFacturado = totalFacturadoString,
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = "0",
                        rows = from a in items
                               select new
                               {
                                   id = a.CUV,
                                   cell = new string[]
                                   {
                                a.CUV,
                                a.DescripcionProd,
                                a.Cantidad.ToString(),
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.PrecioUnidad)),
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.ImporteTotal)),
                                (" " + a.ImporteTotal.ToString("#0.00")),
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.ImporteTotalPedido)),
                                (userData.Simbolo + " " +
                                 string.Format("{0:#,##0.00}", a.ImporteTotal - a.ImporteTotalPedido))
                                   }
                               }
                    };

                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarPedidoWebDetalleClientes(string sidx, string sord, int page, int rows, string campaniaId, string consultoraId)
        {
            if (ModelState.IsValid)
            {
                List<ServicePedido.BEPedidoWebDetalle> olstPedido;

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = userData.PaisID,
                    CampaniaId = int.Parse(campaniaId),
                    ConsultoraId = long.Parse(consultoraId),
                    Consultora = "",
                    EsBpt = EsOpt() == 1,
                    CodigoPrograma = userData.CodigoPrograma,
                    NumeroPedido = userData.ConsecutivoNueva
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstPedido = sv.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                }

                decimal total = 0;
                string totalPw;

                if (olstPedido.Count != 0)
                {
                    total = olstPedido.Sum(p => p.ImporteTotal);
                }

                totalPw = userData.PaisID == 4 ?
                    string.Format("{0:#,##0}", total).Replace(',', '.')
                    : string.Format("{0:N2}", total);


                List<ServiceCliente.BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetClientesByCampania(userData.PaisID, int.Parse(campaniaId), long.Parse(consultoraId)).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ServiceCliente.BEPedidoWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    totalPW = totalPw,
                    simbolo = userData.Simbolo,
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ClienteID,
                               cell = new string[]
                               {
                            a.Nombre,
                            a.ClienteID.ToString(),
                            a.eMail
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarPedidoWebDetalleProductos(string sidx, string sord, int page, int rows, string campaniaId, string clientId, string consultoraId)
        {
            if (ModelState.IsValid)
            {
                List<ServiceCliente.BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(campaniaId), long.Parse(consultoraId), int.Parse(clientId)).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ServiceCliente.BEPedidoWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "DescripcionProd":
                            items = lst.OrderBy(x => x.DescripcionProd);
                            break;
                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;
                        case "PrecioUnidad":
                            items = lst.OrderBy(x => x.PrecioUnidad);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "DescripcionProd":
                            items = lst.OrderByDescending(x => x.DescripcionProd);
                            break;
                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;
                        case "PrecioUnidad":
                            items = lst.OrderByDescending(x => x.PrecioUnidad);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                if (userData.PaisID == 4)
                {
                    var data = new
                    {
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = string.Format("{0:#,##0}", (from req in lst select req.ImporteTotal).Sum())
                            .Replace(',', '.'),
                        rows = from a in items
                               select new
                               {
                                   id = a.PedidoDetalleID,
                                   cell = new string[]
                                   {
                                a.CUV,
                                a.DescripcionProd,
                                a.Cantidad.ToString(),
                                (userData.Simbolo + " " + string.Format("{0:#,##0}", a.PrecioUnidad).Replace(',', '.')),
                                (userData.Simbolo + " " + string.Format("{0:#,##0}", a.ImporteTotal).Replace(',', '.')),
                                a.ImporteTotal.ToString("#0.00")
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = string.Format("{0:#,##0.00}", (from req in lst select req.ImporteTotal).Sum()),
                        rows = from a in items
                               select new
                               {
                                   id = a.PedidoDetalleID,
                                   cell = new string[]
                                   {
                                a.CUV,
                                a.DescripcionProd,
                                a.Cantidad.ToString(),
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.PrecioUnidad)),
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.ImporteTotal)),
                                a.ImporteTotal.ToString("#0.00")
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("PedidoWeb");
        }

        [HttpPost]
        public JsonResult EnviarEmail(string ClientId, string Email, string CampaniaId, string consultoraId)
        {
            try
            {
                if (userData.UsuarioPrueba == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Esta opción no está habilitada para los Usuarios de Prueba.",
                        extra = ""
                    });
                }

                decimal total = 0;
                List<ServiceCliente.BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), long.Parse(consultoraId), int.Parse(ClientId)).ToList();
                }


                #region Mensaje a Enviar

                var txtBuil = new StringBuilder();

                txtBuil.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
                txtBuil.Append("<div style='font-size:12px;'>Hola,</div> <br />");
                txtBuil.Append("<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + CampaniaId.ToString() + "</b> es el siguiente :</div> <br /><br />");
                txtBuil.Append("<table border='1' style='width: 80%;'>");
                txtBuil.Append("<tr style='color: #FFFFFF'>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>");
                txtBuil.Append("Cod. Venta");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>");
                txtBuil.Append("Descripción");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>");
                txtBuil.Append("Cantidad");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>");
                txtBuil.Append("Precio Unit.");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>");
                txtBuil.Append("Precio Total");
                txtBuil.Append("</td>");
                txtBuil.Append("</tr>");

                for (int i = 0; i < lst.Count; i++)
                {

                    txtBuil.Append("<tr>");
                    txtBuil.Append("<td style='font-size:11px; width: 126px; text-align: center;'>");
                    txtBuil.Append("" + lst[i].CUV + "");
                    txtBuil.Append("</td>");
                    txtBuil.Append(" <td style='font-size:11px; width: 347px;'>");
                    txtBuil.Append("" + lst[i].DescripcionProd + "");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; width: 124px; text-align: center;'>");
                    txtBuil.Append("" + lst[i].Cantidad.ToString() + "");
                    txtBuil.Append("</td>");

                    if (userData.PaisID == 4)
                    {
                        txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                        txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].PrecioUnidad).Replace(',', '.') + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                        txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].ImporteTotal).Replace(',', '.') + "");
                        txtBuil.Append("</td>");
                    }
                    else
                    {
                        txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                        txtBuil.Append("" + userData.Simbolo + lst[i].PrecioUnidad.ToString("#0.00") + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                        txtBuil.Append("" + userData.Simbolo + lst[i].ImporteTotal.ToString("#0.00") + "");
                        txtBuil.Append("</td>");
                    }

                    txtBuil.Append("</tr>");

                    total += lst[i].ImporteTotal;

                }

                txtBuil.Append("<tr>");
                txtBuil.Append("<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>");
                txtBuil.Append("Total :");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; text-align: center; font-weight: bold'>");

                if (userData.PaisID == 4)
                {
                    txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", total).Replace(',', '.') + "");
                }
                else
                {
                    txtBuil.Append("" + userData.Simbolo + total.ToString("#0.00") + "");
                }

                txtBuil.Append("</td>");
                txtBuil.Append("</tr>");
                txtBuil.Append("</table>");
                txtBuil.Append("<br /><br />");
                txtBuil.Append("<div style='font-size:12px;'>Saludos,</div>");
                txtBuil.Append("<br /><br />");
                txtBuil.Append("<table border='0'>");
                txtBuil.Append("<tr>");
                txtBuil.Append("<td>");
                txtBuil.Append("<img src='cid:Logo' border='0' />");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='text-align: center; font-size:12px;'>");
                txtBuil.Append("<strong>" + userData.NombreConsultora + "</strong> <br />");
                txtBuil.Append("<strong>Consultora</strong>");
                txtBuil.Append("</td>");
                txtBuil.Append("</tr>");
                txtBuil.Append("</table>");

                string mailBody = txtBuil.ToString();
                #endregion

                Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.Equals("0") ? userData.EMail : Email, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);

                return Json(new
                {
                    success = true,
                    message = "Se envió satisfactoriamente el correo al cliente seleccionado.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el envió de correo, intente nuevamente.",
                    extra = ""
                });
            }
        }

        #endregion 

        public ActionResult SeguimientoPedido(string codigo)
        {
            string url = "";
            try
            {                
                string paisID = userData.PaisID.ToString();
                string codigoConsultora = codigo;
                string mostrarAyudaWebTracking = Convert.ToInt32(true).ToString();
                string paisISO = userData.CodigoISO.Trim();
                string campanhaID = userData.CampaniaID.ToString();
                url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisID, codigoConsultora, mostrarAyudaWebTracking, paisISO, campanhaID);
                ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigoConsultora, "Seguimiento Pedido");
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json("", JsonRequestBehavior.AllowGet);
            }           
        }

        public ActionResult PaqueteDocumentario(string sidx, string sord, int page, int rows, string campania, string codigo)
        {
            try
            {
                ActualizarDatosLogDynamoDB(null, "CONSULTA DATOS CONSULTORA|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Consulta", codigo, "Paquete Documentario");
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            

            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            BEPager pag = new BEPager();
            List<RVPRFModel> lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(campania)) lst = _paqueteDocumentarioProvider.GetListPaqueteDocumentario(codigo, campania, "", userData.CodigoISO);
            IEnumerable<RVPRFModel> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderBy(x => x.Nombre);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderByDescending(x => x.Nombre);
                        break;
                }
            }
            #endregion
            
            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.Nombre + "-" + a.FechaFacturacion,
                           cell = new string[]
                           {
                        a.Nombre,
                        a.FechaFacturacion,
                        a.Ruta,
                           }
                       }
            };
            
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCampaniasRVDigitalWeb(string CodigoConsultora)
        {
            string errorMessage;
            return Json(_paqueteDocumentarioProvider.GetListCampaniaPaqueteDocumentario(CodigoConsultora, userData.CodigoISO, out errorMessage), JsonRequestBehavior.AllowGet);
        }

        #region metodos genericos
        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> ObtenterCampaniasPorPais(int paisId)
        {
            List<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(paisId).ToList();
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(vBusqueda)
                ? lst.Count
                : lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public string DevolverFecha(string url)
        {
            string[] cadenas = url.Split('/');
            string fecha = string.Empty;

            if (cadenas.Length > 0)
            {
                string[] rutas = cadenas[cadenas.Length - 2].Split('_');
                if (rutas.Length > 0)
                {
                    string temp = rutas[0].Substring(6, 8);
                    fecha = string.Format("{0}/{1}/{2}", temp.Substring(6, 2), temp.Substring(4, 2), temp.Substring(0, 4));
                }
            }

            return fecha;
        }

        private List<EstadoCuentaModel> EstadodeCuenta(long consultoraId)
        {
            List<EstadoCuentaModel> lst = ObtenerEstadoCuenta(consultoraId);

            return lst;
        }

        public long ObtenerConsultoraId(string codigoConsultora)
        {
            long consultoraIdmetodo;
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                consultoraIdmetodo = sv.GetConsultoraIdByCodigo(userData.PaisID, codigoConsultora);
            }

            return consultoraIdmetodo;
        }

        public BEPager Paginador(BEGrid item, List<EstadoCuentaModel> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public string OrigenDescripcion(string origen)
        {
            string result;
            switch (origen)
            {
                case "A":
                    result = "PEDIDO ESPECIAL";
                    break;
                case "O":
                    result = "DIGITADO / OCR";
                    break;
                case "OCR":
                    result = "OCR";
                    break;
                case "W":
                case "WEB":
                    result = "WEB";
                    break;
                case "D":
                case "DD":
                    result = "DD";
                    break;
                case "M":
                case "MIXTO":
                    result = "MIXTO (DD + WEB)";
                    break;
                default:
                    result = origen;
                    break;

            }
            return result;
        }

        public string DescripcionCampania(string campaniaId)
        {
            string DesCamp;
            try
            {
                DesCamp = campaniaId.Substring(0, 4) + "-C" + campaniaId.Substring(4, 2);
            }
            catch (Exception ex)
            {
                Web.LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                DesCamp = campaniaId;
            }
            return DesCamp;
        }

        #endregion
    }
}
