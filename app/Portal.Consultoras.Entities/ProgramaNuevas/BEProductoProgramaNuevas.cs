﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEProductoProgramaNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int CampanaID { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string CodigoCupon { get; set; }
        [DataMember]
        public string CodigoVenta { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public int UnidadesMaximas { get; set; }
        [DataMember]
        public bool IndicadorKit { get; set; }
        [DataMember]
        public bool IndicadorCuponIndependiente { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public int NumeroCampanasVigentes { get; set; }

        public BEProductoProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CodigoPrograma") && datarec["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = DbConvert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "CampanaID") && datarec["CampanaID"] != DBNull.Value)
                CampanaID = DbConvert.ToInt32(datarec["CampanaID"]);
            if (DataRecord.HasColumn(datarec, "CodigoNivel") && datarec["CodigoNivel"] != DBNull.Value)
                CodigoNivel = DbConvert.ToString(datarec["CodigoNivel"]);
            if (DataRecord.HasColumn(datarec, "CodigoCupon") && datarec["CodigoCupon"] != DBNull.Value)
                CodigoCupon = DbConvert.ToString(datarec["CodigoCupon"]);
            if (DataRecord.HasColumn(datarec, "CodigoVenta") && datarec["CodigoVenta"] != DBNull.Value)
                CodigoVenta = DbConvert.ToString(datarec["CodigoVenta"]);
            if (DataRecord.HasColumn(datarec, "DescripcionProducto") && datarec["DescripcionProducto"] != DBNull.Value)
                DescripcionProducto = DbConvert.ToString(datarec["DescripcionProducto"]);
            if (DataRecord.HasColumn(datarec, "UnidadesMaximas") && datarec["UnidadesMaximas"] != DBNull.Value)
                UnidadesMaximas = DbConvert.ToInt32(datarec["UnidadesMaximas"]);
            if (DataRecord.HasColumn(datarec, "IndicadorKit") && datarec["IndicadorKit"] != DBNull.Value)
                IndicadorKit = DbConvert.ToBoolean(datarec["IndicadorKit"]);
            if (DataRecord.HasColumn(datarec, "IndicadorCuponIndependiente") && datarec["IndicadorCuponIndependiente"] != DBNull.Value)
                IndicadorCuponIndependiente = DbConvert.ToBoolean(datarec["IndicadorCuponIndependiente"]);
            if (DataRecord.HasColumn(datarec, "PrecioUnitario") && datarec["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = DbConvert.ToDecimal(datarec["PrecioUnitario"]);
            if (DataRecord.HasColumn(datarec, "NumeroCampanasVigentes") && datarec["NumeroCampanasVigentes"] != DBNull.Value)
                NumeroCampanasVigentes = DbConvert.ToInt32(datarec["NumeroCampanasVigentes"]);
        }
    }
}
