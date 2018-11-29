using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEPremioNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int? AnoCampanaIni { get; set; }
        [DataMember]
        public int AnoCampanaFin { get; set; }
        [DataMember]
        public string Nivel { get; set; }
        [DataMember]
        public bool ActiveTooltip { get; set; }
        [DataMember]
        public bool ActiveTooltipMonto { get; set; }
        [DataMember]
        public bool? Active { get; set; }
        [DataMember]
        public bool Ind_Cupo_Elec { get; set; }
        [DataMember]
        public int NumeroPagina { get; set; }
        [DataMember]
        public int FilasPorPagina { get; set; }
        [DataMember]
        public string SortDirection { get; set; }
        [DataMember]
        public string SortColumna { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public int IdActivarPremioNuevas { get; set; }
        [DataMember]
        public int TotalFilas { get; set; }
        [DataMember]
        public int OperacionResultado { get; set; }

        [DataMember]
        public int Nro { get; set; }

        [DataMember]
        public string ActiveTooltipDesc { get; set; }
        [DataMember]
        public string ActiveTooltipMontoDesc { get; set; }
        [DataMember]
        public string ActiveDesc { get; set; }
        [DataMember]
        public string Ind_Cup_ElecDesc { get; set; }
    }
}
