using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class WaTipoEstrategia
    {
        public string _id { get; set; }
        public int TipoEstrategiaId { get; set; }
        public string TipoPersonalizacion { get; set; }
        public string DescripcionTipoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public string ImagenEstrategia { get; set; }
        public int Orden { get; set; }
        public bool FlagActivo { get; set; }
        public bool FlagNueva { get; set; }
        public bool FlagRecoProduc { get; set; }
        public bool FlagRecoPerfil { get; set; }
        public string CodigoPrograma { get; set; }
        public string OfertaId { get; set; }
        public bool FlagMostrarImg { get; set; }
        public bool MostrarImgOfertaIndependiente { get; set; }
        public string ImagenOfertaIndependiente { get; set; }
        public string Codigo { get; set; }
        public bool FlagValidarImagen { get; set; }
        public int PesoMaximoImagen { get; set; }

        //Audit
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}