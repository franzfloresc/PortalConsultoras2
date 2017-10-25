﻿using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELugarPago
    {
        [DataMember]
        public int LugarPagoID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }

        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public string Nombre { set; get; }
        [DataMember]
        public string UrlSitio { set; get; }
        [DataMember]
        public string ArchivoLogo { set; get; }
        [DataMember]
        public string ArchivoLogoAnterior { set; get; }
        [DataMember]
        public string ArchivoInstructivo { set; get; }
        [DataMember]
        public string TextoPago { set; get; }
        [DataMember]
        public int Posicion { set; get; }

        public BELugarPago()
        { }

        public BELugarPago(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "LugarPagoID"))
                LugarPagoID = Convert.ToInt32(row["LugarPagoID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "PaisNombre"))
                PaisNombre = Convert.ToString(row["PaisNombre"]);
            if (DataRecord.HasColumn(row, "NombreCorto"))
                NombreCorto = DbConvert.ToString(row["NombreCorto"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = DbConvert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = DbConvert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "UrlSitio"))
                UrlSitio = DbConvert.ToString(row["UrlSitio"]);
            if (DataRecord.HasColumn(row, "ArchivoLogo"))
                ArchivoLogo = DbConvert.ToString(row["ArchivoLogo"]);
            if (DataRecord.HasColumn(row, "ArchivoInstructivo"))
                ArchivoInstructivo = DbConvert.ToString(row["ArchivoInstructivo"]);
            if (DataRecord.HasColumn(row, "TextoPago"))
                TextoPago = DbConvert.ToString(row["TextoPago"]);
            if (DataRecord.HasColumn(row, "ArchivoInstructivo"))
                Posicion = DbConvert.ToInt32(row["Posicion"]);
        }
    }
}
