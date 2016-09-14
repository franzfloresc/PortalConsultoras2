using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoRechazado
    {
        private DAPedidoRechazado dAPedidoRechazado;

        public BLPedidoRechazado()
        {
            this.dAPedidoRechazado = new DAPedidoRechazado();
        }

        public int InsertarPedidoRechazadoXML(string paisISO, List<BEPedidoRechazado> listBEPedidoRechazado)
        {
            if (listBEPedidoRechazado == null || listBEPedidoRechazado.Count == 0) return 0;
            try
            {
                string xml = CrearClienteXML(listBEPedidoRechazado);
                this.dAPedidoRechazado.InsertarPedidoRechazadoXML(paisISO, xml);
                return 1;
            }
            catch (Exception ex) { }
            return 0;
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
