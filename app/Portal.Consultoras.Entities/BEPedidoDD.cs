namespace Portal.Consultoras.Entities
{
    using Portal.Consultoras.Common;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEPedidoDD
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int PedidoID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public int NumeroClientes { get; set; }

        [DataMember]
        public decimal ImporteTotal { get; set; }

        [DataMember]
        public decimal ImporteMontoMinimo { get; set; }

        [DataMember]
        public decimal MontoMinimoPedido { get; set; }

        [DataMember]
        public decimal ImporteTotalEstimado { get; set; }

        [DataMember]
        public bool IndicadorActivo { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public bool IndicadorEnviado { get; set; }

        [DataMember]
        public string IPUsuario { get; set; }

        [DataMember]
        public string CodigoUsuarioCreacion { get; set; }

        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }

        [DataMember]
        public List<BEPedidoDDDetalle> PedidoDDDetalle { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string NombreConsultora { get; set; }

        [DataMember]
        public decimal SaldoConsultora { get; set; }

        [DataMember]
        public int NroRegistro { get; set; }

        [DataMember]
        public bool SuperoMontoMinimo { get; set; }


        public BEPedidoDD()
        {
        }

        public BEPedidoDD(IDataRecord row, IList<string> columns)
        {
            foreach (var column in columns)
            {
                switch (column)
                {
                    case "CampaniaID":
                        CampaniaID = row.ToInt32("CampaniaID");
                        break;
                    case "PedidoID":
                        PedidoID = row.ToInt32("PedidoID");
                        break;
                    case "ConsultoraID":
                        ConsultoraID = row.ToInt64("ConsultoraID");
                        break;
                    case "FechaRegistro":
                        FechaRegistro = row.ToDateTime("FechaRegistro");
                        break;
                    case "FechaModificacion":
                        FechaModificacion = row.ToDateTime("FechaModificacion");
                        break;
                    case "NumeroClientes":
                        NumeroClientes = row.ToInt32("NumeroClientes");
                        break;
                    case "ImporteTotal":
                        ImporteTotal = row.ToDecimal("ImporteTotal");
                        break;
                    case "ImporteMontoMinimo":
                        ImporteMontoMinimo = row.ToDecimal("ImporteMontoMinimo");
                        break;
                    case "ImporteTotalEstimado":
                        ImporteTotalEstimado = row.ToDecimal("ImporteTotalEstimado");
                        break;
                    case "IndicadorActivo":
                        IndicadorActivo = row.ToBoolean("IndicadorActivo");
                        break;
                    case "PaisID":
                        PaisID = row.ToInt32("PaisID");
                        break;
                    case "IndicadorEnviado":
                        IndicadorEnviado = row.ToBoolean("IndicadorEnviado");
                        break;
                    case "IPUsuario":
                        IPUsuario = row.ToString("IPUsuario");
                        break;
                    case "CodigoUsuarioCreacion":
                        CodigoUsuarioCreacion = row.ToString("CodigoUsuarioCreacion");
                        break;
                    case "CodigoUsuarioModificacion":
                        CodigoUsuarioModificacion = row.ToString("CodigoUsuarioModificacion");
                        break;
                    case "CodigoConsultora":
                        CodigoConsultora = row.ToString("CodigoConsultora");
                        break;
                    case "NombreConsultora":
                        NombreConsultora = row.ToString("NombreConsultora");
                        break;
                    case "MontoMinimoPedido":
                        MontoMinimoPedido = row.ToDecimal("MontoMinimoPedido");
                        break;
                    case "NroRegistro":
                        NroRegistro = row.ToInt32("NroRegistro");
                        break;
                    case "SuperoMontoMinimo":
                        SuperoMontoMinimo = row.ToBoolean("SuperoMontoMinimo");
                        break;
                    case "SaldoConsultora":
                        SaldoConsultora = row.ToDecimal("SaldoConsultora");
                        break;
                }
            }
        }
    }
}