﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMotivoSolicitud
    {
        [DataMember]
        public int MotivoSolicitudID { get; set; }
        [DataMember]
        public string Motivo { get; set; }
        [DataMember]
        public int Tipo { get; set; }
        [DataMember]
        public short Estado { get; set; }

        public BEMotivoSolicitud(IDataRecord row)
        {
            this.MotivoSolicitudID = Convert.ToInt32(row["MotivoSolicitudID"]);
            this.Motivo = Convert.ToString(row["Motivo"]);

            if (DataRecord.HasColumn(row, "Tipo") && row["Tipo"] != DBNull.Value)
                this.Tipo = Convert.ToInt32(row["Tipo"]);
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                this.Estado = Convert.ToInt16(row["Estado"]);
        }
    }
}
