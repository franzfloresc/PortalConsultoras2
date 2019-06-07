﻿using Portal.Consultoras.Common;
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

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common.Exceptions;

namespace Portal.Consultoras.BizLogic
{
    public class BLCatalogo : ICatalogoBusinessLogic
    {
        private readonly int _timeOutIssuu = 10;
        private readonly string _apiKeyIssuu = "hvmznfoyahpnv79c0hdl2dryksonbxcp";
        private readonly string _secretKeyIssuu = "0w9gg5qn6xsn98gazggk9l27hu07gikv";

        private readonly string _urlIssuuList =
            "http://api.issuu.com/1_0?action=issuu.documents.list&apiKey={0}&format=json&orgDocName={1}.pdf&signature={2}";

        private readonly string _signatureIssuu = "{0}actionissuu.documents.listapiKey{1}formatjsonorgDocName{2}.pdf";
        private static HttpClient httpClient = null;

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

        public BLCatalogo()
        {
            if (httpClient == null)
            {
                httpClient = new HttpClient();
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                httpClient.Timeout.Add(new TimeSpan(0, 0, _timeOutIssuu));
            }
        }

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

        public List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania,
            Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            List<BECatalogoRevista> listCatalogoRevista;
            bool ocurrioError = false;
            try
            {
                var catalogoConfiguraciones = GetCatalogoConfiguracion(Util.GetPaisID(paisISO));
                listCatalogoRevista = GetAllCatalogoRevista(paisISO, new[] {campania});
                foreach (var catalogoRevista in listCatalogoRevista)
                {
                    SetCatalogoRevistaMostrar(catalogoRevista, catalogoConfiguraciones);
                    SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                    if (catalogoRevista.MarcaID == 0)
                    {
                        ocurrioError = SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista);
                        if (ocurrioError) return new List<BECatalogoRevista>();
                    }
                }

