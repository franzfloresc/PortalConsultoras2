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
                Estado = row["Estado"].ToString();
            if (DataRecord.HasColumn(row, "FechaSolicitud"))
                FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = row["NombreCliente"].ToString();
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = row["Direccion"].ToString();
            if (DataRecord.HasColumn(row, "EmailCliente"))
                EmailCliente = row["EmailCliente"].ToString();
            if (DataRecord.HasColumn(row, "TelefonoCliente"))
                TelefonoCliente = row["TelefonoCliente"].ToString();
            if (DataRecord.HasColumn(row, "Marca"))
                Marca = row["Marca"].ToString();
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = row["Campania"].ToString();
            if (DataRecord.HasColumn(row, "Producto"))
                Producto = row["Producto"].ToString();
            if (DataRecord.HasColumn(row, "Tono"))
                Tono = row["Tono"].ToString();
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt16(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "MensajeCliente"))
                MensajeCliente = row["MensajeCliente"].ToString();
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = row["CodigoConsultora"].ToString();
            if (DataRecord.HasColumn(row, "NombreConsultora"))
                NombreConsultora = row["NombreConsultora"].ToString();
            if (DataRecord.HasColumn(row, "TelefonoMovilConsultora"))
                TelefonoMovilConsultora = row["TelefonoMovilConsultora"].ToString();
            if (DataRecord.HasColumn(row, "TelefonoFijoConsultora"))
                TelefonoFijoConsultora = row["TelefonoFijoConsultora"].ToString();
            if (DataRecord.HasColumn(row, "EmailConsultora"))
                EmailConsultora = row["EmailConsultora"].ToString();
            if (DataRecord.HasColumn(row, "Leido"))
                Leido = Convert.ToBoolean(row["Leido"]);

        }
    }
}
