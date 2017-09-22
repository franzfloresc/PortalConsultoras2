using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.BizLogic
{
    public class BLCatalogo
    {
        public IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID)
        {
            var catalogos = new List<BECatalogo>();
            var DACatalogo = new DACatalogo(paisID);

            using (IDataReader reader = DACatalogo.GetCatalogosByCampania(campaniaID))
                while (reader.Read())
                {
                    var catalogo = new BECatalogo(reader);
                    catalogos.Add(catalogo);
                }

            return catalogos;
        }

        // RQ 2295 Mejoras en Catalogos Belcorp
        public IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID)
        {
            var catalogos = new List<BECatalogoConfiguracion>();
            var DACatalogo = new DACatalogo(paisID);

            using (IDataReader reader = DACatalogo.GetCatalogoConfiguracion())
                while (reader.Read())
                {
                    var catalogo = new BECatalogoConfiguracion(reader);
                    catalogos.Add(catalogo);
                }

            return catalogos;
        }

        public List<BECatalogoIssuu> GetCatalogosIssuuPublicados(string paisISO, string campaniaId)
        {
            List<BECatalogoIssuu> catalogos = new List<BECatalogoIssuu>();
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            string urlISSUUVisor = "http://issuu.com/somosbelcorp/docs/";

            try
            {
                string catalogoCampania = this.getPaisNombreByISO(paisISO) + ".c" + campaniaId.Substring(4, 2) + "." + campaniaId.Substring(0, 4);
                string catalogoLbel = "lbel." + catalogoCampania;
                string catalogoEsika = "esika." + catalogoCampania;
                string catalogoCyzone = "cyzone." + catalogoCampania;
                string catalogoFinart = "finart." + catalogoCampania;

                var url = urlISSUUSearch +
                    "docname:" + catalogoLbel + "+OR+" +
                    "docname:" + catalogoEsika + "+OR+" +
                    "docname:" + catalogoCyzone + "+OR+" +
                    "docname:" + catalogoFinart + "&jsonCallback=?";

                string response = "";
                using (var wc = new WebClient())
                {
                    using (Stream myStream = wc.OpenRead(new Uri(url)))
                    {
                        using (StreamReader streamReader = new StreamReader(myStream))
                        {
                            response = streamReader.ReadToEnd();
                        }
                    }
                }

                if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

                foreach (var doc in jsonReponse["response"]["docs"])
                {
                    string docName = doc["docname"], documentId = doc["documentId"];

                    if (docName == catalogoLbel) catalogos.Add(new BECatalogoIssuu { MarcaID = 1, CodigoIssuu = documentId, UrlVisor = urlISSUUVisor + docName });
                    else if (docName == catalogoEsika) catalogos.Add(new BECatalogoIssuu { MarcaID = 2, CodigoIssuu = documentId, UrlVisor = urlISSUUVisor + docName });
                    else if (docName == catalogoCyzone) catalogos.Add(new BECatalogoIssuu { MarcaID = 3, CodigoIssuu = documentId, UrlVisor = urlISSUUVisor + docName });
                    else if (docName == catalogoFinart) catalogos.Add(new BECatalogoIssuu { MarcaID = 4, CodigoIssuu = documentId, UrlVisor = urlISSUUVisor + docName });
                }
            }
            catch (Exception) { catalogos = new List<BECatalogoIssuu>(); }
            return catalogos;
        }

        public List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            List<BECatalogoRevista> listCatalogoRevista = this.GetAllCatalogoRevista();
            try
            {
                SetCatalogoRevistaMostrar(paisISO, campania, listCatalogoRevista);
                SetCatalogoRevistaCodigoIssuu(paisISO, codigoZona, campania, listCatalogoRevista);
                SetCatalogoRevistaFieldsInOembedIssuu(paisISO, listCatalogoRevista.Where(cr => cr.MarcaID == 0).ToList());
                SetCatalogoRevistaFieldsInSearchIssuu(listCatalogoRevista.Where(cr => cr.MarcaID != 0).ToList(), tamanioImagenIssu);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisISO);
                listCatalogoRevista = new List<BECatalogoRevista>();
            }
            return listCatalogoRevista;
        }

        public List<BECatalogoRevista> GetListCatalogoRevistaPublicadoWithTitulo(string paisISO, string codigoZona, int campania)
        {
            List<BECatalogoRevista> listCatalogoRevista = this.GetAllCatalogoRevista();
            try
            {
                SetCatalogoRevistaMostrar(paisISO, campania, listCatalogoRevista);
                SetCatalogoRevistaCodigoIssuu(paisISO, codigoZona, campania, listCatalogoRevista);                
                SetCatalogoRevistaFieldsInOembedIssuu(paisISO, listCatalogoRevista);
                AjusteRevistaTituloDescripcion(paisISO, campania, listCatalogoRevista);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisISO);
                listCatalogoRevista = new List<BECatalogoRevista>();
            }
            return listCatalogoRevista;
        }
        
        #region Private Functions

        private string getPaisNombreByISO(string paisISO)
        {
            switch (paisISO)
            {
                case "AR": return "argentina";
                case "BO": return "bolivia";
                case "CL": return "chile";
                case "CO": return "colombia";
                case "CR": return "costarica";
                case "DO": return "republicadominicana";
                case "EC": return "ecuador";
                case "GT": return "guatemala";
                case "MX": return "mexico";
                case "PA": return "panama";
                case "PE": return "peru";
                case "PR": return "puertorico";
                case "SV": return "elsalvador";
                case "VE": return "venezuela";
                default: return "sinpais";
            }
        }

        private List<BECatalogoRevista> GetAllCatalogoRevista()
        {
            return new List<BECatalogoRevista> {
                new BECatalogoRevista
                {
                    MarcaID = 0,
                    MarcaDescripcion = "Revista",
                    UrlImagen = Constantes.CatalogoImagenDefault.Revista,
                    UrlVisor = ""
                },
                new BECatalogoRevista
                {
                    MarcaID = Constantes.Marca.LBel,
                    MarcaDescripcion = "Lbel",
                    UrlImagen = Constantes.CatalogoImagenDefault.Catalogo,
                    UrlVisor = Constantes.CatalogoUrlDefault.Lbel
                },
                new BECatalogoRevista
                {
                    MarcaID = Constantes.Marca.Esika,
                    MarcaDescripcion = "Esika",
                    UrlImagen = Constantes.CatalogoImagenDefault.Catalogo,
                    UrlVisor = Constantes.CatalogoUrlDefault.Esika
                },
                new BECatalogoRevista
                {
                    MarcaID = Constantes.Marca.Cyzone,
                    MarcaDescripcion = "Cyzone",
                    UrlImagen = Constantes.CatalogoImagenDefault.Catalogo,
                    UrlVisor = Constantes.CatalogoUrlDefault.Cyzone
                },
                new BECatalogoRevista
                {
                    MarcaID = Constantes.Marca.Finart,
                    MarcaDescripcion = "Finart",
                    UrlImagen = Constantes.CatalogoImagenDefault.Catalogo
                }
            };
        }

        private void SetCatalogoRevistaMostrar(string paisISO, int campania, List<BECatalogoRevista> listCatalogoRevista)
        {            
            var listCatalogoConfiguracion = this.GetCatalogoConfiguracion(Util.GetPaisID(paisISO)).ToList();

            foreach (var catalogoRevista in listCatalogoRevista)
            {
                if (catalogoRevista.MarcaID == Constantes.Marca.Esika && EsCatalogoUnificado(paisISO, campania))
                {
                    catalogoRevista.Mostrar = false;
                    continue;
                }
                catalogoRevista.Mostrar = CampaniaInicioFin(listCatalogoConfiguracion.FirstOrDefault(cc => cc.MarcaID == catalogoRevista.MarcaID), campania);
            }
        }

        private bool CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            if (catalogo == null) return true;

            string resultado = catalogo.Estado.ToString();
            if (catalogo.Estado == 2)
            {
                resultado = "1";
                if ((campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin)
                    || (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 && campania >= catalogo.CampaniaInicio)
                    )
                {
                    resultado = "0";
                }
            }
            return resultado != "1";
        }

        private bool EsCatalogoUnificado(string paisISO, int campania)
        {
            string paisesCatalogoUnificado = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"] ?? "";
            if (!paisesCatalogoUnificado.Contains(paisISO)) return false;

            string paisUnificado = paisesCatalogoUnificado.Split(';').FirstOrDefault(pais => pais.Contains(paisISO));
            if (paisUnificado == null) return false;

            string[] paisCamp = paisUnificado.Split(',');
            if (paisCamp.Length < 2) return false;

            int campaniaInicio = Convert.ToInt32(paisCamp[1]);
            return campania >= campaniaInicio;
        }
        
        private void SetCatalogoRevistaCodigoIssuu(string paisISO, string codigoZona, int campania, List<BECatalogoRevista> listCatalogoRevista)
        {
            string nombreCatalogoConfig = null, codigo;
            foreach (var catalogoRevista in listCatalogoRevista)
            {
                nombreCatalogoConfig = catalogoRevista.MarcaDescripcion.ToUpper(1);
                string zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + paisISO + campania] ?? "";
                bool esCatalogoRevistaPiloto = zonas.SplitAndTrim(',').Contains(codigoZona);
                if (esCatalogoRevistaPiloto) catalogoRevista.CodigoIssuu = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + paisISO + campania];
                if (!string.IsNullOrEmpty(catalogoRevista.CodigoIssuu)) continue;

                if (catalogoRevista.MarcaID == 0)
                {
                    codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"] ?? "";
                    catalogoRevista.CodigoIssuu = string.Format(codigo, paisISO.ToLower(), campania.Substring(4, 2), campania.Substring(0, 4));
                }
                else
                {
                    codigo = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"] ?? "";
                    catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.MarcaDescripcion.ToLower(), getPaisNombreByISO(paisISO), campania.Substring(4, 2), campania.Substring(0, 4));
                }
            }
        }

        private void SetCatalogoRevistaFieldsInSearchIssuu(List<BECatalogoRevista> listCatalogoRevista, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            var queryString = "";
            for (int i = 0; i < listCatalogoRevista.Count; i++)
            {
                queryString += "docname:" + listCatalogoRevista[i].CodigoIssuu;
                if(i < listCatalogoRevista.Count - 1) queryString += "+OR+";
                else queryString += "&jsonCallback=?";
            }
            
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            var url = urlISSUUSearch + queryString;
            string response = "";
            using (var wc = new WebClient())
            {
                using (Stream myStream = wc.OpenRead(new Uri(url)))
                {
                    using (StreamReader streamReader = new StreamReader(myStream))
                    {
                        response = streamReader.ReadToEnd();
                    }
                }
            }
            if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

            string tamanioImagen = "";
            switch (tamanioImagenIssu)
            {
                case Enumeradores.TamanioImagenIssu.ThumbSmall: tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbSmall; break;
                case Enumeradores.TamanioImagenIssu.ThumbMedium: tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbMedium; break;
                case Enumeradores.TamanioImagenIssu.ThumbLarge: tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbLarge; break;
            }

            BECatalogoRevista catalogoRevista = null;
            string UrlIssuuImage = ConfigurationManager.AppSettings["UrlIssuuImage"] ?? "";
            string urlIssuuVisor = ConfigurationManager.AppSettings["UrlIssuu"] ?? "";
            foreach (var doc in jsonReponse["response"]["docs"])
            {
                catalogoRevista = listCatalogoRevista.FirstOrDefault(cr => cr.CodigoIssuu == doc["docname"]);
                if(catalogoRevista != null)
                {
                    catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
                    catalogoRevista.UrlImagen = string.Format(UrlIssuuImage, doc["documentId"], tamanioImagen);
                }
            }
        }

        private void SetCatalogoRevistaFieldsInOembedIssuu(string paisISO, List<BECatalogoRevista> listCatalogoRevista)
        {
            string urlISSUUSearch = "https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/";
            string url, response;

            foreach (var catalogoRevista in listCatalogoRevista)
            {
                url = urlISSUUSearch + catalogoRevista.CodigoIssuu;
                response = "";
                try
                {
                    using (var wc = new WebClient())
                    {
                        using (Stream myStream = wc.OpenRead(new Uri(url)))
                        {
                            using (StreamReader streamReader = new StreamReader(myStream))
                            {
                                response = streamReader.ReadToEnd();
                            }
                        }
                    }
                    if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
                    JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                    var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

                    string urlIssuuVisor = ConfigurationManager.AppSettings["UrlIssuu"] ?? "";
                    catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
                    catalogoRevista.UrlImagen = jsonReponse["thumbnail_url"];
                    catalogoRevista.CatalogoTitulo = jsonReponse["title"];
                    catalogoRevista.CatalogoDescripcion = jsonReponse["description"];
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisISO); }
            }
        }

        private void AjusteRevistaTituloDescripcion(string paisISO, int campania, List<BECatalogoRevista> listCatalogoRevista)
        {
            var paisesEsika = ConfigurationManager.AppSettings.Get("PaisesEsika") ?? "";
            string paisNombre = Util.GetPaisNombre(Util.GetPaisID(paisISO));
            string revistaNombre = null;

            listCatalogoRevista.Where(cr => cr.MarcaID == 0).ToList().ForEach(cr =>
            {
                revistaNombre = paisesEsika.Contains(paisISO) ? Constantes.RevistaNombre.Esika : Constantes.RevistaNombre.Lbel;


                cr.CatalogoTitulo = string.Format("{0} {1} C{2}", revistaNombre, paisNombre, campania.Substring(4, 2));
                cr.CatalogoDescripcion = string.Format("Revista/Campaña {0}/{1}/{2}", campania.Substring(4, 2), paisNombre, campania.Substring(0, 4)); ;
            });
        }

        #endregion
    }
}
