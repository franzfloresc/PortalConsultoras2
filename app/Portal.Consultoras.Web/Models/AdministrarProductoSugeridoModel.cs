﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarProductoSugeridoModel
    {
        public int CampaniaID { get; set; }
        public int PaisID { get; set; }
        public int PaisIDUser { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }

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
    }
}