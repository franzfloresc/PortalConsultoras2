using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoRechazado
    {
        public int InsertarPedidoRechazadoXML(string PaisISO, List<BEPedidoRechazado> obj)
        {
            int valor = 0;

            DAPedidoRechazado DAPedidoRechazado = new DAPedidoRechazado();

            try
            {
                if (obj != null)
                {
                    string xml = CrearClienteXML(obj);
                    DAPedidoRechazado.InsertarPedidoRechazadoXML(PaisISO,xml);
                    valor = 1;
                }
            }
            catch (Exception ex)
            {
                valor = 0;
            }

            return valor;
        }

        private string CrearClienteXML(List<BEPedidoRechazado> obj)
        {
            StringBuilder sb = new StringBuilder();

            foreach (BEPedidoRechazado lista in obj)
            {
                string Pais = lista.Pais;
                string Campania = lista.Campania;
                string CodigoConsultora = lista.CodigoConsultora;
                string MotivoRechazo = lista.MotivoRechazo;
                string Valor = lista.Valor;

                sb.Append(String.Format("<PedidoRechazado Pais='{0}' Campania='{1}' CodigoConsultora='{2}' MotivoRechazo='{3}' Valor='{4}'/>", Pais, Campania, CodigoConsultora, MotivoRechazo, Valor));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }
    }
}
