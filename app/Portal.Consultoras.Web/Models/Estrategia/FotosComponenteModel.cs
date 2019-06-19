namespace Portal.Consultoras.Web.Models.Estrategia
{
    using System;
    using System.Collections.Generic;

    [Serializable]
    public class FotosComponenteModel
    {
        public List<String> FotoProductoFondoBlanco { get; set; }
        public List<String> FotoProducto { get; set; }
        public List<String> FotoModelo { get; set; }
        public List<String> FotoMontaje { get; set; }
        public List<String> FotoBulk { get; set; }
        public List<String> FotoTipoBelleza1 { get; set; }
        public List<String> FotoTipoBelleza2 { get; set; }
        public List<String> FotoTipoBelleza3 { get; set; }
        public List<String> FotoTipoBelleza4 { get; set; }
    }
}