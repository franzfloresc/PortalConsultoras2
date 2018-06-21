using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Entities
{
    public class BEParametrosLider
    {
        public BEParametrosLider()
        { }

        [DataMember]
        public string SeccionGestionLider { get; set; }
        [DataMember]
        public string NivelProyectado { get; set; }

        public BEParametrosLider(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "SeccionGestionLider"))
                SeccionGestionLider = Convert.ToString(row["SeccionGestionLider"]);
            if (DataRecord.HasColumn(row, "NivelProyectado"))
                NivelProyectado = Convert.ToString(row["NivelProyectado"]);
        }
    }
}
