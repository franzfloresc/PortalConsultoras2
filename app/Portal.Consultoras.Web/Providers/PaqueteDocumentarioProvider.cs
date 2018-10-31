using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Providers
{
    public class PaqueteDocumentarioProvider
    {
        protected readonly ConfiguracionManagerProvider _configuracionManager;

        public PaqueteDocumentarioProvider()
        {
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public List<RVPRFModel> GetListPaqueteDocumentario(string codigoConsultora, string campania, string numeroPedido, string codigoIso)
        {
            var errorMessage = string.Empty;

            var lstRVPRFModel = new List<RVPRFModel>();
            try
            {
                var input = new
                {
                    Pais = codigoIso,
                    Tipo = "1",
                    CodigoConsultora = codigoConsultora,
                    Campana = campania,
                    NumeroPedido = numeroPedido
                };
                var urlService = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_PDF_NEW);
                var wrapper = ConsumirServicio<WrapperPDFWeb>(input, urlService);

                var result = (wrapper ?? new WrapperPDFWeb()).GET_URLResult;
                if (result != null)
                {
                    if (result.errorCode != "00000" && result.errorMessage != "OK") errorMessage = result.errorMessage;

                    if (string.IsNullOrEmpty(errorMessage) && result.objeto != null)
                    {
                        lstRVPRFModel = result.objeto.Select(item => new RVPRFModel
                        {
                            Nombre = "Paquete Documentario",
                            FechaFacturacion = item.fechaFacturacion,
                            Ruta = Convert.ToString(item.url)
                        }).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", codigoIso);
                //errorMessage = Constantes.MensajesError.PaqueteDocumentario_ConsumirServicio;
            }
            return lstRVPRFModel;
        }

        public List<CampaniaModel> GetListCampaniaPaqueteDocumentario(string codigoConsultora, string codigoIso, out string errorMessage)
        {
            errorMessage = string.Empty;

            var lstCampaniaModel = new List<CampaniaModel>();
            try
            {
                var input = new
                {
                    Pais = codigoIso,
                    Tipo = "1",
                    CodigoConsultora = codigoConsultora
                };
                var urlService = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_Campanias_NEW);
                var wrapper = ConsumirServicio<WrapperCampanias>(input, urlService);

                var result = (wrapper ?? new WrapperCampanias()).LIS_CampanaResult;
                if (result != null)
                {
                    if (result.errorCode != string.Empty && result.errorCode != "00000") errorMessage = result.errorMessage;

                    if (string.IsNullOrEmpty(errorMessage) && result.lista != null)
                    {
                        lstCampaniaModel = result.lista.Select(p => p.campana).Distinct()
                            .Select(s => new CampaniaModel() { CampaniaID = Convert.ToInt32(s), Codigo = s })
                            .OrderBy(c => c.CampaniaID).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", codigoIso);
                errorMessage = Constantes.MensajesError.PaqueteDocumentario_ConsumirServicio;
            }
            return lstCampaniaModel;
        }

        private T ConsumirServicio<T>(object input, string metodo)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            WebRequest request = WebRequest.Create(metodo);
            request.Method = "POST";
            request.ContentType = "application/json; charset=utf-8";

            string inputJson = serializer.Serialize(input);
            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(inputJson);
            }

            string outputJson;
            using (StreamReader reader = new StreamReader(request.GetResponse().GetResponseStream()))
            {
                outputJson = reader.ReadToEnd();
            }
            return serializer.Deserialize<T>(outputJson);
        }
    }
}