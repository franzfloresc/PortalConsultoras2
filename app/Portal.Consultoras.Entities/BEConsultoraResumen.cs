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
            //clientes
            if (row.HasColumn("CantidadClientes"))
                CantidadClientes = row.GetValue<int>("CantidadClientes");

            //deudas            
            if (row.HasColumn("CantidadDeudores"))
                Deudas.CantidadDeudores = row.GetValue<int>("CantidadDeudores");

            if (row.HasColumn("TotalDeuda"))
                Deudas.TotalDeuda = row.GetValue<decimal>("TotalDeuda");

            //pedido
            if (row.HasColumn("MotivoCreditoID"))
                Pedido.MotivoCreditoID = row.GetValue<short>("MotivoCreditoID");

            if (row.HasColumn("IndicadorEnviado"))
                Pedido.IndicadorEnviado = row.GetValue<int>("IndicadorEnviado");

            if (row.HasColumn("PedidoId"))
                Pedido.PedidoId = row.GetValue<int>("PedidoId");

            if (row.HasColumn("FechaRegistro"))
                Pedido.FechaRegistro = row.GetValue<DateTime>("FechaRegistro");

            if (row.HasColumn("ImporteTotal"))
                Pedido.ImporteTotal = row.GetValue<decimal>("ImporteTotal");
            if (row.HasColumn("DescuentoProl"))
                Pedido.DescuentoProl = row.GetValue<decimal>("DescuentoProl");
            if (row.HasColumn("MontoEscala"))
                Pedido.MontoEscala = row.GetValue<decimal>("MontoEscala");
            if (row.HasColumn("MontoAhorroCatalogo"))
                Pedido.MontoAhorroCatalogo = row.GetValue<decimal>("MontoAhorroCatalogo");
            if (row.HasColumn("MontoAhorroRevista"))
                Pedido.MontoAhorroRevista = row.GetValue<decimal>("MontoAhorroRevista");
            if (row.HasColumn("Cantidadclientes"))
                Pedido.Cantidadclientes = row.GetValue<int>("Cantidadclientes");

            if (row.HasColumn("Cantidadproductos"))
                Pedido.Cantidadproductos = row.GetValue<int>("Cantidadproductos");
        }
    }
}
