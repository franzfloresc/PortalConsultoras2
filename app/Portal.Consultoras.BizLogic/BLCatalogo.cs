using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
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

        #endregion
    }
}
