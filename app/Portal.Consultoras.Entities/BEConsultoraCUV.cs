using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{

    [DataContract]
    public class BEConsultoraCUV
    {
        [DataMember]
        public int ConsultoraCUVID { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CUVRegular { get; set; }
        [DataMember]
        public string CUVCredito { get; set; }

        public BEConsultoraCUV()
        {

        }

        public BEConsultoraCUV(IDataRecord row, IList<string> columns)
        {
            foreach (var column in columns)
            {
                switch (column)
                {
                    case "ConsultoraCUVID":
                        ConsultoraCUVID = Convert.ToInt16(row["ConsultoraCUVID"]);
                        break;
                    case "CodigoCampania":
                        CodigoCampania = Convert.ToString(row["CodigoCampania"]);
                        break;
                    case "CUVRegular":
                        CUVRegular = Convert.ToString(row["CUVRegular"]);
                        break;
                    case "CUVCredito":
                        CUVCredito = Convert.ToString(row["CUVCredito"]);
                        break;
                    default:
                        break;
                }
            }
        }

    }
}
