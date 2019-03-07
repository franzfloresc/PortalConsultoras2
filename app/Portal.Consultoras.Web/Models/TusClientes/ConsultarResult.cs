using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.TusClientes
{
    public class ConsultarResult
    {
        public ConsultarResult(List<ClienteModel>clientes)
        {
            miData = clientes;
        }

        public List<ClienteModel> miData { get; set; }
    }
}