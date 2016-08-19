namespace Portal.Consultoras.Entities
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEConsultoraDD
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public string CodigorRegion { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int SeccionID { get; set; }
        [DataMember]
        public string CodigoSeccion { get; set; }
        [DataMember]
        public int TerritorioID { get; set; }
        [DataMember]
        public string CodigoTerritorio { get; set; }
        [DataMember]
        public string AutorizaPedido { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public decimal MontoSaldoActual { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember] /*AOB: C20151003*/
        public string EstadoConsultora { get; set; }

        public BEConsultoraDD()
        {
        }

        public BEConsultoraDD(IDataRecord row, IList<string> columns)
        {
            foreach (var column in columns)
            {
                switch (column)
                {
                    case "ConsultoraID":
                        ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
                        break;
                    case "CodigoConsultora":
                        CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
                        break;
                    case "NombreCompleto":
                        NombreCompleto = Convert.ToString(row["NombreCompleto"]);
                        break;
                    case "RegionID":
                        RegionID = Convert.ToInt32(row["RegionID"]);
                        break;
                    case "CodigoRegion":
                        CodigorRegion = Convert.ToString(row["CodigoRegion"]);
                        break;
                    case "ZonaID":
                        ZonaID = Convert.ToInt32(row["ZonaID"]);
                        break;
                    case "CodigoZona":
                        CodigoZona = Convert.ToString(row["CodigoZona"]);
                        break;
                    case "CodigoSeccion":
                        CodigoSeccion = Convert.ToString(row["CodigoSeccion"]);
                        break;
                    case "TerritorioID":
                        TerritorioID = Convert.ToInt32(row["TerritorioID"]);
                        break;
                    case "CodigoTerritorio":
                        CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
                        break;
                    case "AutorizaPedido":
                        AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
                        break;
                    case "IdEstadoActividad":
                        IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
                        break;
                    case "NumeroDocumento":
                        NumeroDocumento = Convert.ToString(row["NumeroDocumento"]);
                        break;
                    case "MontoMinimoPedido":
                        MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
                        break;
                    case "MontoSaldoActual":
                        MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
                        break;
                    case "EstadoConsultora": /*AOB: C20151003*/
                        EstadoConsultora = Convert.ToString(row["EstadoConsultora"]);
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
