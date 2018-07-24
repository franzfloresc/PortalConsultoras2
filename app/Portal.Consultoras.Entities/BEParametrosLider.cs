using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    public class BEParametrosLider
    {
        public BEParametrosLider()
        { }

        [DataMember]
        [Column("SeccionGestionLider")]
        public string SeccionGestionLider { get; set; }
        [DataMember]
        [Column("NivelProyectado")]
        public string NivelProyectado { get; set; }

        public BEParametrosLider(IDataRecord row)
        {
            SeccionGestionLider = row.ToString("SeccionGestionLider");
            NivelProyectado = row.ToString("NivelProyectado");
        }
    }
}
