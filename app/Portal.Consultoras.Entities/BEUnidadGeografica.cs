using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEUnidadGeografica
    {
       

        [DataMember]
        public string CodigoUbigeo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        /*Nuevo*/       
        //public string PadreUbigeoID { get; set; }   
     
        //public string UnidadGeografica { get; set; }

        public int NivelUbigeo { get; set; }

        [DataMember]
        public List<BEUnidadGeografica> Ubigeo { get; set; }       

        public BEUnidadGeografica()
        { }

        public BEUnidadGeografica(IDataRecord row)
        {
            /*
            if (row.HasColumn("CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
            {
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            }

            NivelUbigeo = Convert.ToInt32(row["Nivel"]);
            if (row.HasColumn("UnidadGeografica") && row["UnidadGeografica"] != DBNull.Value)
                Descripcion = Convert.ToString(row["UnidadGeografica"]);

            if (row.HasColumn("UnidadGeografica1") && row["UnidadGeografica1"] != DBNull.Value)
                Descripcion = Convert.ToString(row["UnidadGeografica1"]);

            if (row.HasColumn("UnidadGeografica2") && row["UnidadGeografica2"] != DBNull.Value)
                Descripcion = Convert.ToString(row["UnidadGeografica2"]);

            if (row.HasColumn("UnidadGeografica3") && row["UnidadGeografica3"] != DBNull.Value)
                Descripcion = Convert.ToString(row["UnidadGeografica3"]);

            if (row.HasColumn("UnidadGeografica4") && row["UnidadGeografica4"] != DBNull.Value)
                Descripcion = Convert.ToString(row["UnidadGeografica4"]);
             * */

            // Mejora el tiempo de conversion
            CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            NivelUbigeo = Convert.ToInt32(row["Nivel"]);
            if (row["UnidadGeografica1"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica1"]);

            if (row["UnidadGeografica2"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica2"]);

            if (row["UnidadGeografica3"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica3"]);
            
        }        
    }
}