                SetCatalogoRevistaFieldsInSearchIssuu(listCatalogoRevista.Where(cr => cr.MarcaID != 0).ToList(),
                    tamanioImagenIssu);
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
                    if (catalogoRevista.Mostrar)
                        lstTask.Add(Task.Run(() => GetCatalogoRevista(catalogoRevista, codigoZona)));
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
            bool ocurrioError = false;
            try
            {
                SetCatalogoRevistaCodigoIssuu(codigoZona, catalogoRevista);
                ocurrioError = SetCatalogoRevistaFieldsInOembedIssuu(catalogoRevista);
                if (!ocurrioError)
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

        private void SetCatalogoRevistaMostrar(BECatalogoRevista catalogoRevista,
            IList<BECatalogoConfiguracion> catalogoConfiguraciones)
        {
            if (catalogoRevista.MarcaID == Constantes.Marca.Esika &&
                EsCatalogoUnificado(catalogoRevista.PaisISO, catalogoRevista.CampaniaID))
                catalogoRevista.Mostrar = false;
            else
                catalogoRevista.Mostrar = this.CampaniaInicioFin(
                    catalogoConfiguraciones.FirstOrDefault(cc => cc.MarcaID == catalogoRevista.MarcaID),
                    catalogoRevista.CampaniaID);
        }

        private bool CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            if (catalogo == null) return true;

            string resultado = catalogo.Estado.ToString();
            if (catalogo.Estado == 2)
            {
                resultado = "1";
                if ((campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin)
                    || (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 &&
                        campania >= catalogo.CampaniaInicio)
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
            string codigo;
            bool esRevistaPiloto = false;
            string codeGrupo = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;
            var datos = new BLTablaLogicaDatos().GetListCache(Util.GetPaisID(catalogoRevista.PaisISO),
                Constantes.ConfiguracionManager.RevistaCatalogoTablaLogicaId);
            var Grupos = GetValueByCode(datos,
                Constantes.ConfiguracionManager.RevistaPiloto_Grupos + catalogoRevista.PaisISO +
                catalogoRevista.CampaniaID);

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
                        var zonas = GetValueByCode(datos,
                            Constantes.ConfiguracionManager.RevistaPiloto_Zonas + catalogoRevista.PaisISO +
                            catalogoRevista.CampaniaID + "_" + grupo);
                        esRevistaPiloto = zonas.Split(',').Select(zona => zona.Trim()).Contains(codigoZona);
                        if (esRevistaPiloto)
                        {
                            codeGrupo = grupo.Trim();
                            break;
                        }
                    }
                }
                else
                    esRevistaPiloto = false;

                codigo = ServiceSettings.Instance.CodigoRevistaIssuu;

                if (esRevistaPiloto)
                    catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), nroCampania,
                        anioCampania, codeGrupo.Replace(Constantes.ConfiguracionManager.RevistaPiloto_Escenario, ""));
                else
                {
                    catalogoRevista.CodigoIssuu = string.Format(codigo, catalogoRevista.PaisISO.ToLower(), nroCampania,
                        anioCampania, "");
                    catalogoRevista.CodigoIssuu =
                        Util.Trim(catalogoRevista.CodigoIssuu.Substring(catalogoRevista.CodigoIssuu.Length - 1)) == "."
                            ? catalogoRevista.CodigoIssuu.Substring(0, catalogoRevista.CodigoIssuu.Length - 1)
                            : catalogoRevista.CodigoIssuu;
                }
            }
            else
            {
                catalogoRevista.CodigoIssuu = GetCatalogoCodigoIssuu(catalogoRevista.CampaniaID.ToString(),
                    catalogoRevista.MarcaID, catalogoRevista.PaisISO, codigoZona,
                    ServiceSettings.Instance.CodigoCatalogoIssuu, nroCampania, anioCampania);
            }
        }

        private string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo, string CodigoISO, string CodigoZona,
            string codigo, string nroCampania, string anioCampania)
        {
            string nombreCatalogoIssuu = null;
            string nombreCatalogoConfig = null;
            string CodeGrup = null;
            string requestUrl;
            bool esRevistaPiloto = false;
            string Grupos;
            bool esMarcaEspecial;
            var datos = new BLTablaLogicaDatos().GetListCache(Util.GetPaisID(CodigoISO),
                Constantes.ConfiguracionManager.RevistaCatalogoTablaLogicaId);
            string marcas = GetValueByCode(datos,
                Constantes.ConfiguracionManager.Catalogo_Marca_Piloto + CodigoISO + campania);

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

            Grupos = GetValueByCode(datos,
                Constantes.ConfiguracionManager.Catalogo_Piloto_Grupos + nombreCatalogoConfig +
                Constantes.ConfiguracionManager.SubGuion + CodigoISO + campania);
            esMarcaEspecial = marcas.Split(',').Select(marca => marca.Trim()).Contains(nombreCatalogoConfig);


            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = GetValueByCode(datos,
                        Constantes.ConfiguracionManager.Catalogo_Piloto_Zonas + nombreCatalogoConfig +
                        Constantes.ConfiguracionManager.SubGuion + CodigoISO + campania +
                        Constantes.ConfiguracionManager.SubGuion + grupo);
                    esRevistaPiloto = zonas.Split(',').Select(zona => zona.Trim()).Contains(CodigoZona);
                    if (esRevistaPiloto)
                    {
                        CodeGrup = grupo.Trim();
                        break;
                    }
                }
            }
            else
                esRevistaPiloto = false;

            if (esRevistaPiloto && esMarcaEspecial)
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, Util.GetPaisNombreByISO(CodigoISO), nroCampania,
                    anioCampania, CodeGrup.Replace(Constantes.ConfiguracionManager.Catalogo_Piloto_Escenario, ""));
            }
            else
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, Util.GetPaisNombreByISO(CodigoISO),
                    campania.Substring(4, 2), campania.Substring(0, 4), "");
                requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "."
                    ? requestUrl.Substring(0, requestUrl.Length - 1)
                    : requestUrl;
            }

            return requestUrl;
        }

        private void SetCatalogoRevistaFieldsInSearchIssuu(List<BECatalogoRevista> listCatalogoRevista,
            Enumeradores.TamanioImagenIssu tamanioImagenIssu)
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
                case Enumeradores.TamanioImagenIssu.ThumbSmall:
                    tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbSmall;
                    break;
                case Enumeradores.TamanioImagenIssu.ThumbMedium:
                    tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbMedium;
                    break;
                case Enumeradores.TamanioImagenIssu.ThumbLarge:
                    tamanioImagen = Constantes.TamaniosImagenIssuu.ThumbLarge;
                    break;
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

        private bool SetCatalogoRevistaFieldsInOembedIssuu(BECatalogoRevista catalogoRevista)
        {
            bool OcurrioError = false;
            try
            {
                if (string.IsNullOrEmpty(catalogoRevista.CodigoIssuu)) return OcurrioError;

                var signature = string.Format(_signatureIssuu, _secretKeyIssuu, _apiKeyIssuu, catalogoRevista.CodigoIssuu);
                signature = Crypto.CreateMD5(signature).ToLower();
                var url = string.Format(_urlIssuuList, _apiKeyIssuu, catalogoRevista.CodigoIssuu, signature);
                var paisID = Util.GetPaisID(catalogoRevista.PaisISO);


                var docs =   GetIssuuObject(url, catalogoRevista.PaisISO, paisID, catalogoRevista.CodigoIssuu , out OcurrioError);

                if(docs == null)
                    return OcurrioError;


                var doc = docs.FirstOrDefault();
                if (doc == null) return OcurrioError;

                var ndoc = doc["document"];
                string titutlo = ndoc.Value<string>("title");
                string Descripcion = ndoc.Value<string>("name");

                catalogoRevista.CatalogoTitulo = titutlo;
                catalogoRevista.CatalogoDescripcion = Descripcion;
                catalogoRevista.UrlVisor =
                    string.Format(ServiceSettings.Instance.UrlIssuu, catalogoRevista.CodigoIssuu);
                catalogoRevista.UrlImagen = string.Format("https://image.issuu.com/{0}/jpg/page_1_thumb_medium.jpg",
                    ndoc["documentId"]);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", catalogoRevista.PaisISO);
                OcurrioError = true;
            }

            return OcurrioError;
        }

        private void AjusteRevistaTituloDescripcion(BECatalogoRevista catalogoRevista)
        {
            var paisesEsika = ServiceSettings.Instance.PaisesEsika;
            var paisNombre = Util.GetPaisNombre(Util.GetPaisID(catalogoRevista.PaisISO));

            if (catalogoRevista.MarcaID == 0)
            {
                var revistaNombre = paisesEsika.Contains(catalogoRevista.PaisISO)
                    ? Constantes.RevistaNombre.Esika
                    : Constantes.RevistaNombre.Lbel;
                catalogoRevista.CatalogoTitulo = string.Format("{0} {1} C{2}", revistaNombre, paisNombre,
                    catalogoRevista.CampaniaID.Substring(4, 2));
                catalogoRevista.CatalogoDescripcion = string.Format("Revista/Campaña {0}/{1}/{2}",
                    catalogoRevista.CampaniaID.Substring(4, 2), paisNombre, catalogoRevista.CampaniaID.Substring(0, 4));
            }
        }

        private string ObtenerObjetoIssue(string url, string codigoIso)
        {
            try
            {
                var response = httpClient.GetAsync(url).Result;
                response.EnsureSuccessStatusCode();

                return response.Content.ReadAsStringAsync().Result;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, url, codigoIso);
                return string.Empty;
            }
        }

        public string GetValueByCode(List<BETablaLogicaDatos> datos, string codigo)
        {
            datos = datos ?? new List<BETablaLogicaDatos>();

            var par = datos.FirstOrDefault(d => d.Codigo == codigo) ?? new BETablaLogicaDatos();

            return Util.Trim(par.Valor);
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
            var catalogos = SelectCatalogoRevistas_ODS(paisID);

            var oLista = catalogos.Where(x =>
                    x.Descripcion != null && x.Descripcion != Constantes.ConstSession.DescripcionPedidoOtro)
                .GroupBy(test => test.Descripcion)
                .Select(grp => grp.First())
                .ToList();

            if (catalogos.Any(x => x.Descripcion == Constantes.ConstSession.DescripcionPedidoOtro))
                oLista.Add(new BECatalogoRevista_ODS
                {
                    Descripcion = Constantes.ConstSession.DescripcionPedidoOtro,
                    CodigoCatalogo = Constantes.ConstSession.CodigoPedidoOtro
                });

            return oLista;
        }

        #endregion

     

        private JArray GetIssuuObject(string url,string codigoIso , int paisId, string CodigoIssue , out bool error)
        {
            JArray result = null;
            string Json = string.Empty;
            string accion = string.Empty;
            error = false;
            try
            {
                var Issue = CacheManager<JArray>.GetDataElement(paisId, ECacheItem.ApiIssuuData, CodigoIssue);
                if (Issue != null)
                {
                    return Issue;
                }
                Json = ObtenerObjetoIssue(url, codigoIso);
                if (string.IsNullOrEmpty(Json))
                {
                    return result;
                }

                if (Json.IndexOf("error") > -1)
                {
                    error = true;
                    return result;
                }
                accion = "JsonConvert.DeserializeObject<dynamic>(Json)";
                var oIssuu = JsonConvert.DeserializeObject<dynamic>(Json);
                accion =  "(JArray)oIssuu.rsp._content.result._content";
                result =  (JArray)oIssuu.rsp._content.result._content;

                CacheManager<JArray>.AddDataElement(paisId, ECacheItem.ApiIssuuData, CodigoIssue, result , new TimeSpan(7,0,0,0));

               

            }
            catch 
            {
                error = true;
                StringBuilder build = new StringBuilder();
                build.AppendLine("Tracking => GetIssuuObject");
                build.AppendLine(string.Format("Url:{0}", url));
                build.AppendLine(string.Format("Json:{0}", Json));
                build.AppendLine(string.Format("Accion:{0}", accion));
                build.AppendLine(string.Format("CodigoIssue:{0}", CodigoIssue));
                LogManager.SaveLog(new ClientInformationException(build.ToString()), "userTracking", codigoIso);
            }
            return result;
        }
    }
}