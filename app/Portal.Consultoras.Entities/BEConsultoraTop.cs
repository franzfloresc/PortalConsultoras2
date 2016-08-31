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
    public class BEConsultoraTop
    {
        [DataMember]
        public int ConsultoraTopID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public bool EsTop { get; set; }

        public BEConsultoraTop()
        {

        }

        public BEConsultoraTop(IDataRecord row, IList<string> columns)
        {
            foreach (var column in columns)
            {
                switch (column)
                {
                    case "ConsultoraTopID":
                        ConsultoraTopID = Convert.ToInt16(row["ConsultoraTopID"]);
                        break;
                    case "CodigoConsultora":
                        CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
                        break;
                    case "EsTop":
                        EsTop = Convert.ToBoolean(row["EsTop"]);
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
