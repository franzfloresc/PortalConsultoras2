using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstadoCuentaController : BaseMobileController
    {
        protected EstadoCuentaProvider _estadoCuentaProvider;

        public EstadoCuentaController()
        {
            _estadoCuentaProvider = new EstadoCuentaProvider();
        }

        #region Acciones

        public ActionResult Index()
        {
            var userData = UserData();
            var model = new EstadoCuentaMobilModel();
            try
            {
                model.Simbolo = userData.Simbolo;
                model.CorreoConsultora = userData.EMail;
                model.ListaEstadoCuentaDetalle = new List<EstadoCuentaDetalleMobilModel>();

                var lstEstadoCuenta = EstadodeCuenta();
                if (lstEstadoCuenta.Count > 0) lstEstadoCuenta.RemoveAt(lstEstadoCuenta.Count - 1);
                foreach (var item in lstEstadoCuenta)
                {
                    model.ListaEstadoCuentaDetalle.Add(
                        new EstadoCuentaDetalleMobilModel
                        {
                            Glosa = item.Glosa,
                            FechaVencimiento = item.Fecha.ToString("dd/MM/yyyy"),
                            FechaVencimientoFormatDiaMes = Util.ObtenerFormatoDiaMes(item.Fecha),
                            TipoMovimiento = item.Abono > 0
                                ? Constantes.EstadoCuentaTipoMovimiento.Abono
                                : item.Cargo > 0
                                    ? Constantes.EstadoCuentaTipoMovimiento.Cargo
                                    : 0,
                            MontoStr = Util.DecimalToStringFormat(item.Abono > 0 ? item.Abono : item.Cargo, userData.CodigoISO),
                            Fecha = item.Fecha
                        });
                }

                model.UltimoMovimiento = _estadoCuentaProvider.ObtenerUltimoMovimientoEstadoCuenta(userData.PaisID, userData.TienePagoEnLinea, userData.ConsultoraID, userData.ZonaHoraria, userData.Simbolo, userData.CodigoISO);

                model.FechaVencimiento = userData.FechaLimPago.ToString("dd/MM/yyyy");
                model.MontoPagarStr = Util.DecimalToStringFormat(userData.MontoDeuda, userData.CodigoISO);

                if (model.ListaEstadoCuentaDetalle.Count == 0)
                {
                    model.MontoStr = Util.DecimalToStringFormat(0, userData.CodigoISO);
                    model.MontoPagarStr = Util.DecimalToStringFormat(0, userData.CodigoISO);
                }
                else
                {
                    model.ListaEstadoCuentaDetalle = model.ListaEstadoCuentaDetalle.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

                    model.FechaVencimiento = userData.FechaLimPago.ToString("dd/MM/yyyy");
                    model.MontoPagarStr = Util.DecimalToStringFormat(userData.MontoDeuda, userData.CodigoISO);
                }

                model.TienePagoEnLinea = userData.TienePagoEnLinea;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        public JsonResult EnviarCorreo(string correo)
        {
            var userData = UserData();
            try
            {
                var lstEstadoCuenta = EstadodeCuenta();

                if (lstEstadoCuenta.Count != 0)
                {
                    lstEstadoCuenta.RemoveAt(lstEstadoCuenta.Count - 1);
                }

                lstEstadoCuenta.ForEach(l =>
                {
                    if (l.Cargo > 0)
                    {
                        l.TipoMovimiento = 1;
                    }
                    if (l.Abono > 0)
                    {
                        l.TipoMovimiento = 2;
                    }
                });

                lstEstadoCuenta = lstEstadoCuenta.OrderByDescending(x => x.Fecha).ThenBy(x => x.TipoMovimiento).ToList();

                var contenido = ConstruirContenidoCorreo(lstEstadoCuenta);

                Util.EnviarMailMobile("no-responder@somosbelcorp.com", correo, "(" + userData.CodigoISO + ") Estado de Cuenta", contenido, true, userData.NombreConsultora);

                return Json(new
                {
                    success = true,
                    message = "El correo se envió de forma correcta a la cuenta: " + correo
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
        }

        #endregion

        #region Metodos

        private List<EstadoCuentaModel> EstadodeCuenta()
        {
            var listSession = ObtenerEstadoCuenta();
            var list = new List<EstadoCuentaModel>();

            listSession.ForEach((item) =>
            {
                list.Add(new EstadoCuentaModel
                {
                    Abono = item.Abono,
                    Cargo = item.Cargo,
                    CorreoConsultora = item.CorreoConsultora,
                    Fecha = item.Fecha,
                    FechaVencimiento = item.FechaVencimiento,
                    Glosa = item.Glosa,
                    MontoPagar = item.MontoPagar,
                    Simbolo = item.Simbolo,
                    TipoMovimiento = item.TipoMovimiento
                });
            });
            return list;
        }

        private string ConstruirContenidoCorreo(List<EstadoCuentaModel> lst)
        {
            var userData = UserData();

            var txtBuil = new StringBuilder();

            txtBuil.Append(
                        "<h2> Estado de cuenta </h2>" +
                        "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                            "<tr>" +
                                "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                                "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                                "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                                "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                            "</tr>"
                          );

            if (userData.PaisID == 4 && lst.Any())
            {
                for (int i = 0; i < lst.Count - 1; i++)
                {
                    txtBuil.Append(
                            "<tr>" +
                                "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                "<td align='left'>" + lst[i].Glosa + "</td>" +
                                "<td align='right'>" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].Cargo).Replace(',', '.') + "</td>" +
                                "<td align='right'>" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].Abono).Replace(',', '.') + "</td>" +
                            "</tr>"
                            );
                }
            }
            else
            {
                if (lst.Any())
                {
                    for (int i = 0; i < lst.Count - 1; i++)
                    {
                        txtBuil.Append(
                                "<tr>" +
                                    "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                    "<td align='left'>" + lst[i].Glosa + "</td>" +
                                    "<td align='right'>" + userData.Simbolo + lst[i].Cargo.ToString("0.00") + "</td>" +
                                    "<td align='right'>" + userData.Simbolo + lst[i].Abono.ToString("0.00") + "</td>" +
                                "</tr>"
                                     );
                    }
                }
            }

            var cadena = txtBuil.ToString();

            if (lst.Any())
            {
                if (Math.Abs(lst[lst.Count - 1].Cargo) > 0)
                {
                    cadena += "</table><br /><br />" +
                               "TOTAL A PAGAR: " + userData.Simbolo + string.Format("{0:0.##}", lst[lst.Count - 1].Cargo).Replace(',', '.') + "<br />";
                }
                else if (Math.Abs(lst[lst.Count - 1].Abono) > 0)
                {
                    cadena += "</table><br /><br />" +
                              "TOTAL A PAGAR: " + userData.Simbolo + string.Format("{0:0.##}", lst[lst.Count - 1].Abono).Replace(',', '.') + "<br />";
                }
            }
            return cadena;
        }        

        #endregion
    }
}
