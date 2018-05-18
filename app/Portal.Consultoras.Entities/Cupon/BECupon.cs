﻿using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cupon
{
    [DataContract]
    public class BECupon
    {
        [DataMember]
        public int CuponId { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public bool Estado { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BECupon(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CuponId"))
                CuponId = DbConvert.ToInt32(datarec["CuponId"]);
            if (DataRecord.HasColumn(datarec, "Tipo"))
                Tipo = DbConvert.ToString(datarec["Tipo"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = DbConvert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = DbConvert.ToBoolean(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
        }
    }
}