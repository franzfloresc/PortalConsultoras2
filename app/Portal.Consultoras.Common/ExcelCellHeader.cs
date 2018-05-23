using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class ExcelCellHeader
    {
        public ExcelCellHeader(string nombre, int ancho, Color fondo, Color color, bool isBold)
        {
            this.Nombre = nombre;
            this.Ancho = ancho;
            this.Fondo = fondo;
            this.Color = color;
            this.IsBold = isBold;
        }

        public string Nombre { get; set; }
        public int Ancho { get; set; }
        public Color Fondo { get; set; }
        public Color Color { get; set; }
        public bool IsBold { get; set; }
    }
}
