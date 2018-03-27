using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.PagoEnLinea
{
    public class DataRequestAut
    {
        public string transactionToken { get; set; }
        public string sessionToken { get; set; }
        public Data data { get; set; }
    }
}
