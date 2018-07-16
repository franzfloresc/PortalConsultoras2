using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebDetalle
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public int PedidoID { set; get; }
        [DataMember]
        public Int16 PedidoDetalleID { set; get; }
        [DataMember]
        public Int16 PedidoDetalleIDPadre { set; get; }
        [DataMember]
        public byte MarcaID { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public Int16 ClienteID { set; get; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionProd { get; set; }
        [DataMember]
        public string DescripcionCortadaProd { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string eMail { get; set; }
        [DataMember]
        public bool OfertaWeb { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string ClaseFila { get; set; }
        [DataMember]
        public int TipoObservacion { get; set; }
        [DataMember]
        public string CUVPadre { get; set; }
        [DataMember]
        public bool ModificaPedidoReservado { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public int Clientes { get; set; }
        [DataMember]
        public decimal ImporteTotalPedido { get; set; }
        [DataMember]
        public short EstadoItem { get; set; }
        [DataMember]
        public bool CUVNuevo { get; set; }
        [DataMember]
        public bool EliminadoTemporal { get; set; }
        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CantidadAnterior { set; get; }
        [DataMember]
        public int Flag { set; get; }
        [DataMember]
        public int Stock { set; get; }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public string CodigoUsuarioCreacion { get; set; }
        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }
        [DataMember]
        public int SubTipoOfertaSisID { get; set; }
        [DataMember]
        public string TipoPedido { get; set; }
        [DataMember]
        public string DescripcionOferta { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string DescripcionLarga { get; set; }
        [DataMember]
        public string Categoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        public bool IndicadorOfertaCUV { get; set; }
        [DataMember]
        public decimal MontoTotalProl { get; set; }

        [DataMember]
        public string NombreCliente { get; set; }

        [DataMember]
        public bool EsSugerido { get; set; }

        [DataMember]
        public bool EsKitNueva { get; set; }

        [DataMember]
        public int OrdenPedidoWD { get; set; }

        [DataMember]
        public decimal DescuentoProl { get; set; }
        [DataMember]
        public bool FlagConsultoraOnline { get; set; }

        [DataMember]
        public decimal MontoEscala { get; set; }
        [DataMember]
        public decimal MontoAhorroCatalogo { get; set; }
        [DataMember]
        public decimal MontoAhorroRevista { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
        [DataMember]
        public bool EsBackOrder { get; set; }
        [DataMember]
        public bool AceptoBackOrder { get; set; }
        [DataMember]
        public bool EsCompraPorCompra { get; set; }

        [DataMember]
        public BEIndicadorPedidoAutentico IndicadorPedidoAutentico { get; set; }

        [DataMember]
        public int CodigoCatalago { get; set; }

        [DataMember]
        public bool EsOfertaIndependiente { get; set; }

        [DataMember]
        public string TipoEstrategiaCodigo { get; set; }

        [DataMember]
        public bool FlagNueva { get; set; }

        [DataMember]
        public bool ProgramaNuevoActivado { get; set; }

        [DataMember]
        public string CodigoTipoOferta { get; set; }
        
        [DataMember]
        public int SetID { get; set; }

        public BEPedidoWebDetalle()
        { }

        public BEPedidoWebDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID"))
                PedidoDetalleID = Convert.ToInt16(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToByte(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = Convert.ToInt16(row["ClienteID"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "DescripcionProd"))
                DescripcionProd = Convert.ToString(row["DescripcionProd"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "eMail"))
                eMail = Convert.ToString(row["eMail"]);
            if (DataRecord.HasColumn(row, "OfertaWeb"))
                OfertaWeb = Convert.ToBoolean(row["OfertaWeb"]);
            if (DataRecord.HasColumn(row, "CUVPadre"))
                CUVPadre = Convert.ToString(row["CUVPadre"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID"))
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "TipoPedido"))
                TipoPedido = Convert.ToString(row["TipoPedido"]);
            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);
            if (DataRecord.HasColumn(row, "DescripcionLarga"))
                DescripcionLarga = Convert.ToString(row["DescripcionLarga"]);
            if (DataRecord.HasColumn(row, "Categoria"))
                Categoria = Convert.ToString(row["Categoria"]);
            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);
            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);
            if (DataRecord.HasColumn(row, "IndicadorOfertaCUV"))
                IndicadorOfertaCUV = Convert.ToBoolean(row["IndicadorOfertaCUV"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);
            if (DataRecord.HasColumn(row, "EsSugerido"))
                EsSugerido = Convert.ToBoolean(row["EsSugerido"]);
            if (DataRecord.HasColumn(row, "EsKitNueva"))
                EsKitNueva = Convert.ToBoolean(row["EsKitNueva"]);
            if (DataRecord.HasColumn(row, "OrdenPedidoWD"))
                OrdenPedidoWD = Convert.ToInt32(row["OrdenPedidoWD"]);
            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "FlagConsultoraOnline"))
                FlagConsultoraOnline = Convert.ToBoolean(row["FlagConsultoraOnline"]);
            if (DataRecord.HasColumn(row, "MontoEscala"))
                MontoEscala = Convert.ToDecimal(row["MontoEscala"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo"))
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista"))
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (DataRecord.HasColumn(row, "OrigenPedidoWeb"))
                OrigenPedidoWeb = Convert.ToInt32(row["OrigenPedidoWeb"]);
            if (DataRecord.HasColumn(row, "EsBackOrder"))
                EsBackOrder = Convert.ToBoolean(row["EsBackOrder"]);
            if (DataRecord.HasColumn(row, "AceptoBackOrder"))
                AceptoBackOrder = Convert.ToBoolean(row["AceptoBackOrder"]);
            if (DataRecord.HasColumn(row, "EsCompraPorCompra"))
                EsCompraPorCompra = Convert.ToBoolean(row["EsCompraPorCompra"]);
            if (DataRecord.HasColumn(row, "CodigoCatalago"))
                CodigoCatalago = Convert.ToInt32(row["CodigoCatalago"]);
            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"]);
            if (DataRecord.HasColumn(row, "TipoEstrategiaCodigo"))
                TipoEstrategiaCodigo = Convert.ToString(row["TipoEstrategiaCodigo"]);
            if (DataRecord.HasColumn(row, "FlagNueva"))
                FlagNueva = Convert.ToBoolean(row["FlagNueva"]);
            if (DataRecord.HasColumn(row, "ProgramaNuevoActivado"))
                ProgramaNuevoActivado = Convert.ToBoolean(row["ProgramaNuevoActivado"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            
            if (DataRecord.HasColumn(row, "SetID"))
                SetID = Convert.ToInt32(row["SetID"]);

        }

        public BEPedidoWebDetalle(IDataRecord row, string Consultora)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID"))
                PedidoDetalleID = Convert.ToInt16(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToByte(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = Convert.ToInt16(row["ClienteID"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "DescripcionProd"))
                DescripcionProd = Convert.ToString(row["DescripcionProd"]);
            
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                NombreCliente = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "eMail"))
                eMail = Convert.ToString(row["eMail"]);
            if (DataRecord.HasColumn(row, "OfertaWeb"))
                OfertaWeb = Convert.ToBoolean(row["OfertaWeb"]);
            if (DataRecord.HasColumn(row, "CUVPadre"))
                CUVPadre = Convert.ToString(row["CUVPadre"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleIDPadre"))
                PedidoDetalleIDPadre = Convert.ToInt16(row["PedidoDetalleIDPadre"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            else
                IndicadorMontoMinimo = 1;

            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID"))
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "TipoPedido"))
                TipoPedido = Convert.ToString(row["TipoPedido"]);
            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);
            if (DataRecord.HasColumn(row, "ObservacionPROL"))
                ObservacionPROL = Convert.ToString(row["ObservacionPROL"]);
            if (DataRecord.HasColumn(row, "DescripcionLarga"))
                DescripcionLarga = Convert.ToString(row["DescripcionLarga"]);
            if (DataRecord.HasColumn(row, "Categoria"))
                Categoria = Convert.ToString(row["Categoria"]);
            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);
            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);
            if (DataRecord.HasColumn(row, "IndicadorOfertaCUV"))
                IndicadorOfertaCUV = Convert.ToBoolean(row["IndicadorOfertaCUV"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);
            if (DataRecord.HasColumn(row, "EsSugerido"))
                EsSugerido = Convert.ToBoolean(row["EsSugerido"]);
            if (DataRecord.HasColumn(row, "EsKitNueva"))
                EsKitNueva = Convert.ToBoolean(row["EsKitNueva"]);
            if (DataRecord.HasColumn(row, "OrdenPedidoWD"))
                OrdenPedidoWD = Convert.ToInt32(row["OrdenPedidoWD"]);
            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "FlagConsultoraOnline"))
                FlagConsultoraOnline = Convert.ToBoolean(row["FlagConsultoraOnline"]);
            if (DataRecord.HasColumn(row, "MontoEscala"))
                MontoEscala = Convert.ToDecimal(row["MontoEscala"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo"))
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista"))
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (DataRecord.HasColumn(row, "OrigenPedidoWeb"))
                OrigenPedidoWeb = Convert.ToInt32(row["OrigenPedidoWeb"]);
            if (DataRecord.HasColumn(row, "EsBackOrder"))
                EsBackOrder = Convert.ToBoolean(row["EsBackOrder"]);
            if (DataRecord.HasColumn(row, "AceptoBackOrder"))
                AceptoBackOrder = Convert.ToBoolean(row["AceptoBackOrder"]);
            if (DataRecord.HasColumn(row, "EsCompraPorCompra"))
                EsCompraPorCompra = Convert.ToBoolean(row["EsCompraPorCompra"]);
            if (DataRecord.HasColumn(row, "CodigoCatalago"))
                CodigoCatalago = Convert.ToInt32(row["CodigoCatalago"]);
            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"]);
            if (DataRecord.HasColumn(row, "TipoEstrategiaCodigo"))
                TipoEstrategiaCodigo = Convert.ToString(row["TipoEstrategiaCodigo"]);
            if (DataRecord.HasColumn(row, "FlagNueva"))
                FlagNueva = Convert.ToBoolean(row["FlagNueva"]);
            if (DataRecord.HasColumn(row, "ProgramaNuevoActivado"))
                ProgramaNuevoActivado = Convert.ToBoolean(row["ProgramaNuevoActivado"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
                
            if (DataRecord.HasColumn(row, "SetID"))
                SetID = Convert.ToInt32(row["SetID"]);

        }
    }

}
