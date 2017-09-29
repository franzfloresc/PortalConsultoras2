using Portal.Consultoras.Common;

using System;
using System.Collections.Generic;
using System.Data;
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

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEIncentivoConcurso(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CampaniaIDInicio"))
                CampaniaIDInicio = Convert.ToInt32(row["CampaniaIDInicio"]);

            if (DataRecord.HasColumn(row, "CampaniaIDFin"))
                CampaniaIDFin = Convert.ToInt32(row["CampaniaIDFin"]);

            if (DataRecord.HasColumn(row, "CodigoConcurso"))
                CodigoConcurso = Convert.ToString(row["CodigoConcurso"]);

            if (DataRecord.HasColumn(row, "TipoConcurso"))
                TipoConcurso = Convert.ToString(row["TipoConcurso"]);

            if (DataRecord.HasColumn(row, "PuntosAcumulados"))
                PuntosAcumulados = Convert.ToInt32(row["PuntosAcumulados"]);

            if (DataRecord.HasColumn(row, "IndicadorPremioAcumulativo"))
                IndicadorPremioAcumulativo = Convert.ToBoolean(row["IndicadorPremioAcumulativo"]);

            if (DataRecord.HasColumn(row, "NivelAlcanzado"))
                NivelAlcanzado = Convert.ToInt32(row["NivelAlcanzado"]);

            if (DataRecord.HasColumn(row, "PuntosNivel"))
                PuntosNivel = Convert.ToInt32(row["PuntosNivel"]);

            if (DataRecord.HasColumn(row, "CampaniaIDPremiacion") && row["CampaniaIDPremiacion"] != DBNull.Value)
                CampaniaIDPremiacion = Convert.ToInt32(row["CampaniaIDPremiacion"]);

            if (DataRecord.HasColumn(row, "PuntajeExigido"))
                PuntajeExigido = Convert.ToInt32(row["PuntajeExigido"]);

            if (DataRecord.HasColumn(row, "DescripcionConcurso"))
                DescripcionConcurso = Convert.ToString(row["DescripcionConcurso"]);

            if (DataRecord.HasColumn(row, "EstadoConcurso"))
                EstadoConcurso = Convert.ToString(row["EstadoConcurso"]);
        }

        public BEIncentivoConcurso()
        {
        }
    }
}
