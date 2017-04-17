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
            string urlIssuuVisor = ConfigurationManager.AppSettings["UrlIssuu"] ?? "";          

            try
            {
                SetCatalogoRevistaMostrar(paisISO, campania, listCatalogoRevista);
                SetCatalogoCodigoCatalogo(paisISO, codigoZona, campania, listCatalogoRevista);

                var dictionaryIssu = new Dictionary<string, string>();
                this.AddIssuuRevista(paisISO, listCatalogoRevista, dictionaryIssu);
                this.AddIssuuCatalogo(listCatalogoRevista, tamanioImagenIssu, dictionaryIssu);

                foreach (var catalogoRevista in listCatalogoRevista)
                {
                    if (dictionaryIssu.ContainsKey(catalogoRevista.CodigoCatalogo))
                    {
                        catalogoRevista.UrlImagen = dictionaryIssu[catalogoRevista.CodigoCatalogo];
                        catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoCatalogo);
                    }
                }
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
                //new BECatalogoRevista
                //{
                //    MarcaID = Constantes.Marca.Finart,
                //    MarcaDescripcion = "Finart"
                //}
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
        
        private void SetCatalogoCodigoCatalogo(string paisISO, string codigoZona, int campania, List<BECatalogoRevista> listCatalogoRevista)
        {
            foreach (var catalogoRevista in listCatalogoRevista)
            {
                if (catalogoRevista.MarcaID == 0) catalogoRevista.CodigoCatalogo = GetRevistaCodigoIssuu(paisISO, codigoZona, campania.ToString());
                else catalogoRevista.CodigoCatalogo = GetCatalogoCodigoIssuu(paisISO, codigoZona, campania.ToString(), catalogoRevista.MarcaID);
            }
        }

        protected string GetRevistaCodigoIssuu(string paisISO, string codigoZona, string campania)
        {
            string codigo = null;
            string zonas = ConfigurationManager.AppSettings["RevistaPiloto_Zonas_" + paisISO + campania] ?? "";
            bool esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(codigoZona);
            if (esRevistaPiloto) codigo = ConfigurationManager.AppSettings["RevistaPiloto_Codigo_" + paisISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"] ?? "";
            return string.Format(codigo, paisISO.ToLower(), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        protected string GetCatalogoCodigoIssuu(string paisISO, string codigoZona, string campania, int idMarcaCatalogo)
        {
            string nombreCatalogoIssuu = null, nombreCatalogoConfig = null;
            switch (idMarcaCatalogo)
            {
                case Constantes.Marca.LBel:
                    nombreCatalogoIssuu = "lbel";
                    nombreCatalogoConfig = "Lbel";
                    break;
                case Constantes.Marca.Esika:
                    nombreCatalogoIssuu = "esika";
                    nombreCatalogoConfig = "Esika";
                    break;
                case Constantes.Marca.Cyzone:
                    nombreCatalogoIssuu = "cyzone";
                    nombreCatalogoConfig = "Cyzone";
                    break;
                case Constantes.Marca.Finart:
                    nombreCatalogoIssuu = "finart";
                    nombreCatalogoIssuu = "Finart";
                    break;
            }

            string codigo = null;
            string zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + paisISO + campania] ?? "";
            bool esCatalogoPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(codigoZona);
            if (esCatalogoPiloto) codigo = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + paisISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"] ?? "";
            return string.Format(codigo, nombreCatalogoIssuu, getPaisNombreByISO(paisISO), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        private void AddIssuuCatalogo(List<BECatalogoRevista> listCatalogoRevista, Enumeradores.TamanioImagenIssu tamanioImagenIssu, Dictionary<string, string> dictionaryIssuu)
        {
            var queryString = "";
            var listCatalogo = listCatalogoRevista.Where(cr => cr.MarcaID != 0).ToList();
            for (int i = 0; i < listCatalogo.Count; i++)
            {
                var catalogoRevista = listCatalogo[i];
                queryString += "docname:" + catalogoRevista.CodigoCatalogo;

                if(i < listCatalogo.Count - 1) queryString += "+OR+";
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

            string UrlIssuuImage = ConfigurationManager.AppSettings["UrlIssuuImage"] ?? "";
            foreach (var doc in jsonReponse["response"]["docs"])
            {
                dictionaryIssuu.Add(doc["docname"], string.Format(UrlIssuuImage, doc["documentId"], tamanioImagen));
            }
        }

        private void AddIssuuRevista(string paisISO, List<BECatalogoRevista> listCatalogoRevista, Dictionary<string, string> dictionaryIssuu)
        {
            var revista = listCatalogoRevista.FirstOrDefault(cr => cr.MarcaID == 0);
            if (revista == null) return;

            string urlISSUUSearch = "https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/";
            var url = urlISSUUSearch + revista.CodigoCatalogo;
            try
            {
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
                dictionaryIssuu.Add(revista.CodigoCatalogo, jsonReponse["thumbnail_url"]);
            }
            catch (Exception ex) { LogManager.SaveLog(ex, "", paisISO); }            
        }

        #endregion
    }
}
