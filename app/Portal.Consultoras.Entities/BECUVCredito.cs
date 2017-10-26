using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECUVCredito
    {
        private string cuvCredito;
        private string cuvRegular;
        private int idMensaje;

        [DataMember]
        public string CuvCredito
        {
            get { return cuvCredito; }
            set { cuvCredito = value; }
        }
        [DataMember]
        public string CuvRegular
        {
            get { return cuvRegular; }
            set { cuvRegular = value; }
        }
        [DataMember]
        public int IdMensaje
        {
            get { return idMensaje; }
            set { idMensaje = value; }
        }

    }
}