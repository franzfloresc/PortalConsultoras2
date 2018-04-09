using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaFIC : BEPaging
    {
        [DataMember]
        public int CampaniaID { set; get; }

        [DataMember]
        public string CUV { set; get; }

        [DataMember]
        public string ImagenUrl { set; get; }

        [DataMember]
        public string PaisISO { set; get; }

        [DataMember]
        public string UsuarioRegistro { set; get; }

        [DataMember]
        public string NombreImagen { set; get; }

        [DataMember]
        [ViewProperty]
        public string Descripcion { set; get; }

        public BEOfertaFIC(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV"))
                CUV = Convert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "PaisISO"))
                PaisISO = Convert.ToString(datarec["PaisISO"]);
            if (DataRecord.HasColumn(datarec, "UsuarioRegistro"))
                UsuarioRegistro = Convert.ToString(datarec["UsuarioRegistro"]);
            if (DataRecord.HasColumn(datarec, "NombreImagen"))
                NombreImagen = Convert.ToString(datarec["NombreImagen"]);
            if (DataRecord.HasColumn(datarec, "ImagenUrl"))
                ImagenUrl = Convert.ToString(datarec["ImagenUrl"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "List_TotalNumeroPagina"))
                TotalPages = Convert.ToInt32(datarec["List_TotalNumeroPagina"]);
            if (DataRecord.HasColumn(datarec, "List_TotalRegistros"))
                RowsCount = Convert.ToInt32(datarec["List_TotalRegistros"]);
        }

        public BEOfertaFIC() { }
    }

}
