using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReportePedidos
    {
        [DataMember]
        private int SolicitudClienteID { get; set; }
        [DataMember]
        private string Estado { get; set; }
        [DataMember]
        private DateTime FechaSolicitud { get; set; }
        [DataMember]
        private string NombreCliente { get; set; }
        [DataMember]
        private string Direccion { get; set; }
        [DataMember]
        private string EmailCliente { get; set; }
        [DataMember]
        private string TelefonoCliente { get; set; }
        [DataMember]
        private string Marca { get; set; }
        [DataMember]
        private string Campania { get; set; }
        [DataMember]
        private string Producto { get; set; }
        [DataMember]
        private string Tono { get; set; }
        [DataMember]
        private int Cantidad { get; set; }
        [DataMember]
        private decimal Precio { get; set; }
        [DataMember]
        private string MensajeCliente { get; set; }
        [DataMember]
        private string CodigoConsultora { get; set; }
        [DataMember]
        private string NombreConsultora { get; set; }
        [DataMember]
        private string TelefonoMovilConsultora { get; set; }
        [DataMember]
        private string TelefonoFijoConsultora { get; set; }
        [DataMember]
        private string EmailConsultora { get; set; }
        [DataMember]
        private bool Leido { get; set; }


        public BEReportePedidos(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "SolicitudClienteID"))
                SolicitudClienteID = Convert.ToInt32(row["SolicitudClienteID"]);
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToString(row["Estado"]);
            if (DataRecord.HasColumn(row, "FechaSolicitud"))
                FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "EmailCliente"))
                EmailCliente = Convert.ToString(row["EmailCliente"]);
            if (DataRecord.HasColumn(row, "TelefonoCliente"))
                TelefonoCliente = Convert.ToString(row["TelefonoCliente"]);
            if (DataRecord.HasColumn(row, "Marca"))
                Marca = Convert.ToString(row["Marca"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "Producto"))
                Producto = Convert.ToString(row["Producto"]);
            if (DataRecord.HasColumn(row, "Tono"))
                Tono = Convert.ToString(row["Tono"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt16(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "MensajeCliente"))
                MensajeCliente = Convert.ToString(row["MensajeCliente"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "NombreConsultora"))
                NombreConsultora = Convert.ToString(row["NombreConsultora"]);
            if (DataRecord.HasColumn(row, "TelefonoMovilConsultora"))
                TelefonoMovilConsultora = Convert.ToString(row["TelefonoMovilConsultora"]);
            if (DataRecord.HasColumn(row, "TelefonoFijoConsultora"))
                TelefonoFijoConsultora = Convert.ToString(row["TelefonoFijoConsultora"]);
            if (DataRecord.HasColumn(row, "EmailConsultora"))
                EmailConsultora = Convert.ToString(row["EmailConsultora"]);
            if (DataRecord.HasColumn(row, "Leido"))
                Leido = Convert.ToBoolean(row["Leido"]);

        }
    }
}
