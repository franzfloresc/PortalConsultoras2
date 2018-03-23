using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;


namespace Portal.Consultoras.Entities.Estrategia
{
    public class UpsellingMarcaCategoria
    {
        [DataMember]
        [Column("UpsellingID")]
        public int UpsellingID { get; set; }
        [DataMember]
        [Column("MarcaID")]
        public string MarcaID { get; set; }
        [DataMember]
        [Column("MarcaNombre")]
        public string MarcaNombre { get; set; }
        [DataMember]
        [Column("CategoriaID")]
        public string CategoriaID { get; set; }
        [DataMember]
        [Column("CategoriaNombre")]
        public string CategoriaNombre { get; set; }

    }
}
