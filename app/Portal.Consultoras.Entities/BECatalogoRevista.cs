using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoRevista
    {
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string MarcaDescripcion { get; set; }
        [DataMember]
        public bool Mostrar { get; set; }
        [DataMember]
        public string UrlImagen { get; set; }
        [DataMember]
        public string UrlVisor { get; set; }
        [DataMember]
        public string CatalogoTitulo { get; set; }
        [DataMember]
        public string CatalogoDescripcion { get; set; }

        public string CodigoIssuu { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string PaisISO { get; set; }
    }

    [DataContract]
    public class BECatalogoRevista_ODS
    {
        [DataMember]
        public int IdMatrizCatalogo { get; set; }
        [DataMember]
        public int CodigoCatalogo { get; set; }
        [DataMember]
        public bool EstadoActivo { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string DescripcionCatalogo { get; set; }
        [DataMember]
        public int CheckSumID { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BECatalogoRevista_ODS()
        {
            IdMatrizCatalogo = default(int);
            CodigoCatalogo = default(int);
            EstadoActivo = default(bool);
            PaisID = default(int);
            DescripcionCatalogo = default(string);
            CheckSumID = default(int);
            Descripcion = default(string);
        }

        public BECatalogoRevista_ODS(IDataRecord row)
        {
            IdMatrizCatalogo = row.ToInt32("IdMatrizCatalogo");
            CodigoCatalogo = row.ToInt32("CodigoCatalogo");
            EstadoActivo = row.ToBoolean("EstadoActivo");
            PaisID = row.ToInt32("PaisID");
            DescripcionCatalogo = row.ToString("DescripcionCatalogo");
            CheckSumID = row.ToInt32("CheckSumID");
            Descripcion = row.ToString("Descripcion");
        }

    }
}
