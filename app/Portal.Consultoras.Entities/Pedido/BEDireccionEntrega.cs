using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Pedido
{
    public class BEDireccionEntrega
    {
        public int DireccionEntregaID { get; set; }
        public int ConsultoraID { get; set; }
        public  int CampaniaID { get; set; }
        public int CampaniaAnteriorID { get; set; }
        public int CiudadID { get; set; }
        public int ComunaID { get; set; }
        public int CiudadAnteriorID { get; set; }
        public int ComunaAnteriorID { get; set; }
        public string DireccionAnterior { get; set; }
        public string Direccion { get; set; }
        public string Referencia { get; set; }
        public  string CodigoConsultora { get; set; }
        public string NombreConsultora { get; set; }
        public int LatitudAnterior { get; set; }
        public int LongitudAnterior { get; set; }
        public int Latitud { get; set; }
        public int Longitud { get; set; }
        public  DateTime? UltimafechaActualizacion { get; set; }

        public  string CodigoUsuario { get; set; }
        public  int PaisID { get; set; }
        public int Resultado { get; set; }


    }
}
