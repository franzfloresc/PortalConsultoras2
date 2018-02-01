using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var model = new ReportePedidoDDWebModel
            {
                DropDownListCampania = new List<BECampania>(),
                DropDownListZona = new List<BEZona>(),
                DropDownListRegion = new List<BERegion>(),
                listaPaises = DropDowListPaises(),
                hdnpaisISO = userData.CodigoISO
            };
            ViewBag.PaisOcultoID = userData.PaisID;
            return View(model);
        }
        public ActionResult ReportePedidosDDWebDetalle()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("ReportePedidosDDWeb");

            var serializer = new JavaScriptSerializer();
            var data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            var model = new ReportePedidoDDWebModel
            {
                lblCampaniaCod = data["CampaniaCod"].ToString(),
                lblConsultoraCod = data["ConsultoraCod"].ToString(),
                lblConsultoraNombre = data["ConsultoraNombre"].ToString(),
                lblUsuarioNombre = data["UsuarioNombre"].ToString(),
                lblOrigen = data["Origen"].ToString(),
                lblValidado = data["Validado"].ToString(),
                lblSaldo = data["Saldo"].ToString(),
                lblImporte = data["Importe"].ToString(),
                lblImporteConDescuento = data["ImporteConDescuento"].ToString(),
                hdnpaisISO = data["paisISO"].ToString(),
                Usuario = Convert.ToString(data["Usuario"]),
                TipoProceso = data["TipoProceso"].ToString(),
                MotivoRechazo = data["MotivoRechazo"].ToString()
            };

            return View(model);
        }
        public ActionResult ReportePedidosDDWebDetalleImp(string parametros)
        {
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(';');

            var model = new ReportePedidoDDWebModel
            {
                hdnpaisISO = lista[0],
                lblCampaniaCod = lista[1],
                lblConsultoraCod = lista[2],
                lblConsultoraNombre = lista[3],
                lblUsuarioNombre = lista[4],
                lblOrigen = lista[5],
                lblValidado = lista[6],
                lblSaldo = lista[7],
                lblImporte = lista[8],
                vpage = lista[9],
                vsortname = lista[10],
                vsortorder = lista[11],
                vrowNum = lista[12],
                Usuario = lista[13],
                TipoProceso = lista[17],
                MotivoRechazo = lista[18]
            };

            return View(model);
        }
        public ActionResult ConsultarPedidosDDWeb(string sidx, string sord, int page, int rows, string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {
            if (ModelState.IsValid)
            {
                ViewBag.PaisOcultoID = userData.PaisID;

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

                List<BEPedidoDDWeb> lst;
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

                string isoWs = bepais.CodigoISO;

                try
                {
                    if (Session["PedidosWebDD"] == null)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            ((BasicHttpBinding)sv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;
                            lst = sv.GetPedidosWebDDNoFacturados(
                                new BEPedidoDDWeb
                                {
                                    paisID = Convert.ToInt32(vPaisID),
                                    paisISO = isoWs,
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
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                            paisISO = isoWs,
                            TipoProceso = item.OrigenNombre,
                            Zona = item.Zona,
                            IndicadorEnviado = item.IndicadorEnviado,
                            PrimeraCampaniaCodigo = item.PrimeraCampaniaCodigo,
                            Region = item.Region,
                            DocumentoIdentidad = item.DocumentoIdentidad,
                            MotivoRechazo = string.IsNullOrEmpty(item.MotivoRechazo) ? " " : item.MotivoRechazo
                        });
                        fila = fila + 1;
                    }
                    lst = temp;
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEPedidoDDWeb> items = lst;

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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, lst);

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
                                   a.paisISO,
                                   a.NroRegistro,
                                   a.FechaRegistro.ToString(),
                                   a.FechaReserva.HasValue ? a.FechaReserva.Value.ToString() : "",
                                   a.CampaniaCodigo,
                                   a.Region,
                                   a.Zona,
                                   a.Seccion,
                                   a.ConsultoraCodigo,
                                   a.ConsultoraNombre,
                                   a.DocumentoIdentidad,
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.ImporteTotal.ToString("#,##0").Replace(',','.') : a.ImporteTotal.ToString("0.00")),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.ImporteTotalConDescuento.ToString("#,##0").Replace(',','.') : a.ImporteTotalConDescuento.ToString("0.00")),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.ConsultoraSaldo.ToString("#,##0").Replace(',','.') : a.ConsultoraSaldo.ToString("0.00")),
                                   a.OrigenNombre,
                                   a.EstadoValidacionNombre,
                                   a.IndicadorEnviado,
                                   a.TipoProceso,
                                   FomatearMontoDecimalGPR(a.MotivoRechazo)
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        private string FomatearMontoDecimalGPR(string motivoRechazo)
        {
            var txtBuil = new StringBuilder();
            string[] motivos = motivoRechazo.Split(',');

            foreach (string item in motivos)
            {
                var motivoItem = item;
                if (motivoItem.Contains(':') && userData.CodigoISO.Equals(Constantes.CodigosISOPais.Colombia))
                {
                    decimal montoDecimal = Convert.ToDecimal(motivoItem.Substring(motivoItem.IndexOf(':') + 1).Replace(" ", string.Empty));

                    motivoItem = motivoItem.Remove(motivoItem.IndexOf(':'));
                    txtBuil.Append(string.Format("{0}: {1}", motivoItem, (userData.PaisID == 4) ? montoDecimal.ToString("#,##0").Replace(',', '.') : montoDecimal.ToString("0.00")));
                }
            }

            string textoDecimal = txtBuil.ToString();
            return string.IsNullOrEmpty(textoDecimal) ? motivoRechazo : textoDecimal;
        }

        public ActionResult ConsultarPedidosDDWebDetalle(string sidx, string sord, int page, int rows, string vPaisISO, string vCampania, string vConsultoraCodigo, string vTipoProceso)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoDDWebDetalle> lst;

                PedidoBS businessService = new PedidoBS();

                string isoWs = vPaisISO;

                if (vTipoProceso == "SRV")
                {
                    var lista = businessService.obtenerPedidoWebAnteriorDetalle(vCampania, isoWs, "0", "0", vConsultoraCodigo);
                    if (lista == null)
                    {
                        lst = new List<BEPedidoDDWebDetalle>();
                    }
                    else
                    {
                        lst = (from c in lista
                               where !string.IsNullOrEmpty(c.descripcion.Trim())
                               select new BEPedidoDDWebDetalle
                               {
                                   CUV = c.cuv,
                                   Descripcion = c.descripcion,
                                   Cantidad = c.cantidad,
                                   PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                                   PrecioTotal = Convert.ToDecimal(c.importeTotal)
                               }).ToList();

                    }
                }
                else
                {
                    isoWs = userData.CodigoISO;
                    List<BEPedidoDDWebDetalle> lstPedidosDdWebNoFacturados;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lstPedidosDdWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(userData.PaisID, isoWs, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                    }
                    
                    lst = (from c in lstPedidosDdWebNoFacturados
                        select new BEPedidoDDWebDetalle
                        {
                            CUV = c.CUV,
                            Descripcion = c.Descripcion,
                            Cantidad = c.Cantidad,
                            PrecioUnitario = c.PrecioUnitario,
                            PrecioTotal = c.PrecioTotal
                        }).ToList();
                    
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = PaginadorDetalle(grid, lst);

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
                                   a.CUV,
                                   a.Descripcion,
                                   a.Cantidad.ToString("0.00"),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.PrecioUnitario.ToString("#,##0").Replace(',','.') : a.PrecioUnitario.ToString("0.00")),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.PrecioTotal.ToString("#,##0").Replace(',','.') : a.PrecioTotal.ToString("0.00"))
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ExportarExcel(string vCampania, string vPaisISO, string vConsultoraCodigo, string vTipoProceso, string vMotivoRechazo)
        {
            var lst = new List<BEPedidoDDWebDetalle>();

            PedidoBS businessService = new PedidoBS();
            string isoWs = vPaisISO;


            if (vTipoProceso == "SRV")
            {
                var lista = businessService.obtenerPedidoWebAnteriorDetalle(vCampania, isoWs, "0", "0", vConsultoraCodigo);

                if (lista != null)
                {
                    lst = (from c in lista
                           where !string.IsNullOrEmpty(c.descripcion.Trim())
                           select new BEPedidoDDWebDetalle
                           {
                               CUV = c.cuv,
                               Descripcion = c.descripcion,
                               Cantidad = c.cantidad,
                               PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                               PrecioTotal = Convert.ToDecimal(c.importeTotal),
                               MotivoRechazo = vMotivoRechazo
                           }).ToList();
                }
            }
            else
            {
                isoWs = userData.CodigoISO;
                List<BEPedidoDDWebDetalle> lstPedidosDdWebNoFacturados;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lstPedidosDdWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(userData.PaisID, isoWs, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                }

                lst = (from c in lstPedidosDdWebNoFacturados
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

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Código Único de Venta", "CUV"},
                {"Descripción", "Descripcion"},
                {"Cantidad", "Cantidad"},
                {"Precio Unitario", "PrecioUnitario"},
                {"Precio Total", "PrecioTotal"},
                {"MotivoRechazo", "MotivoRechazo"}
            };


            ExportToExcelDetallePedido("exportar", lst, dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public ActionResult ExportarExcelDetallePedido(string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {
            List<BEPedidoDDWeb> lst;

            if (vRegionID == "" || vRegionID == "-- Todas --") vRegionID = "0";
            if (vZonaID == "" || vZonaID == "-- Todas --") vZonaID = "0";
            if (vConsultora == "") vConsultora = "0";

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                string paisIso = Util.GetPaisISO(int.Parse(vPaisID));
                lst = sv.GetPedidosWebDDDetalleConsultora(
                    new BEPedidoDDWeb
                    {
                        paisID = Convert.ToInt32(vPaisID),
                        paisISO = paisIso,
                        CampaniaID = Convert.ToInt32(vCampania),
                        RegionCodigo = vRegionID,
                        ZonaCodigo = vZonaID,
                        Origen = Convert.ToInt32(vOrigen),
                        ConsultoraCodigo = (string.IsNullOrEmpty(vConsultora) || vConsultora == "0" ? string.Empty : vConsultora),
                        EstadoValidacion = int.Parse(vEstadoValidacion),
                        EsRechazado = int.Parse(vEsRechazado)
                    }).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Región", "RegionCodigo"},
                {"Zona", "Zona"},
                {"Cod. Consultora", "ConsultoraCodigo"},
                {"CUV", "CUV"},
                {"Cantidad", "Cantidad"}
            };


            Util.ExportToExcel("PedidoDetalleConsultora", lst, dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public ActionResult ExportarExcelCabecera(string vPaisID, string vCampania, string vConsultora, string vRegionID, string vZonaID, string vOrigen, string vEstadoValidacion, string vEsRechazado)
        {

            List<BEPedidoDDWeb> lst;
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

            string isoWs = bepais.CodigoISO;

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    ((BasicHttpBinding)sv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;
                    lst = sv.GetPedidosWebDDNoFacturados(
                        new BEPedidoDDWeb
                        {
                            paisID = Convert.ToInt32(vPaisID),
                            paisISO = isoWs,
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lst = new List<BEPedidoDDWeb>();
            }

            if (lst.Count != 0)
            {
                int fila = 1;
                var temp = new List<BEPedidoDDWeb>();

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
                        PrimeraCampaniaCodigo = item.PrimeraCampaniaCodigo,
                        ImporteTotal = item.ImporteTotal,
                        ImporteTotalConDescuento = item.ImporteTotalConDescuento,
                        UsuarioResponsable = item.UsuarioResponsable,
                        ConsultoraSaldo = item.ConsultoraSaldo,
                        OrigenNombre = item.OrigenNombre,
                        EstadoValidacionNombre = item.EstadoValidacionNombre,
                        paisISO = isoWs,
                        TipoProceso = item.OrigenNombre,
                        Zona = item.Zona,
                        IndicadorEnviado = item.IndicadorEnviado,
                        Region = item.Region,
                        MotivoRechazo = item.MotivoRechazo,
                        DocumentoIdentidad = item.DocumentoIdentidad,
                    });
                    fila = fila + 1;
                }
                lst = temp;
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"NroRegistro", "Nro. Registro,"},
                {"FechaRegistro", "Fecha/Hora Ingreso,"},
                {"FechaReserva", "Fecha Reserva,"},
                {"CampaniaCodigo", "Año/Campaña,"},
                {"Region", "Región,"},
                {"Zona", "Zona,"},
                {"Seccion", "Sección,"},
                {"ConsultoraCodigo", "Cod. Consultora,"},
                {"ConsultoraNombre", "Nombre Consultora,"},
                {"DocumentoIdentidad", "Documento Identidad,"},
                {"ImporteTotal", "Monto Total Pedido,"},
                {"ImporteTotalConDescuento", "Monto Total Pedido con Descuento,"},
                {"ConsultoraSaldo", "Saldo,"},
                {"OrigenNombre", "Origen,"},
                {"EstadoValidacionNombre", "Validado,"},
                {"IndicadorEnviado", "Estado,"},
                {"MotivoRechazo", "Motivo de Rechazo"}
            };


            var lista = from a in lst
                        select new
                        {
                            a.NroRegistro,
                            a.FechaRegistro,
                            a.FechaReserva,
                            a.CampaniaCodigo,
                            a.Region,
                            a.Zona,
                            a.Seccion,
                            a.ConsultoraCodigo,
                            a.ConsultoraNombre,
                            a.DocumentoIdentidad,
                            ImporteTotal = userData.Simbolo + " " + (userData.PaisID == 4 ? a.ImporteTotal.ToString("#,##0").Replace(',', '.') : a.ImporteTotal.ToString("0.00")),
                            ImporteTotalConDescuento = userData.Simbolo + " " + (userData.PaisID == 4 ? a.ImporteTotalConDescuento.ToString("#,##0").Replace(',', '.') : a.ImporteTotalConDescuento.ToString("0.00")),
                            ConsultoraSaldo = userData.Simbolo + " " + (userData.PaisID == 4 ? a.ConsultoraSaldo.ToString("#,##0").Replace(',', '.') : a.ConsultoraSaldo.ToString("0.00")),
                            a.OrigenNombre,
                            a.EstadoValidacionNombre,
                            a.IndicadorEnviado,
                            MotivoRechazo = string.IsNullOrEmpty(a.MotivoRechazo) ? "" : a.MotivoRechazo.Replace(",", ";")
                        };

            ExportToCSV("exportar", lista.ToList(), dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
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

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
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

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
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

                                    if (userData.PaisID == 4)
                                    {
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

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        public JsonResult SelectConsultora(string codigo, int rowCount)
        {
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                BEConsultoraCodigo[] beconsultora = sv.SelectConsultoraCodigo_A(userData.PaisID, codigo, rowCount);
                return Json(beconsultora, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ExportarPDF(string vPaisISO, string vCampaniaCod, string vConsultoraCod, string vConsultoraNombre,
                                        string vUsuarioNombre, string vOrigen, string vValidado, string vSaldo, string vImporte, string vImporteConDescuento,
                                        string vpage, string vsortname, string vsortorder, string vrowNum, string vUsuario, string vTipoProceso, string vMotivoRechazo)
        {
            string[] lista = new string[21];

            Session["PaisID"] = userData.PaisID;

            lista[0] = vPaisISO; lista[1] = vCampaniaCod; lista[2] = vConsultoraCod; lista[3] = vConsultoraNombre;
            lista[4] = vUsuarioNombre; lista[5] = vOrigen; lista[6] = vValidado; lista[7] = vSaldo;
            lista[8] = vImporte; lista[9] = vImporteConDescuento; lista[10] = vpage; lista[11] = vsortname; lista[12] = vsortorder;
            lista[13] = vrowNum; lista[14] = vUsuario; lista[15] = userData.Simbolo; lista[16] = userData.BanderaImagen;
            lista[17] = userData.NombrePais; lista[18] = vTipoProceso; lista[19] = userData.PaisID.ToString(); lista[20] = vMotivoRechazo;

            Util.ExportToPdfWebPages(this, "PedidoDDWeb.pdf", "ReportePedidoDDWebDetalleImp", Util.EncriptarQueryString(lista));
            return new EmptyResult();
        }

        #endregion

        #region Metodos

        public List<BECampania> CargarCampania()
        {
            var model = new ReportePedidoDDWebModel();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                BECampania[] becampania = sv.SelectCampanias(userData.PaisID);

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
                BEZona[] bezona = sv.SelectAllZonas(userData.PaisID);

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
        public BEPager PaginadorDetalle(BEGrid item, List<BEPedidoDDWebDetalle> lst)
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> {sv.SelectPais(userData.PaisID)};
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        #endregion


        public bool ExportToCSV<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".csv";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;
                
                string nombre = originalFileName;
                var sw = new StringWriter();

                var txtBuilNombre = new StringBuilder();
                var txtBuilCabecera = new StringBuilder();
                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    txtBuilNombre.Append(keyvalue.Key + ",");
                    txtBuilCabecera.Append(keyvalue.Value);
                }
                string csv = CreateCSVTextFile(txtBuilNombre.ToString(), Source);
                sw.WriteLine(txtBuilCabecera.ToString());
                sw.Write(csv);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-Disposition", "attachment; filename=" + nombre);
                var isoEncoding = Encoding.GetEncoding("iso-8859-1");
                HttpContext.Response.Charset = isoEncoding.WebName;
                HttpContext.Response.ContentEncoding = isoEncoding;
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "text/csv";
                HttpContext.Response.Write(sw);
                HttpContext.Response.Flush();
                HttpContext.Response.End();

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

    }
}
