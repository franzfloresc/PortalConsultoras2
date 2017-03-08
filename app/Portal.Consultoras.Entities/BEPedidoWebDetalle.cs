using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
        public int SubTipoOfertaSisID { get; set; }//1513
        [DataMember]
        private string TipoPedido { get; set; }
        [DataMember]
        private string DescripcionOferta { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }//CCSS_JZ_PROL2
        [DataMember]
        public DateTime FechaCreacion { get; set; }//JZ_VAL_PROL_AUTO - R2073
        [DataMember]
        public string DescripcionLarga { get; set; } //CSR_R2469 
        [DataMember]
        public string Categoria { get; set; } //CSR_R2469
        [DataMember]
        public string DescripcionEstrategia { get; set; } //JICM_R2469
        [DataMember]
        public int TipoEstrategiaID { get; set; }//LR_R2621

        [DataMember]
        public bool IndicadorOfertaCUV { get; set; } /*R20150701*/
        [DataMember]
        public decimal MontoTotalProl { get; set; }   /*R20150701*/
        
        [DataMember]
        public string NombreCliente { get; set; } //R2584

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
                ClienteID = row["ClienteID"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["ClienteID"]);
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
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["TipoOfertaSisID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            //1513
            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID") && row["SubTipoOfertaSisID"] != DBNull.Value)
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);
            else
                SubTipoOfertaSisID = 0;

            if (DataRecord.HasColumn(row, "TipoPedido"))
                TipoPedido = Convert.ToString(row["TipoPedido"]);

            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);
            //2469
            if (DataRecord.HasColumn(row, "DescripcionLarga"))
                DescripcionLarga = Convert.ToString(row["DescripcionLarga"]);
            if (DataRecord.HasColumn(row, "Categoria"))
                Categoria = Convert.ToString(row["Categoria"]);
            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);
            // 2621
            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);
            /*R20150701*/
            if (DataRecord.HasColumn(row, "IndicadorOfertaCUV"))
                IndicadorOfertaCUV = row["IndicadorOfertaCUV"] == DBNull.Value ? false : Convert.ToBoolean(row["IndicadorOfertaCUV"]);

            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                MontoTotalProl = row["MontoTotalProl"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoTotalProl"]);
            
            //2584
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);

            if (DataRecord.HasColumn(row, "EsSugerido"))
                EsSugerido = Convert.ToBoolean(row["EsSugerido"]);

            if (DataRecord.HasColumn(row, "EsKitNueva"))
                EsKitNueva = Convert.ToBoolean(row["EsKitNueva"]);

            if (DataRecord.HasColumn(row, "OrdenPedidoWD"))
                OrdenPedidoWD = row["OrdenPedidoWD"] == DBNull.Value ? 0 : Convert.ToInt32(row["OrdenPedidoWD"]);

            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = row["DescuentoProl"] == DBNull.Value ? 0 : Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "FlagConsultoraOnline"))
                FlagConsultoraOnline = Convert.ToBoolean(row["FlagConsultoraOnline"]);
            if (DataRecord.HasColumn(row, "MontoEscala"))
                MontoEscala = row["MontoEscala"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoEscala"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo"))
                MontoAhorroCatalogo = row["MontoAhorroCatalogo"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista"))
                MontoAhorroRevista = row["MontoAhorroRevista"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoAhorroRevista"]);

            if (DataRecord.HasColumn(row, "OrigenPedidoWeb"))
                OrigenPedidoWeb = row["OrigenPedidoWeb"] == DBNull.Value ? 0 : Convert.ToInt32(row["OrigenPedidoWeb"]);
            if (DataRecord.HasColumn(row, "EsBackOrder"))
                this.EsBackOrder = row["EsBackOrder"] == DBNull.Value ? false : Convert.ToBoolean(row["EsBackOrder"]);
            if (DataRecord.HasColumn(row, "AceptoBackOrder"))
                this.AceptoBackOrder = row["AceptoBackOrder"] == DBNull.Value ? false : Convert.ToBoolean(row["AceptoBackOrder"]);
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
                ClienteID = row["ClienteID"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["ClienteID"]);
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
                Nombre = row["Nombre"] == DBNull.Value ? Consultora : Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "eMail"))
                eMail = Convert.ToString(row["eMail"]);
            if (DataRecord.HasColumn(row, "OfertaWeb"))
                OfertaWeb = Convert.ToBoolean(row["OfertaWeb"]);
            if (DataRecord.HasColumn(row, "CUVPadre"))
                CUVPadre = Convert.ToString(row["CUVPadre"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleIDPadre"))
                PedidoDetalleIDPadre = row["PedidoDetalleIDPadre"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["PedidoDetalleIDPadre"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["TipoOfertaSisID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo") && row["IndicadorMontoMinimo"] != DBNull.Value)
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            else
                IndicadorMontoMinimo = 1;

            //1513
            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID") && row["SubTipoOfertaSisID"] != DBNull.Value)
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);
            else
                SubTipoOfertaSisID = 0;


            if (DataRecord.HasColumn(row, "TipoPedido"))
                TipoPedido = Convert.ToString(row["TipoPedido"]);

            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);

            //CCSS_JZ_PROL2
            if (DataRecord.HasColumn(row, "ObservacionPROL"))
                ObservacionPROL = Convert.ToString(row["ObservacionPROL"]);
            //2469 2505
            if (DataRecord.HasColumn(row, "DescripcionLarga"))
                DescripcionLarga = Convert.ToString(row["DescripcionLarga"]);
            if (DataRecord.HasColumn(row, "Categoria"))
                Categoria = Convert.ToString(row["Categoria"]);
            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);
            // 2621
            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = row["TipoEstrategiaID"] == DBNull.Value ? 0 : Convert.ToInt32(row["TipoEstrategiaID"]);

            /*R20150701*/
            if (DataRecord.HasColumn(row, "IndicadorOfertaCUV"))
                IndicadorOfertaCUV = row["IndicadorOfertaCUV"] == DBNull.Value ? false : Convert.ToBoolean(row["IndicadorOfertaCUV"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                MontoTotalProl = row["MontoTotalProl"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoTotalProl"]);
            
            //2584
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);

            if (DataRecord.HasColumn(row, "EsSugerido"))
                EsSugerido = row["EsSugerido"] == DBNull.Value ? false : Convert.ToBoolean(row["EsSugerido"]);

            if (DataRecord.HasColumn(row, "EsKitNueva"))
                EsKitNueva = row["EsKitNueva"] == DBNull.Value ? false : Convert.ToBoolean(row["EsKitNueva"]);

            if (DataRecord.HasColumn(row, "OrdenPedidoWD"))
                OrdenPedidoWD = row["OrdenPedidoWD"] == DBNull.Value ? 0 : Convert.ToInt32(row["OrdenPedidoWD"]);

            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = row["DescuentoProl"] == DBNull.Value ? 0 : Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "FlagConsultoraOnline"))
                FlagConsultoraOnline = Convert.ToBoolean(row["FlagConsultoraOnline"]);
            if (DataRecord.HasColumn(row, "MontoEscala"))
                MontoEscala = row["MontoEscala"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoEscala"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo"))
                MontoAhorroCatalogo = row["MontoAhorroCatalogo"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista"))
                MontoAhorroRevista = row["MontoAhorroRevista"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoAhorroRevista"]);

            if (DataRecord.HasColumn(row, "OrigenPedidoWeb"))
                OrigenPedidoWeb = row["OrigenPedidoWeb"] == DBNull.Value ? 0 : Convert.ToInt32(row["OrigenPedidoWeb"]);
            if (DataRecord.HasColumn(row, "EsBackOrder"))
                this.EsBackOrder = row["EsBackOrder"] == DBNull.Value ? false : Convert.ToBoolean(row["EsBackOrder"]);
            if (DataRecord.HasColumn(row, "AceptoBackOrder"))
                this.AceptoBackOrder = row["AceptoBackOrder"] == DBNull.Value ? false : Convert.ToBoolean(row["AceptoBackOrder"]);
        }
    }
}
