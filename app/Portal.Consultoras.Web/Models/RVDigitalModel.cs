using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
        public string FechaFacturacion { get; set; }//R20150906
    }

    [Serializable]
    public class RVDCampaniasParam
    {
        public string pais { get; set; }
        public string tipo { get; set; }
        public string docIdentidad { get; set; }
        public string consultora { get; set; }
        public string marca { get; set; }
    }

    [Serializable]
    public class RVDPDFParam
    {
        public string consultora { get; set; }
        public string pais { get; set; }
        public string tipo { get; set; }
        public string docIdentidad { get; set; }
        public string marca { get; set; }
        public string Campana { get; set; }
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
        public List<string> lista { get; set; }
        public string objeto { get; set; }
    }

    [Serializable]
    public class WrapperPDF
    {
        public SEL_PDFxCampanaResult SEL_PDFxCampanaResult { get; set; }
    }

    [Serializable]
    public class SEL_PDFxCampanaResult
    {
        public string errorCode { get; set; }
        public string errorMessage { get; set; }
        public List<string> lista { get; set; }
        public string objeto { get; set; }
    }

    //RQ_RV_WEB- R2161
    [Serializable]
    public class RVDWebCampaniasParam
    {
        public string Pais { get; set; }
        public string Tipo { get; set; }
        public string CodigoConsultora { get; set; }
        public string Campana { get; set; }
    }

    //RQ_RV_WEB- R2161
    [Serializable]
    public class WrapperPDFWeb
    {
        public GET_URLResult GET_URLResult { get; set; }
    }

    //R20150906
    [Serializable]
    public class objeto
    {
        public string fechaFacturacion { get; set; }
        public string url { get; set; }
    }



    //RQ_RV_WEB- R2161
    [Serializable]
    public class GET_URLResult
    {
        public string errorCode { get; set; }
        public string errorMessage { get; set; }
        public List<string> lista { get; set; }
        public List<objeto> objeto { get; set; }//R20150906
    }
     
}