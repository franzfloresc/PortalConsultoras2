﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoFaltante : BEPaging
    {
        [DataMember]
        public int CampaniaID { set; get; }

        [DataMember]
        public string CUV { set; get; }

        [DataMember]
        public int ZonaID { set; get; }

        [DataMember]
        [ViewProperty]
        public int Estado { set; get; }

        [DataMember]
        [ViewProperty]
        public string Descripcion { set; get; }

        [DataMember]
        [ViewProperty]//R1957
        public string Fecha { set; get; }

        [DataMember]
        [ViewProperty]
        public int PaisID { set; get; }

        [DataMember]
        public string Zona { set; get; }

        [DataMember]
        [ViewProperty]
        public string Codigo { set; get; }

        [DataMember]
        [ViewProperty]
        public bool FaltanteUltimoMinuto { set; get; }

        [DataMember]
        [ViewProperty] // 1957
        public string rowID { set; get; }

        [DataMember]
        [ViewProperty]
        public string Categoria { set; get; }

        [DataMember]
        [ViewProperty]
        public string Catalogo { set; get; }

        [DataMember]
        [ViewProperty]
        public int NumeroPagina { set; get; }

        public BEProductoFaltante(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "RowNumber")) //R1957
                rowID = Convert.ToString(datarec["RowNumber"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV"))
                CUV = Convert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "ZonaID")) ZonaID = Convert.ToInt32(datarec["ZonaID"]);
            if (DataRecord.HasColumn(datarec, "Zona")) Zona = Convert.ToString(datarec["Zona"]);
            if (DataRecord.HasColumn(datarec, "Descripcion")) Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "List_TotalNumeroPagina")) TotalPages = Convert.ToInt32(datarec["List_TotalNumeroPagina"]);
            if (DataRecord.HasColumn(datarec, "List_TotalRegistros")) RowsCount = Convert.ToInt32(datarec["List_TotalRegistros"]);
            if (DataRecord.HasColumn(datarec, "Estado")) Estado = Convert.ToInt32(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "fecha")) Fecha = Convert.IsDBNull(datarec["fecha"]) ? "" : datarec["fecha"].ToString();
            else Fecha = "";
            if (DataRecord.HasColumn(datarec, "Codigo")) Codigo = Convert.ToString(datarec["Codigo"]);
            if (DataRecord.HasColumn(datarec, "FaltanteUltimoMinuto")) FaltanteUltimoMinuto = Convert.ToBoolean(datarec["FaltanteUltimoMinuto"]);

            if (DataRecord.HasColumn(datarec, "Categoria")) Categoria = Convert.IsDBNull(datarec["Categoria"]) ? "" : datarec["Categoria"].ToString();
            if (DataRecord.HasColumn(datarec, "Catalogo")) Catalogo = Convert.IsDBNull(datarec["Catalogo"]) ? "" : datarec["Catalogo"].ToString();
            if (DataRecord.HasColumn(datarec, "NumeroPagina")) NumeroPagina = Convert.IsDBNull(datarec["NumeroPagina"]) ? 0 : Convert.ToInt32(datarec["NumeroPagina"]);
        }

        public BEProductoFaltante()
        {
        }
    }
    /* 1957 - Inicio */
    [DataContract]
    public class BETablaTemType
    {
        [DataMember]
        public int CampaniaID { set; get; }

        [DataMember]
        public string CUV { set; get; }

        [DataMember]
        public int ZonaID { set; get; }

    }
    /* 1957 - Fin */
}
