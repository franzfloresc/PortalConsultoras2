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
            if (DataRecord.HasColumn(row, "OfertaShowRoomID"))
                OfertaShowRoomID = Convert.ToInt32(row["OfertaShowRoomID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(row["PrecioValorizado"]);
            if (DataRecord.HasColumn(row, "Stock"))
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "StockInicial"))
                StockInicial = Convert.ToInt32(row["StockInicial"]);
            if (DataRecord.HasColumn(row, "ImagenProducto"))
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto"))
                FlagHabilitarProducto = Convert.ToBoolean(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal"))
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "CategoriaID"))
                CategoriaID = Convert.ToString(row["CategoriaID"]);
            if (DataRecord.HasColumn(row, "UsuarioRegistro"))
                UsuarioRegistro = Convert.ToString(row["UsuarioRegistro"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "ImagenMini"))
                ImagenMini = Convert.ToString(row["ImagenMini"]);

            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta"))
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "CodigoCategoria"))
                CodigoCategoria = Convert.ToString(row["CodigoCategoria"]);
            if (DataRecord.HasColumn(row, "TipNegocio"))
                TipNegocio = Convert.ToString(row["TipNegocio"]);
            if (DataRecord.HasColumn(row, "DescripcionCategoria"))
                DescripcionCategoria = Convert.ToString(row["DescripcionCategoria"]);
            if (DataRecord.HasColumn(row, "EsSubCampania"))
                EsSubCampania = Convert.ToBoolean(row["EsSubCampania"]);
            if (DataRecord.HasColumn(row, "CodigoEstrategia"))
                CodigoEstrategia = Convert.ToString(row["CodigoEstrategia"]);
            if (DataRecord.HasColumn(row, "TieneVariedad"))
                TieneVariedad = Convert.ToInt32(row["TieneVariedad"]);
            if (DataRecord.HasColumn(row, "FlagRevista"))
                FlagRevista = Convert.ToInt32(row["FlagRevista"]);

        }
    }
}
