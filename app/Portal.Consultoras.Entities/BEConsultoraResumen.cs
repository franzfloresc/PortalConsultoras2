using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraResumen
    {
        [DataMember]
        public int CantidadClientes { get; set; }

        [DataMember]
        public DeudasResumen Deudas { get; set; }

        [DataMember]
        public PedidoResumen Pedido { get; set; }

        [DataContract]
        public class PedidoResumen
        {
            [DataMember]
            public int MotivoCreditoID { get; set; }

            [DataMember]
            public int IndicadorEnviado { get; set; }

            [DataMember]
            public int PedidoId { get; set; }

            [DataMember]
            public DateTime FechaRegistro { get; set; }

            [DataMember]
            public decimal ImporteTotal { get; set; }

            [DataMember]
            public decimal DescuentoProl { get; set; }

            [DataMember]
            public decimal MontoEscala { get; set; }

            [DataMember]
            public decimal MontoAhorroCatalogo { get; set; }

            [DataMember]
            public decimal MontoAhorroRevista { get; set; }

            [DataMember]
            public int Cantidadclientes { get; set; }

            [DataMember]
            public int Cantidadproductos { get; set; }
        }

        [DataContract]
        public class DeudasResumen
        {
            [DataMember]
            public int CantidadDeudores { get; set; }

            [DataMember]
            public decimal TotalDeuda { get; set; }
        }

        public BEConsultoraResumen()
        {
            Deudas = new DeudasResumen();
            Pedido = new PedidoResumen();
        }

        public BEConsultoraResumen(IDataRecord row)
        {
            Build(row);
        }

        public void Build(IDataRecord row)
        {
            
                CantidadClientes = row.GetColumn<int>("CantidadClientes");

            
                Deudas.CantidadDeudores = row.GetColumn<int>("CantidadDeudores");

            
                Deudas.TotalDeuda = row.GetColumn<decimal>("TotalDeuda");

            
                Pedido.MotivoCreditoID = row.GetColumn<short>("MotivoCreditoID");

            
                Pedido.IndicadorEnviado = row.GetColumn<int>("IndicadorEnviado");

            
                Pedido.PedidoId = row.GetColumn<int>("PedidoId");

            
                Pedido.FechaRegistro = row.GetColumn<DateTime>("FechaRegistro");

            
                Pedido.ImporteTotal = row.GetColumn<decimal>("ImporteTotal");
            
                Pedido.DescuentoProl = row.GetColumn<decimal>("DescuentoProl");
            
                Pedido.MontoEscala = row.GetColumn<decimal>("MontoEscala");
            
                Pedido.MontoAhorroCatalogo = row.GetColumn<decimal>("MontoAhorroCatalogo");
            
                Pedido.MontoAhorroRevista = row.GetColumn<decimal>("MontoAhorroRevista");
            
                Pedido.Cantidadclientes = row.GetColumn<int>("CantidadclientesPedido");

            
                Pedido.Cantidadproductos = row.GetColumn<int>("CantidadproductosPedido");
        }
    }
}
