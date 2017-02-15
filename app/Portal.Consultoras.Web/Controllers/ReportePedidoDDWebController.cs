using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
//using Portal.Consultoras.Web.ServiceOSBBelcorp;
using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReportePedidoDDWebController : BaseController
    {
        #region Action

        public ActionResult ReportePedidosDDWeb()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReportePedidoDDWeb/ReportePedidosDDWeb"))
                    return RedirectToAction("Index", "Bienvenida");
                Session["PedidosWebDDConf"] = null;
                Session["PedidosWebDD"] = null;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            var model = new ReportePedidoDDWebModel();
            model.DropDownListCampania = new List<BECampania>();
            model.DropDownListZona = new List<BEZona>();
            model.DropDownListRegion = new List<BERegion>();
            model.listaPaises = DropDowListPaises();
            model.hdnpaisISO = UserData().CodigoISO;
            ViewBag.PaisOcultoID = UserData().PaisID;
            return View(model);
        }
        public ActionResult ReportePedidosDDWebDetalle()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("ReportePedidosDDWeb");

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Dictionary<string, object> data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            var model = new ReportePedidoDDWebModel();

            model.lblCampaniaCod = data["CampaniaCod"].ToString();
            model.lblConsultoraCod = data["ConsultoraCod"].ToString();
            model.lblConsultoraNombre = data["ConsultoraNombre"].ToString();
            model.lblUsuarioNombre = data["UsuarioNombre"].ToString();
            model.lblOrigen = data["Origen"].ToString();
            model.lblValidado = data["Validado"].ToString();
            model.lblSaldo = data["Saldo"].ToString();
            model.lblImporte = data["Importe"].ToString();
            model.lblImporteConDescuento = data["ImporteConDescuento"].ToString();
            model.hdnpaisISO = data["paisISO"].ToString();
            model.Usuario = Convert.ToString(data["Usuario"]);
            model.TipoProceso = data["TipoProceso"].ToString();
            model.MotivoRechazo = data["MotivoRechazo"].ToString();
            return View(model);
        }
        public ActionResult ReportePedidosDDWebDetalleImp(string parametros)
        {
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(new char[] { ';' });
            string PaisISO = lista[0];
            string CampaniaCod = lista[1];
            string ConsultoraCod = lista[2];
            string ConsultoraNombre = lista[3];
            string UsuarioNombre = lista[4];
            string Origen = lista[5];
            string Validado = lista[6];
            string Saldo = lista[7];
            string Importe = lista[8];
            string page = lista[9];
            string sortname = lista[10];
            string sortorder = lista[11];
            string rowNum = lista[12];
            string usuario = lista[13];
            string TipoProceso = lista[17];
            string MotivoRechazo = lista[18];

            var model = new ReportePedidoDDWebModel();

            model.lblCampaniaCod = CampaniaCod;
            model.lblConsultoraCod = ConsultoraCod;
            model.lblConsultoraNombre = ConsultoraNombre;
            model.lblUsuarioNombre = UsuarioNombre;
            model.lblOrigen = Origen;
            model.lblValidado = Validado;
            model.lblSaldo = Saldo;
            model.lblImporte = Importe;
            model.hdnpaisISO = PaisISO;
            model.vpage = page;
            model.vsortname = sortname;
            model.vsortorder = sortorder;
            model.vrowNum = rowNum;
            model.Usuario = usuario;
            model.TipoProceso = TipoProceso;
            model.MotivoRechazo = MotivoRechazo;
            return View(model);
        }
        public ActionResult ConsultarPedidosDDWeb(string sidx, string sord, int page, int rows, string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {
            if (ModelState.IsValid)
            {
                ViewBag.PaisOcultoID = UserData().PaisID;

                string cadena = vPaisID + vCampania + vConsultora + vRegionID + vZonaID + vOrigen + vEstadoValidacion + vEsRechazado;

                if (Session["PedidosWebDDConf"] == null)
                    Session["PedidosWebDDConf"] = cadena;
                else
                {
                    if (Convert.ToString(Session["PedidosWebDDConf"]) != cadena)
                    {
                        Session["PedidosWebDDConf"] = cadena;
                        Session["PedidosWebDD"] = null;
                    }
                }

                List<BEPedidoDDWeb> lst = new List<BEPedidoDDWeb>();
                BEPais bepais = new BEPais();

                if (vPaisID == "")
                {
                    bepais.CodigoISO = "";
                }
                else
                {
                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                    }
                }
                if (vRegionID == "" || vRegionID == "-- Todas --") vRegionID = "0";
                if (vZonaID == "" || vZonaID == "-- Todas --") vZonaID = "0";
                if (vConsultora == "") vConsultora = "0";

                string ISOWS = bepais.CodigoISO;

                // Valida los pedidos No Facturados

                try
                {
                    if (Session["PedidosWebDD"] == null)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            lst = sv.GetPedidosWebDDNoFacturados(
                                new BEPedidoDDWeb
                                {
                                    paisID = Convert.ToInt32(vPaisID),
                                    paisISO = ISOWS,
                                    CampaniaID = Convert.ToInt32(vCampania),
                                    RegionCodigo = vRegionID,
                                    ZonaCodigo = vZonaID,
                                    Origen = Convert.ToInt32(vOrigen),
                                    ConsultoraCodigo = (string.IsNullOrEmpty(vConsultora) || vConsultora == "0" ? string.Empty : vConsultora),
                                    EstadoValidacion = int.Parse(vEstadoValidacion),
                                    EsRechazado = int.Parse(vEsRechazado)
                                }).ToList();
                        }

                        Session["PedidosWebDD"] = lst;
                    }
                    else
                    {
                        lst = (List<BEPedidoDDWeb>)Session["PedidosWebDD"];
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEPedidoDDWeb>();
                }

                if (lst.Count != 0)
                {
                    int fila = 1;
                    List<BEPedidoDDWeb> temp = new List<BEPedidoDDWeb>();

                    foreach (var item in lst)
                    {
                        temp.Add(new BEPedidoDDWeb
                        {
                            NroRegistro = fila.ToString(),
                            FechaRegistro = item.FechaRegistro,
                            FechaReserva = item.FechaReserva,
                            CampaniaCodigo = item.CampaniaCodigo,
                            Seccion = item.Seccion,
                            ConsultoraCodigo = item.ConsultoraCodigo,
                            ConsultoraNombre = item.ConsultoraNombre,
                            ImporteTotal = item.ImporteTotal,
                            ImporteTotalConDescuento = item.ImporteTotalConDescuento,
                            UsuarioResponsable = item.UsuarioResponsable,
                            ConsultoraSaldo = item.ConsultoraSaldo,
                            OrigenNombre = item.OrigenNombre,
                            EstadoValidacionNombre = item.EstadoValidacionNombre,
                            paisISO = ISOWS,
                            TipoProceso = item.OrigenNombre,
                            Zona = item.Zona,
                            IndicadorEnviado = item.IndicadorEnviado,
                            PrimeraCampaniaCodigo = item.PrimeraCampaniaCodigo,
                            Region = item.Region,
                            MotivoRechazo = item.MotivoRechazo
                        });
                        fila = fila + 1;
                    }
                    lst = temp;
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEPedidoDDWeb> items = lst;//lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NroRegistro":
                            items = lst.OrderBy(x => x.NroRegistro);
                            break;
                        case "FechaRegistro":
                            items = lst.OrderBy(x => x.FechaRegistro);
                            break;
                        case "CampaniaCodigo":
                            items = lst.OrderBy(x => x.CampaniaCodigo);
                            break;
                        case "Seccion":
                            items = lst.OrderBy(x => x.Seccion);
                            break;
                        case "ConsultoraCodigo":
                            items = lst.OrderBy(x => x.ConsultoraCodigo);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
                            break;
                        case "ImporteTotalConDescuento":
                            items = lst.OrderBy(x => x.ImporteTotalConDescuento);
                            break;
                        case "ConsultoraNombre":
                            items = lst.OrderBy(x => x.ConsultoraNombre);
                            break;
                        case "UsuarioResponsable":
                            items = lst.OrderBy(x => x.UsuarioResponsable);
                            break;
                        case "ConsultoraSaldo":
                            items = lst.OrderBy(x => x.ConsultoraSaldo);
                            break;
                        case "OrigenNombre":
                            items = lst.OrderBy(x => x.OrigenNombre);
                            break;
                        case "EstadoValidacionNombre":
                            items = lst.OrderBy(x => x.EstadoValidacionNombre);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NroRegistro":
                            items = lst.OrderByDescending(x => x.NroRegistro);
                            break;
                        case "FechaRegistro":
                            items = lst.OrderByDescending(x => x.FechaRegistro);
                            break;
                        case "CampaniaCodigo":
                            items = lst.OrderByDescending(x => x.CampaniaCodigo);
                            break;
                        case "Seccion":
                            items = lst.OrderByDescending(x => x.Seccion);
                            break;
                        case "ConsultoraCodigo":
                            items = lst.OrderByDescending(x => x.ConsultoraCodigo);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                        case "ImporteTotalConDescuento":
                            items = lst.OrderByDescending(x => x.ImporteTotalConDescuento);
                            break;
                        case "ConsultoraNombre":
                            items = lst.OrderByDescending(x => x.ConsultoraNombre);
                            break;
                        case "UsuarioResponsable":
                            items = lst.OrderByDescending(x => x.UsuarioResponsable);
                            break;
                        case "ConsultoraSaldo":
                            items = lst.OrderByDescending(x => x.ConsultoraSaldo);
                            break;
                        case "OrigenNombre":
                            items = lst.OrderByDescending(x => x.OrigenNombre);
                            break;
                        case "EstadoValidacionNombre":
                            items = lst.OrderByDescending(x => x.EstadoValidacionNombre);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               idCampania = a.CampaniaID.ToString(),
                               idPedido = a.PedidoID.ToString(),
                               cell = new string[] 
                               {
                                   //a.CampaniaID.ToString(),
                                   //a.PedidoID.ToString(),
                                   a.paisISO,
                                   a.NroRegistro.ToString(),
                                   a.FechaRegistro.ToString(),
                                   a.FechaReserva.HasValue ? a.FechaReserva.Value.ToString() : "",
                                   a.CampaniaCodigo.ToString(),
                                   a.Seccion.ToString(),
                                   a.Region,
                                   a.Zona,
                                   a.ConsultoraCodigo.ToString(),
                                   a.ConsultoraNombre.ToString(),
                                   a.PrimeraCampaniaCodigo,
                                   UserData().Simbolo + " " + ((UserData().PaisID == 4)? a.ImporteTotal.ToString("#,##0").Replace(',','.') : a.ImporteTotal.ToString("0.00")), // Validación país colombia req. 1478
                                   UserData().Simbolo + " " + ((UserData().PaisID == 4)? a.ImporteTotalConDescuento.ToString("#,##0").Replace(',','.') : a.ImporteTotalConDescuento.ToString("0.00")), // GR-846
                                   UserData().Simbolo + " " + ((UserData().PaisID == 4)? a.ConsultoraSaldo.ToString("#,##0").Replace(',','.') : a.ConsultoraSaldo.ToString("0.00")), // Validación país colombia req. 1478
                                   a.OrigenNombre.ToString(),
                                   a.EstadoValidacionNombre.ToString(),               
                                   a.IndicadorEnviado,
                                   a.TipoProceso,
                                   a.MotivoRechazo
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }
        public ActionResult ConsultarPedidosDDWebDetalle(string sidx, string sord, int page, int rows, string vPaisISO, string vCampania, string vConsultoraCodigo, string vTipoProceso)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoDDWebDetalle> lst = new List<BEPedidoDDWebDetalle>();

                //ServiceOSBBelcorp.BusinessService BusinessService = new BusinessService();
                //ServiceOSBBelcorp.pedidoWebAnteriorDetalleBean[] lista;
                PedidoBS BusinessService = new PedidoBS();
                ServiceOSBBelcorpPedido.pedidoWebAnteriorDetalleBean[] lista;

                string ISOWS = vPaisISO;

                //if (UserData().CodigoISO.Equals("PE"))
                //    ISOWS = "PE";
                //else if (UserData().CodigoISO.Equals("CL"))
                //    ISOWS = "CLE";
                //else if (UserData().CodigoISO.Equals("EC"))
                //    ISOWS = "ECL";

                if (vTipoProceso == "SRV")
                {
                    lista = BusinessService.obtenerPedidoWebAnteriorDetalle(vCampania, ISOWS, "0", "0", vConsultoraCodigo);
                    //lista = BusinessService.obtenerPedidoWebAnteriorDetalle("201303", "PE", "0", "0", "032054889");
                    //'201303','PE',0,0,'032054889'
                    if (lista == null)
                    {
                        lst = new List<BEPedidoDDWebDetalle>(); ;
                    }
                    else
                    {
                        lst = (from c in lista
                               where string.IsNullOrEmpty(c.descripcion.Trim()) == false
                               select new BEPedidoDDWebDetalle
                                    {
                                        CUV = c.cuv,
                                        Descripcion = c.descripcion,
                                        Cantidad = c.cantidad,
                                        PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                                        PrecioTotal = Convert.ToDecimal(c.importeTotal)
                                    }).ToList();

                        //foreach (var pedidoWebAnteriorDetalleBean in lista)
                        //{
                        //    lst.Add(new BEPedidoDDWebDetalle
                        //    {
                        //        CUV = pedidoWebAnteriorDetalleBean.cuv,
                        //        Descripcion = pedidoWebAnteriorDetalleBean.descripcion,
                        //        Cantidad = pedidoWebAnteriorDetalleBean.cantidad,
                        //        PrecioUnitario = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.precioUnidad),
                        //        PrecioTotal = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.importeTotal),
                        //    });
                        //}
                    }
                }
                else
                {
                    ISOWS = UserData().CodigoISO;
                    List<BEPedidoDDWebDetalle> lstPedidosDDWebNoFacturados;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lstPedidosDDWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(UserData().PaisID, ISOWS, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                    }

                    if (lstPedidosDDWebNoFacturados == null)
                    {
                        lst = new List<BEPedidoDDWebDetalle>(); ;
                    }
                    else
                    {
                        lst = (from c in lstPedidosDDWebNoFacturados
                               select new BEPedidoDDWebDetalle
                               {
                                   CUV = c.CUV,
                                   Descripcion = c.Descripcion,
                                   Cantidad = c.Cantidad,
                                   PrecioUnitario = c.PrecioUnitario,
                                   PrecioTotal = c.PrecioTotal
                               }).ToList();
                    }
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEPedidoDDWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;
                        case "PrecioUnitario":
                            items = lst.OrderBy(x => x.PrecioUnitario);
                            break;
                        case "PrecioTotal":
                            items = lst.OrderBy(x => x.PrecioTotal);
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
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;
                        case "PrecioUnitario":
                            items = lst.OrderByDescending(x => x.PrecioUnitario);
                            break;
                        case "PrecioTotal":
                            items = lst.OrderByDescending(x => x.PrecioTotal);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = PaginadorDetalle(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               cell = new string[] 
                               {
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.Cantidad.ToString("0.00"),
                                   UserData().Simbolo + " " + ((UserData().PaisID == 4) ? a.PrecioUnitario.ToString("#,##0").Replace(',','.') : a.PrecioUnitario.ToString("0.00")),
                                   UserData().Simbolo + " " + ((UserData().PaisID == 4) ? a.PrecioTotal.ToString("#,##0").Replace(',','.') : a.PrecioTotal.ToString("0.00"))
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }
        public ActionResult ExportarExcel(string vCampania, string vPaisISO, string vConsultoraCodigo, string vTipoProceso, string vMotivoRechazo)
        {

            List<BEPedidoDDWebDetalle> lst;

            PedidoBS BusinessService = new PedidoBS();
            ServiceOSBBelcorpPedido.pedidoWebAnteriorDetalleBean[] lista;
            string ISOWS = vPaisISO;

            //if (UserData().CodigoISO.Equals("PE"))
            //    ISOWS = "PE";
            //else if (UserData().CodigoISO.Equals("CL"))
            //    ISOWS = "CLE";
            //else if (UserData().CodigoISO.Equals("EC"))
            //    ISOWS = "ECL";

            lst = new List<BEPedidoDDWebDetalle>();

            if (vTipoProceso == "SRV")
            {
                lista = BusinessService.obtenerPedidoWebAnteriorDetalle(vCampania, ISOWS, "0", "0", vConsultoraCodigo);

                if (lista != null)
                {
                    lst = (from c in lista
                           where string.IsNullOrEmpty(c.descripcion.Trim()) == false
                           select new BEPedidoDDWebDetalle
                           {
                               CUV = c.cuv,
                               Descripcion = c.descripcion,
                               Cantidad = c.cantidad,
                               PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                               PrecioTotal = Convert.ToDecimal(c.importeTotal),
                               MotivoRechazo = vMotivoRechazo
                           }).ToList();

                    //foreach (var pedidoWebAnteriorDetalleBean in lista)
                    //{
                    //    lst.Add(new BEPedidoDDWebDetalle
                    //    {
                    //        CUV = pedidoWebAnteriorDetalleBean.cuv,
                    //        Descripcion = pedidoWebAnteriorDetalleBean.descripcion,
                    //        Cantidad = pedidoWebAnteriorDetalleBean.cantidad,
                    //        PrecioUnitario = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.precioUnidad),
                    //        PrecioTotal = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.importeTotal),
                    //    });
                    //}
                }
            }
            else
            {
                ISOWS = UserData().CodigoISO;
                List<BEPedidoDDWebDetalle> lstPedidosDDWebNoFacturados;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lstPedidosDDWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(UserData().PaisID, ISOWS, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                }

                lst = (from c in lstPedidosDDWebNoFacturados
                       select new BEPedidoDDWebDetalle
                       {
                           CUV = c.CUV,
                           Descripcion = c.Descripcion,
                           Cantidad = c.Cantidad,
                           PrecioUnitario = c.PrecioUnitario,
                           PrecioTotal = c.PrecioTotal,
                           MotivoRechazo = vMotivoRechazo
                       }).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Código Único de Venta", "CUV");
            dic.Add("Descripción", "Descripcion");
            dic.Add("Cantidad", "Cantidad");
            dic.Add("Precio Unitario", "PrecioUnitario");
            dic.Add("Precio Total", "PrecioTotal");
            dic.Add("MotivoRechazo", "MotivoRechazo");

            ExportToExcelDetallePedido("exportar", lst, dic, "DescargaCompleta", "1");
            return View();
        }
        public ActionResult ExportarExcelDetallePedido(string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {
            List<BEPedidoDDWeb> lst = new List<BEPedidoDDWeb>();

            if (vRegionID == "" || vRegionID == "-- Todas --") vRegionID = "0";
            if (vZonaID == "" || vZonaID == "-- Todas --") vZonaID = "0";
            if (vConsultora == "") vConsultora = "0";

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                string paisISO = Util.GetPaisISO(int.Parse(vPaisID));
                lst = sv.GetPedidosWebDDDetalleConsultora(
                    new BEPedidoDDWeb
                    {
                        paisID = Convert.ToInt32(vPaisID),
                        paisISO = paisISO,
                        CampaniaID = Convert.ToInt32(vCampania),
                        RegionCodigo = vRegionID,
                        ZonaCodigo = vZonaID,
                        Origen = Convert.ToInt32(vOrigen),
                        ConsultoraCodigo = (string.IsNullOrEmpty(vConsultora) || vConsultora == "0" ? string.Empty : vConsultora),
                        EstadoValidacion = int.Parse(vEstadoValidacion),
                        EsRechazado = int.Parse(vEsRechazado)
                    }).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Región", "RegionCodigo");
            dic.Add("Zona", "Zona");
            dic.Add("Cod. Consultora", "ConsultoraCodigo");
            dic.Add("CUV", "CUV");
            dic.Add("Cantidad", "Cantidad");

            Util.ExportToExcel("PedidoDetalleConsultora", lst, dic, "DescargaCompleta", "1");
            return View();
        }

        public ActionResult ExportarExcelCabecera(string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {

            List<BEPedidoDDWeb> lst = new List<BEPedidoDDWeb>();
            BEPais bepais = new BEPais();

            //ServiceOSBBelcorp.BusinessService BusinessService = new BusinessService();
            PedidoBS BusinessService = new PedidoBS();

            if (vPaisID == "")
            {
                bepais.CodigoISO = "";
            }
            else
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                }
            }
            if (vRegionID == "" || vRegionID == "-- Todas --") vRegionID = "0";
            if (vZonaID == "" || vZonaID == "-- Todas --") vZonaID = "0";
            if (vConsultora == "") vConsultora = "0";

            string ISOWS = bepais.CodigoISO;

            // Valida los pedidos No Facturados

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetPedidosWebDDNoFacturados(
                        new BEPedidoDDWeb
                        {
                            paisID = Convert.ToInt32(vPaisID),
                            paisISO = ISOWS,
                            CampaniaID = Convert.ToInt32(vCampania),
                            RegionCodigo = vRegionID,
                            ZonaCodigo = vZonaID,
                            Origen = Convert.ToInt32(vOrigen),
                            ConsultoraCodigo = (string.IsNullOrEmpty(vConsultora) || vConsultora == "0" ? string.Empty : vConsultora),
                            EstadoValidacion = int.Parse(vEstadoValidacion),
                            EsRechazado = int.Parse(vEsRechazado)
                        }).ToList();
                }
            }
            catch (Exception ex)
            {
                lst = new List<BEPedidoDDWeb>();
            }

            if (lst.Count != 0)
            {
                int fila = 1;
                List<BEPedidoDDWeb> temp = new List<BEPedidoDDWeb>();

                foreach (var item in lst)
                {
                    temp.Add(new BEPedidoDDWeb
                    {
                        NroRegistro = fila.ToString(),
                        FechaRegistro = item.FechaRegistro,
                        FechaReserva = item.FechaReserva,
                        CampaniaCodigo = item.CampaniaCodigo,
                        Seccion = item.Seccion,
                        ConsultoraCodigo = item.ConsultoraCodigo,
                        ConsultoraNombre = item.ConsultoraNombre,
                        PrimeraCampaniaCodigo = item.PrimeraCampaniaCodigo,  // 1630
                        ImporteTotal = item.ImporteTotal,
                        ImporteTotalConDescuento = item.ImporteTotalConDescuento,
                        UsuarioResponsable = item.UsuarioResponsable,
                        ConsultoraSaldo = item.ConsultoraSaldo,
                        OrigenNombre = item.OrigenNombre,
                        EstadoValidacionNombre = item.EstadoValidacionNombre,
                        paisISO = ISOWS,
                        TipoProceso = item.OrigenNombre,
                        Zona = item.Zona,
                        IndicadorEnviado = item.IndicadorEnviado,
                        Region = item.Region, // 2446
                        MotivoRechazo = item.MotivoRechazo
                    });
                    fila = fila + 1;
                }
                lst = temp;
            }

            // 2446 - Inicio
            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("NroRegistro", "Nro. Registro,");
            dic.Add("FechaRegistro", "Fecha/Hora Ingreso,");
            dic.Add("FechaReserva", "Fecha Reserva,");
            dic.Add("CampaniaCodigo", "Año/Campaña,");
            dic.Add("Seccion", "Sección,");
            dic.Add("Region", "Región,");
            dic.Add("Zona", "Zona,");
            dic.Add("ConsultoraCodigo", "Cod. Consultora,");
            dic.Add("ConsultoraNombre", "Nombre Consultora,");
            if (UserData().PaisID == 9)
            {
                dic.Add("PrimeraCampaniaCodigo", "Campaña de 1er Pedido,"); // 1630
            }
            dic.Add("ImporteTotal", "Monto Total Pedido,");
            dic.Add("ImporteTotalConDescuento", "Monto Total Pedido con Descuento,");
            dic.Add("ConsultoraSaldo", "Saldo,");
            dic.Add("OrigenNombre", "Origen,");
            dic.Add("EstadoValidacionNombre", "Validado,");
            dic.Add("IndicadorEnviado", "Estado,");
            dic.Add("MotivoRechazo", "Motivo Rechazo");

            var lista = from a in lst
                        select new
                        {
                            a.NroRegistro,
                            a.FechaRegistro,
                            a.FechaReserva,
                            a.CampaniaCodigo,
                            a.Seccion,
                            a.Region,
                            a.Zona,
                            a.ConsultoraCodigo,
                            a.ConsultoraNombre,
                            a.PrimeraCampaniaCodigo,
                            ImporteTotal = UserData().Simbolo + " " + ((UserData().PaisID == 4) ? a.ImporteTotal.ToString("#,##0").Replace(',', '.') : a.ImporteTotal.ToString("0.00")),
                            ImporteTotalConDescuento = UserData().Simbolo + " " + ((UserData().PaisID == 4) ? a.ImporteTotalConDescuento.ToString("#,##0").Replace(',', '.') : a.ImporteTotalConDescuento.ToString("0.00")),
                            ConsultoraSaldo = UserData().Simbolo + " " + ((UserData().PaisID == 4) ? a.ConsultoraSaldo.ToString("#,##0").Replace(',', '.') : a.ConsultoraSaldo.ToString("0.00")),
                            a.OrigenNombre,
                            a.EstadoValidacionNombre,
                            a.IndicadorEnviado,
                            a.MotivoRechazo
                        };

            ExportToCSV("exportar", lista.ToList(), dic, "DescargaCompleta", "1");            
            // 2446 - Fin
            return View();
        }

        public bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    //Establece las columnas
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    Columns.Add(keyvalue.Value);
                }
                int row = 2;
                int col = 0;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    col = 1;
                    foreach (string column in Columns)
                    {
                        //Establece el valor para esa columna
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";


                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");
                //ws.Row(1).Style.Font.Bold = true;
                //ws.Row(1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //ws.Row(1).Style.Fill.BackgroundColor = XLColor.Aquamarine;

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;
                //ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool ExportToExcelCO<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    //Establece las columnas
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    Columns.Add(keyvalue.Value);
                }
                int row = 2;
                int col = 0;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    col = 1;
                    foreach (string column in Columns)
                    {
                        //Establece el valor para esa columna
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";

                                    // validación pais colombia req. 1478
                                    if (col == 9 || col == 10)
                                    {
                                        string valorDecimal = Convert.ToDecimal(System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null)).ToString("#,##0").Replace(',', '.');
                                        ws.Cell(row, col).Value = valorDecimal;
                                    }
                                    else
                                    {
                                        ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    }

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");
                //ws.Row(1).Style.Font.Bold = true;
                //ws.Row(1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //ws.Row(1).Style.Fill.BackgroundColor = XLColor.Aquamarine;

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;
                //ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool ExportToExcelDetallePedido<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    //Establece las columnas
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    Columns.Add(keyvalue.Value);
                }
                int row = 2;
                int col = 0;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    col = 1;
                    foreach (string column in Columns)
                    {
                        //Establece el valor para esa columna
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";

                                    if (UserData().PaisID == 4)
                                    { // validación pais colombia req. 1478
                                        if (col == 4 || col == 5)
                                        {
                                            string valorDecimal = Convert.ToDecimal(System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null)).ToString("#,##0").Replace(',', '.');
                                            ws.Cell(row, col).Value = valorDecimal;
                                        }
                                        else
                                        {
                                            ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                        }
                                    }
                                    else
                                    {
                                        ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    }
                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");
                //ws.Row(1).Style.Font.Bold = true;
                //ws.Row(1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //ws.Row(1).Style.Fill.BackgroundColor = XLColor.Aquamarine;

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;
                //ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public JsonResult SelectConsultora(string codigo, int rowCount)
        {
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                BEConsultoraCodigo[] beconsultora = sv.SelectConsultoraCodigo_A(UserData().PaisID, codigo, rowCount);
                return Json(beconsultora, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ExportarPDF(string vPaisISO, string vCampaniaCod, string vConsultoraCod, string vConsultoraNombre,
                                        string vUsuarioNombre, string vOrigen, string vValidado, string vSaldo, string vImporte, string vImporteConDescuento,
                                        string vpage, string vsortname, string vsortorder, string vrowNum, string vUsuario, string vTipoProceso, string vMotivoRechazo)
        {
            string[] lista = new string[21];

            Session["PaisID"] = UserData().PaisID;

            lista[0] = vPaisISO; lista[1] = vCampaniaCod; lista[2] = vConsultoraCod; lista[3] = vConsultoraNombre;
            lista[4] = vUsuarioNombre; lista[5] = vOrigen; lista[6] = vValidado; lista[7] = vSaldo;
            lista[8] = vImporte; lista[9] = vImporteConDescuento; lista[10] = vpage; lista[11] = vsortname; lista[12] = vsortorder;
            lista[13] = vrowNum; lista[14] = vUsuario; lista[15] = UserData().Simbolo; lista[16] = UserData().BanderaImagen;
            lista[17] = UserData().NombrePais; lista[18] = vTipoProceso; lista[19] = UserData().PaisID.ToString(); lista[20] = vMotivoRechazo;

            Util.ExportToPdfWebPages(this, "PedidoDDWeb.pdf", "ReportePedidoDDWebDetalleImp", Util.EncriptarQueryString(lista));
            return View();
        }

        #endregion

        #region Metodos

        public List<BECampania> CargarCampania()
        {
            var model = new ReportePedidoDDWebModel();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                BECampania[] becampania = sv.SelectCampanias(UserData().PaisID);

                model.DropDownListCampania = becampania.ToList();
                model.DropDownListCampania.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
                return model.DropDownListCampania;
            }
        }
        public List<BEZona> CargarZona()
        {
            var model = new ReportePedidoDDWebModel();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                BEZona[] bezona = sv.SelectAllZonas(UserData().PaisID);

                model.DropDownListZona = bezona.ToList();
                model.DropDownListZona.Insert(0, new BEZona { ZonaID = 0, Codigo = "-- Todas --" });
                return model.DropDownListZona;
            }
        }
        public JsonResult ObtenterCampaniasyZonasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);
            IEnumerable<RegionModel> lstRegiones = DropDownListRegiones(PaisID);

            return Json(new
            {
                DropDownListCampania = lst,
                DropDownListZona = lstZonas.OrderBy(p => p.Codigo),
                DropDownListRegion = lstRegiones.OrderBy(p => p.Codigo),
            }, JsonRequestBehavior.AllowGet);
        }

        public BEPager Paginador(BEGrid item, List<BEPedidoDDWeb> lst)
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
        public BEPager PaginadorDetalle(BEGrid item, List<BEPedidoDDWebDetalle> lst)
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }
        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        #endregion


        // 2446 - Inicio
        public bool ExportToCSV<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".csv";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;
                string nombreCabecera = "";
                string cabecera = "";
                string nombre = originalFileName; // +"-" + DateTime.Now.ToString("yyyyMMdd-hhmmss") + ".csv";
                var sw = new StringWriter();

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    //Establece las columnas
                    nombreCabecera += keyvalue.Key + ",";
                    cabecera += keyvalue.Value;
                }
                string csv = CreateCSVTextFile(nombreCabecera, Source);
                sw.WriteLine(cabecera);
                sw.Write(csv);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-Disposition", "attachment; filename=" + nombre);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "text/csv";
                HttpContext.Response.Write(sw);
                HttpContext.Response.Flush();
                HttpContext.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private static string CreateCSVTextFile<T>(string nombreCabecera, List<T> data)
        {
            PropertyInfo[] properties = typeof(T).GetProperties();
            StringBuilder result = new StringBuilder();

            foreach (var row in data)
            {
                var values = properties.Where(x => nombreCabecera.Contains(x.Name))
                                       .Select(p => p.GetValue(row, null))
                                       .Select(v => StringToCSVCell(Convert.ToString(v)));
                var line = string.Join(",", values);
                result.AppendLine(line);
            }

            return result.ToString();
        }

        private static string StringToCSVCell(string str)
        {
            bool mustQuote = (str.Contains(",") || str.Contains("\"") || str.Contains("\r") || str.Contains("\n"));
            if (mustQuote)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("\"");
                foreach (char nextChar in str)
                {
                    sb.Append(nextChar);
                    if (nextChar == '"')
                        sb.Append("\"");
                }
                sb.Append("\"");
                return sb.ToString();
            }

            return str;
        }
        // 2446 - Fin

    }
}
