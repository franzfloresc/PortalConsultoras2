using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using svUsuario = Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    public class CuponController : BaseController
    {
        [HttpPost]
        public JsonResult ActivarCupon(CuponUsuarioModel model)
        {
            try
            {
                ActivacionCupon();
                ActualizarCelularUsuario(model);
                ValidarPopupDelGestorPopups();
                return Json(new { success = true, message = "El cupón fue activado." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpPost]
        public JsonResult EnviarCorreoConfirmacionEmail(CuponEnviarCorreoConfirmacion confirmarModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    svUsuario.BEUsuario entidad = new svUsuario.BEUsuario
                    {
                        EMail = Util.Trim(confirmarModel.EMailNuevo),
                        Celular = Util.Trim(confirmarModel.Celular),
                        CodigoUsuario = userData.CodigoUsuario,
                        Telefono = userData.Telefono,
                        TelefonoTrabajo = userData.TelefonoTrabajo,
                        Sobrenombre = userData.Sobrenombre,
                        ZonaID = userData.ZonaID,
                        RegionID = userData.RegionID,
                        ConsultoraID = userData.ConsultoraID,
                        PaisID = userData.PaisID
                    };

                    if (!string.IsNullOrEmpty(entidad.EMail))
                    {
                        bool correoDisponible = ValidarDisponibilidadDeNuevoEmail(entidad.EMail);
                        if (!correoDisponible)
                        {
                            return Json(new { success = false, message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora." }, JsonRequestBehavior.AllowGet);
                        }
                    }

                    string correoAnterior = Util.Trim(userData.EMail);
                    string correoNuevo = entidad.EMail;

                    ActualizarDatos(entidad, correoAnterior);
                    ActualizarDatosSesion(entidad, correoNuevo, correoAnterior);


                    string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, correoNuevo, "UrlReturn,cupon" };
                    string paramQuerystring = Util.Encrypt(string.Join(";", parametros));

                    bool tipopais = _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO);

                    var cadena = MailUtilities.CuerpoMensajePersonalizado(Util.GetUrlHost(this.HttpContext.Request).ToString(), userData.Sobrenombre, paramQuerystring, tipopais);

                    Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", correoNuevo, "Confirmación de Correo", cadena, true, userData.NombreConsultora);

                    return Json(new { success = true, message = "Se envió el correo de confirmar email." });
                }
                else
                {
                    return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. Algunos campos no son correctos." });
                }
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpGet]
        public JsonResult ObtenerCupon()
        {
            try
            {
                CuponConsultoraModel cuponModel = ObtenerDatosCupon();
                if (cuponModel != null)
                    cuponModel.MontoLimiteFormateado = ObtenerMontoLimiteDelCupon();

                return Json(new { success = true, data = cuponModel }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpPost]
        public JsonResult EnviarCorreoActivacionCupon()
        {
            try
            {
                string url = Util.GetUrlHost(this.HttpContext.Request).ToString();
                string montoLimite = ObtenerMontoLimiteDelCupon();
                CuponConsultoraModel cuponModel = ObtenerDatosCupon();
                bool tipopais = _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO);
                string mailBody = MailUtilities.CuerpoCorreoActivacionCupon(userData.PrimerNombre, userData.CampaniaID.ToString(), userData.Simbolo, cuponModel.ValorAsociado, cuponModel.TipoCupon, url, montoLimite, tipopais);
                string correo = userData.EMail;
                Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", correo, "Activación de Cupón", mailBody, true, userData.NombreConsultora);

                return Json(new { success = true, message = "El correo de activación fue enviado." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpGet]
        public JsonResult ObtenerOfertasPlan20EnPedido()
        {
            try
            {
                bool tieneOfertasPlan20 = true;

                return Json(new { success = true, tieneOfertasPlan20 = tieneOfertasPlan20, message = "" }, JsonRequestBehavior.AllowGet);   
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        private CuponConsultoraModel ObtenerDatosCupon()
        {
            BECuponConsultora cuponResult = ObtenerCuponDesdeServicio();

            var cuponModel = cuponResult != null ? MapearBECuponConsultoraACuponConsultoraModel(cuponResult) : null;

            return cuponModel;
        }

        private BECuponConsultora ObtenerCuponDesdeServicio()
        {
            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                int paisId = userData.PaisID;
                BECuponConsultora cuponBe = new BECuponConsultora
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    CampaniaId = userData.CampaniaID
                };

                var cuponResult = svClient.GetCuponConsultoraByCodigoConsultoraCampaniaId(paisId, cuponBe);
                return cuponResult;
            }
        }

        private string ObtenerMontoLimiteDelCupon()
        {
            List<BETablaLogicaDatos> listSegmentos;
            using (SACServiceClient sv = new SACServiceClient())
            {
                listSegmentos = sv.GetTablaLogicaDatos(userData.PaisID, 103).ToList();

            }

            var descripcion = (listSegmentos.FirstOrDefault(x => x.Codigo == userData.CampaniaID.ToString()) ?? new BETablaLogicaDatos())
                .Descripcion;
            decimal montoLimite = (string.IsNullOrEmpty(descripcion) ? 0 : Convert.ToDecimal(descripcion));
            string montoLimiteFormateado = String.Format("{0:0.00}", montoLimite);

            return montoLimiteFormateado;
        }

        private bool ValidarDisponibilidadDeNuevoEmail(string email)
        {
            using (svUsuario.UsuarioServiceClient svr = new svUsuario.UsuarioServiceClient())
            {
                int cantidad = svr.ValidarEmailConsultora(userData.PaisID, email, userData.CodigoUsuario);
                return (cantidad <= 0);
            }
        }

        private void ActualizarDatos(svUsuario.BEUsuario entidad, string correoAnterior)
        {
            using (svUsuario.UsuarioServiceClient sv = new svUsuario.UsuarioServiceClient())
            {
                sv.UpdateDatos(entidad, correoAnterior);
            }
        }

        private void ActualizarDatosSesion(svUsuario.BEUsuario entidad, string correoNuevo, string correoAnterior)
        {
            userData.EMail = entidad.EMail;
            userData.Celular = entidad.Celular;
            userData.EMailActivo = correoNuevo == correoAnterior && userData.EMailActivo;
            sessionManager.SetUserData(userData);
        }

        private void ActivacionCupon()
        {
            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                BECuponConsultora cuponBe = new BECuponConsultora
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    CampaniaId = userData.CampaniaID,
                    EstadoCupon = Constantes.EstadoCupon.Activo,
                    EnvioCorreo = true
                };

                svClient.UpdateCuponConsultoraEstadoCupon(userData.PaisID, cuponBe);
                svClient.UpdateCuponConsultoraEnvioCorreo(userData.PaisID, cuponBe);
            }
        }

        //private bool TieneOfertasPlan20()
        //{
        //    var flag = false;
        //    var flagValidacionCodigoCatalogo = false;   
        //    var flagValidacionAppCatalogo = false;  
        //    List<BEPedidoWebDetalle> listaPedidoWebDetalle;

        //    if (sessionManager.GetDetallesPedido() == null)
        //    {
        //        using (PedidoServiceClient sv = new PedidoServiceClient())
        //        {
        //            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
        //            {
        //                PaisId = userData.PaisID,
        //                CampaniaId = userData.CampaniaID,
        //                ConsultoraId = userData.ConsultoraID,
        //                Consultora = userData.NombreConsultora,
        //                EsBpt = EsOpt() == 1,
        //                CodigoPrograma = userData.CodigoPrograma,
        //                NumeroPedido = userData.ConsecutivoNueva
        //            };

        //            listaPedidoWebDetalle = sv.SelectByCampania(bePedidoWebDetalleParametros).ToList();
        //        }
        //    }
        //    else
        //    {
        //        listaPedidoWebDetalle = sessionManager.GetDetallesPedido();
        //    }

        //    #region Logica validacion por Codigo de Catalogo    

        //    List<BETablaLogicaDatos> lstCodigosOfertas; 
        //    using (SACServiceClient svc = new SACServiceClient())
        //    {
        //        lstCodigosOfertas = svc.GetTablaLogicaDatos(userData.PaisID, Constantes.TipoOfertasPlan20.TablaLogicaId).ToList();
        //    }


        //    var listaCodigoTipoOferta = new List<string>(); 
        //    listaCodigoTipoOferta.Add("126");   

        //    if (listaPedidoWebDetalle.Any() && lstCodigosOfertas.Any()) 
        //    {
        //        var producto = listaPedidoWebDetalle.FirstOrDefault(x => lstCodigosOfertas.Any(y => x.CodigoCatalago == int.Parse(y.Codigo))    
        //                                                && listaCodigoTipoOferta.Any(y => x.CodigoTipoOferta.Trim() != y)   
        //                                                && x.TipoEstrategiaCodigo.Trim() != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);     

        //        if (producto != null)   
        //            flagValidacionCodigoCatalogo = true;
        //    }

        //    #endregion

        //    #region Logica validacion por App Catalogo y OrigenPedidoWeb    

        //    if (listaPedidoWebDetalle.Any())    
        //    {
        //        var producto = listaPedidoWebDetalle.FirstOrDefault(p => p.OrigenPedidoWeb.ToString().StartsWith("4")   
        //                                                            && listaCodigoTipoOferta.Any(y => p.CodigoTipoOferta.Trim() != y)   
        //                                                            && p.TipoEstrategiaCodigo.Trim() != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);     
        //        if (producto != null)   
        //            flagValidacionAppCatalogo = true;
        //    }

        //    #endregion

        //    flag = flagValidacionCodigoCatalogo && flagValidacionAppCatalogo;   

        //    return flag;    
        //}

        private void ValidarPopupDelGestorPopups()
        {
            if (!IsMobile())
            {
                int tipoPopup = Convert.ToInt32(Session[Constantes.ConstSession.TipoPopUpMostrar]);

                if (tipoPopup == Constantes.TipoPopUp.Cupon)
                {
                    Session[Constantes.ConstSession.TipoPopUpMostrar] = null;
                }
            }
        }

        private CuponConsultoraModel MapearBECuponConsultoraACuponConsultoraModel(BECuponConsultora cuponBe)
        {
            var codigoIso = userData.CodigoISO;

            return new CuponConsultoraModel(codigoIso)
            {
                CuponConsultoraId = cuponBe.CuponConsultoraId,
                CodigoConsultora = cuponBe.CodigoConsultora,
                CampaniaId = cuponBe.CampaniaId,
                CuponId = cuponBe.CuponId,
                ValorAsociado = cuponBe.ValorAsociado,
                EstadoCupon = cuponBe.EstadoCupon,
                CorreoGanasteEnviado = cuponBe.EnvioCorreo,
                FechaCreacion = cuponBe.FechaCreacion,
                FechaModificacion = cuponBe.FechaModificacion,
                UsuarioCreacion = cuponBe.UsuarioCreacion,
                UsuarioModificacion = cuponBe.UsuarioModificacion,
                TipoCupon = cuponBe.TipoCupon
            };
        }

        private void ActualizarCelularUsuario(CuponUsuarioModel model)
        {
            var celularActual = userData.Celular;
            if (!celularActual.Equals(model.Celular))
            {
                svUsuario.BEUsuario entidad = new svUsuario.BEUsuario
                {
                    CodigoUsuario = userData.CodigoUsuario,
                    EMail = userData.EMail,
                    Telefono = userData.Telefono,
                    TelefonoTrabajo = userData.TelefonoTrabajo,
                    Celular = Util.Trim(model.Celular),
                    Sobrenombre = userData.Sobrenombre,
                    ZonaID = userData.ZonaID,
                    RegionID = userData.RegionID,
                    ConsultoraID = userData.ConsultoraID,
                    PaisID = userData.PaisID
                };

                ActualizarDatos(entidad, entidad.EMail);

                userData.Celular = entidad.Celular;
                sessionManager.SetUserData(userData);
            }
        }

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                Session[Constantes.ConstSession.TipoPopUpMostrar] = Constantes.TipoPopUp.Ninguno;

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}