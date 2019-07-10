﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using static Portal.Consultoras.Web.Models.CaminoBrillante.NivelCaminoBrillanteModel;

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
                var lst = Consulta == "1" ? GetListaBeneficiosByNivel(paisID, CodigoNivel) : new List<BeneficioCaminoBrillanteModel>();
                lst = lst ?? new List<BeneficioCaminoBrillanteModel>();

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
                IEnumerable<BeneficioCaminoBrillanteModel> items = lst;

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
                                   a.UrlIcono
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
    }
}