using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETallaColor
    {
        public BETallaColor()
        {
            IDAux = 0;
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public int IDAux { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionCUV { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string DescripcionTipo { get; set; }
        [DataMember]
        public string DescripcionTallaColor { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BETallaColor(IDataRecord row)
        {
            ID = row.ToInt32("ID");
            CUV = row.ToString("CUV");
            DescripcionCUV = row.ToString("DescripcionCUV");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            Tipo = row.ToString("Tipo");
            DescripcionTipo = row.ToString("DescripcionTipo");
            DescripcionTallaColor = row.ToString("DescripcionTallaColor");
        }

    }
}
