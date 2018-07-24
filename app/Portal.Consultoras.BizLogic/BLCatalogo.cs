using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Settings;
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
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.BizLogic
{
    public class BLCatalogo : ICatalogoBusinessLogic
    {
        private readonly int ObjetoIssueTimeOut = 10;
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
            var daCatalogo = new DACatalogo(paisID);

            using (IDataReader reader = daCatalogo.GetCatalogosByCampania(campaniaID))
                while (reader.Read())
                {
                    var catalogo = new BECatalogo(reader);
                    catalogos.Add(catalogo);
                }

            return catalogos;
        }

        public IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID)
        {
            using (IDataReader reader = new DACatalogo(paisID).GetCatalogoConfiguracion())
            {
                return reader.MapToCollection<BECatalogoConfiguracion>();
            }
        }

        public List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            List<BECatalogoRevista> listCatalogoRevista;

            try
            {
                var catalogoConfiguraciones = GetCatalogoConfiguracion(Util.GetPaisID(paisISO));
                listCatalogoRevista = GetAllCatalogoRevista(paisISO, new[] { campania });
                foreach (var catalogoRevista in listCatalogoRevista)
                {
                    SetCatalogoRevistaMostrar(catalogoRevista, catalogoConfiguraciones);
                    SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                    if (catalogoRevista.MarcaID == 0)
                        SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista);
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

        public List<BECatalogoRevista> GetCatalogoRevista(string paisISO, string codigoZona, List<int> campanias)
        {
            var catalogoRevistas = new List<BECatalogoRevista>();
            var lstTask = new List<Task<BECatalogoRevista>>();

            try
            {
                var catalogoConfiguraciones = GetCatalogoConfiguracion(Util.GetPaisID(paisISO));

                catalogoRevistas = GetAllCatalogoRevista(paisISO, campanias);

                foreach (var catalogoRevista in catalogoRevistas)
                {
                    SetCatalogoRevistaMostrar(catalogoRevista, catalogoConfiguraciones);
                    if (catalogoRevista.Mostrar) lstTask.Add(Task.Run(() => GetCatalogoRevista(catalogoRevista, codigoZona)));
                }

                var arrTask = lstTask.ToArray();
                Task.WaitAll(arrTask);
                catalogoRevistas = arrTask.Select(x => x.Result).ToList();
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisISO);
            }

            return catalogoRevistas;
        }

        #region Private Functions
        private BECatalogoRevista GetCatalogoRevista(BECatalogoRevista catalogoRevista, string codigoZona)
        {
            try
            {
                SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista);
                AjusteRevistaTituloDescripcion(catalogoRevista);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, catalogoRevista.PaisISO);
            }

            return catalogoRevista;
        }

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
            string codigo = null;
            bool esRevistaPiloto = false;
            var Grupos = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.RevistaPiloto_Grupos + catalogoRevista.PaisISO + catalogoRevista.CampaniaID];
            string codeGrupo = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;

            if (catalogoRevista.CampaniaID.ToString().Length >= 6)
                nroCampania = catalogoRevista.CampaniaID.Substring(4, 2);
            if (catalogoRevista.CampaniaID.ToString().Length >= 6)
                anioCampania = catalogoRevista.CampaniaID.Substring(0, 4);

            if (catalogoRevista.MarcaID == 0)
            {
                if (!string.IsNullOrEmpty(Grupos))
                {

                    foreach (var grupo in Grupos.Split(','))
                    {
                        var zonas = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.RevistaPiloto_Zonas + catalogoRevista.PaisISO + catalogoRevista.CampaniaID + "_" + grupo];
                        esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(codigoZona);
                        if (esRevistaPiloto)
                        {
                            codeGrupo = grupo.Trim().ToString();
                            break;
                        }
                    }
                }
                else
                    esRevistaPiloto = false;

                codigo = ServiceSettings.Instance.CodigoRevistaIssuu;

                if (esRevistaPiloto)
                    catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), nroCampania, anioCampania, codeGrupo.Replace(Constantes.ConfiguracionManager.RevistaPiloto_Escenario, ""));
                else
                {
                    catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), nroCampania, anioCampania, "");
                    catalogoRevista.CodigoIssuu = Util.Trim(catalogoRevista.CodigoIssuu.Substring(catalogoRevista.CodigoIssuu.Length - 1)) == "." ? catalogoRevista.CodigoIssuu.Substring(0, catalogoRevista.CodigoIssuu.Length - 1) : catalogoRevista.CodigoIssuu;
                }
            }
            else
            {
                catalogoRevista.CodigoIssuu = GetCatalogoCodigoIssuu(catalogoRevista.CampaniaID.ToString(), catalogoRevista.MarcaID, catalogoRevista.PaisISO, codigoZona, ServiceSettings.Instance.CodigoCatalogoIssuu, nroCampania, anioCampania);
            }
        }

        private string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo, string CodigoISO, string CodigoZona, string codigo, string nroCampania, string anioCampania)
        {
            string nombreCatalogoIssuu = null;
            string nombreCatalogoConfig = null;
            string CodeGrup = null;
            string requestUrl = null;
            bool esRevistaPiloto = false;
            string Grupos = null;
            string marcas = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.Catalogo_Marca_Piloto + CodigoISO + campania] ?? "";
            bool esMarcaEspecial = false;

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
                    break;
            }

            Grupos = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.Catalogo_Piloto_Grupos + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + CodigoISO + campania] ?? "";
            esMarcaEspecial = marcas.Split(new char[1] { ',' }).Select(marca => marca.Trim()).Contains(nombreCatalogoConfig);


            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.Catalogo_Piloto_Zonas + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + CodigoISO + campania + Constantes.ConfiguracionManager.SubGuion + grupo] ?? "";
                    esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(CodigoZona);
                    if (esRevistaPiloto)
                    {
                        CodeGrup = grupo.Trim().ToString();
                        break;
                    }
                }
            }
            else
                esRevistaPiloto = false;

            if (esRevistaPiloto && esMarcaEspecial)
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, GetPaisNombreByISO(CodigoISO), nroCampania, anioCampania, CodeGrup.Replace(Constantes.ConfiguracionManager.Catalogo_Piloto_Escenario, ""));
            else
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, GetPaisNombreByISO(CodigoISO), campania.Substring(4, 2), campania.Substring(0, 4), "");
                requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "." ? requestUrl.Substring(0, requestUrl.Length - 1) : requestUrl;
            }

            return requestUrl;
        }

        //private void SetCatalogoRevistaCodigoIssuu_Backup(string codigoZona, BECatalogoRevista catalogoRevista)
        //{
        //    string codigo;
        //    var nombreCatalogoConfig = catalogoRevista.MarcaDescripcion.ToUpper(1);
        //    string zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + catalogoRevista.PaisISO + catalogoRevista.CampaniaID] ?? "";
        //    bool esCatalogoRevistaPiloto = zonas.SplitAndTrim(',').Contains(codigoZona);
        //    if (esCatalogoRevistaPiloto) catalogoRevista.CodigoIssuu = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + catalogoRevista.PaisISO + catalogoRevista.CampaniaID];
        //    if (!string.IsNullOrEmpty(catalogoRevista.CodigoIssuu)) return;

        //    if (catalogoRevista.MarcaID == 0)
        //    {
        //        codigo = ServiceSettings.Instance.CodigoRevistaIssuu;
        //        catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), catalogoRevista.CampaniaID.Substring(4, 2), catalogoRevista.CampaniaID.Substring(0, 4));
        //    }
        //    else
        //    {
        //        codigo = ServiceSettings.Instance.CodigoCatalogoIssuu;
        //        catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.MarcaDescripcion.ToLower(), GetPaisNombreByISO(catalogoRevista.PaisISO), catalogoRevista.CampaniaID.Substring(4, 2), catalogoRevista.CampaniaID.Substring(0, 4));
        //    }
        //}

        private void SetCatalogoRevistaFieldsInSearchIssuu(List<BECatalogoRevista> listCatalogoRevista, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            var txtBuil = new StringBuilder();
            for (int i = 0; i < listCatalogoRevista.Count; i++)
            {
                txtBuil.Append("docname:" + listCatalogoRevista[i].CodigoIssuu);
                if (i < listCatalogoRevista.Count - 1) txtBuil.Append("+OR+");
                else txtBuil.Append("&jsonCallback=?");
            }

            string urlIssuuSearch = "http:" + Constantes.CatalogoUrlIssu.Buscador;
            var url = urlIssuuSearch + txtBuil.ToString();
            string response = "";
            using (var wc = new WebClient())
            {
                using (Stream myStream = wc.OpenRead(new Uri(url)))
                {
                    if (myStream != null)
                    {
                        using (StreamReader streamReader = new StreamReader(myStream))
                        {
                            response = streamReader.ReadToEnd();
                        }
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

            string urlIssuuImage = ConfigurationManager.AppSettings["UrlIssuuImage"] ?? "";
            string urlIssuuVisor = ConfigurationManager.AppSettings["UrlIssuu"] ?? "";
            foreach (var doc in jsonReponse["response"]["docs"])
            {
                var catalogoRevista = listCatalogoRevista.FirstOrDefault(cr => cr.CodigoIssuu == doc["docname"]);
                if (catalogoRevista != null)
                {
                    catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
                    catalogoRevista.UrlImagen = string.Format(urlIssuuImage, doc["documentId"], tamanioImagen);
                }
            }
        }

        private void SetCatalogoRevistaFieldsInOembedIssuu(BECatalogoRevista catalogoRevista)
        {
            if (string.IsNullOrEmpty(catalogoRevista.CodigoIssuu)) return;

            var url = string.Format("{0}{1}", _urlISSUUSearch, catalogoRevista.CodigoIssuu);

            var reponse = ObtenerObjetoIssue(url, catalogoRevista.PaisISO);
            if (!reponse.Item1) return;

            var urlIssuuVisor = ServiceSettings.Instance.UrlIssuu;
            catalogoRevista.UrlVisor = string.Format(urlIssuuVisor, catalogoRevista.CodigoIssuu);
            catalogoRevista.UrlImagen = reponse.Item2.thumbnail_url;
            catalogoRevista.CatalogoTitulo = reponse.Item2.title;
            catalogoRevista.CatalogoDescripcion = reponse.Item2.description;
        }

        private void AjusteRevistaTituloDescripcion(BECatalogoRevista catalogoRevista)
        {
            var paisesEsika = ServiceSettings.Instance.PaisesEsika;
            var paisNombre = Util.GetPaisNombre(Util.GetPaisID(catalogoRevista.PaisISO));

            if (catalogoRevista.MarcaID == 0)
            {
                var revistaNombre = paisesEsika.Contains(catalogoRevista.PaisISO) ? Constantes.RevistaNombre.Esika : Constantes.RevistaNombre.Lbel;
                catalogoRevista.CatalogoTitulo = string.Format("{0} {1} C{2}", revistaNombre, paisNombre, catalogoRevista.CampaniaID.Substring(4, 2));
                catalogoRevista.CatalogoDescripcion = string.Format("Revista/Campaña {0}/{1}/{2}", catalogoRevista.CampaniaID.Substring(4, 2), paisNombre, catalogoRevista.CampaniaID.Substring(0, 4));
            }
        }

        private Tuple<bool, dynamic> ObtenerObjetoIssue(string url, string codigoIso)
        {
            try
            {
                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    client.Timeout.Add(new TimeSpan(0, 0, ObjetoIssueTimeOut));

                    var response = client.GetAsync(url).Result;
                    response.EnsureSuccessStatusCode();

                    var content = response.Content.ReadAsStringAsync().Result;

                    if (string.IsNullOrEmpty(content)) return new Tuple<bool, dynamic>(false, null);

                    return new Tuple<bool, dynamic>(true, Newtonsoft.Json.Linq.JObject.Parse(content));
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, url, codigoIso);
                return new Tuple<bool, dynamic>(false, null);
            }
        }

        private string GetPaisNombreByISO(string paisISO)
        {
            switch (paisISO)
            {
                case Constantes.CodigosISOPais.Argentina: return "argentina";
                case Constantes.CodigosISOPais.Bolivia: return "bolivia";
                case Constantes.CodigosISOPais.Chile: return "chile";
                case Constantes.CodigosISOPais.Colombia: return "colombia";
                case Constantes.CodigosISOPais.CostaRica: return "costarica";
                case Constantes.CodigosISOPais.Dominicana: return "republicadominicana";
                case Constantes.CodigosISOPais.Ecuador: return "ecuador";
                case Constantes.CodigosISOPais.Guatemala: return "guatemala";
                case Constantes.CodigosISOPais.Mexico: return "mexico";
                case Constantes.CodigosISOPais.Panama: return "panama";
                case Constantes.CodigosISOPais.Peru: return "peru";
                case Constantes.CodigosISOPais.PuertoRico: return "puertorico";
                case Constantes.CodigosISOPais.Salvador: return "elsalvador";
                case Constantes.CodigosISOPais.Venezuela: return "venezuela";
                default: return "sinpais";
            }
        }
        #endregion

        #region Catalogo Revista ODS

        public List<BECatalogoRevista_ODS> SelectCatalogoRevistas_ODS(int paisID)
        {
            var catalogos = new List<BECatalogoRevista_ODS>();
            var daCatalogo = new DACatalogo(paisID);

            using (IDataReader reader = daCatalogo.GetCatalogoRevistas_ODS())
                while (reader.Read())
                {
                    var catalogo = new BECatalogoRevista_ODS(reader);
                    catalogos.Add(catalogo);
                }

            return catalogos;
        }

        public List<BECatalogoRevista_ODS> PS_CatalogoRevistas_ODS(int paisID)
        {
            //var oLista = new List<BECatalogoRevista_ODS>();
            var catalogos = SelectCatalogoRevistas_ODS(paisID);

            var oLista = catalogos.Where(x => x.Descripcion != null && x.Descripcion != Constantes.ConstSession.DescripcionPedidoOtro)
                               .GroupBy(test => test.Descripcion)
                               .Select(grp => grp.First())
                               .ToList();

            if (catalogos.Count(x => x.Descripcion == Constantes.ConstSession.DescripcionPedidoOtro) > 0)
                oLista.Add(new BECatalogoRevista_ODS { Descripcion = Constantes.ConstSession.DescripcionPedidoOtro, CodigoCatalogo = Constantes.ConstSession.CodigoPedidoOtro });

            return oLista;
        }

        #endregion
    }
}