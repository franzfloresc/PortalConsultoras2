using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PaqueteDocumentarioController : BaseController
    {
        readonly PaqueteDocumentarioProvider _paqueteDocumentarioProvider;

        public PaqueteDocumentarioController()
        {
            _paqueteDocumentarioProvider = new PaqueteDocumentarioProvider();
        }

        public ActionResult Index()
        {
            string errorMessage;
            string codigoConsultora = userData.GetCodigoConsultora();
            var rvDigitalModel = new RVDigitalModel { listaCampania = _paqueteDocumentarioProvider.GetListCampaniaPaqueteDocumentario(codigoConsultora, userData.CodigoISO, out errorMessage) };

            ViewBag.ErrorDescripcion = errorMessage;
            return View(rvDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            var lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(Campania)) lst = _paqueteDocumentarioProvider.GetListPaqueteDocumentario(userData.GetCodigoConsultora(), Campania, "", userData.CodigoISO);
            IEnumerable<RVPRFModel> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderBy(x => x.Nombre);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderByDescending(x => x.Nombre);
                        break;
                }
            }
            #endregion

            items = lst;

            BEGrid grid = new BEGrid(sidx, sord, page, rows);
            BEPager pag = Paginador(grid, Campania, lst);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.Nombre + "-" + a.FechaFacturacion,
                           cell = new string[]
                           {
                                a.Nombre,
                                a.FechaFacturacion,
                                a.Ruta,
                           }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(vBusqueda)
                ? lst.Count
                : lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

    }
}
