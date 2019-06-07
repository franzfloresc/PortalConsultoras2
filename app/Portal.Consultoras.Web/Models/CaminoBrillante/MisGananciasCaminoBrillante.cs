using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class MisGananciasCaminoBrillante
    {
        public string Titulo { get; set; }
        public string SubTitulo { get; set; }
        public List<GananciaCampaniaCaminoBrillante> MisGanancias { get; set; }

        public class GananciaCampaniaCaminoBrillante
        {
            public string LabelSerie { get; set; }
            public decimal ValorSerie { get; set; }
            public string ValorSerieFormat { get; set; }
            public decimal GananciaCampania { get; set; }
            public decimal GananciaPeriodo { get; set; }
            public string GananciaCampaniaFormat { get; set; }
            public string GananciaPeriodoFormat { get; set; }
        }
    }
}