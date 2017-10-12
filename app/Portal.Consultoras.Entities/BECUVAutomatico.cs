﻿using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECUVAutomatico : BEPaging
    {
        [DataMember]
        public int CampaniaID { set; get; }

        [DataMember]
        public string CUV { set; get; }

        [DataMember]
        public string PaisISO { set; get; }

        [DataMember]
        public string UsuarioRegistro { set; get; }

        [DataMember]
        [ViewProperty]
        public string Descripcion { set; get; }

        public BECUVAutomatico(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV"))
                CUV = Convert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "PaisISO"))
                PaisISO = Convert.ToString(datarec["PaisISO"]);
            if (DataRecord.HasColumn(datarec, "UsuarioRegistro"))
                UsuarioRegistro = Convert.ToString(datarec["UsuarioRegistro"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "List_TotalNumeroPagina"))
                TotalPages = Convert.ToInt32(datarec["List_TotalNumeroPagina"]);
            if (DataRecord.HasColumn(datarec, "List_TotalRegistros"))
                RowsCount = Convert.ToInt32(datarec["List_TotalRegistros"]);
        }

        public BECUVAutomatico() { }
    }
}
