namespace Portal.Consultoras.Web.Controllers
{
    using AutoMapper;
    using Portal.Consultoras.Common;
    using Portal.Consultoras.Web.Models;
    using Portal.Consultoras.Web.ServiceCliente;
    using Portal.Consultoras.Web.ServiceOSBBelcorpConsultora;
    using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;
    using Portal.Consultoras.Web.ServicePedido;
    using Portal.Consultoras.Web.ServiceSAC;
    using Portal.Consultoras.Web.ServiceUsuario;
    using Portal.Consultoras.Web.ServiceZonificacion;
    using System;
    using System.Collections.Generic;
    using System.Configuration;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Web.Mvc;
    using System.Web.Script.Serialization;

    public class ConsultaDatoConsultoraController : BaseController
    {
        //
        // GET: /ConsultaDatoConsultora/
        public ActionResult ConsultaDatoConsultora()
        {
            var model = new ConsultaDatoConsultoraModel();
            model.listaPaises = DropDowListPaises();
            model.PaisID = userData.PaisID;
            model.listaCampania = ObtenterCampaniasPorPais(userData.PaisID);
            return View(model);
        }

        public ActionResult DatoConsultora(string paisID, string codigoConsultora, string documento)
        {
            try
            {
                ServiceUsuario.UsuarioServiceClient consultora = new ServiceUsuario.UsuarioServiceClient();
                BEConsultoraDatoSAC consultoraDato = consultora.DatoConsultoraSAC(paisID, codigoConsultora, documento);
                return Json(consultoraDato, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        #region EstadoConsultora
        public ActionResult EstadoConsultora(string paisID, string codigoConsultora)
        {
            try
            {
                ServiceUsuario.UsuarioServiceClient consultora = new ServiceUsuario.UsuarioServiceClient();
                BEConsultoraEstadoSAC consultoraEstado = consultora.ConsultoraEstadoSAC(paisID, codigoConsultora);
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
                List<BEOfertaNueva> lista;
                ServicePedido.PedidoServiceClient svc = new ServicePedido.PedidoServiceClient();
                lista = svc.GetProductosOfertaConsultoraNueva(userData.PaisID, Convert.ToInt32(campaniaId), Convert.ToInt32(consultoraID)).ToList();
                var data = new
                {
                    rows = from a in lista
                           select new
                           {
                               cell = new string[] 
                               {
                                   a.OfertaNuevaId.ToString(),
                                   a.DescripcionProd.ToString()
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
            if (ModelState.IsValid)
            {
                List<EstadoCuentaModel> lst;

                lst = EstadodeCuenta(codigoConsultora);

                ///Totales
                string fechaVencimiento;
                string montoPagar;
                string simbolo;
                if (lst.Count == 0)
                {
                    fechaVencimiento = "";
                    if (userData.PaisID == 4) // Validación para país colombia req. 1478
                    {
                        montoPagar = "0";
                    }
                    else
                    {
                        montoPagar = "0.0";
                    }
                }
                else
                {
                    if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                        fechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    else
                        fechaVencimiento = string.Empty;
                    if (userData.PaisID == 4) // Validación para país colombia req. 1478
                    {
                        montoPagar = string.Format("{0:#,##0}", lst[lst.Count - 1].Cargo).Replace(',', '.');
                    }
                    else
                    {
                        montoPagar = string.Format("{0:#,##0.00}", lst[lst.Count - 1].Cargo);
                    }
                }
                simbolo = string.Format("{0} ", userData.Simbolo);
                ///Fin Totales











                if (lst.Count != 0)
                {
                    lst.RemoveAt(lst.Count - 1);
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);


                // Creamos la estructura
                if (userData.PaisID == 4) // validación para colombia req. 1478
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
                                   a.Glosa.ToString(),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0}", a.Cargo).Replace(',','.'),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0}", a.Abono).Replace(',','.')
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
                                   a.Glosa.ToString(),
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
            if (ModelState.IsValid)
            {
                List<Portal.Consultoras.Web.ServicePedido.BEPedidoWeb> lst = new List<Portal.Consultoras.Web.ServicePedido.BEPedidoWeb>();
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

                }

                foreach (var pedido in lista)
                    {
                        Portal.Consultoras.Web.ServicePedido.BEPedidoWeb oBEPedidoWeb = new Portal.Consultoras.Web.ServicePedido.BEPedidoWeb();
                    oBEPedidoWeb.CampaniaID = pedido.Campania;
                    oBEPedidoWeb.ImporteTotal = pedido.ImporteTotal;
                    oBEPedidoWeb.CantidadProductos = pedido.Cantidad;
                    if (!string.IsNullOrEmpty(pedido.EstadoPedido))
                        {
                        string[] parametros = pedido.EstadoPedido.Split(';');
                        if (parametros.Length >= 3)
                            {
                                //Se utilizará el campo para enviar la información de Origen
                                oBEPedidoWeb.EstadoPedidoDesc = OrigenDescripcion(parametros[0]);
                                //Se utilizará el campo para enviar la información de Flete
                                oBEPedidoWeb.Direccion = parametros[1] == string.Empty ? "0" : parametros[1];
                                //Se utilizará el campo para enviar la fecha de Facturación
                                oBEPedidoWeb.CodigoUsuarioCreacion = parametros[2] == string.Empty ? "" : Convert.ToDateTime(parametros[2]).ToShortDateString();
                            }
                            
                            
                        }
                        
                        lst.Add(oBEPedidoWeb);
                    }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<Portal.Consultoras.Web.ServicePedido.BEPedidoWeb> items = lst;

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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                if (userData.PaisID == 4) // validación pais colombia req. 1478
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
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
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
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
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

        public ActionResult PedidoFacturadoProducto(string sidx, string sord, int page, int rows, string campaniaId, string codigoConsultora,string flete, string totalFacturado)
        {
            if (ModelState.IsValid)
            {
                decimal Flete2 = flete == string.Empty ? 0 : Convert.ToDecimal(flete);
                decimal TotalFacturado = totalFacturado == string.Empty ? 0 :Convert.ToDecimal(totalFacturado);
                string importeTotal;
                string fleteString;
                string totalFacturadoString;

                if (userData.PaisID == 4)
                {

                    fleteString = string.Format("{0:#,##0}", Flete2).Replace(',', '.');
                    totalFacturadoString = string.Format("{0:#,##0}", TotalFacturado).Replace(',', '.');
                    importeTotal = string.Format("{0:#,##0}", TotalFacturado - Flete2).Replace(',', '.');
                }
                else
                {
                    fleteString = string.Format("{0:#,##0.00}", Flete2);
                    totalFacturadoString = string.Format("{0:#,##0.00}", TotalFacturado);
                    importeTotal = string.Format("{0:#,##0.00}", TotalFacturado - Flete2);
                }


                List<Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle> lst = new List<Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle>();
                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(userData.PaisID, campaniaId, "0", "0", codigoConsultora, 0).ToList();
                    }
                }
                catch (Exception ex)
                {
                    lista = null;
                }

                foreach (var pedido in lista)
                {
                    if (pedido.CUV.Trim().Length > 0 &&
                        pedido.Descripcion.Trim().Length > 0)
                        lst.Add(new Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle
                        {
                            CUV = pedido.CUV,
                            DescripcionProd = pedido.Descripcion,
                            Cantidad = pedido.Cantidad,
                            PrecioUnidad = pedido.PrecioUnidad,
                            ImporteTotal = pedido.ImporteTotal,
                            //Se esta reutilizando este campo para devolver el descuente correspondiente al CUV
                            ImporteTotalPedido = pedido.MontoDescuento
                        });
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
                IEnumerable<Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle> items = lst;

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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                if (userData.PaisID == 4)
                { // validación país colombia req. 1478
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
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.PrecioUnidad).Replace(',','.')),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
                                   (" " + a.ImporteTotal.ToString("#,##0").Replace(',','.')),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotalPedido).Replace(',','.')),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal - a.ImporteTotalPedido).Replace(',','.'))
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
                        totalSum = "0",//string.Format("{0:#,##0.00}", Math.Truncate((from req in lst select req.ImporteTotal - req.ImporteTotalPedido).Sum()*100)/100),
                        rows = from a in items
                               select new
                               {
                                   id = a.CUV,
                                   cell = new string[] 
                               {
                                   a.CUV,
                                   a.DescripcionProd,
                                   a.Cantidad.ToString(),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.PrecioUnidad)),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
                                   (" " + a.ImporteTotal.ToString("#0.00")),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotalPedido)),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal - a.ImporteTotalPedido))
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
                List<ServicePedido.BEPedidoWebDetalle> olstPedido = new List<ServicePedido.BEPedidoWebDetalle>();
                using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
                {
                    //Inicio ITG 1793 HFMG
                    olstPedido = sv.SelectByCampania(userData.PaisID, int.Parse(campaniaId), long.Parse(consultoraId), "").ToList();
                    //Fin ITG 1793 HFMG
                }

