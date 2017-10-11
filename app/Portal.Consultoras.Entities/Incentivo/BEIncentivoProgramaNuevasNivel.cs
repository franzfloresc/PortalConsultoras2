using System.Runtime.Serialization;
using System.Collections.Generic;

namespace Portal.Consultoras.Entities.Incentivo
{
    /// <summary>
    /// Entidad nivel de programa nuevas
    /// </summary>
    public class BEIncentivoProgramaNuevasNivel
    {
        /// <summary>
        /// Codigo del concurso
        /// </summary>
        [DataMember]
        public string CodigoConcurso { get; set; }
        /// <summary>
        /// Codigo del nivel de la consultora
        /// </summary>
        [DataMember]
        public string CodigoNivel { get; set; }

        /// <summary>
        /// Array de premios por nivel
        /// </summary>
        [DataMember]
        public List<BEIncentivoProgramaNuevasPremio> PremiosProgramaNuevas { get; set; }

        /// <summary>
        /// Array de cupones por nivel
        /// </summary>
        [DataMember]
        public List<BEIncentivoProgramaNuevasCupon> CuponesProgramaNuevas { get; set; }
    }
}
