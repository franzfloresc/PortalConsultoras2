using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    public class BEDescripcionEstrategia
    {
        public string Cuv { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public string Mensaje { get; set; }
        
        public BEDescripcionEstrategia() { }

        public BEDescripcionEstrategia(IDataRecord row)
        {
            Cuv = DataRecord.GetColumn<string>(row, "Cuv");
            Descripcion = DataRecord.GetColumn<string>(row, "Descripcion");
            Estado = DataRecord.GetColumn<int>(row, "Estado");
            Mensaje = DataRecord.GetColumn<string>(row, "Mensaje");
        }
    }
}
