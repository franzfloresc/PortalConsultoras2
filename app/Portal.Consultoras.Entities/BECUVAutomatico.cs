using OpenSource.Library.DataAccess;
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

        public BECUVAutomatico(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            PaisISO = row.ToString("PaisISO");
            UsuarioRegistro = row.ToString("UsuarioRegistro");
            Descripcion = row.ToString("Descripcion");
            TotalPages = row.ToInt32("List_TotalNumeroPagina");
            RowsCount = row.ToInt32("List_TotalRegistros");
        }

        public BECUVAutomatico() { }
    }
}
