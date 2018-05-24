
using System.Collections.Generic;


namespace Portal.Consultoras.Entities.Pedido
{
    public class DEWrapperPDF
    {
        public GET_URLResult GET_URLResult { get; set; }
    }

    public class GET_URLResult
    {
        public string errorCode { get; set; }
        public string errorMessage { get; set; }
        public List<string> lista { get; set; }
        public List<objeto> objeto { get; set; }
    }

    public class objeto
    {
        public string fechaFacturacion { get; set; }
        public string url { get; set; }
    }
}
