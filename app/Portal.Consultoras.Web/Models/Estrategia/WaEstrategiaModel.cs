using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class WaEstrategiaModel
    {
        public string _id { get; set; }
        public int EstrategiaId { get; set; }
        public string CodigoEstrategia { get; set; }
        public string CodigoCampania { get; set; }
        public bool Activo { get; set; }
        public string CUV2 { get; set; }
        public string DescripcionCUV2 { get; set; }
        public float Precio { get; set; }
        public float Precio2 { get; set; }
        public float PrecioPublico { get; set; }
        public float Ganancia { get; set; }
        public string ImagenURL { get; set; }
        public bool FlagImagenURL { get; set; }
        public int LimiteVenta { get; set; }
        public string TextoLibre { get; set; }
        public bool FlagNueva { get; set; }
        public int DiaInicio { get; set; }
        public int Orden { get; set; }
        public bool FlagConfig { get; set; }
        public string Zona { get; set; }
        public bool FlagEstrella { get; set; }

        //TipoEstrategia
        public int TipoEstrategiaId { get; set; }
        public string DescripcionTipoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public string ImagenEstrategia { get; set; }
        public bool FlagActivo { get; set; }
        public bool FlagRecoPerfil { get; set; }

        //Producto        
        public int MarcaId { get; set; }
        public string MarcaDescripcion { get; set; }
        public string CodigoProducto { get; set; }
        public bool IndicadorMontoMinimo { get; set; }
        public string CodigoSap { get; set; }
        public int MatrizComercialId { get; set; }

        //Audit
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}