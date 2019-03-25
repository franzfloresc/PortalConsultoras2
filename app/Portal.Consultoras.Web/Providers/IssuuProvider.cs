using Portal.Consultoras.Common;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class IssuuProvider
    {
        protected ConfiguracionManagerProvider _configuracionManager;
        protected TablaLogicaProvider _tablaLogicaProvider;

        public IssuuProvider()
        {
            _configuracionManager = new ConfiguracionManagerProvider();
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo, string codigoISO, string codigoZona, out bool outPilotoSeg)
        {
            string nombreCatalogoIssuu = null;
            string nombreCatalogoConfig = null;
            string CodeGrup = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;
            string codigo;
            string requestUrl;
            bool esRevistaPiloto = false;
            string Grupos;
            bool esMarcaEspecial;
            outPilotoSeg = false;
            var datos = _tablaLogicaProvider.GetTablaLogicaDatos(Util.GetPaisID(codigoISO),
                Constantes.ConfiguracionManager.RevistaCatalogoTablaLogicaId);
            string marcas = _tablaLogicaProvider.GetValueByCode(datos, Constantes.ConfiguracionManager.Catalogo_Marca_Piloto + codigoISO + campania);

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

            Grupos = _tablaLogicaProvider.GetValueByCode(datos, Constantes.ConfiguracionManager.Catalogo_Piloto_Grupos + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + codigoISO + campania);
            esMarcaEspecial = marcas.Split(',').Select(marca => marca.Trim()).Contains(nombreCatalogoConfig);


            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = _tablaLogicaProvider.GetValueByCode(datos, Constantes.ConfiguracionManager.Catalogo_Piloto_Zonas + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + codigoISO + campania + Constantes.ConfiguracionManager.SubGuion + grupo);
                    esRevistaPiloto = zonas.Split(',').Select(zona => zona.Trim()).Contains(codigoZona);
                    if (esRevistaPiloto)
                    {
                        CodeGrup = grupo.Trim();
                        break;
                    }
                }
            }
            else
                esRevistaPiloto = false;

            codigo = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoCatalogoIssuu);
            if (campania.Length >= 6)
                nroCampania = campania.Substring(4, 2);
            if (campania.Length >= 6)
                anioCampania = campania.Substring(0, 4);

            if (esRevistaPiloto && esMarcaEspecial)
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, Util.GetPaisNombreByISO(codigoISO), nroCampania, anioCampania, CodeGrup.Replace(Constantes.ConfiguracionManager.Catalogo_Piloto_Escenario, ""));
                outPilotoSeg = true;
            }
            else
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, Util.GetPaisNombreByISO(codigoISO), campania.Substring(4, 2), campania.Substring(0, 4), "");
                requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "." ? requestUrl.Substring(0, requestUrl.Length - 1) : requestUrl;
            }

            return requestUrl;
        }

        public string GetRevistaCodigoIssuu(string campania, bool tieneRDCR, string codigoISO, string codigoZona)
        {
            string codigo;
            string requestUrl;
            bool esRevistaPiloto = false;
            var Grupos = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Grupos + codigoISO + campania);
            string codeGrupo = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;

            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Zonas + codigoISO + campania + "_" + grupo);
                    esRevistaPiloto = zonas.Split(',').Select(zona => zona.Trim()).Contains(codigoZona);
                    if (esRevistaPiloto)
                    {
                        codeGrupo = grupo.Trim();
                        break;
                    }
                }
            }

            codigo = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoRevistaIssuu);
            if (campania.Length >= 6)
            {
                anioCampania = campania.Substring(0, 4);
                nroCampania = campania.Substring(4, 2);
            }

            if (esRevistaPiloto)
                requestUrl = string.Format(codigo, codigoISO.ToLower(), nroCampania, anioCampania, codeGrupo.Replace(Constantes.ConfiguracionManager.RevistaPiloto_Escenario, ""));
            else
            {
                requestUrl = string.Format(codigo, codigoISO.ToLower(), nroCampania, anioCampania, "");
                if (requestUrl.Length > 0)
                    requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "." ? requestUrl.Substring(0, requestUrl.Length - 1) : requestUrl;
            }
            requestUrl = GetRevistaCodigoIssuuRDR(requestUrl, tieneRDCR, codigoISO, codigoZona);
            return requestUrl;
        }
        
        public string GetRevistaCodigoIssuuRDR(string codigoRevista, bool tieneRDCR, string codigoISO, string codigoZona)
        {
            if (tieneRDCR)
            {
                if (codigoRevista.EndsWith(Constantes.CatalogoUrlIssu.RDR + "1") || codigoRevista.EndsWith(Constantes.CatalogoUrlIssu.RDR + "2"))
                    return codigoRevista;

                string tipo = "1";
                if (_configuracionManager.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + codigoISO, codigoZona))
                {
                    tipo = "2";
                }

                codigoRevista += Constantes.CatalogoUrlIssu.RDR + tipo;

            }
            return codigoRevista;
        }
    }
}