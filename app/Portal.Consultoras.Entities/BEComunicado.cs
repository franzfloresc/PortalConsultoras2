using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

//R2004
namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEComunicado
    {
        [DataMember]
        public long ComunicadoId {get; set;}
        [DataMember]
        public bool Visualizo {get; set;}
        [DataMember]
        public string CodigoConsultora { get; set; }

        public BEComunicado()
        { }

        public BEComunicado(IDataRecord record)
        {
            ComunicadoId = Convert.ToInt64(record["ComunicadoId"]);
            Visualizo = Convert.ToBoolean(record["Visualizo"]);
        }
    }
}
