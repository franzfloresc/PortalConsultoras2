using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomOferta
    {
        [DataMember]
        [ViewProperty]
        public int OfertaShowRoomID { get; set; }

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
        public decimal PrecioOferta { get; set; }        

        [DataMember]
        [ViewProperty]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        [ViewProperty]
        public int StockInicial { get; set; }

        [DataMember]
        [ViewProperty]
        public string ImagenProducto { get; set; }

        [DataMember]
        [ViewProperty]
        public int Orden { get; set; }

        [DataMember]
        public int UnidadesPermitidas { get; set; }

        [DataMember]
        [ViewProperty]
        public bool FlagHabilitarProducto { get; set; }

        [DataMember]
        [ViewProperty]
        public string DescripcionLegal { get; set; }

        [DataMember]
        [ViewProperty]
        public string CategoriaID { get; set; }     

        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        [ViewProperty]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [ViewProperty]
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
        public string CodigoProducto { get; set; }

        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }

        [DataMember]
        [ViewProperty]
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

        public BEShowRoomOferta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OfertaShowRoomID") && row["OfertaShowRoomID"] != DBNull.Value)
                OfertaShowRoomID = Convert.ToInt32(row["OfertaShowRoomID"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "PrecioCatalogo") && row["PrecioCatalogo"] != DBNull.Value)
                PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);
            if (DataRecord.HasColumn(row, "Stock") && row["Stock"] != DBNull.Value)
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "StockInicial") && row["StockInicial"] != DBNull.Value)
                StockInicial = Convert.ToInt32(row["StockInicial"]);
            if (DataRecord.HasColumn(row, "ImagenProducto") && row["ImagenProducto"] != DBNull.Value)
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas") && row["UnidadesPermitidas"] != DBNull.Value)
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto") && row["FlagHabilitarProducto"] != DBNull.Value)
                FlagHabilitarProducto = Convert.ToBoolean(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal") && row["DescripcionLegal"] != DBNull.Value)
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "CategoriaID") && row["CategoriaID"] != DBNull.Value)
                CategoriaID = Convert.ToString(row["CategoriaID"]);            
            if (DataRecord.HasColumn(row, "UsuarioRegistro") && row["UsuarioRegistro"] != DBNull.Value)
                UsuarioRegistro = Convert.ToString(row["UsuarioRegistro"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion") && row["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "ImagenMini") && row["ImagenMini"] != DBNull.Value)
                ImagenMini = Convert.ToString(row["ImagenMini"]);

            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CodigoCampania") && row["CodigoCampania"] != DBNull.Value)
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta") && row["TipoOferta"] != DBNull.Value)
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToInt32(row["MarcaID"]);            
        }
    }
}
