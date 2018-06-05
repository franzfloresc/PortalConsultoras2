using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BEOpcionesVerificacion
    {
        [DataMember]
        public int OrigenID { get; set; }
        [DataMember]
        public string OrigenDescripcion { get; set; }
        [DataMember]
        public bool OpcionEmail { get; set; }
        [DataMember]
        public bool OpcionSms { get; set; }
        [DataMember]
        public bool OpcionChat { get; set; }
        [DataMember]
        public bool OpcionBelcorpResponde { get; set; }
        [DataMember]
        public bool IncluyeFiltros { get; set; }
        [DataMember]
        public bool TieneAlcanse { get; set; }
        [DataMember]
        public bool Activo { get; set; }
        [DataMember]
        public List<BEZonasOpcionesVerificacion> lstZonas { get; set; }
        [DataMember]
        public List<BEFiltrosOpcionesVerificacion> lstFiltros { get; set; }

        public BEOpcionesVerificacion()
        {}

        public BEOpcionesVerificacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OrigenID") && row["OrigenID"] != DBNull.Value)
                OrigenID = Convert.ToInt32(row["OrigenID"]);
            if (DataRecord.HasColumn(row, "OrigenDescripcion") && row["OrigenDescripcion"] != DBNull.Value)
                OrigenDescripcion = Convert.ToString(row["OrigenDescripcion"]);
            if (DataRecord.HasColumn(row, "OpcionEmail") && row["OpcionEmail"] != DBNull.Value)
                OpcionEmail = Convert.ToBoolean(row["OpcionEmail"]);
            if (DataRecord.HasColumn(row, "OpcionSms") && row["OpcionSms"] != DBNull.Value)
                OpcionSms = Convert.ToBoolean(row["OpcionSms"]);
            if (DataRecord.HasColumn(row, "OpcionChat") && row["OpcionChat"] != DBNull.Value)
                OpcionChat = Convert.ToBoolean(row["OpcionChat"]);
            if (DataRecord.HasColumn(row, "OpcionBelcorpResponde") && row["OpcionBelcorpResponde"] != DBNull.Value)
                OpcionBelcorpResponde = Convert.ToBoolean(row["OpcionBelcorpResponde"]);
            if (DataRecord.HasColumn(row, "IncluyeFiltros") && row["IncluyeFiltros"] != DBNull.Value)
                IncluyeFiltros = Convert.ToBoolean(row["IncluyeFiltros"]);
            if (DataRecord.HasColumn(row, "TieneAlcanse") && row["TieneAlcanse"] != DBNull.Value)
                TieneAlcanse = Convert.ToBoolean(row["TieneAlcanse"]);
            if (DataRecord.HasColumn(row, "Activo") && row["Activo"] != DBNull.Value)
                Activo = Convert.ToBoolean(row["Activo"]);
        }
    }
}
