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
            if (row.HasColumn("CantidadClientes"))
                CantidadClientes = row.GetColumn<int>("CantidadClientes");
            if (row.HasColumn("CantidadDeudores"))
                Deudas.CantidadDeudores = row.GetColumn<int>("CantidadDeudores");
            if (row.HasColumn("TotalDeuda"))
                Deudas.TotalDeuda = row.GetColumn<decimal>("TotalDeuda");
            if (row.HasColumn("MotivoCreditoID"))
                Pedido.MotivoCreditoID = row.GetColumn<short>("MotivoCreditoID");
            if (row.HasColumn("IndicadorEnviado"))
                Pedido.IndicadorEnviado = row.GetColumn<int>("IndicadorEnviado");
            if (row.HasColumn("PedidoId"))
                Pedido.PedidoId = row.GetColumn<int>("PedidoId");
            if (row.HasColumn("FechaRegistro"))
                Pedido.FechaRegistro = row.GetColumn<DateTime>("FechaRegistro");
            if (row.HasColumn("ImporteTotal"))
                Pedido.ImporteTotal = row.GetColumn<decimal>("ImporteTotal");
            if (row.HasColumn("DescuentoProl"))
                Pedido.DescuentoProl = row.GetColumn<decimal>("DescuentoProl");
            if (row.HasColumn("MontoEscala"))
                Pedido.MontoEscala = row.GetColumn<decimal>("MontoEscala");
            if (row.HasColumn("MontoAhorroCatalogo"))
                Pedido.MontoAhorroCatalogo = row.GetColumn<decimal>("MontoAhorroCatalogo");
            if (row.HasColumn("MontoAhorroRevista"))
                Pedido.MontoAhorroRevista = row.GetColumn<decimal>("MontoAhorroRevista");
            if (row.HasColumn("CantidadclientesPedido"))
                Pedido.Cantidadclientes = row.GetColumn<int>("CantidadclientesPedido");
            if (row.HasColumn("CantidadproductosPedido"))
                Pedido.Cantidadproductos = row.GetColumn<int>("CantidadproductosPedido");
        }
    }
}
