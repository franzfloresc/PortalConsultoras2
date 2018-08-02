using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaNueva
    {
        [DataMember]
        public int OfertaNuevaId { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int CampaniaIDFin { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string NumeroPedido { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioNormal { get; set; }
        [DataMember]
        public decimal PrecioParaTi { get; set; }
        [DataMember]
        public int UnidadesPermitidas { get; set; }
        [DataMember]
        public string ImagenProducto01 { get; set; }
        [DataMember]
        public string ImagenProducto02 { get; set; }
        [DataMember]
        public string ImagenProducto03 { get; set; }
        [DataMember]
        public Int16 FlagImagenActiva { get; set; }
        [DataMember]
        public bool FlagHabilitarOferta { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoProducto { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }
        [DataMember]
        public string DescripcionProd { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int IndicadorPedido { get; set; }

        [DataMember]
        public decimal ganahasta { get; set; }

        public BEOfertaNueva()
        {
        }

        public BEOfertaNueva(IDataRecord row)
        {
            OfertaNuevaId = row.ToInt32("OfertaNuevaId");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            NumeroPedido = row.ToString("NumeroPedido");
            Descripcion = row.ToString("Descripcion");
            PrecioNormal = row.ToDecimal("PrecioNormal");
            PrecioParaTi = row.ToDecimal("PrecioParaTi");
            UnidadesPermitidas = row.ToInt32("UnidadesPermitidas");
            ImagenProducto01 = row.ToString("ImagenProducto01");
            ImagenProducto02 = row.ToString("ImagenProducto02");
            ImagenProducto03 = row.ToString("ImagenProducto03");
            FlagImagenActiva = row.ToInt16("FlagImagenActiva");
            FlagHabilitarOferta = row.ToBoolean("FlagHabilitarOferta");
            UsuarioRegistro = row.ToString("UsuarioRegistro");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            CodigoProducto = row.ToString("CodigoProducto");
            CodigoCampania = row.ToString("CodigoCampania");
            MarcaID = row.ToInt32("MarcaID");
            IndicadorMontoMinimo = row.ToInt32("IndicadorMontoMinimo");
            DescripcionProd = row.ToString("DescripcionProd");
            IndicadorPedido = row.ToInt32("IndicadorPedido");
            ganahasta = row.ToDecimal("ganahasta");
        }
    }
}
