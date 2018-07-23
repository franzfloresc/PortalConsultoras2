using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMatrizComercial
    {
        [DataMember]
        [ViewProperty]
        public int PaisID { get; set; }
        [DataMember]
        [ViewProperty]
        public int IdMatrizComercial { get; set; }
        [DataMember]
        public string CodigoSAP { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionOriginal { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionProductoComercial { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto { get; set; }

        [DataMember]
        public string FotoProducto01 { get; set; }
        [DataMember]
        public string FotoProducto02 { get; set; }
        [DataMember]
        public string FotoProducto03 { get; set; }

        public BEMatrizComercial(IDataRecord row)
        {
            IdMatrizComercial = row.ToInt32("IdMatrizComercial");
            CodigoSAP = row.ToString("CodigoSAP");
            DescripcionOriginal = row.ToString("DescripcionOriginal");
            Descripcion = row.ToString("Descripcion");
            DescripcionProductoComercial = row.ToString("DescripcionProductoComercial");
            FotoProducto = row.ToString("FotoProducto");
        }
    }
}
