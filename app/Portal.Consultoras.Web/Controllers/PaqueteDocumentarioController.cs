using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class PaqueteDocumentarioController : BaseController
    {
        public ActionResult Index()
        {
            bool ErrorServicio;
            string ErrorCode;
            string ErrorMessage;

            RVDigitalModel oRVDigitalModel = new RVDigitalModel();
            oRVDigitalModel.listaCampania = GetCampaniasRVDigitalWeb(out ErrorServicio, out ErrorCode, out ErrorMessage);

            if (ErrorServicio)
            {
                ViewBag.ErrorDescripcion = "Ocurrió un error al intentar obtener la información. Por favor, vuelva a intentar dentro de unos minutos.";
            }
            else
            {
                if (ErrorCode == string.Empty || ErrorCode == "00000")
                    ViewBag.ErrorDescripcion = string.Empty;
                else
                    ViewBag.ErrorDescripcion = ErrorMessage;
            }
            return View(oRVDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            BEGrid grid = new BEGrid {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };

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

        public List<CampaniaModel> GetCampaniasRVDigitalWeb(out bool ErrorServicio, out string ErrorCode, out string ErrorMessage)
        {
            UsuarioModel usuario = UserData();
            var complain = new RVDWebCampaniasParam { Pais = usuario.CodigoISO, Tipo = "1", CodigoConsultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora) };
            List<CampaniaModel> lstCampaniaModel = new List<CampaniaModel>();
            ErrorServicio = false;
            ErrorCode = string.Empty;
            ErrorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_Campanias_NEW);
                Uri uri = new Uri(strUri);
                WebRequest request = WebRequest.Create(uri);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";

                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(output);
                }

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                StreamReader sReader = new StreamReader(reader);
                string outResult = sReader.ReadToEnd();
                sReader.Close();

                JavaScriptSerializer json_serializer = new JavaScriptSerializer();

                WrapperCampanias st = json_serializer.Deserialize<WrapperCampanias>(outResult);
                if (st != null)
                {
                    if (st.LIS_CampanaResult != null)
                    {
                        if (st.LIS_CampanaResult.lista != null)
                        {
                            if (st.LIS_CampanaResult.lista.Count != 0)
                            {
                                foreach (var item in st.LIS_CampanaResult.lista)
                                {
                                    lstCampaniaModel.Add(new CampaniaModel() { CampaniaID = Convert.ToInt32(item), Codigo = item });
                                }
                            }
                            else
                            {
                                ErrorCode = st.LIS_CampanaResult.errorCode;
                                ErrorMessage = st.LIS_CampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            ErrorCode = st.LIS_CampanaResult.errorCode;
                            ErrorMessage = st.LIS_CampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ErrorServicio = true;
            }
            if (lstCampaniaModel.Count != 0)
                return lstCampaniaModel.Distinct().OrderBy(p => p.CampaniaID).ToList();
            else
                return lstCampaniaModel;
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
