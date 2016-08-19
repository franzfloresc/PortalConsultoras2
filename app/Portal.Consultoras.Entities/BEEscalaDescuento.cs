﻿using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEscalaDescuento
    {
        [DataMember]
        public decimal MontoDesde { get; set; }
        [DataMember]
        public decimal MontoHasta { get; set; }
        [DataMember]
        public int PorDescuento { get; set; }
        [DataMember]
        public bool Seleccionado { get; set; }
        public BEEscalaDescuento(){ }

        public BEEscalaDescuento(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "MontoDesde") && row["MontoDesde"] != DBNull.Value)
                MontoDesde = Convert.ToDecimal(row["MontoDesde"]);
            if (DataRecord.HasColumn(row, "MontoHasta") && row["MontoHasta"] != DBNull.Value)
                MontoHasta = Convert.ToDecimal(row["MontoHasta"]);
            if (DataRecord.HasColumn(row, "PorDescuento") && row["PorDescuento"] != DBNull.Value)
                PorDescuento = Convert.ToInt32(row["PorDescuento"]);
        }
    }
}
