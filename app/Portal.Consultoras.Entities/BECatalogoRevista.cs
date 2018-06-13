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
            this.IdMatrizCatalogo       = default(int);
            this.CodigoCatalogo         = default(int);
            this.EstadoActivo           = default(bool);
            this.PaisID                 = default(int);
            this.DescripcionCatalogo    = default(string);
            this.CheckSumID             = default(int);
            this.Descripcion            = default(string);
        }

        public BECatalogoRevista_ODS(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizCatalogo"))
                IdMatrizCatalogo = Convert.ToInt32(row["IdMatrizCatalogo"]);

            if (DataRecord.HasColumn(row, "CodigoCatalogo"))
                CodigoCatalogo = Convert.ToInt32(row["CodigoCatalogo"]);

            if (DataRecord.HasColumn(row, "EstadoActivo"))
                EstadoActivo = Convert.ToBoolean(row["EstadoActivo"]);

            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);

            if (DataRecord.HasColumn(row, "DescripcionCatalogo"))
                DescripcionCatalogo = Convert.ToString(row["DescripcionCatalogo"]);

            if (DataRecord.HasColumn(row, "CheckSumID"))
                CheckSumID = Convert.ToInt32(row["CheckSumID"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
        }

    }
}
