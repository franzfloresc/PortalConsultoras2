﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentario
    {
        [DataMember]
        public int ProdComentarioId { get; set; }

        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        [DataMember]
        public int CantAprobados { get; set; }

        [DataMember]
        public int CantRecomendados { get; set; }

        [DataMember]
        public int PromValorizado { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public Int16 Estado { get; set; }

        public BEProductoComentario()
        { }

        public BEProductoComentario(IDataRecord row)
        {
            if (row.HasColumn("ProdComentarioId"))
                ProdComentarioId = Convert.ToInt32(row["ProdComentarioId"]);

            if (row.HasColumn("CodigoSap"))
                CodigoSap = Convert.ToString(row["CodigoSap"]);

            if (row.HasColumn("CodigoGenerico"))
                CodigoGenerico = Convert.ToString(row["CodigoGenerico"]);

            if (row.HasColumn("CantAprobados"))
                CantAprobados = Convert.ToInt32(row["CantAprobados"]);

            if (row.HasColumn("CantRecomendados"))
                CantRecomendados = Convert.ToInt32(row["CantRecomendados"]);

            if (row.HasColumn("PromValorizado"))
                PromValorizado = Convert.ToInt32(row["PromValorizado"]);

            if (row.HasColumn("FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (row.HasColumn("Estado"))
                Estado = Convert.ToInt16(row["Estado"]);
        }
    }
}