using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BERespValidarElectivos
    {
        [DataMember]
        public Enumeradores.ValidarCuponesElectivos Resultado { get; set; }
        [DataMember]
        public List<string> ListCuvEliminar { get; set; }

        public BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos resultado, List<string> listCuvEliminar)
        {
            Resultado = resultado;
            ListCuvEliminar = listCuvEliminar;
        }
        public BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos resultado) : this(resultado, new List<string>()) { }
    }
}
