using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraConcurso
    {
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string DescripcionConcurso { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public int NivelAlcanzado { get; set; }
        [DataMember]
        public int NivelSiguiente { get; set; }
        [DataMember]
        public bool Participa { get; set; }
        [DataMember]
        public int PuntosFaltantesSiguienteNivel { get; set; }
        [DataMember]
        public int PuntosXVentas { get; set; }
        [DataMember]
        public int PuntosRetail { get; set; }
        [DataMember]
        public int PuntajeTotal { get; set; }
        [DataMember]
        public string TipoConcurso { get; set; }
        [DataMember]
        public DateTime FechaVentaRetail { get; set; }
        [DataMember]
        public List<BEPremio> Premios { get; set; }


        public BEConsultoraConcurso(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "COD_CLIE"))
                CodigoConsultora = Convert.ToString(row["COD_CLIE"]);

            if (DataRecord.HasColumn(row, "COD_CONC"))
                CodigoConcurso = Convert.ToString(row["COD_CONC"]);

            if (DataRecord.HasColumn(row, "DES_CONC"))
                DescripcionConcurso = Convert.ToString(row["DES_CONC"]);

            if (DataRecord.HasColumn(row, "COD_REGI"))
                CodigoRegion = Convert.ToString(row["COD_REGI"]);

            if (DataRecord.HasColumn(row, "PARTICIPA"))
                Participa = Convert.ToBoolean(row["PARTICIPA"]);

            if (DataRecord.HasColumn(row, "COD_CAMPANIA"))
                CodigoCampania = Convert.ToString(row["COD_CAMPANIA"]);

            if (DataRecord.HasColumn(row, "NIV_ALCA"))
                NivelAlcanzado = Convert.ToInt32(row["NIV_ALCA"]);

            if (DataRecord.HasColumn(row, "NivelSiguiente"))
                NivelSiguiente = Convert.ToInt32(row["NivelSiguiente"]);

            if (DataRecord.HasColumn(row, "PUN_FALT_NIVS"))
                PuntosFaltantesSiguienteNivel = Convert.ToInt32(row["PUN_FALT_NIVS"]);

            if (DataRecord.HasColumn(row, "PUN_VTAS"))
                PuntosXVentas = Convert.ToInt32(row["PUN_VTAS"]);

            if (DataRecord.HasColumn(row, "PUN_RETA"))
                PuntosRetail = Convert.ToInt32(row["PUN_RETA"]);

            if (DataRecord.HasColumn(row, "PUN_TOTA"))
                PuntajeTotal = Convert.ToInt32(row["PUN_TOTA"]);

            if (DataRecord.HasColumn(row, "TIP_CONC"))
                TipoConcurso = Convert.ToString(row["TIP_CONC"]);
            if (DataRecord.HasColumn(row, "FEC_VIGE_RETA"))
                FechaVentaRetail = Convert.ToDateTime(row["FEC_VIGE_RETA"]);
        }

        public BEConsultoraConcurso()
        {
            Premios = new List<BEPremio>();
        }
    }
}
