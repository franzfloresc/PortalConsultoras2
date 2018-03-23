using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

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
        [Column("CodigoConcurso")]
        public string CodigoConcurso { get; set; }
        /// <summary>
        /// Codigo del nivel de la consultora
        /// </summary>
        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }
        /// <summary>
        /// Monto exigido para los premios
        /// </summary>
        [DataMember]
        [Column("MontoExigidoPremio")]
        public decimal MontoExigidoPremio { get; set; }
        /// <summary>
        /// Monto exigido para los cupones
        /// </summary>
        [DataMember]
        [Column("MontoExigidoCupon")]
        public decimal MontoExigidoCupon { get; set; }

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
