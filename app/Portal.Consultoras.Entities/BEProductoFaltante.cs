using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        [ViewProperty]
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
        [ViewProperty]
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

        public BEProductoFaltante(IDataRecord row)
        {
            rowID = row.ToString("RowNumber");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            ZonaID = row.ToInt32("ZonaID");
            Zona = row.ToString("Zona");
            Descripcion = row.ToString("Descripcion");
            TotalPages = row.ToInt32("List_TotalNumeroPagina");
            RowsCount = row.ToInt32("List_TotalRegistros");
            Estado = row.ToInt32("Estado");
            Fecha = row.ToString("fecha", "");
            Codigo = row.ToString("Codigo");
            FaltanteUltimoMinuto = row.ToBoolean("FaltanteUltimoMinuto");
            Categoria = row.ToString("Categoria", "");
            Catalogo = row.ToString("Catalogo", "");
            NumeroPagina = row.ToInt32("NumeroPagina", 0);
        }

        public BEProductoFaltante()
        {
        }
    }

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

}
