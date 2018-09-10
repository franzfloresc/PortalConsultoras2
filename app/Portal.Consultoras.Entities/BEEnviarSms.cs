using Portal.Consultoras.Common;
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
    public class BEEnviarSms
    {
        [DataMember]
        public string UsuarioSms { get; set; }
        [DataMember]
        public string ClaveSms { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string MensajeOptin { get; set; }
        [DataMember]
        public string RequestUrl { get; set; }
        [DataMember]
        public string RecursoApi { get; set; }

        public BEEnviarSms()
        {}
    }

    [DataContract]
    public class BERespuestaSMS
    {
        [DataMember]
        public string codigo { get; set; }
        [DataMember]
        public string mensaje { get; set; }
        [DataMember]
        public bool resultado { get; set; }

        public BERespuestaSMS()
        { }
    }
}
