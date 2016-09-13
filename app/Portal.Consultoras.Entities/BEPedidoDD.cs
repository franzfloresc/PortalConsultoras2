namespace Portal.Consultoras.Entities
{
    using Common;
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
                        if (row["CampaniaID"] != DBNull.Value)
                            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
                        break;
                    case "PedidoID":
                        if (row["PedidoID"] != DBNull.Value)
                            PedidoID = Convert.ToInt32(row["PedidoID"]);
                        break;
                    case "ConsultoraID":
                        if (row["ConsultoraID"] != DBNull.Value)
                            ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
                        break;
                    case "FechaRegistro":
                        if (row["FechaRegistro"] != DBNull.Value)
                            FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
                        break;
                    case "FechaModificacion":
                        if (row["FechaModificacion"] != DBNull.Value)
                            FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
                        break;
                    case "NumeroClientes":
                        if (row["NumeroClientes"] != DBNull.Value)
                            NumeroClientes = Convert.ToInt32(row["NumeroClientes"]);
                        break;
                    case "ImporteTotal":
                        if (row["ImporteTotal"] != DBNull.Value)
                            ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
                        break;
                    case "ImporteMontoMinimo":
                        if (row["ImporteMontoMinimo"] != DBNull.Value)
                            ImporteMontoMinimo = Convert.ToDecimal(row["ImporteMontoMinimo"]);
                        break;
                    case "ImporteTotalEstimado":
                        if (row["ImporteTotalEstimado"] != DBNull.Value)
                            ImporteTotalEstimado = Convert.ToDecimal(row["ImporteTotalEstimado"]);
                        break;
                    case "IndicadorActivo":
                        if (row["IndicadorActivo"] != DBNull.Value)
                            IndicadorActivo = Convert.ToBoolean(row["IndicadorActivo"]);
                        break;
                    case "PaisID":
                        if (row["PaisID"] != DBNull.Value)
                            PaisID = Convert.ToInt32(row["PaisID"]);
                        break;
                    case "IndicadorEnviado":
                        if (row["IndicadorEnviado"] != DBNull.Value)
                            IndicadorEnviado = Convert.ToBoolean(row["IndicadorEnviado"]);
                        break;
                    case "IPUsuario":
                        if (row["IPUsuario"] != DBNull.Value)
                            IPUsuario = Convert.ToString(row["IPUsuario"]);
                        break;
                    case "CodigoUsuarioCreacion":
                        if (row["CodigoUsuarioCreacion"] != DBNull.Value)
                            CodigoUsuarioCreacion = Convert.ToString(row["CodigoUsuarioCreacion"]);
                        break;
                    case "CodigoUsuarioModificacion":
                        if (row["CodigoUsuarioModificacion"] != DBNull.Value)
                            CodigoUsuarioModificacion = Convert.ToString(row["CodigoUsuarioModificacion"]);
                        break;
                    case "CodigoConsultora":
                        if (row["CodigoConsultora"] != DBNull.Value)
                            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
                        break;
                    case "NombreConsultora":
                        if (row["NombreConsultora"] != DBNull.Value)
                            NombreConsultora = Convert.ToString(row["NombreConsultora"]);
                        break;
                    case "MontoMinimoPedido":
                        if (row["MontoMinimoPedido"] != DBNull.Value)
                            MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
                        break;
                    case "NroRegistro":
                        if (row["NroRegistro"] != DBNull.Value)
                            NroRegistro = Convert.ToInt32(row["NroRegistro"]);
                        break;
                    case "SuperoMontoMinimo":
                        if (row["SuperoMontoMinimo"] != DBNull.Value)
                            SuperoMontoMinimo = Convert.ToBoolean(row["SuperoMontoMinimo"]);
                        break;
                    case "SaldoConsultora":
                        if (row["SaldoConsultora"] != DBNull.Value)
                            SaldoConsultora = Convert.ToDecimal(row["SaldoConsultora"]);
                        break;
                }
            }
        }
    }
}