﻿using AutoMapper;
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
        [Authorize]
        [OutputCache(Duration = 3600, VaryByParam = "none")]
        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.hdnPaisISO = userData.CodigoISO;
            return View(PremioNuevaModel);
        }
  
        [HttpGet]
        [Authorize]
        public ActionResult ListarPremiosPaginado(string sidx, string sord, int page, int rows,string CodigoPrograma , int? AnoCampanaIni, string Nivel, bool? ActivePremioAuto)
        {

            List<BEPremioNuevas> lst;
            BEPremioNuevas row = null;
            try
            {
                using (var sv = new ODSServiceClient())
                {

                    lst = sv.ListarPremioNuevasPaginado(new BEPremioNuevas
                    {
                        CodigoPrograma=   string.IsNullOrEmpty(CodigoPrograma) ? null : CodigoPrograma,
                        AnoCampanaIni= AnoCampanaIni,
                        Nivel= string.IsNullOrEmpty(Nivel) ? null  : Nivel,
                        SortColumna =sidx,
                        SortDirection = sord.ToUpper(),
                        ActivePremioAuto = ActivePremioAuto,
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
        [Authorize]
        public ActionResult OperacionPremio(PremioNuevaModel Premios)
        {
            BEPremioNuevas Result = null;
            bool success = false;
            string message = string.Empty;
            try
            {
                Premios.PaisID = userData.PaisID;
                Premios.CodigoUsuario = userData.CodigoUsuario;
                BEPremioNuevas model = Mapper.Map<PremioNuevaModel, BEPremioNuevas>(Premios);
                if (ModelState.IsValid)
                {
                    using (var sv = new ODSServiceClient())
                    {
                        if (Premios.Operacion == 0)
                            Result = sv.Insertar(model);
                        else
                            Result = sv.Editar(model);
                    }

                    if (Result.OperacionResultado == 1)
                    {
                        message = "Se grabó con exito los datos.";
                        success = true;
                    }
                    else if (Result.OperacionResultado == 0)
                    {
                        message = "Las fechas no se pueden traslapar, dentro de una misma configuración: Campaña + Programa + Nivel + Premio electivo.";
                    }
                    else
                    {
                        message = "Ocurrió un problema al intentar registrar los datos";
                    }
                }
            }
            catch (Exception ex)
            {
                message = "Ocurrió un problema al intentar registrar los datos";
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                success,
                message
            });
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
                new { ActivePremioAuto ="1" , NombreCorto="Si"},
                new { ActivePremioAuto ="0" , NombreCorto="No"}
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