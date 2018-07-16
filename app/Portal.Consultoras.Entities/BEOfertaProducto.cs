using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaProducto
    {
        [DataMember]
        [ViewProperty]
        public int PaisID { get; set; }

        [DataMember]
        [ViewProperty]
        public int OfertaProductoID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Stock { get; set; }
        [DataMember]
        [ViewProperty]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        [ViewProperty]
        public string Descripcion { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public string PrecioString { get; set; }
        [DataMember]
        [ViewProperty]
        public string ImagenProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public int Orden { get; set; }
        [DataMember]
        [ViewProperty]
        public int UnidadesPermitidas { get; set; }
        [DataMember]
        [ViewProperty]
        public int FlagHabilitarProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }
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
        public int NroOrden { get; set; }
        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionLegal { get; set; }
        [DataMember]
        [ViewProperty]
        public int MarcaID { get; set; }
        [DataMember]
        [ViewProperty]
        public int Flag { get; set; }
        [DataMember]
        [ViewProperty]
        public int StockInicial { get; set; }

        [DataMember]
        [ViewProperty]
        public int ID { get; set; }
        [DataMember]
        [ViewProperty]
        public int IDAux { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionCUV { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        [ViewProperty]
        public string Tipo { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionTipo { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionTallaColor { get; set; }
        [DataMember]
        [ViewProperty]
        public string CUVPadre { get; set; }
        [DataMember]
        [ViewProperty]
        public string TallaColor { get; set; }
        [DataMember]
        [ViewProperty]
        public int ConsultoraID { get; set; }

        [DataMember]
        [ViewProperty]
        public string DescripcionMarca { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        [ViewProperty]
        public string ImagenProductoSmall { get; set; }

        [DataMember]
        [ViewProperty]
        public string ImagenProductoMedium { get; set; }

        public BEOfertaProducto(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OfertaProductoID"))
                OfertaProductoID = Convert.ToInt32(row["OfertaProductoID"]);
            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta"))
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "Stock"))
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "ImagenProducto"))
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto"))
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal"))
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "StockInicial"))
                StockInicial = Convert.ToInt32(row["StockInicial"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV"))
                DescripcionCUV = Convert.ToString(row["DescripcionCUV"]);

            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);

            if (DataRecord.HasColumn(row, "Tipo"))
                Tipo = Convert.ToString(row["Tipo"]);

            if (DataRecord.HasColumn(row, "DescripcionTipo"))
                DescripcionTipo = Convert.ToString(row["DescripcionTipo"]);

            if (DataRecord.HasColumn(row, "DescripcionTallaColor"))
                DescripcionTallaColor = Convert.ToString(row["DescripcionTallaColor"]);

            if (DataRecord.HasColumn(row, "TallaColor"))
                TallaColor = Convert.ToString(row["TallaColor"]);

            if (DataRecord.HasColumn(row, "DescripcionMarca"))
                DescripcionMarca = Convert.ToString(row["DescripcionMarca"]);

            if (DataRecord.HasColumn(row, "DescripcionCategoria"))
                DescripcionCategoria = Convert.ToString(row["DescripcionCategoria"]);

            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);

        }
        public BEOfertaProducto()
        { }
    }
}
