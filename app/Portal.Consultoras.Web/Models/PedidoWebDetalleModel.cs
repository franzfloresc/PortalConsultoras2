﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class PedidoWebDetalleModel
    {
        public string IPUsuario { get; set; }

        public int CampaniaID { get; set; }

        public int ConsultoraID { get; set; }

        public int PaisID { get; set; }

        public int TipoOfertaSisID { get; set; }

        public int ConfiguracionOfertaID { get; set; }

        public int ClienteID { get; set; }

        public int PedidoID { get; set; }

        public bool OfertaWeb { get; set; }

        public int IndicadorMontoMinimo { get; set; }

        public int SubTipoOfertaSisID { get; set; }

        public bool EsSugerido { get; set; }

        public bool EsKitNueva { get; set; }

        public int MarcaID { get; set; }

        public string Cantidad { get; set; }

        public string CodigoIso { get; set; }

        public decimal PrecioUnidad { get; set; }

        public string FormatoPrecioUnidad
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioUnidad, CodigoIso);
            }
        }

        public string CUV { get; set; }

        public string DescripcionProd { get; set; }

        public decimal ImporteTotal { get; set; }

        public string FormatoImporteTotal
        {
            get
            {
                return Util.DecimalToStringFormat(ImporteTotal, CodigoIso);
            }
        }

        public string Nombre { get; set; }

        public int Stock { get; set; }

        public int PedidoDetalleID { get; set; }

        public int Flag { get; set; }

        public string TipoPedido { get; set; }

        public bool EliminadoTemporal { get; set; }

        public decimal ImporteTotalPedido { get; set; }

        public string FormatoImporteTotalPedido
        {
            get
            {
                return Util.DecimalToStringFormat(ImporteTotalPedido, CodigoIso);
            }
        }

        public string CodigoUsuarioCreacion { get; set; }

        public string CodigoUsuarioModificacion { get; set; }

        public short EstadoItem { get; set; }

        public bool CUVNuevo { get; set; }

        public string ClaseFila { get; set; }

        public string Simbolo { get; set; }

        public bool EstadoSimplificacionCuv { get; set; }

        public bool IndicadorOfertaCUV { get; set; }

        public string DescripcionLarga { get; set; }

        public string ClienteID_ { get; set; }

        public string Pagina { get; set; }

        public string PaginaDe { get; set; }

        public string RegistrosTotal { get; set; }

        public string Registros { get; set; }

        public string RegistrosDe { get; set; }

        public string CUVReco { get; set; }

        public string Mensaje { get; set; }

        public int TipoObservacion { get; set; }

        public string DescripcionOferta { get; set; }

        public string Categoria { get; set; }

        public string DescripcionEstrategia { get; set; }

        public int TipoEstrategiaID { get; set; }

        public bool FlagConsultoraOnline { get; set; }
    }
}