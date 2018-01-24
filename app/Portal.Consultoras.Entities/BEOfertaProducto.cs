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
            if (DataRecord.HasColumn(row, "OfertaProductoID") && row["OfertaProductoID"] != DBNull.Value)
                OfertaProductoID = Convert.ToInt32(row["OfertaProductoID"]);
            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania") && row["CodigoCampania"] != DBNull.Value)
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta") && row["TipoOferta"] != DBNull.Value)
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "Stock") && row["Stock"] != DBNull.Value)
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "ImagenProducto") && row["ImagenProducto"] != DBNull.Value)
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas") && row["UnidadesPermitidas"] != DBNull.Value)
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto") && row["FlagHabilitarProducto"] != DBNull.Value)
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal") && row["DescripcionLegal"] != DBNull.Value)
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "StockInicial") && row["StockInicial"] != DBNull.Value)
                StockInicial = Convert.ToInt32(row["StockInicial"]);

            if (DataRecord.HasColumn(row, "ID") && row["ID"] != DBNull.Value)
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = row["CUV"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCUV") && row["DescripcionCUV"] != DBNull.Value)
                DescripcionCUV = row["DescripcionCUV"].ToString();

            if (DataRecord.HasColumn(row, "PrecioUnitario") && row["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"].ToString());

            if (DataRecord.HasColumn(row, "Tipo") && row["Tipo"] != DBNull.Value)
                Tipo = row["Tipo"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionTipo") && row["DescripcionTipo"] != DBNull.Value)
                DescripcionTipo = row["DescripcionTipo"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionTallaColor") && row["DescripcionTallaColor"] != DBNull.Value)
                DescripcionTallaColor = row["DescripcionTallaColor"].ToString();

            if (DataRecord.HasColumn(row, "TallaColor") && row["TallaColor"] != DBNull.Value)
                TallaColor = row["TallaColor"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionMarca") && row["DescripcionMarca"] != DBNull.Value)
                DescripcionMarca = row["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCategoria") && row["DescripcionCategoria"] != DBNull.Value)
                DescripcionCategoria = row["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionEstrategia") && row["DescripcionEstrategia"] != DBNull.Value)
                DescripcionEstrategia = row["DescripcionEstrategia"].ToString();

        }
        public BEOfertaProducto()
        { }
    }
}
