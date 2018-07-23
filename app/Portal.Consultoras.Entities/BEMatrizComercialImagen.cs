using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMatrizComercialImagen
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int IdMatrizComercialImagen { get; set; }

        [DataMember]
        public int IdMatrizComercial { get; set; }

        [DataMember]
        public string Foto { get; set; }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public DateTime? FechaRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string NemoTecnico { get; set; }

        [DataMember]
        public string DescripcionComercial { get; set; }

        [DataMember]
        public int TotalRegistros { get; set; }

        public BEMatrizComercialImagen(IDataRecord row)
        {
            IdMatrizComercialImagen = row.ToInt32("IdMatrizComercialImagen");
            IdMatrizComercial = row.ToInt32("IdMatrizComercial");
            Foto = row.ToString("Foto");
            NemoTecnico = row.ToString("NemoTecnico");
            DescripcionComercial = row.ToString("DescripcionComercial");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            TotalRegistros = row.ToInt32("TotalRegistros");
        }
    }
}
