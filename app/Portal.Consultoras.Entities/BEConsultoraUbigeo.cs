using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Entities
{
    [DataContract]
   public class BEConsultoraUbigeo
    {
          
            [DataMember]
            public long ConsultoraID { get; set; }
            [DataMember]
            public string CodigoConsultora { get; set; }
            [DataMember]
            public string CodigoUbigeo { get; set; }
            [DataMember]
            public string NombreCompleto { get; set; }
            [DataMember]
            public string Email { get; set; }

            public BEConsultoraUbigeo(BEConsultora entidad){

                ConsultoraID = entidad.ConsultoraID;
                CodigoConsultora = entidad.Codigo;
                CodigoUbigeo = entidad.CodigoUbigeo;
                NombreCompleto = entidad.NombreCompleto;
                Email = entidad.Email;

        
             }

        //    public BEConsultoraUbigeo(IDataRecord row)
        //    {
        //    if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
        //        ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
        //    if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
        //        CodigoConsultora = Convert.ToString(row["Codigo"]);
        //    if (DataRecord.HasColumn(row, "CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
        //        CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
        //    if (DataRecord.HasColumn(row, "NombreCompletoConsultora") && row["NombreCompletoConsultora"] != DBNull.Value)
        //        NombreCompleto = Convert.ToString(row["NombreCompletoConsultora"]);           
        //    if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
        //        Email = Convert.ToString(row["Email"]);           

            

        //}


        
    }
}
