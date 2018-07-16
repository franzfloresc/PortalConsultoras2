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
        public DateTime? FechaVentaRetail { get; set; }
        [DataMember]
        public List<BEPremio> Premios { get; set; }
        [DataMember]
        public int Importante { get; set; }
        [DataMember]
        public bool EsCampaniaAnterior { get; set; }
        [DataMember]
        public bool IndicadorPremiacionPedido { get; set; }
        [DataMember]
        public decimal MontoPremiacionPedido { get; set; }
        [DataMember]
        public bool IndicadorPremioAcumulativo { get; set; }
        [DataMember]
        public int NumeroNiveles { get; set; }
        [DataMember]
        public string Simbolo { get; set; }

        [DataMember]
        public string CampaniaInicio { get; set; }

        [DataMember]
        public string CampaniaFin { get; set; }

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

            if (DataRecord.HasColumn(row, "EsCampaniaAnterior"))
                EsCampaniaAnterior = Convert.ToBoolean(row["EsCampaniaAnterior"]);

            if (DataRecord.HasColumn(row, "IND_PREM_PEDI"))
                IndicadorPremiacionPedido = Convert.ToBoolean(row["IND_PREM_PEDI"]);

            if (DataRecord.HasColumn(row, "MON_PREM_PEDI"))
                MontoPremiacionPedido = Convert.ToDecimal(row["MON_PREM_PEDI"]);

            if (DataRecord.HasColumn(row, "IND_PREM_ACUM"))
                IndicadorPremioAcumulativo = Convert.ToBoolean(row["IND_PREM_ACUM"]);

            if (DataRecord.HasColumn(row, "NUMERO_NIVELES"))
                NumeroNiveles = Convert.ToInt32(row["NUMERO_NIVELES"]);

            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);

            if (row.HasColumn("CampaniaInicio"))
                CampaniaInicio = row.GetValue<string>("CampaniaInicio");

            if (row.HasColumn("CampaniaFinal"))
                CampaniaFin = row.GetValue<string>("CampaniaFinal");
        }

        public BEConsultoraConcurso()
        {
        }
    }
}
