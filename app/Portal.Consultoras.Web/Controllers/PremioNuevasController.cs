using AutoMapper;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Common;
using System.Web.UI;

namespace Portal.Consultoras.Web.Controllers
{
    public class PremioNuevasController : BaseController
    {
        // GET: PremioNuevas
        [OutputCache(Duration = 3600, VaryByParam = "none")]
        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.hdnPaisISO = userData.CodigoISO;
            return View(PremioNuevaModel);
        }
        //[OutputCache(Duration = 500, VaryByParam = "sidx;sord;page;rows;CodigoPrograma;AnoCampanaIni;Nivel;Active", Location = OutputCacheLocation.Client)]
        [HttpGet]
        public ActionResult ListarPremiosPaginado(string sidx, string sord, int page, int rows,string CodigoPrograma , int? AnoCampanaIni, string Nivel, bool? Active)
        {

            List<BEPremioNuevas> lst;
            BEPremioNuevas row = null;
            try
            {
                using (var sv = new ODSServiceClient())
                {

                    lst = sv.ListarPremioNuevasPaginado(new BEPremioNuevas
                    {
                        CodigoPrograma= CodigoPrograma ,
                        AnoCampanaIni= AnoCampanaIni,
                        Nivel= string.IsNullOrEmpty(Nivel) ? null  : Nivel,
                        SortColumna =sidx,
                        SortDirection = sord.ToUpper(),
                        Active = Active,
                        PaisID = userData.PaisID,
                        CodigoUsuario = userData.CodigoUsuario,
                        NumeroPagina = page,
                        FilasPorPagina =  rows
                    }).ToList();
                    row = lst.FirstOrDefault();
                }
                var grid = new BEGrid()
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                BEPager pag = ObtenerPaginado(row,grid);
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = lst
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.ToString(), JsonRequestBehavior.AllowGet);
            }
         
        }
        #region CRUD
        [HttpGet]
        public ActionResult Movimientos(PremioNuevaModel Premios)
        {
            if (!Request.IsAjaxRequest())
                return RedirectToActionPermanent("Index");
            Premios.DropDownListCampania = CargarCampania();
            Premios.DropDownListNivel = CargarNivel();
            Premios.DropDownListEstado = CargarEstado();
            return PartialView(Premios);
        }
        [HttpPost]
        public ActionResult OperacionPremio(PremioNuevaModel Premios)
        {
            
            try
            {
                Premios.PaisID = userData.PaisID;
                Premios.CodigoUsuario = userData.CodigoUsuario;
                BEPremioNuevas model = Mapper.Map<PremioNuevaModel, BEPremioNuevas>(Premios);
                BEPremioNuevas Result = null;
                using (var sv = new ODSServiceClient())
                {
                    if (Premios.Operacion == 0)
                        Result = sv.Insertar(model);
                    else
                        Result = sv.Editar(model);
                   
                }
                return Json(new
                {
                    success = Result.OperacionResultado == 0 ? true : false,
                    message = Result.OperacionResultado == 0 ? "Se grabó con �xito los datos." : "Las fechas no se pueden traslapar, dentro de  una config. programa + nivel + valor electivo"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar registrar los datos"
                });
            }
        }
     
        #endregion
        #region DropDownList
        private List<object> CargarNivel()
        {
            var Niveles = new List<Object>
            {
                new { Nivel ="01" , NombreCorto="01"},
                new { Nivel ="02" , NombreCorto="02"},
                new { Nivel ="03" , NombreCorto="03"},
                new { Nivel ="04" , NombreCorto="04"},
                new { Nivel ="05" , NombreCorto="05"},
                new { Nivel ="06" , NombreCorto="06"}
            };
            return Niveles;
        }
        private List<object> CargarEstado()
        {
            var Niveles = new List<object>
            {
                new { Active ="1" , NombreCorto="Si"},
                new { Active ="0" , NombreCorto="No"}
            };
            return Niveles;
        }
        private List<CampaniaModel> CargarCampania()
        {
            List<CampaniaModel> resultado;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                var becampania = servicezona.SelectCampanias(11).ToList();
                resultado = Mapper.Map<List<BECampania>, List<CampaniaModel>>(becampania);
            }

            return resultado;
        }
        #endregion
        #region Private Method
        private PremioNuevaModel PremioNuevaModel
        {
            get
            {
                return new PremioNuevaModel
                {
                    DropDownListCampania = CargarCampania(),
                    DropDownListNivel = CargarNivel(),
                    DropDownListEstado = CargarEstado()
                };
            }
        }
        private BEPager ObtenerPaginado(BEPremioNuevas row, BEGrid grid)
        {
            grid.PageSize = grid.PageSize <= 0 ? 1 : grid.PageSize;
            BEPager pag = new BEPager();
            pag.RecordCount = row.TotalFilas;
            pag.PageCount = ((pag.RecordCount - 1) / grid.PageSize) + 1;
            pag.CurrentPage = grid.CurrentPage > pag.PageCount ? pag.PageCount : grid.CurrentPage;
            return pag;
        }
        #endregion
    }
}