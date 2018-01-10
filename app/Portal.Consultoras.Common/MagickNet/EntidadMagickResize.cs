using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.MagickNet
{
    public class EntidadMagickResize
    {
        public string RutaImagenOriginal { get; set; }
        public string RutaImagenResize { get; set; }
        public int Width { get; set; }
        public int Height { get; set; }
        public string TipoImagen { get; set; }
        public string CodigoIso { get; set; }
    }
}
