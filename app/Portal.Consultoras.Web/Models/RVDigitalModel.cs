using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class RVDigitalModel
    {
        public int CampaniaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { get; set; }
    }

    public class RVPRFModel
    {
        public string Ruta { get; set; }
        public string Nombre { get; set; }
        public string FechaFacturacion { get; set; }
    }

    [Serializable]
    public class WrapperCampanias
    {
        public LIS_CampanaResult LIS_CampanaResult { get; set; }
    }

    [Serializable]
    public class LIS_CampanaResult
    {
        public string errorCode { get; set; }
        public string errorMessage { get; set; }
        public List<LIS_PedidoResult> lista { get; set; }
        public string objeto { get; set; }
    }

    [Serializable]
    public class LIS_PedidoResult
    {
        public string campana { get; set; }
        public string pedido { get; set; }
    }

    [Serializable]
    public class WrapperPDFWeb
    {
        public GET_URLResult GET_URLResult { get; set; }
    }

    [Serializable]
    public class GET_URLResult
    {
        public string errorCode { get; set; }
        public string errorMessage { get; set; }
        public List<string> lista { get; set; }
        public List<objeto> objeto { get; set; }
    }

    [Serializable]
    public class objeto
    {
        public string fechaFacturacion { get; set; }
        public string url { get; set; }
    }
}