using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                        var cuponBe = MapearCuponModelABECupon(model);
                        svClient.CrearCupon(userData.PaisID, cuponBe);
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
                        var cuponBe = MapearCuponModelABECupon(model);
                        svClient.ActualizarCupon(userData.PaisID, cuponBe);
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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<CuponModel> items = listaCupones;

                if (listaCupones.Any())
                {
                    switch (grid.SortColumn)
                    {
                        case "Tipo":
                            items = grid.SortOrder == "asc"
                                ? listaCupones.OrderBy(c => c.Tipo)
                                : listaCupones.OrderByDescending(c => c.Tipo);
                            break;
                        case "Descripcion":
                            items = grid.SortOrder == "asc"
                                ? listaCupones.OrderBy(c => c.Descripcion)
                                : listaCupones.OrderByDescending(c => c.Descripcion);
                            break;
                        case "FechaCreacion":
                            items = grid.SortOrder == "asc" ?
                                listaCupones.OrderBy(c => c.FechaCreacion)
                                : listaCupones.OrderByDescending(c => c.FechaCreacion);
                            break;
                    }
                }

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, listaCupones);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from row in items
                           select new
                           {
                               id = row.CuponId,
                               TipoId = row.Tipo,
                               Tipo = (row.Tipo.Trim() == Constantes.CodigoTipoCupon.Monto.ToString() ? Constantes.NombreTipoCupon.Monto : Constantes.NombreTipoCupon.Porcentaje),
                               Descripcion = row.Descripcion,
                               FechaCreacion = row.FechaCreacion.ToString("dd/MM/yyyy HH:mm"),
                               Estado = row.Estado
                           }
                };

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
                        var cuponConsultoraBe = MapearCuponConsultoraModelABECuponConsultora(model);
                        svClient.CrearCuponConsultora(userData.PaisID, cuponConsultoraBe);
                    }
                }
                else
                {
                    return Json(new { success = false, message = "La consultora ya está registra para la campaña y cupón seleccionado." }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, message = "La consultora fue creada." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpPost]
        public JsonResult ActualizarCuponConsultora(CuponConsultoraModel model)
        {
            try
            {
                var listaCuponConsultoras = ListarCuponConsultorasPorCupon(userData.PaisID, model.CuponId);
                var existeCuponConsultora = listaCuponConsultoras.Any(x => x.CodigoConsultora == model.CodigoConsultora && x.CampaniaId == model.CampaniaId && x.CuponId == model.CuponId && x.CuponConsultoraId != model.CuponConsultoraId);

                if (!existeCuponConsultora)
                {
                    using (PedidoServiceClient svClient = new PedidoServiceClient())
                    {
                        var cuponConsultoraBe = MapearCuponConsultoraModelABECuponConsultora(model);
                        svClient.ActualizarCuponConsultora(userData.PaisID, cuponConsultoraBe);
                    }
                }
                else
                {
                    return Json(new { success = false, message = "La consultora a actualizar ya está registrada." }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, message = "La consultora fue actualizada." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpGet]
        public JsonResult ListarCuponConsultorasPorCupon(string sidx, string sord, int page, int rows, int paisID, int cuponID)
        {
            try
            {
                var listaCuponConsultoras = ListarCuponConsultorasPorCupon(paisID, cuponID);

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<CuponConsultoraModel> items = listaCuponConsultoras;

                if (listaCuponConsultoras.Any())
                {
                    switch (grid.SortColumn)
                    {
                        case "Consultora":
                            items = grid.SortOrder == "asc"
                                ? listaCuponConsultoras.OrderBy(c => c.CodigoConsultora)
                                : listaCuponConsultoras.OrderByDescending(c => c.CodigoConsultora);
                            break;
                        case "ValorAsociado":
                            items = grid.SortOrder == "asc"
                                ? listaCuponConsultoras.OrderBy(c => c.ValorAsociado)
                                : listaCuponConsultoras.OrderByDescending(c => c.ValorAsociado);
                            break;
                        case "Estado":
                            items = grid.SortOrder == "asc"
                                ? listaCuponConsultoras.OrderBy(c => c.EstadoCupon)
                                : listaCuponConsultoras.OrderByDescending(c => c.EstadoCupon);
                            break;
                    }
                }

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, listaCuponConsultoras);

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
                               Estado = (row.EstadoCupon == Constantes.EstadoCupon.Reservado ? Constantes.NombreEstadoCupon.Reservado : row.EstadoCupon == Constantes.EstadoCupon.Activo ? Constantes.NombreEstadoCupon.Activo : Constantes.NombreEstadoCupon.Utilizado),
                               CampaniaId = row.CampaniaId,
                               CuponId = row.CuponId
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        [HttpPost]
        public JsonResult CuponConsultoraCargaMasiva(HttpPostedFileBase flCuponConsultora, int hdCampaniaIdFrmCargaMasiva, int hdCuponIdFrmCargaMasiva)
        {
            try
            {
                if (flCuponConsultora != null)
                {
                    string finalPath;
                    GuardarArchivoEnCarpeta(flCuponConsultora, out finalPath);
                    var listaCuponConsultoras = ObtenerListaCuponConsultora(finalPath);

                    if (!listaCuponConsultoras.Any())
                        return Json(new { success = false, message = "No hay datos para guardar" }, JsonRequestBehavior.AllowGet);

                    using (PedidoServiceClient svClient = new PedidoServiceClient())
                    {
                        svClient.InsertarCuponConsultorasXML(userData.PaisID, hdCuponIdFrmCargaMasiva, hdCampaniaIdFrmCargaMasiva, listaCuponConsultoras.ToArray());
                    }

                    return Json(new { success = true, message = "Los datos fueron grabados." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Debe seleccionar un archivo" }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        private void GuardarArchivoEnCarpeta(HttpPostedFileBase flCuponConsultora, out string finalPath)
        {
            string fileName = Path.GetFileName(flCuponConsultora.FileName) ?? "";
            string pathFolder = Server.MapPath("~/Content/FileCargaCuponConsultora");
            if (!Directory.Exists(pathFolder))
                Directory.CreateDirectory(pathFolder);
            finalPath = Path.Combine(pathFolder, fileName);
            flCuponConsultora.SaveAs(finalPath);
        }

        private List<BECuponConsultora> ObtenerListaCuponConsultora(string finalPath)
        {
            List<BECuponConsultora> listaCuponConsultoras = new List<BECuponConsultora>();

            using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
            {
                string inputLine;
                int count = 0;

                while ((inputLine = sr.ReadLine()) != null)
                {
                    count++;
                    if (count >= 2)
                    {
                        var values = inputLine.Split(',');
                        if (values.Length > 0)
                        {
                            BECuponConsultora cuponConsultora =
                                new BECuponConsultora
                                {
                                    CodigoConsultora = values[0].Trim(),
                                    ValorAsociado = Convert.ToDecimal(values[1].Trim())
                                };

                            listaCuponConsultoras.Add(cuponConsultora);
                        }
                    }
                }
            }

            return listaCuponConsultoras;
        }

        private List<CuponModel> ListarCuponesPorCampania(int paisId, int campaniaId)
        {
            List<CuponModel> listaCupones;

            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                var listaCuponesBe = svClient.ListarCuponesPorCampania(paisId, campaniaId).ToList();
                listaCupones = listaCuponesBe.Select(x => MapearBECuponACuponModel(x)).ToList();
            }

            return listaCupones;
        }

        private List<CuponConsultoraModel> ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            List<CuponConsultoraModel> listaCuponConsultoras;

            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                var listaCuponConsultorasBe = svClient.ListarCuponConsultorasPorCupon(paisId, cuponId).ToList();
                listaCuponConsultoras = listaCuponConsultorasBe.Select(x => MapearBECuponConsultoraABECuponConsultoraModel(x)).ToList();
            }

            return listaCuponConsultoras;
        }

        private IEnumerable<PaisModel> ListarPaises()
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

        private CuponModel MapearBECuponACuponModel(BECupon cuponBe)
        {
            return new CuponModel()
            {
                CuponId = cuponBe.CuponId,
                Tipo = cuponBe.Tipo,
                Descripcion = cuponBe.Descripcion,
                CampaniaId = cuponBe.CampaniaId,
                Estado = cuponBe.Estado,
                FechaCreacion = cuponBe.FechaCreacion,
                FechaModificacion = cuponBe.FechaModificacion,
                UsuarioCreacion = cuponBe.UsuarioCreacion,
                UsuarioModificacion = cuponBe.UsuarioModificacion
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

        private CuponConsultoraModel MapearBECuponConsultoraABECuponConsultoraModel(BECuponConsultora cuponConsultoraBe)
        {
            var codigoIso = userData.CodigoISO;

            return new CuponConsultoraModel(codigoIso)
            {
                CuponConsultoraId = cuponConsultoraBe.CuponConsultoraId,
                CodigoConsultora = cuponConsultoraBe.CodigoConsultora,
                CampaniaId = cuponConsultoraBe.CampaniaId,
                CuponId = cuponConsultoraBe.CuponId,
                ValorAsociado = cuponConsultoraBe.ValorAsociado,
                EstadoCupon = cuponConsultoraBe.EstadoCupon,
                CorreoGanasteEnviado = cuponConsultoraBe.EnvioCorreo,
                FechaCreacion = cuponConsultoraBe.FechaCreacion,
                FechaModificacion = cuponConsultoraBe.FechaModificacion,
                UsuarioCreacion = cuponConsultoraBe.UsuarioCreacion,
                UsuarioModificacion = cuponConsultoraBe.UsuarioModificacion,
            };
        }

        #endregion
    }
}