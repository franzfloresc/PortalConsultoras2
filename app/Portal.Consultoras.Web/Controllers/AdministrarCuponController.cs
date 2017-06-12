using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarCuponController : BaseController
    {
        public ActionResult Index(AdmCuponModel model)
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarCupon/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.ListaPaises = ListarPaises();
                model.ListaCampanias = new List<CampaniaModel>();

                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return View(model);
            }
        }

        [HttpPost]
        public JsonResult CrearCupon(CuponModel model)
        {
            try
            {
                var listaCupones = ListarCuponesPorCampania(userData.PaisID, model.CampaniaId);
                var existeCupon = listaCupones.Any(x => x.Tipo == model.Tipo && x.CampaniaId == model.CampaniaId);

                if (!existeCupon)
                {
                    using (PedidoServiceClient svClient = new PedidoServiceClient())
                    {
                        var cuponBE = MapearCuponModelABECupon(model);
                        svClient.CrearCupon(cuponBE);
                    }
                }
                else
                {
                    return Json(new { success = false, message = "El tipo de cupón a ingresar ya está registrado a la campaña." }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, message = "El cupón fue creado." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpPost]
        public JsonResult ActualizarCupon(CuponModel model)
        {
            try
            {
                var listaCupones = ListarCuponesPorCampania(userData.PaisID, model.CampaniaId);
                var existeCupon = listaCupones.Any(x => x.Tipo == model.Tipo && x.CampaniaId == model.CampaniaId && x.CuponId != model.CuponId);

                if (!existeCupon)
                {
                    using (PedidoServiceClient svClient = new PedidoServiceClient())
                    {
                        var cuponBE = MapearCuponModelABECupon(model);
                        svClient.ActualizarCupon(cuponBE);
                    }
                }
                else
                {
                    return Json(new { success = false, message = "El tipo de cupón a actualizar ya está registrado a la campaña." }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, message = "El cupón fue actualizado." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpGet]
        public JsonResult ListarCuponesPorCampania(string sidx, string sord, int page, int rows, int paisID, int campaniaID)
        {
            try
            {
                var listaCupones = ListarCuponesPorCampania(paisID, campaniaID);

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
                IEnumerable<CuponModel> items = listaCupones;

                if (listaCupones.Any())
                {
                    switch (grid.SortColumn)
                    {
                        case "Tipo":
                            if (grid.SortOrder == "asc")
                                items = listaCupones.OrderBy(c => c.Tipo);
                            else
                                items = listaCupones.OrderByDescending(c => c.Tipo);
                            break;
                        case "Descripcion":
                            if (grid.SortOrder == "asc")
                                items = listaCupones.OrderBy(c => c.Descripcion);
                            else
                                items = listaCupones.OrderByDescending(c => c.Descripcion);
                            break;
                    }
                }

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                pag = Util.PaginadorGenerico(grid, listaCupones);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from row in items
                           select new
                           {
                               id = row.CuponId,
                               Tipo = (row.Tipo == Constantes.CodigoTipoCupon.Monto.ToString() ? Constantes.NombreTipoCupon.Monto : Constantes.NombreTipoCupon.Porcentaje),
                               Descripcion = row.Descripcion,
                               FechaCreacion = row.FechaCreacion.ToString("dd/MM/yyyy HH:mm"),
                               Estado = row.Estado
                           }
                };

                //return Json(new { success = true, data = listaCupones }, JsonRequestBehavior.AllowGet);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpPost]
        public JsonResult CrearCuponConsultora(CuponConsultoraModel model)
        {
            try
            {
                var listaCuponConsultoras = ListarCuponConsultorasPorCupon(userData.PaisID, model.CuponId);
                var existeCuponConsultora = listaCuponConsultoras.Any(x => x.CodigoConsultora == model.CodigoConsultora && x.CampaniaId == model.CampaniaId && x.CuponId == model.CuponId);

                if (!existeCuponConsultora)
                {
                    using (PedidoServiceClient svClient = new PedidoServiceClient())
                    {
                        var cuponConsultoraBE = MapearCuponConsultoraModelABECuponConsultora(model);
                        svClient.CrearCuponConsultora(userData.PaisID, cuponConsultoraBE);
                    }
                }
                else
                {
                    return Json(new { success = false, message = "La consultora ya está registra para la campaña y cupón seleccionado." }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, message = "El consultora fue creada." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpGet]
        public JsonResult ListarCuponConsultorasPorCupon(string sidx, string sord, int page, int rows, int paisID, int cuponID)
        {
            try
            {
                var listaCuponConsultoras = ListarCuponConsultorasPorCupon(paisID, cuponID);

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
                IEnumerable<CuponConsultoraModel> items = listaCuponConsultoras;

                if (listaCuponConsultoras.Any())
                {
                    switch (grid.SortColumn)
                    {
                        case "Consultora":
                            if (grid.SortOrder == "asc")
                                items = listaCuponConsultoras.OrderBy(c => c.CodigoConsultora);
                            else
                                items = listaCuponConsultoras.OrderByDescending(c => c.CodigoConsultora);
                            break;
                        case "ValorAsociado":
                            if (grid.SortOrder == "asc")
                                items = listaCuponConsultoras.OrderBy(c => c.ValorAsociado);
                            else
                                items = listaCuponConsultoras.OrderByDescending(c => c.ValorAsociado);
                            break;
                        case "Estado":
                            if (grid.SortOrder == "asc")
                                items = listaCuponConsultoras.OrderBy(c => c.EstadoCupon);
                            else
                                items = listaCuponConsultoras.OrderByDescending(c => c.EstadoCupon);
                            break;
                    }
                }

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                pag = Util.PaginadorGenerico(grid, listaCuponConsultoras);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from row in items
                           select new
                           {
                               id = row.CuponConsultoraId,
                               Consultora = row.CodigoConsultora,
                               ValorAsociado = (row.ValorAsociado),
                               Estado = (row.EstadoCupon == Constantes.EstadoCupon.Reservado ? Constantes.NombreEstadoCupon.Reservado : row.EstadoCupon == Constantes.EstadoCupon.Activo ? Constantes.NombreEstadoCupon.Activo : Constantes.NombreEstadoCupon.Utilizado)
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        private List<CuponModel> ListarCuponesPorCampania(int paisId, int campaniaId)
        {
            List<CuponModel> listaCupones = new List<CuponModel>();

            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                var listaCuponesBE = svClient.ListarCuponesPorCampania(paisId, campaniaId).ToList();
                listaCupones = listaCuponesBE.Select(x => MapearBECuponACuponModel(x)).ToList();
            }

            return listaCupones;
        }

        private List<CuponConsultoraModel> ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            List<CuponConsultoraModel> listaCuponConsultoras = new List<CuponConsultoraModel>();

            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                var listaCuponConsultorasBE = svClient.ListarCuponConsultorasPorCupon(paisId, cuponId).ToList();
                listaCuponConsultoras = listaCuponConsultorasBE.Select(x => MapearBECuponConsultoraABECuponConsultoraModel(x)).ToList();
            }

            return listaCuponConsultoras;
        }

        private IEnumerable<PaisModel> ListarPaises()
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

        #region Mapeo

        private BECupon MapearCuponModelABECupon(CuponModel cuponModel)
        {
            return new BECupon()
            {
                CuponId = cuponModel.CuponId,
                Tipo = cuponModel.Tipo,
                Descripcion = cuponModel.Descripcion,
                CampaniaId = cuponModel.CampaniaId,
                Estado = cuponModel.Estado,
                FechaCreacion = cuponModel.FechaCreacion,
                FechaModificacion = cuponModel.FechaModificacion,
                UsuarioCreacion = cuponModel.UsuarioCreacion,
                UsuarioModificacion = cuponModel.UsuarioModificacion
            };
        }

        private CuponModel MapearBECuponACuponModel(BECupon cuponBE)
        {
            return new CuponModel()
            {
                CuponId = cuponBE.CuponId,
                Tipo = cuponBE.Tipo,
                Descripcion = cuponBE.Descripcion,
                CampaniaId = cuponBE.CampaniaId,
                Estado = cuponBE.Estado,
                FechaCreacion = cuponBE.FechaCreacion,
                FechaModificacion = cuponBE.FechaModificacion,
                UsuarioCreacion = cuponBE.UsuarioCreacion,
                UsuarioModificacion = cuponBE.UsuarioModificacion
            };
        }

        private BECuponConsultora MapearCuponConsultoraModelABECuponConsultora(CuponConsultoraModel cuponConsultoraModel)
        {
            return new BECuponConsultora()
            {
                CuponConsultoraId = cuponConsultoraModel.CuponConsultoraId,
                CodigoConsultora = cuponConsultoraModel.CodigoConsultora,
                CampaniaId = cuponConsultoraModel.CampaniaId,
                CuponId = cuponConsultoraModel.CuponId,
                ValorAsociado = cuponConsultoraModel.ValorAsociado,
                EstadoCupon = cuponConsultoraModel.EstadoCupon,
                EnvioCorreo = cuponConsultoraModel.CorreoGanasteEnviado,
                FechaCreacion = cuponConsultoraModel.FechaCreacion,
                FechaModificacion = cuponConsultoraModel.FechaModificacion,
                UsuarioCreacion = cuponConsultoraModel.UsuarioCreacion,
                UsuarioModificacion = cuponConsultoraModel.UsuarioModificacion,
            };
        }

        private CuponConsultoraModel MapearBECuponConsultoraABECuponConsultoraModel(BECuponConsultora cuponConsultoraBE)
        {
            var codigoISO = userData.CodigoISO;

            return new CuponConsultoraModel(codigoISO)
            {
                CuponConsultoraId = cuponConsultoraBE.CuponConsultoraId,
                CodigoConsultora = cuponConsultoraBE.CodigoConsultora,
                CampaniaId = cuponConsultoraBE.CampaniaId,
                CuponId = cuponConsultoraBE.CuponId,
                ValorAsociado = cuponConsultoraBE.ValorAsociado,
                EstadoCupon = cuponConsultoraBE.EstadoCupon,
                CorreoGanasteEnviado = cuponConsultoraBE.EnvioCorreo,
                FechaCreacion = cuponConsultoraBE.FechaCreacion,
                FechaModificacion = cuponConsultoraBE.FechaModificacion,
                UsuarioCreacion = cuponConsultoraBE.UsuarioCreacion,
                UsuarioModificacion = cuponConsultoraBE.UsuarioModificacion,
            };
        }

        #endregion
    }
}