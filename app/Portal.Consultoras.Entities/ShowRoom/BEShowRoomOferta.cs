using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomOferta
    {
        [DataMember]
        [ViewProperty]
        [Column("EstrategiaID")]
        public int OfertaShowRoomID { get; set; }

        [DataMember]
        [Column("TipoEstrategiaId")]
        public int TipoEstrategiaId { get; set; }

        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }

        [DataMember]
        public int TipoOfertaSisID { get; set; }

        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }

        [DataMember]
        [Column("CUV2")]
        public string CUV2 { get; set; }

        [DataMember]
        [Column("Stock")]
        public int Stock { get; set; }

        [DataMember]
        //[ViewProperty]
        [Column("ConfiguracionOfertaID")]
        public int ConfiguracionOfertaID { get; set; }

        [DataMember]
        [Column("Precio")]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        [Column("Precio2")]
        public decimal PrecioOferta { get; set; }

        [DataMember]
        [ViewProperty]
        public int StockInicial { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("ImagenProducto")]
        public string ImagenProducto { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("Orden")]
        public int Orden { get; set; }

        [DataMember]
        [Column("UnidadesPermitidas")]
        public int UnidadesPermitidas { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Descripcion2")]
        public string Descripcion2 { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("FlagHabilitarProducto")]
        public bool FlagHabilitarProducto { get; set; }

        [DataMember]
        [ViewProperty]
        public string DescripcionLegal { get; set; }

        [DataMember]
        [ViewProperty]
        public string CategoriaID { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("UsuarioRegistro")]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("FechaRegistro")]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("UsuarioModificacion")]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("FechaModificacion")]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("ImagenMini")]
        public string ImagenMini { get; set; }

        [DataMember]
        [ViewProperty]
        public int NroOrden { get; set; }

        [DataMember]
        [ViewProperty]
        public string CodigoCampania { get; set; }

        [DataMember]
        [ViewProperty]
        public string CodigoTipoOferta { get; set; }

        [DataMember]
        [ViewProperty]
        public string TipoOferta { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("CodigoProducto")]
        public string CodigoProducto { get; set; }

        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("MarcaID")]
        public int MarcaID { get; set; }

        [DataMember]
        [ViewProperty]
        public int Incrementa { get; set; }

        [DataMember]
        [ViewProperty]
        public int CantidadIncrementa { get; set; }

        [DataMember]
        [ViewProperty]
        public int FlagAgotado { get; set; }

        [DataMember]
        [ViewProperty]
        public int StockResultado { get; set; }

        [DataMember]
        public string CodigoCategoria { get; set; }

        [DataMember]
        [Column("TipNegocio")]
        public string TipNegocio { get; set; }

        [DataMember]
        [ViewProperty]
        public string DescripcionCategoria { get; set; }

        [DataMember]
        [Column("EsSubCampania")]
        public bool EsSubCampania { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("CodigoEstrategia")]
        public string CodigoEstrategia { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("TieneVariedad")]
        public int TieneVariedad { get; set; }

        [DataMember]
        [ViewProperty]
        [Column("FlagRevista")]
        public int FlagRevista { get; set; }

        [DataMember]
        [Column("CodigoTipoEstrategia")]
        public string CodigoTipoEstrategia { get; set; }

        public BEShowRoomOferta()
        { }

        public BEShowRoomOferta(IDataRecord row)
        {
            OfertaShowRoomID = row.ToInt32("OfertaShowRoomID");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            Descripcion = row.ToString("Descripcion");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            PrecioValorizado = row.ToDecimal("PrecioValorizado");
            Stock = row.ToInt32("Stock");
            StockInicial = row.ToInt32("StockInicial");
            ImagenProducto = row.ToString("ImagenProducto");
            Orden = row.ToInt32("Orden");
            UnidadesPermitidas = row.ToInt32("UnidadesPermitidas");
            FlagHabilitarProducto = row.ToBoolean("FlagHabilitarProducto");
            DescripcionLegal = row.ToString("DescripcionLegal");
            CategoriaID = row.ToString("CategoriaID");
            UsuarioRegistro = row.ToString("UsuarioRegistro");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            ImagenMini = row.ToString("ImagenMini");
            NroOrden = row.ToInt32("NroOrden");
            CodigoCampania = row.ToString("CodigoCampania");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            TipoOferta = row.ToString("TipoOferta");
            CodigoProducto = row.ToString("CodigoProducto");
            MarcaID = row.ToInt32("MarcaID");
            CodigoCategoria = row.ToString("CodigoCategoria");
            TipNegocio = row.ToString("TipNegocio");
            DescripcionCategoria = row.ToString("DescripcionCategoria");
            EsSubCampania = row.ToBoolean("EsSubCampania");
            CodigoEstrategia = row.ToString("CodigoEstrategia");
            TieneVariedad = row.ToInt32("TieneVariedad");
            FlagRevista = row.ToInt32("FlagRevista");
        }
    }
}
