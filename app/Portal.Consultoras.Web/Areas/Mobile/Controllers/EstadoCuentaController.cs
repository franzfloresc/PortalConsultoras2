using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstadoCuentaController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var userData = UserData();
            var model = new EstadoCuentaMobilModel();
            try
            {
                model.PaisID = userData.PaisID;
                model.CodigoISO = userData.CodigoISO;
                model.Simbolo = userData.Simbolo;
                model.CorreoConsultora = userData.EMail;
                model.ListaEstadoCuenta = new List<EstadoCuentaMobilModel>();

                var lstEstadoCuenta = EstadodeCuenta();
                if (lstEstadoCuenta.Count > 0)
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

                foreach (var item in lstEstadoCuenta)
                {
                    model.ListaEstadoCuenta.Add(
                        new EstadoCuentaMobilModel
                        {
                            MontoPagar = item.MontoPagar,
                            Simbolo = item.Simbolo,
                            FechaVencimiento = item.FechaVencimiento,
                            CorreoConsultora = item.CorreoConsultora,
                            Abono = item.Abono,
                            Cargo = item.Cargo,
                            Glosa = item.Glosa,
                            FechaConvertida = item.Fecha.ToString("dd/MM/yyyy"),
                            TipoMovimiento = item.TipoMovimiento,
                            Fecha = item.Fecha
                        });
                }

                if (model.ListaEstadoCuenta.Count == 0)
                {
                    model.FechaVencimiento = "";

                    if (model.CodigoISO == Constantes.CodigosISOPais.Colombia)
                    {
                        model.MontoPagar = "0";
                    }
                    else
                    {
                        model.MontoPagar = "0.0";
                    }
                }
                else
                {
                    model.ListaEstadoCuenta = model.ListaEstadoCuenta.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

                    var ultimoMovimiento = model.ListaEstadoCuenta.FirstOrDefault();

                    model.FechaVencimiento = ultimoMovimiento.FechaConvertida;
                    model.Glosa = ultimoMovimiento.Glosa.ToString();
                    model.MontoPagar = ultimoMovimiento.MontoPagar;
                    model.Abono = ultimoMovimiento.Abono;
                    model.Cargo = ultimoMovimiento.Cargo;

                    using (var service = new ContenidoServiceClient())
                    {
                        if (model.CodigoISO == Constantes.CodigosISOPais.Colombia || model.CodigoISO == Constantes.CodigosISOPais.Peru)
                        {
                            model.MontoPagar = service.GetDeudaTotal(userData.PaisID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();
                        }
                        else
                        {
                            model.MontoPagar = service.GetSaldoPendiente(userData.PaisID, userData.CampaniaID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();
                        }
                    }
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
            var userData = UserData();
            var lst = new List<EstadoCuentaModel>();

            try
            {
                BEEstadoCuenta[] estadoCuenta;
                using (var service = new SACServiceClient())
                {
                    estadoCuenta = service.GetEstadoCuentaConsultora(userData.PaisID, userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora);
                }

                foreach (var item in estadoCuenta)
                {
                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = item.FechaRegistro,
                        Glosa = item.DescripcionOperacion,
                        Cargo = item.Cargo,
                        Abono = item.Abono
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return lst;
        }

        private string ConstruirContenidoCorreo(List<EstadoCuentaModel> lst)
        {
            var userData = UserData();

            var cadena = "<h2> Estado de cuenta </h2>" +
                         "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                         "<tr>" +
                            "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                            "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                            "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                            "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                         "</tr>";

            if (userData.PaisID == 4)
            {
                for (int i = 0; i < lst.Count - 1; i++)
                {
                    cadena += "<tr>" +
                                  "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                  "<td align='left'>" + lst[i].Glosa + "</td>" +
                                  "<td align='right'>" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].Cargo).Replace(',', '.') + "</td>" +
                                  "<td align='right'>" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].Abono).Replace(',', '.') + "</td>" +
                              "</tr>";
                }
            }
            else
            {
                for (int i = 0; i < lst.Count - 1; i++)
                {
                    cadena += "<tr>" +
                                "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                "<td align='left'>" + lst[i].Glosa + "</td>" +
                                "<td align='right'>" + userData.Simbolo + lst[i].Cargo.ToString("0.00") + "</td>" +
                                "<td align='right'>" + userData.Simbolo + lst[i].Abono.ToString("0.00") + "</td>" +
                              "</tr>";
                }
            }

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

            return cadena;
        }

        #endregion
    }
}
