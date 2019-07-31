using System.Collections.Generic;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    public class BELogroCaminoBrillante
    {
        public string Id { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public List<BEIndicadorCaminoBrillante> Indicadores { get; set; }

        public class BEIndicadorCaminoBrillante
        {
            public int Orden { get; set; }
            public string Codigo { get; set; }
            public string Titulo { get; set; }
            public string Descripcion { get; set; }
            public List<BEMedallaCaminoBrillante> Medallas { get; set; }

            public class BEMedallaCaminoBrillante
            {
                public int Orden { get; set; }
                public string Tipo { get; set; }
                public string Titulo { get; set; }
                public string Subtitulo { get; set; }
                public string Valor { get; set; }
                public bool Estado { get; set; }
                public bool Destacar { get; set; }
                public string ModalTitulo { get; set; }
                public string ModalDescripcion { get; set; }
                public decimal MontoSuperior { get; set; }
                public string DescripcionNivel { get; set; }
                public string MontoAcumulado { get; set; }
            }

        }
    }
}
