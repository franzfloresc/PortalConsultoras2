﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Portal.Consultoras.Common.Settings;

namespace Portal.Consultoras.BizLogic
{
    public class BLCatalogo : ICatalogoBusinessLogic
    {
        private readonly string _urlISSUUSearch = "https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/";

        private readonly List<BECatalogoRevista> _catalogosRevistas = new List<BECatalogoRevista>
            {
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
                }

            };

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

        public List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            List<BECatalogoRevista> listCatalogoRevista = _catalogosRevistas;

            try
            {
                var catalogoConfiguraciones = GetCatalogoConfiguracion(Util.GetPaisID(paisISO));
                listCatalogoRevista = GetAllCatalogoRevista(paisISO, new [] { campania });
                foreach (var catalogoRevista in listCatalogoRevista)
                {
                    SetCatalogoRevistaMostrar(catalogoRevista, catalogoConfiguraciones);
                    SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                    if (catalogoRevista.MarcaID == 0)
                        Task.WaitAll(SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista));
                }

                SetCatalogoRevistaFieldsInSearchIssuu(listCatalogoRevista.Where(cr => cr.MarcaID != 0).ToList(), tamanioImagenIssu);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisISO);
                listCatalogoRevista = new List<BECatalogoRevista>();
            }
            return listCatalogoRevista;
        }

        public async Task<List<BECatalogoRevista>> GetCatalogoRevista(string paisISO, string codigoZona, IEnumerable<int> campanias)
        {
            var catalogoRevistas = new List<BECatalogoRevista>();

            try
            {
                var catalogoConfiguraciones = GetCatalogoConfiguracion(Util.GetPaisID(paisISO));

                catalogoRevistas = GetAllCatalogoRevista(paisISO, campanias);

                foreach (var catalogoRevista in catalogoRevistas)
                {
                    SetCatalogoRevistaMostrar(catalogoRevista, catalogoConfiguraciones);
                    SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                    await SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista);
                    AjusteRevistaTituloDescripcion(catalogoRevista);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisISO);
            }

            return catalogoRevistas;
        }
        #region Private Functions

        private List<BECatalogoRevista> GetAllCatalogoRevista(string paisISO, IEnumerable<int> campanias)
        {
            var catalogoRevistas = new List<BECatalogoRevista>();

            foreach (var campania in campanias)
            {
                _catalogosRevistas.ForEach(c =>
                {
                    catalogoRevistas.Add(new BECatalogoRevista()
                    {
                        CampaniaID = campania,
                        PaisISO = paisISO,
                        MarcaID = c.MarcaID,
                        MarcaDescripcion = c.MarcaDescripcion,
                        UrlImagen = c.UrlImagen,
                        UrlVisor = c.UrlVisor
                    });
                });
            }

            return catalogoRevistas;
        }

        private void SetCatalogoRevistaMostrar(BECatalogoRevista catalogoRevista, IList<BECatalogoConfiguracion> catalogoConfiguraciones)
        {
            if (catalogoRevista.MarcaID == Constantes.Marca.Esika && EsCatalogoUnificado(catalogoRevista.PaisISO, catalogoRevista.CampaniaID))
                catalogoRevista.Mostrar = false;
            else
                catalogoRevista.Mostrar = this.CampaniaInicioFin(catalogoConfiguraciones.FirstOrDefault(cc => cc.MarcaID == catalogoRevista.MarcaID), catalogoRevista.CampaniaID);
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

        private void SetCatalogoRevistaCodigoIssuu(string codigoZona, BECatalogoRevista catalogoRevista)
        {
            string nombreCatalogoConfig = null, codigo;
            nombreCatalogoConfig = catalogoRevista.MarcaDescripcion.ToUpper(1);
            string zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + catalogoRevista.PaisISO + catalogoRevista.CampaniaID] ?? "";
            bool esCatalogoRevistaPiloto = zonas.SplitAndTrim(',').Contains(codigoZona);
            if (esCatalogoRevistaPiloto) catalogoRevista.CodigoIssuu = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + catalogoRevista.PaisISO + catalogoRevista.CampaniaID];
            if (!string.IsNullOrEmpty(catalogoRevista.CodigoIssuu)) return;

            if (catalogoRevista.MarcaID == 0)
            {
                codigo = ServiceSettings.Instance.CodigoRevistaIssuu;
                catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), catalogoRevista.CampaniaID.Substring(4, 2), catalogoRevista.CampaniaID.Substring(0, 4));
            }
            else
            {
                codigo = ServiceSettings.Instance.CodigoCatalogoIssuu;
                catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.MarcaDescripcion.ToLower(), GetPaisNombreByISO(catalogoRevista.PaisISO), catalogoRevista.CampaniaID.Substring(4, 2), catalogoRevista.CampaniaID.Substring(0, 4));
            }
        }

        private void SetCatalogoRevistaFieldsInSearchIssuu(List<BECatalogoRevista> listCatalogoRevista, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            var queryString = "";
            for (int i = 0; i < listCatalogoRevista.Count; i++)
            {
                queryString += "docname:" + listCatalogoRevista[i].CodigoIssuu;
                if (i < listCatalogoRevista.Count - 1) queryString += "+OR+";
                else queryString += "&jsonCallback=?";
            }

            string urlISSUUSearch = "http:" + Constantes.CatalogoUrlIssu.Buscador;
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
                if (catalogoRevista != null)
                {
                    catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
                    catalogoRevista.UrlImagen = string.Format(UrlIssuuImage, doc["documentId"], tamanioImagen);
                }
            }
        }

        private async Task SetCatalogoRevistaFieldsInOembedIssuu(BECatalogoRevista catalogoRevista)
        {
            if (string.IsNullOrEmpty(catalogoRevista.CodigoIssuu))
            {
                LogManager.SaveLog(null, "", "Codigo issuu null o vacio");
                return;
            }

            var url = string.Format("{0}{1}", _urlISSUUSearch, catalogoRevista.CodigoIssuu);

            try
            {
                var reponse = await ObtenerObjetoIssueAsync(url);
                if (!reponse.Item1)
                    return;

                string urlIssuuVisor = ServiceSettings.Instance.UrlIssuu;
                catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
                catalogoRevista.UrlImagen = reponse.Item2.thumbnail_url;
                catalogoRevista.CatalogoTitulo = reponse.Item2.title;
                catalogoRevista.CatalogoDescripcion = reponse.Item2.description;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", catalogoRevista.PaisISO);
            }
        }

        private void AjusteRevistaTituloDescripcion(BECatalogoRevista catalogoRevista)
        {
            var paisesEsika = ServiceSettings.Instance.PaisesEsika;
            string paisNombre = Util.GetPaisNombre(Util.GetPaisID(catalogoRevista.PaisISO));
            string revistaNombre = null;

            if (catalogoRevista.MarcaID == 0)
            {
                revistaNombre = paisesEsika.Contains(catalogoRevista.PaisISO) ? Constantes.RevistaNombre.Esika : Constantes.RevistaNombre.Lbel;
                catalogoRevista.CatalogoTitulo = string.Format("{0} {1} C{2}", revistaNombre, paisNombre, catalogoRevista.CampaniaID.Substring(4, 2));
                catalogoRevista.CatalogoDescripcion = string.Format("Revista/Campaña {0}/{1}/{2}", catalogoRevista.CampaniaID.Substring(4, 2), paisNombre, catalogoRevista.CampaniaID.Substring(0, 4));
            }
        }

        private async Task<Tuple<bool, dynamic>> ObtenerObjetoIssueAsync(string url)
        {
            using (var client = new HttpClient())
            {
                var response = await client.GetAsync(url);
                if (!response.IsSuccessStatusCode)
                {
                    LogManager.SaveLog(null, "", "Error " + response.StatusCode);
                    return new Tuple<bool, dynamic>(false, null);
                }

                var content = await response.Content.ReadAsStringAsync();

                if (string.IsNullOrEmpty(content))
                {
                    LogManager.SaveLog(null, "", "Null content " + response.StatusCode);
                    return new Tuple<bool, dynamic>(false, null);
                }

                return new Tuple<bool, dynamic>(true, Newtonsoft.Json.Linq.JObject.Parse(content));
            }
        }
        
        private string GetPaisNombreByISO(string paisISO)
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
