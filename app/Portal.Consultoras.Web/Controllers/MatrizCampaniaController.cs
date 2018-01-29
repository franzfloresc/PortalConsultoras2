using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;


namespace Portal.Consultoras.Web.Controllers
{
    public class MatrizCampaniaController : BaseController
    {
        public ActionResult ActualizarMatrizCampania()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizCampania/Actualizarmatrizcampania"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var model = new MatrizCampaniaModel
            {
                listaPaises = ObtenerPaises(),
                DropDownListCampania = ObtenerCampanias()
            };
            ViewBag.HabilitarRegalo = userData.CodigoISO == Constantes.CodigosISOPais.Chile;

            return View(model);
        }

        private IEnumerable<PaisModel> ObtenerPaises()
        {
            List<BEPais> paises;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == Constantes.Rol.Administrador)
                {
                    paises = sv.SelectPaises().ToList();
                }
                else
                {
                    paises = new List<BEPais>
                    {
                        sv.SelectPais(UserData().PaisID)
                    };
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(paises);
        }

        private List<BECampania> ObtenerCampanias()
        {
            var campanias = new List<BECampania>();
            campanias.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return campanias;
        }

        public JsonResult CargarCampania(string paisId)
        {
            var campanias = new List<BECampania>() {
                new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" }
            };

            try
            {
                if (string.IsNullOrEmpty(paisId)) throw new ArgumentNullException("vPaisID", "No puede ser nulo o vacío.");
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    campanias.AddRange(sv.SelectCampanias(UserData().PaisID).ToList());
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

            return Json(new
            {
                DropDownListCampania = campanias
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ConsultarDescripcion(string CUV, string IDCampania, string paisID)
        {
            try
            {
                List<BEProductoDescripcion> productos;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    productos = sv.GetProductoDescripcionByCUVandCampania(Convert.ToInt32(paisID), Convert.ToInt32(IDCampania), CUV).ToList();

                }

                if (!productos.Any())
                {
                    return Json(new
                    {
                        success = false,
                        message = "El CUV ingresado no se encuentra registrado para la campaña seleccionada, verifique.",
                        extra = ""
                    });
                }

                if (productos.Count == 2)
                {
                    var producto = productos.LastOrDefault();
                    if (producto != null && !string.IsNullOrEmpty(producto.RegaloImagenUrl))
                    {
                        string carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                        productos.LastOrDefault().RegaloImagenUrl = ConfigS3.GetUrlFileS3(carpetaPais, producto.RegaloImagenUrl, carpetaPais);
                        

                    }
                }
                
                return Json(new
                {
                    success = true,
                    lstProducto = productos,
                    message = "",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertarProductoDescripcion(MatrizCampaniaModel model)
        {
            try
            {
                ServiceSAC.BEProductoDescripcion entidad = Mapper.Map<MatrizCampaniaModel, ServiceSAC.BEProductoDescripcion>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdProductoDescripcion(entidad, UserData().CodigoUsuario);
                }
                return Json(new
                {
                    success = true,
                    message = "El producto se actualizó satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }
    }
}
