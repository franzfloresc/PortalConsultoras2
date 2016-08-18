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
    public class BEPedidoExtendidoWS
    {
        [DataMember]
        public int NroRegistro { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string ConsultoraNombre { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public string UsuarioResponsable { get; set; }
        [DataMember]
        public decimal ConsultoraSaldo { get; set; }
        [DataMember]
        public string Origen { get; set; }
        [DataMember]
        public string EstadoValidacion { get; set; }
        [DataMember]
        public decimal ImporteTotalMM { get; set; }
        [DataMember]
        public int DigitoVerificador { get; set; }
        [DataMember]
        public string EstadoConsultora { get; set; }
        [DataMember]
        public string AutorizaPedido { get; set; }
        [DataMember]
        public bool Bloqueado { get; set; }
        [DataMember]
        public string DescripcionBloqueo { get; set; }
        [DataMember]
        public string ZonaCodigo { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Segmento { get; set; }
        [DataMember]
        public string NroDocumentoConsultora { get; set; }

        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public decimal PrecioTotal { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public string Territorio { get; set; }
        [DataMember]
        public bool IndicadorMontoMinimo { get; set; }
        [DataMember]
        public bool IndicadorDigitable { get; set; }

        public BEPedidoExtendidoWS(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "NroRegistro"))
                NroRegistro = Convert.ToInt32(row["NroRegistro"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToInt32(row["Campania"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                Seccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "ConsultoraNombre"))
                ConsultoraNombre = Convert.ToString(row["ConsultoraNombre"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "UsuarioResponsable"))
                UsuarioResponsable = Convert.ToString(row["UsuarioResponsable"]);
            if (DataRecord.HasColumn(row, "ConsultoraSaldo"))
                ConsultoraSaldo = Convert.ToDecimal(row["ConsultoraSaldo"]);
            if (DataRecord.HasColumn(row, "EstadoValidacion"))
                EstadoValidacion = Convert.ToString(row["EstadoValidacion"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);
            if (DataRecord.HasColumn(row, "PrecioTotal"))
                PrecioTotal = Convert.ToDecimal(row["PrecioTotal"]);

            if (DataRecord.HasColumn(row, "ZonaCodigo"))
                ZonaCodigo = Convert.ToString(row["ZonaCodigo"]);

            if (DataRecord.HasColumn(row, "ImporteTotalMM"))
                ImporteTotalMM = Convert.ToDecimal(row["ImporteTotalMM"]);
            if (DataRecord.HasColumn(row, "DigitoVerificador"))
                DigitoVerificador = Convert.ToInt32(row["DigitoVerificador"]);
            if (DataRecord.HasColumn(row, "EstadoConsultora"))
                EstadoConsultora = Convert.ToString(row["EstadoConsultora"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido"))
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);

            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Bloqueado"))
                Bloqueado = Convert.ToBoolean(row["Bloqueado"]);
            if (DataRecord.HasColumn(row, "DescripcionBloqueo"))
                DescripcionBloqueo = Convert.ToString(row["DescripcionBloqueo"]);
            if (DataRecord.HasColumn(row, "Territorio"))
                Territorio = Convert.ToString(row["Territorio"]);

            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Segmento"))
                Segmento = Convert.ToString(row["Segmento"]);

            if (DataRecord.HasColumn(row, "MontoMinimoPedido"))
                MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
            if (DataRecord.HasColumn(row, "NroDocumentoConsultora"))
                NroDocumentoConsultora = Convert.ToString(row["NroDocumentoConsultora"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToBoolean(row["IndicadorMontoMinimo"]);
            if (DataRecord.HasColumn(row, "IndicadorDigitable"))
                IndicadorDigitable = Convert.ToBoolean(row["IndicadorDigitable"]);



        }
    }
}
