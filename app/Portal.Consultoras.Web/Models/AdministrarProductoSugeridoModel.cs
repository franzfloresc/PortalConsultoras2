using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarProductoSugeridoModel
    {
        public int CampaniaID { get; set; }
        public int PaisID { get; set; }
        public int PaisIDUser { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
        public string ExpValidacionNemotecnico { get; set; }
        public int ProductoSugeridoID { get; set; }
        public string CUV { get; set; }
        public string CUVSugerido { get; set; }
        public int Orden { get; set; }
        public string ImagenProducto { get; set; }
        public string Estado { get; set; }
        public string UsuarioRegistro { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public int MostrarAgotado { get; set; }
        public int ConsultoraID { get; set; }
        public bool CuvEsAceptado { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }
    }
}