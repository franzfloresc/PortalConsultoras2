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
            CodigoConsultora = row.ToString("COD_CLIE");
            CodigoConcurso = row.ToString("COD_CONC");
            DescripcionConcurso = row.ToString("DES_CONC");
            CodigoRegion = row.ToString("COD_REGI");
            Participa = row.ToBoolean("PARTICIPA");
            CodigoCampania = row.ToString("COD_CAMPANIA");
            NivelAlcanzado = row.ToInt32("NIV_ALCA");
            NivelSiguiente = row.ToInt32("NivelSiguiente");
            PuntosFaltantesSiguienteNivel = row.ToInt32("PUN_FALT_NIVS");
            PuntosXVentas = row.ToInt32("PUN_VTAS");
            PuntosRetail = row.ToInt32("PUN_RETA");
            PuntajeTotal = row.ToInt32("PUN_TOTA");
            TipoConcurso = row.ToString("TIP_CONC");
            FechaVentaRetail = row.ToDateTime("FEC_VIGE_RETA");
            EsCampaniaAnterior = row.ToBoolean("EsCampaniaAnterior");
            IndicadorPremiacionPedido = row.ToBoolean("IND_PREM_PEDI");
            MontoPremiacionPedido = row.ToDecimal("MON_PREM_PEDI");
            IndicadorPremioAcumulativo = row.ToBoolean("IND_PREM_ACUM");
            NumeroNiveles = row.ToInt32("NUMERO_NIVELES");
            Simbolo = row.ToString("Simbolo");
            CampaniaInicio = row.GetColumn<string>("CampaniaInicio");
            CampaniaFin = row.GetColumn<string>("CampaniaFinal");
        }

        public BEConsultoraConcurso()
        {
        }
    }
}