                decimal Total = 0;
                string TotalPW;

                if (olstPedido.Count != 0)
                {
                    Total = olstPedido.Sum(p => p.ImporteTotal);
                }

                if (userData.PaisID == 4)
                { // Validación pais Colombia Req. 1478
                    TotalPW = string.Format("{0:#,##0}", Total).Replace(',', '.');
                }
                else
                {
                    TotalPW = string.Format("{0:N2}", Total);
                }


                List<ServiceCliente.BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    //Inicio ITG 1793 HFMG
                    lst = sv.GetClientesByCampania(userData.PaisID, int.Parse(campaniaId), long.Parse(consultoraId)).ToList();
                    //Fin ITG 1793 HFMG
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    totalPW = TotalPW,
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
                    //Inicio ITG 1793 HFMG
                    lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(campaniaId), long.Parse(consultoraId), int.Parse(clientId)).ToList();
                    //Fin ITG 1793 HFMG
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                if (userData.PaisID == 4)
                { // validación país colombia req. 1478
                    var data = new
                    {
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = string.Format("{0:#,##0}", (from req in lst select req.ImporteTotal).Sum()).Replace(',', '.'),
                        rows = from a in items
                               select new
                               {
                                   id = a.PedidoDetalleID,
                                   cell = new string[] 
                               {
                                   a.CUV,
                                   a.DescripcionProd,
                                   a.Cantidad.ToString(),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.PrecioUnidad).Replace(',','.')),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
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
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.PrecioUnidad)),
                                   (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
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
                //Inicio ITG 1793 HFMG
                if (userData.UsuarioPrueba == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Esta opción no está habilitada para los Usuarios de Prueba.",
                        extra = ""
                    });
                }
                else
                {
                    decimal Total = 0;
                    List<ServiceCliente.BEPedidoWebDetalle> lst = new List<ServiceCliente.BEPedidoWebDetalle>();
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), long.Parse(consultoraId), int.Parse(ClientId)).ToList();
                    }


                    #region Mensaje a Enviar
                    //Mejora - Correo
                    //string nomPais = Util.ObtenerNombrePaisPorISO(userData.CodigoISO);
                    string mailBody = string.Empty;
                    mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                    mailBody += "<div style='font-size:12px;'>Hola,</div> <br />";
                    mailBody += "<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + CampaniaId.ToString() + "</b> es el siguiente :</div> <br /><br />";
                    mailBody += "<table border='1' style='width: 80%;'>";
                    mailBody += "<tr style='color: #FFFFFF'>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>";
                    mailBody += "Cod. Venta";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>";
                    mailBody += "Descripción";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>";
                    mailBody += "Cantidad";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>";
                    mailBody += "Precio Unit.";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>";
                    mailBody += "Precio Total";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    /* Armado de Data */
                    for (int i = 0; i < lst.Count; i++)
                    {

                        mailBody += "<tr>";
                        mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailBody += "" + lst[i].CUV.ToString() + "";
                        mailBody += "</td>";
                        mailBody += " <td style='font-size:11px; width: 347px;'>";
                        mailBody += "" + lst[i].DescripcionProd.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 124px; text-align: center;'>";
                        mailBody += "" + lst[i].Cantidad.ToString() + "";
                        mailBody += "</td>";
                        if (userData.PaisID == 4) // validación para colombia req. 1478
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].PrecioUnidad).Replace(',', '.') + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].ImporteTotal).Replace(',', '.') + "";
                            mailBody += "</td>";

                        }
                        else
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + lst[i].PrecioUnidad.ToString("#0.00") + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + lst[i].ImporteTotal.ToString("#0.00") + "";
                            mailBody += "</td>";
                        }
                        mailBody += "</tr>";
                        Total += lst[i].ImporteTotal;

                    }
                    /* Fin de Armado de Data*/
                    mailBody += "<tr>";
                    mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                    mailBody += "Total :";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                    if (userData.PaisID == 4) // validación para colombia req. 1478
                    {
                        mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", Total).Replace(',', '.') + "";
                    }
                    else
                    {
                        mailBody += "" + userData.Simbolo + Total.ToString("#0.00") + "";
                    }

                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";
                    mailBody += "<br /><br />";
                    mailBody += "<div style='font-size:12px;'>Saludos,</div>";
                    mailBody += "<br /><br />";
                    mailBody += "<table border='0'>";
                    mailBody += "<tr>";
                    mailBody += "<td>";
                    mailBody += "<img src='cid:Logo' border='0' />";
                    mailBody += "</td>";
                    mailBody += "<td style='text-align: center; font-size:12px;'>";
                    mailBody += "<strong>" + userData.NombreConsultora + "</strong> <br />";
                    mailBody += "<strong>Consultora</strong>";
                    //Mejora - Correo
                    //mailBody += "</td>";
                    //mailBody += "</tr>";
                    //mailBody += "</table>";
                    //mailBody += "<table border='0' style='width: 80%;'>";
                    //mailBody += "<tr>";
                    //mailBody += "<td style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>";
                    //mailBody += "Belcorp - " + nomPais;
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";

                    #endregion

                    //Mejora - Correo
                    //Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.ToString().Equals("0") ? userData.EMail : Email, "Pedido Solicitado", mailBody, true, string.Format("{0} - Pedido total", Util.SinAcentosCaracteres(nomPais.ToUpper())));
                    //Util.EnviarMail(Globals.EmailCatalogos, ClientId.ToString().Equals("0") ? userData.EMail : Email, "Pedido Solicitado", mailBody, true, userData.NombreConsultora);
                    Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.ToString().Equals("0") ? userData.EMail : Email, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);


                    return Json(new
                    {
                        success = true,
                        message = "Se envió satisfactoriamente el correo al cliente seleccionado.",
                        extra = ""
                    });
                }
                //Fin ITG 1793 HFMG
            }
            catch (Exception ex)
            {
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
            string paisID = userData.PaisID.ToString();
            string codigoConsultora = codigo;
            string mostrarAyudaWebTracking = Convert.ToInt32(true).ToString();
            string paisISO = userData.CodigoISO.Trim();
            string campanhaID = userData.CampaniaID.ToString();
            url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisID, codigoConsultora, mostrarAyudaWebTracking, paisISO, campanhaID);
            return Json(url, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PaqueteDocumentario(string sidx, string sord, int page, int rows, string campania, string codigo)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            //int buscar = int.Parse(txtBuscar);
            BEPager pag = new BEPager();
            bool ErrorServicio;
            string ErrorCode;
            string ErrorMessage;
            List<RVPRFModel> lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(campania))
                lst = GetPDFRVDigital(campania, codigo, out ErrorServicio, out ErrorCode, out ErrorMessage);
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

            //if (string.IsNullOrEmpty(campania))
            //    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            //else
            //    items = items.Where(p => p.Nombre.ToUpper().Contains(campania.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = Paginador(grid, campania, lst);

            // Creamos la estructura
            var data = new 
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           //R20150906
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
            UsuarioModel usuario = userData;
            //Inicio ITG 1793 HFMG
            var complain = new RVDWebCampaniasParam { Pais = usuario.CodigoISO, Tipo = "1", CodigoConsultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : CodigoConsultora) };
            //Fin ITG 1793 HFMG
            List<CampaniaModel> lstCampaniaModel = new List<CampaniaModel>();
            bool ErrorServicio = false;
            string ErrorCode = string.Empty;
            string ErrorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = ConfigurationManager.AppSettings["WS_RV_Campanias_NEW"];
                Uri uri = new Uri(strUri);
                WebRequest request = WebRequest.Create(uri);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";

                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(output);
                }

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                StreamReader sReader = new StreamReader(reader);
                string outResult = sReader.ReadToEnd();
                sReader.Close();

                JavaScriptSerializer json_serializer = new JavaScriptSerializer();

                WrapperCampanias st = json_serializer.Deserialize<WrapperCampanias>(outResult);
                if (st != null)
                {
                    if (st.LIS_CampanaResult != null)
                    {
                        if (st.LIS_CampanaResult.lista != null)
                        {
                            if (st.LIS_CampanaResult.lista.Count != 0)
                            {
                                foreach (var item in st.LIS_CampanaResult.lista)
                                {
                                    lstCampaniaModel.Add(new CampaniaModel() { CampaniaID = Convert.ToInt32(item), Codigo = item });
                                }
                            }
                            else
                            {
                                ErrorCode = st.LIS_CampanaResult.errorCode;
                                ErrorMessage = st.LIS_CampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            ErrorCode = st.LIS_CampanaResult.errorCode;
                            ErrorMessage = st.LIS_CampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorServicio = true;
            }
            //R20150906
            if (lstCampaniaModel.Count != 0)
                return Json(lstCampaniaModel.Distinct().OrderBy(p => p.CampaniaID).ToList(), JsonRequestBehavior.AllowGet);
            else


                return Json(lstCampaniaModel, JsonRequestBehavior.AllowGet);


        }

        #region metodos genericos
        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (userData.RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(userData.PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> ObtenterCampaniasPorPais(int PaisID)
        {
            List<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(PaisID).ToList();
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
                .ForMember(x => x.NombreCorto, t => t.MapFrom(c => c.NombreCorto))
                .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        public List<RVPRFModel> GetPDFRVDigital(string campania, string codigo, out bool ErrorServicio, out string ErrorCode, out string ErrorMessage)
        {
            UsuarioModel usuario = userData;
            string Marca;
            string NombrePais = DevolverNombrePais(codigo, out Marca);
            //Inicio ITG 1793 HFMG
            //var complain = new RVDPDFParam { Pais = NombrePais, tipo = "Paq Doc Consultora", docIdentidad = "", consultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : codigo), marca = Marca, Campana = campania };
            var complain = new RVDWebCampaniasParam { Pais = usuario.CodigoISO, Tipo = "1", CodigoConsultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : codigo), Campana = campania };
            //Fin ITG 1793 HFMG
            List<RVPRFModel> lstRVPRFModel = new List<RVPRFModel>();
            ErrorServicio = false;
            ErrorCode = string.Empty;
            ErrorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = ConfigurationManager.AppSettings["WS_RV_PDF_NEW"];
                Uri uri = new Uri(strUri);
                WebRequest request = WebRequest.Create(uri);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";

                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(output);
                }

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                StreamReader sReader = new StreamReader(reader);
                string outResult = sReader.ReadToEnd();
                sReader.Close();

                JavaScriptSerializer json_serializer = new JavaScriptSerializer();

                WrapperPDFWeb st = json_serializer.Deserialize<WrapperPDFWeb>(outResult);
                if (st != null)
                {
                    if (st.GET_URLResult != null)
                    {
                        if (st.GET_URLResult.errorCode == "00000" || st.GET_URLResult.errorMessage == "OK")
                        {
                            //R20150906
                            if (st.GET_URLResult.objeto != null && st.GET_URLResult.objeto.Count != 0)
                            {
                                foreach (var item in st.GET_URLResult.objeto)
                                {
                                    lstRVPRFModel.Add(new RVPRFModel() { Nombre = "Paquete Documentario", FechaFacturacion = item.fechaFacturacion, Ruta = Convert.ToString(item.url) });
                                }
                            }

                        }
                        else
                        {
                            ErrorCode = st.GET_URLResult.errorCode;
                            ErrorMessage = st.GET_URLResult.errorMessage;
                        }

                    }

                }

            }
            catch (Exception ex)
            {
                ErrorServicio = true;
            }

            return lstRVPRFModel;
        }

        public string DevolverNombrePais(string ISO, out string Marca)
        {
            string result = string.Empty;
            Marca = string.Empty;

            switch (ISO)
            {
                case "AR": result = "ARGENTINA";
                    Marca = "L'Bel";
                    break;
                case "BO": result = "BOLIVIA";
                    Marca = "Esika";
                    break;
                case "CL": result = "CHILE";
                    Marca = "Esika";
                    break;
                case "CO": result = "COLOMBIA";
                    Marca = "L'Bel";
                    break;
                case "CR": result = "COSTA RICA";
                    Marca = "L'Bel";
                    break;
                case "DO": result = "DOMINICANA";
                    Marca = "L'Bel";
                    break;
                case "EC": result = "ECUADOR";
                    Marca = "L'Bel";
                    break;
                case "SV": result = "EL SALVADOR";
                    Marca = "Esika";
                    break;
                case "GT": result = "GUATEMALA";
                    Marca = "Esika";
                    break;
                case "MX": result = "MEXICO";
                    Marca = "L'Bel";
                    break;
                case "PA": result = "PANAMA";
                    Marca = "L'Bel";
                    break;
                case "PE": result = "PERU";
                    Marca = "Esika";
                    break;
                case "PR": result = "PUERTO RICO";
                    Marca = "L'Bel";
                    break;
                case "VE": result = "VENEZUELA";
                    Marca = "L'Bel";
                    break;
            }
            return result;
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

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

        private List<EstadoCuentaModel> EstadodeCuenta(string codigoConsultora)
        {
            List<EstadoCuentaModel> lst = ObtenerEstadoCuenta();

            return lst;            
        }

        public BEPager Paginador(BEGrid item, List<EstadoCuentaModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        public string OrigenDescripcion(string Origen)
        {
            string result = string.Empty;
            switch (Origen)
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
                    result = Origen;
                    break;

            }
            return result;
        }

        public string DescripcionCampania(string CampaniaID)
        {
            string DesCamp = string.Empty;
            try
            {
                DesCamp = CampaniaID.Substring(0, 4) + "-C" + CampaniaID.Substring(4, 2);
            }
            catch (Exception ex)
            {
                DesCamp = CampaniaID;
            }
            return DesCamp;
        }

        #endregion
    }
}
