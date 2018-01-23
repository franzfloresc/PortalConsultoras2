using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PaqueteDocumentarioController : BaseController
    {
        public ActionResult Index()
        {
            string errorMessage;
            string codigoConsultora = (userData.UsuarioPrueba == 1) ? userData.ConsultoraAsociada : userData.CodigoConsultora;
            var rvDigitalModel = new RVDigitalModel { listaCampania = GetListCampaniaPaqueteDocumentario(codigoConsultora, out errorMessage) };

            ViewBag.ErrorDescripcion = errorMessage;
            return View(rvDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            var lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(Campania)) lst = GetPDFRVDigital(userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora, Campania, "");
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

            BEGrid grid = SetGrid(sidx, sord, page, rows);
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

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

    }
}
