using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class WaEstrategiaComponenteModel
    {
        public string _id { get; set; }
        public string CuvPadre { get; set; }
        public string CampaniaId { get; set; }
        public string Cuv { get; set; }
        public int CodigoEstrategia { get; set; }
        public int Grupo { get; set; }
        public string CodigoSap { get; set; }
        public int Cantidad { get; set; }
        public double PrecioUnitario { get; set; }
        public double PrecioValorizado { get; set; }
        public int Orden { get; set; }
        public bool IndicadorDigitable { get; set; }
        public int FactorCuadre { get; set; }
        public string Descripcion1 { get; set; }
        public string NombreProducto { get; set; }
        public int MarcaId { get; set; }
        public string NombreMarca { get; set; }
        public string Categoria { get; set; }
        public string GrupoArticulo { get; set; }
        public string Linea { get; set; }

        //Producto Comercial
        public bool? Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }

        //SQL
        public int EstrategiaId { get; set; }
        public int EstrategiaProductoId { get; set; }

        #region App Catalogo
        public string ImagenProducto { get; set; }
        public string NombreComercial { get; set; }
        public string Descripcion { get; set; }
        public string Volumen { get; set; }
        public string ImagenBulk { get; set; }
        public string NombreBulk { get; set; }
        #endregion
    }
}