using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.PagoEnLinea
{
    public class RespuestaAutorizacionVisa
    {
        public int errorCode { get; set; }
        public string errorMessage { get; set; }
        public string transactionUUID { get; set; }
        public string externalTransactionId { get; set; }
        public long transactionDateTime { get; set; }
        public int transactionDuration { get; set; }
        public string merchantId { get; set; }
        public string userTokenId { get; set; }
        public string aliasName { get; set; }
        public DataRespuestaVisa data { get; set; }
    }

    public class DataRespuestaVisa
    {
        public string FECHAYHORA_TX { get; set; }
        public string RES_CVV2 { get; set; }
        public string CSIMENSAJE { get; set; }
        public string ID_UNICO { get; set; }
        public string userTokenUUID { get; set; }
        public string ETICKET { get; set; }
        public object DECISIONCS { get; set; }
        public string CSIPORCENTAJEDESCUENTO { get; set; }
        public string NROCUOTA { get; set; }
        public string cardTokenUUID { get; set; }
        public string CSIIMPORTECOMERCIO { get; set; }
        public string CSICODIGOPROGRAMA { get; set; }
        public string DSC_ECI { get; set; }
        public string ECI { get; set; }
        public string DSC_COD_ACCION { get; set; }
        public string NOM_EMISOR { get; set; }
        public string IMPCUOTAAPROX { get; set; }
        public string CSITIPOCOBRO { get; set; }
        public string NUMREFERENCIA { get; set; }
        public string RESPUESTA { get; set; }
        public string NUMORDEN { get; set; }
        public string CODACCION { get; set; }
        public string IMP_AUTORIZADO { get; set; }
        public string COD_AUTORIZA { get; set; }
        public string CODTIENDA { get; set; }
        public string PAN { get; set; }
        public object reviewTransaction { get; set; }
        public string ORI_TARJETA { get; set; }
    }
}
