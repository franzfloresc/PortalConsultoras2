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
            if (DataRecord.HasColumn(row, "OfertaNuevaId"))
                OfertaNuevaId = Convert.ToInt32(row["OfertaNuevaId"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "NumeroPedido"))
                NumeroPedido = Convert.ToString(row["NumeroPedido"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioNormal"))
                PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);
            if (DataRecord.HasColumn(row, "PrecioParaTi"))
                PrecioParaTi = Convert.ToDecimal(row["PrecioParaTi"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "ImagenProducto01"))
                ImagenProducto01 = Convert.ToString(row["ImagenProducto01"]);
            if (DataRecord.HasColumn(row, "ImagenProducto02"))
                ImagenProducto02 = Convert.ToString(row["ImagenProducto02"]);
            if (DataRecord.HasColumn(row, "ImagenProducto03"))
                ImagenProducto03 = Convert.ToString(row["ImagenProducto03"]);
            if (DataRecord.HasColumn(row, "FlagImagenActiva"))
                FlagImagenActiva = Convert.ToInt16(row["FlagImagenActiva"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarOferta"))
                FlagHabilitarOferta = Convert.ToBoolean(row["FlagHabilitarOferta"]);
            if (DataRecord.HasColumn(row, "UsuarioRegistro"))
                UsuarioRegistro = Convert.ToString(row["UsuarioRegistro"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            if (DataRecord.HasColumn(row, "DescripcionProd"))
                DescripcionProd = Convert.ToString(row["DescripcionProd"]);

            if (DataRecord.HasColumn(row, "IndicadorPedido"))
                IndicadorPedido = Convert.ToInt32(row["IndicadorPedido"]);

            if (DataRecord.HasColumn(row, "ganahasta"))
                ganahasta = Convert.ToDecimal(row["ganahasta"]);
        }
    }
}