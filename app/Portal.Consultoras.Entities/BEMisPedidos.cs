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
    public class BEMisPedidos
    {
        [DataMember]
        public long PedidoId { get; set; }
        [DataMember]
        public string Cliente { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string MensajeDelCliente { get; set; }
        [DataMember]
        public int Leido { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public int NumIteracion { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public DateTime FechaSolicitud { get; set; }
        [DataMember]
        public DateTime? FechaModificacion { get; set; } 
        [DataMember]
        public string FlagMedio { get; set; } // GR-1385
        [DataMember]
        public bool FlagConsultora { get; set; } // GR-1385
        [DataMember]
        public List<BEMisPedidosDetalle> DetallePedido  { get; set; }

        public BEMisPedidos(IDataRecord row)
        {
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            this.MarcaID = Convert.ToInt32(row["MarcaID"]);
            this.Campania = Convert.ToString(row["Campania"]);
            this.Cliente = Convert.ToString(row["NombreCompleto"]);
            this.Direccion = Convert.ToString(row["Direccion"]);
            this.Telefono = Convert.ToString(row["Telefono"]);
            this.Email = Convert.ToString(row["Email"]);
            this.MensajeDelCliente = Convert.ToString(row["Mensaje"]);
            this.Leido = Convert.ToInt16(row["Leido"]);
            this.Estado = Convert.ToString(row["Estado"]);
            this.NumIteracion = Convert.ToInt32(row["NumIteracion"]);
            this.CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            this.FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                this.FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "FlagMedio") && row["FlagMedio"] != DBNull.Value)
                this.FlagMedio = Convert.ToString(row["FlagMedio"]); //GR-1385
            if (DataRecord.HasColumn(row, "FlagConsultora") && row["FlagConsultora"] != DBNull.Value)
                this.FlagConsultora = Convert.ToBoolean(row["FlagConsultora"]); //GR-1385
            
            this.DetallePedido = new List<BEMisPedidosDetalle>();
        }
    }

    //[DataContract]
    public class BEMisPedidosDetalle
    {
        //[DataMember]
        public long PedidoId { get; set; }
        //[DataMember]
        public string Producto { get; set; }
        //[DataMember]
        public string Tono { get; set; }
        //[DataMember]
        public string Marca { get; set; }
        //[DataMember]
        public string CUV { get; set; }
        //[DataMember]
        public int Cantidad { get; set; }
        //[DataMember]
        public double PrecioUnitario { get; set; }
        //[DataMember]
        public double PrecioTotal { get; set; }

        public string MedioContacto { get; set; }

        //[DataMember]
        //public int Estado;
        public BEMisPedidosDetalle()
        {
        }
        public BEMisPedidosDetalle(IDataRecord row)
        {
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            this.Producto = Convert.ToString(row["Producto"]);
            this.Tono = Convert.ToString(row["Tono"]);
            this.Marca = Convert.ToString(row["Marca"]);
            this.CUV = Convert.ToString(row["CUV"]);
            this.PrecioUnitario = Convert.ToDouble(row["Precio"]);
            this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            this.PrecioTotal = this.PrecioUnitario * this.Cantidad;
            //this.Estado = Convert.ToInt32(row["Estado"]);
            
            //gr-1012
            if (DataRecord.HasColumn(row, "MContacto") && row["MContacto"] != DBNull.Value)
                this.MedioContacto = Convert.ToString(row["MContacto"]);
        }
    }
}
