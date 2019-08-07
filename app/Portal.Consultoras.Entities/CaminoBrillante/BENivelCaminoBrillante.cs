using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    public class BENivelCaminoBrillante
    {
        /// <summary>
        /// Codigo de nivel en camino brillante de la consultora
        /// </summary>
        public string CodigoNivel { get; set; }
        /// <summary>
        /// Descripcion del Nivel de la consultora
        /// </summary>
        public string DescripcionNivel { get; set; }
        /// <summary>
        /// Especifica en monto mínimo de la consultora en su nivel correspondiente
        /// </summary>
        public string MontoMinimo { get; set; }
        /// <summary>
        ///  Especifica en monto máximo de la consultora en su nivel correspondiente
        /// </summary>
        public string MontoMaximo { get; set; }
        /// <summary>
        /// Indica el monto Maximo del siguiente nivel
        /// </summary>
        public decimal? MontoFaltante { get; set; }
        /// <summary>
        /// Indica el monto Acumulado
        /// </summary>
        public decimal? MontoAcumulado { get; set; }
        /// <summary>   
        /// Indica si tendra ofertas o no
        /// </summary>
        public bool TieneOfertasEspeciales { get; set; }
        /// <summary>
        /// Listado de beneficos para cada Nivel
        /// </summary>
        public List<BEBeneficioCaminoBrillante> Beneficios { get; set; }
        /// <summary>
        /// Enterate Más Nivel
        /// </summary>
        public int EnterateMas { get; set; }
        /// <summary>
        /// Enterate Más Nivel Param
        /// </summary>
        public string EnterateMasParam { get; set; }
        /// <summary>
        /// Puntaje Nivel
        /// </summary>
        public int Puntaje { get; set; }
        /// <summary>
        /// Puntaje Acumulado
        /// </summary>
        public int? PuntajeAcumulado { get; set; }
        /// <summary>
        /// Mensaje Nivel
        /// </summary>
        public string Mensaje { get; set; }

    }

    [DataContract]
    public class BEBeneficioCaminoBrillante
    {
        [DataMember]
        [Column("Registro")]
        public int Registro { get; set; }

        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }

        [DataMember]
        [Column("CodigoBeneficio")]
        public string CodigoBeneficio { get; set; }

        [DataMember]
        [Column("NombreBeneficio")]
        public string NombreBeneficio { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }

        [DataMember]
        [Column("Icono")]
        public string Icono { get; set; }

        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }
    }

}