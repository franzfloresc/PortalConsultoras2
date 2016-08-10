﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ShowRoomOfertaModel
    {
        public int OfertaShowRoomID { get; set; }

        public int CampaniaID { get; set; }

        public string CUV { get; set; }

        public int TipoOfertaSisID { get; set; }
       
        public int ConfiguracionOfertaID { get; set; }

        public string Descripcion { get; set; }

        public decimal PrecioOferta { get; set; }

        public decimal PrecioCatalogo { get; set; }

        public int Stock { get; set; }

        public int StockInicial { get; set; }

        public string ImagenProducto { get; set; }

        public int Orden { get; set; }

        public int UnidadesPermitidas { get; set; }

        public bool FlagHabilitarProducto { get; set; }

        public string DescripcionLegal { get; set; }

        public string CategoriaID { get; set; }

        public string DescripcionProducto1 { get; set; }

        public string DescripcionProducto2 { get; set; }

        public string DescripcionProducto3 { get; set; }

        public string ImagenProducto1 { get; set; }

        public string ImagenProducto2 { get; set; }

        public string ImagenProducto3 { get; set; }

        public string UsuarioRegistro { get; set; }

        public DateTime FechaRegistro { get; set; }

        public string UsuarioModificacion { get; set; }

        public DateTime FechaModificacion { get; set; }


        public int NroOrden { get; set; }

        public string CodigoCampania { get; set; }

        public string CodigoTipoOferta { get; set; }

        public string TipoOferta { get; set; }

        public string CodigoProducto { get; set; }

        public string ISOPais { get; set; }

        public int PaisID { get; set; }

        public int MarcaID { get; set; }

        public string DescripcionMarca { get; set; }
    }
}