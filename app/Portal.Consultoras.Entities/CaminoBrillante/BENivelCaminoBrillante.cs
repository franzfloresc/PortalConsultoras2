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
        /// Indica si tendra ofertas o no
        /// </summary>
        public bool TieneOfertasEspeciales { get; set; }
        /// <summary>
        /// Url de imagen del Nivel
        /// </summary>
        //public string UrlImagenNivel { get; set; }
        /// <summary>
        /// Listado de beneficos para cada Nivel
        /// </summary>
        public List<BEBeneficioCaminoBrillante> Beneficios { get; set; }

        [DataContract]
        public class BEBeneficioCaminoBrillante
        {
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
            [Column("Icono")]
            public string Icono { get; set; }
        }

    }
}
