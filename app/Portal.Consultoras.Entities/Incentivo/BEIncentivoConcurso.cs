using Portal.Consultoras.Entities.Incentivo;

using System.Collections.Generic;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoConcurso
    {
        private string _CodigoConcurso;
        private string _TipoConcurso;

        [Column("COD_CONC")]
        public string COD_CONC { get; set; }
        [Column("TIP_CONC")]
        public string TIP_CONC { get; set; }

        [Column("CampaniaID")]
        [DataMember]
        public int CampaniaID { get; set; }
        [Column("CampaniaIDInicio")]
        [DataMember]
        public int CampaniaIDInicio { get; set; }
        [Column("CampaniaIDFin")]
        [DataMember]
        public int CampaniaIDFin { get; set; }
        [Column("CodigoConcurso")]
        [DataMember]
        public string CodigoConcurso
        {
            get
            {
                if (!string.IsNullOrEmpty(COD_CONC)) return COD_CONC;
                return _CodigoConcurso;
            }
            set
            {
                _CodigoConcurso = value;
            }
        }
        [Column("TipoConcurso")]
        [DataMember]
        public string TipoConcurso
        {
            get
            {
                if (!string.IsNullOrEmpty(TIP_CONC)) return TIP_CONC;
                return _TipoConcurso;
            }
            set
            {
                _TipoConcurso = value;
            }
        }
        [Column("PuntosAcumulados")]
        [DataMember]
        public int PuntosAcumulados { get; set; }
        [Column("IndicadorPremioAcumulativo")]
        [DataMember]
        public bool IndicadorPremioAcumulativo { get; set; }
        [Column("NivelAlcanzado")]
        [DataMember]
        public int NivelAlcanzado { get; set; }
        [Column("PuntosNivel")]
        [DataMember]
        public int PuntosNivel { get; set; }
        [Column("CampaniaIDPremiacion")]
        [DataMember]
        public int? CampaniaIDPremiacion { get; set; }
        [Column("PuntajeExigido")]
        [DataMember]
        public int PuntajeExigido { get; set; }
        [Column("DescripcionConcurso")]
        [DataMember]
        public string DescripcionConcurso { get; set; }
        [Column("EstadoConcurso")]
        [DataMember]
        public string EstadoConcurso { get; set; }
        [DataMember]
        public List<BEIncentivoNivel> Niveles { get; set; }

        #region ProgramaNuevas
        [DataMember]
        public List<BEIncentivoProgramaNuevasPremio> PremiosProgramaNuevas { get; set; }
        [DataMember]
        public List<BEIncentivoProgramaNuevasCupon> CuponesProgramaNuevas { get; set; }
        #endregion

        public BEIncentivoConcurso()
        {
        }
    }
}
