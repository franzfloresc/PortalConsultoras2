﻿using System;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentarioResumen
    {
        [DataMember]
        public int ProdComentarioResumenId { get; set; }

        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        [DataMember]
        public int CantComentarios { get; set; }

        [DataMember]
        public int CantAprobados { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        public BEProductoComentarioResumen()
        { }

        public BEProductoComentarioResumen(IDataRecord row)
        {
            if (row.HasColumn("ProdComentarioResumenId"))
                ProdComentarioResumenId = Convert.ToInt32(row["ProdComentarioResumenId"]);

            if (row.HasColumn("CodigoSAP"))
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);

            if (row.HasColumn("CodigoGenerico"))
                CodigoGenerico = Convert.ToString(row["CodigoGenerico"]);

            if (row.HasColumn("CantComentarios"))
                CantComentarios = Convert.ToInt32(row["CantComentarios"]);

            if (row.HasColumn("CantAprobados"))
                CantAprobados = Convert.ToInt32(row["CantAprobados"]);

            if (row.HasColumn("FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
        }
    }
}