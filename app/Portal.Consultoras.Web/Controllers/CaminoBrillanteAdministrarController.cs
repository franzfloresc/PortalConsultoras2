using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteAdministrarController: BaseAdmController
    {      
        public ActionResult AdministrarBeneficios(AdministrarCaminoBrillanteModel model)
        {
            try
            {
                model.listaPaises = DropDowListPaises();
                model.listaNiveles = DropDowListNivelesCaminoBrillante();
                model.listaIconos = DropDowListIconosBeneficios();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, string CodigoNivel, string Consulta)
        {
            if (ModelState.IsValid)
            {
                var lst = Consulta == "1" ? GetListaBeneficiosByNivel(paisID, CodigoNivel) : new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();
                lst = lst ?? new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();

                //if (lst.Count > 0)
                //{
                //    lst.Update(x => x.ImagenEstrategia = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, x.ImagenEstrategia));
                //    lst.Update(x => x.ImagenOfertaIndependiente = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, x.ImagenOfertaIndependiente));
                //}

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel> items = lst;

                #region Sort Section
                //if (sord == "asc")
                //{
                //    switch (sidx)
                //    {
                //        case "TipoEstrategiaID":
                //            items = lst.OrderBy(x => x.TipoEstrategiaID);
                //            break;
                //        case "DescripcionEstrategia":
                //            items = lst.OrderBy(x => x.DescripcionEstrategia);
                //            break;
                //    }
                //}
                //else
                //{
                //    switch (sidx)
                //    {
                //        case "TipoEstrategiaID":
                //            items = lst.OrderByDescending(x => x.TipoEstrategiaID);
                //            break;
                //        case "DescripcionEstrategia":
                //            items = lst.OrderByDescending(x => x.DescripcionEstrategia);
                //            break;
                //    }
                //}
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CodigoBeneficio,
                               cell = new string[]
                               {
                                   a.CodigoBeneficio,                                   
                                   a.Registro.ToString(),
                                   a.NombreBeneficio,
                                   a.Descripcion,
                                   a.Orden.ToString(),
                                   a.FlagActivo,
                                   a.UrlIcono,                                   
                                   //a.Orden.ToString(),
                                   //a.ImagenEstrategia,
                                   //a.OfertaID,
                                   //a.FlagActivo.ToString(),
                                   //a.FlagNueva.ToString(),
                                   //a.FlagRecoProduc.ToString(),
                                   //a.FlagRecoPerfil.ToString(),
                                   //string.IsNullOrEmpty( a.CodigoPrograma) ? string.Empty: a.CodigoPrograma,
                                   //a.FlagMostrarImg.ToString(),
                                   //a.MostrarImgOfertaIndependiente.ToInt().ToString(),
                                   //a.ImagenOfertaIndependiente,
                                   //a.FlagValidarImagen.ToString(),
                                   //a.PesoMaximoImagen.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("AdministrarBeneficios", "CaminoBrillanteAdministrar");
        }

        [HttpPost]
        public JsonResult RegistrarBeneficio(NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel model)
        {
            string operacion = "registró";
            try
            {

                //BEOferta entidad = new BEOferta
                //{
                //    OfertaID = Convert.ToInt32(OfertaID),
                //    PaisID = userData.PaisID,
                //    CodigoOferta = CodigoOferta,
                //    DescripcionOferta = DescripcionOferta,
                //    UsuarioRegistro = userData.CodigoUsuario,
                //    UsuarioModificacion = userData.CodigoUsuario,
                //    CodigoPrograma = CodigoPrograma
                //};

                if (model.FlagActivo == "1") model.Estado = true;
                if (model.FlagActivo == "0") model.Estado = false;

                var entidad = Mapper.Map<BEBeneficioCaminoBrillante>(model) ?? new BEBeneficioCaminoBrillante();

                using (var sv = new UsuarioServiceClient())
                {
                    sv.InsBeneficioCaminoBrillante(userData.PaisID, entidad);
                }

                //if (OfertaID != "0")
                //{
                //    operacion = "modificó";
                //}
                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el beneficio.", operacion),
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    }
}