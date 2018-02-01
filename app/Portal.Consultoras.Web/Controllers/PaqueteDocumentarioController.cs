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
            bool errorServicio;
            string errorCode;
            string errorMessage;

            RVDigitalModel oRVDigitalModel = new RVDigitalModel();
            oRVDigitalModel.listaCampania = GetCampaniasRVDigitalWeb(out errorServicio, out errorCode, out errorMessage);

            if (errorServicio)
            {
                ViewBag.ErrorDescripcion = "Ocurrió un error al intentar obtener la información. Por favor, vuelva a intentar dentro de unos minutos.";
            }
            else
            {
                if (errorCode == string.Empty || errorCode == "00000")
                    ViewBag.ErrorDescripcion = string.Empty;
                else
                    ViewBag.ErrorDescripcion = errorMessage;
            }
            return View(oRVDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            bool errorServicio;
            string errorCode;
            string errorMessage;
            List<RVPRFModel> lst = new List<RVPRFModel>();

            if (!string.IsNullOrEmpty(Campania))
            {
                lst = GetPDFRVDigitalWeb(Campania, out errorServicio, out errorCode, out errorMessage);
            }
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

        public List<CampaniaModel> GetCampaniasRVDigitalWeb(out bool errorServicio, out string errorCode, out string errorMessage)
        {
            UsuarioModel usuario = UserData();
            var complain = new RVDWebCampaniasParam { Pais = usuario.CodigoISO, Tipo = "1", CodigoConsultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora) };
            List<CampaniaModel> lstCampaniaModel = new List<CampaniaModel>();
            errorServicio = false;
            errorCode = string.Empty;
            errorMessage = string.Empty;
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
                if (reader != null)
                {
                    StreamReader sReader = new StreamReader(reader);
                    string outResult = sReader.ReadToEnd();
                    sReader.Close();

                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();

                    WrapperCampanias st = jsonSerializer.Deserialize<WrapperCampanias>(outResult);
                    if (st != null && st.LIS_CampanaResult != null)
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
                                errorCode = st.LIS_CampanaResult.errorCode;
                                errorMessage = st.LIS_CampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            errorCode = st.LIS_CampanaResult.errorCode;
                            errorMessage = st.LIS_CampanaResult.errorMessage;
                        }
                        
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorServicio = true;
            }

            if (lstCampaniaModel.Count != 0)
                return lstCampaniaModel.Distinct().OrderBy(p => p.CampaniaID).ToList();

            return lstCampaniaModel;
        }

        public List<RVPRFModel> GetPDFRVDigitalWeb(string campania, out bool errorServicio, out string errorCode, out string errorMessage)
        {
            UsuarioModel usuario = UserData();
            var complain = new RVDWebCampaniasParam { Pais = usuario.CodigoISO, Tipo = "1", CodigoConsultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora), Campana = campania };
            List<RVPRFModel> lstRVPRFModel = new List<RVPRFModel>();
            errorServicio = false;
            errorCode = string.Empty;
            errorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_PDF_NEW);
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
                if (reader != null)
                {
                    StreamReader sReader = new StreamReader(reader);
                    string outResult = sReader.ReadToEnd();
                    sReader.Close();

                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();

                    WrapperPDFWeb st = jsonSerializer.Deserialize<WrapperPDFWeb>(outResult);
                    if (st != null && st.GET_URLResult != null)
                    {
                        if (st.GET_URLResult.errorCode == "00000" || st.GET_URLResult.errorMessage == "OK")
                        {
                            if (st.GET_URLResult.objeto != null && st.GET_URLResult.objeto.Count != 0)
                            {
                                foreach (var item in st.GET_URLResult.objeto)
                                {
                                    lstRVPRFModel.Add(new RVPRFModel() { Nombre = "Paquete Documentario", FechaFacturacion = item.fechaFacturacion, Ruta = Convert.ToString(item.url) });
                                }
                            }

                        }
                        else
                        {
                            errorCode = st.GET_URLResult.errorCode;
                            errorMessage = st.GET_URLResult.errorMessage;
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorServicio = true;
            }

            return lstRVPRFModel;
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
