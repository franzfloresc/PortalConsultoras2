using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaModel
    {
        public string CodigoIso { get; set; }
        public string Simbolo { get; set; }
        public decimal MontoDeuda { get; set; }
        public DateTime FechaVencimiento { get; set; }

        public int PorcentajeGastosAdministrativos { get; set; }

        public PagoVisaModel PagoVisaModel { get; set; }

        public string MontoDeudaString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDeuda, CodigoIso);
            }
        }

        public string FechaVencimientoString
        {
            get
            {
                return FechaVencimiento.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : FechaVencimiento.ToString("dd/MM/yyyy");
            }
        }

        public decimal MontoGastosAdministrativos
        {
            get
            {
                return MontoDeuda * (decimal.Parse(PorcentajeGastosAdministrativos.ToString()) / 100);
            }
        }

        public string MontoGastosAdministrativosString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoGastosAdministrativos, CodigoIso);
            }
        }

        public decimal MontoDeudaConGastos
        {
            get
            {
                return MontoDeuda * (1 + decimal.Parse(PorcentajeGastosAdministrativos.ToString()) / 100);
            }
        }

        public string MontoDeudaConGastosString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDeudaConGastos, CodigoIso);
            }
        }
    }
}