using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETracking
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        [Column("NumeroPedido")]
        public string NumeroPedido { get; set; }

        [DataMember]
        [Column("Campana")]
        public int Campana { get; set; }

        [DataMember]
        [Column("Estado")]
        public string Estado { get; set; }

        [DataMember]
        public int Etapa { get; set; }

        [DataMember]
        public string Situacion { get; set; }

        [DataMember]
        [Column("Fecha")]
        public DateTime? Fecha { get; set; }

        [DataMember]
        public string ValorTurno { get; set; }

        [DataMember]
        public List<BETrackingDetalle> Detalles { get; set; }

        public BETracking()
        {
        }

        public BETracking(IDataRecord row)
        {
            if (row.HasColumn("CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (row.HasColumn("NumeroPedido"))
                NumeroPedido = Convert.ToString(row["NumeroPedido"]);
            if (row.HasColumn("Campana"))
                Campana = Convert.ToInt32(row["Campana"]);
            if (row.HasColumn("Estado"))
                Estado = Convert.ToString(row["Estado"]);
            if (row.HasColumn("Etapa"))
                Etapa = Convert.ToInt32(row["Etapa"]);
            if (row.HasColumn("Situacion"))
                Situacion = Convert.ToString(row["Situacion"]);
            if (row.HasColumn("Fecha"))
                Fecha = Convert.ToDateTime(row["Fecha"]);

            if (row.HasColumn("ValorTurno"))
                ValorTurno = Convert.ToString(row["ValorTurno"]);
        }
    }

    [DataContract]
    public class BENovedadTracking
    {
        [DataMember]
        public string TipoEntrega { get; set; }
        [DataMember]
        public string DesTipoEntrega { get; set; }
        [DataMember]
        public string Novedad { get; set; }
        [DataMember]
        public string DesNovedad { get; set; }
        [DataMember]
        public string MensajeNovedad { get; set; }
        [DataMember]
        public DateTime? FechaNovedad { get; set; }
        [DataMember]
        public string Latitud { get; set; }
        [DataMember]
        public string Longitud { get; set; }
        [DataMember]
        public string Observacion { get; set; }
        [DataMember]
        public string Boleta { get; set; }
        [DataMember]
        public string Foto { get; set; }

        public BENovedadTracking()
        { }

        public BENovedadTracking(IDataRecord row)
        {
            TipoEntrega = Convert.ToString(row["TipoEntrega"]);
            DesTipoEntrega = Convert.ToString(row["DesTipoEntrega"]);
            Novedad = Convert.ToString(row["Novedad"]);
            DesNovedad = Convert.ToString(row["DesNovedad"]);
            MensajeNovedad = Convert.ToString(row["MensajeNovedad"]);

            if (DataRecord.HasColumn(row, "Boleta"))
                FechaNovedad = Convert.ToDateTime(row["FechaNovedad"]);
            else
                FechaNovedad = (DateTime?)null;

            Latitud = Convert.ToString(row["Latitud"]);
            Longitud = Convert.ToString(row["Longitud"]);
            Observacion = Convert.ToString(row["Observacion"]);
            if (DataRecord.HasColumn(row, "Boleta"))
                Boleta = Convert.ToString(row["Boleta"]);
            if (DataRecord.HasColumn(row, "Foto"))
                Foto = Convert.ToString(row["Foto"]);
        }
    }

    [DataContract]
    public class BENovedadFacturacion
    {
        [DataMember]
        public string CodigoMotivo { get; set; }
        [DataMember]
        public string DescripcionMotivo { get; set; }

        public BENovedadFacturacion()
        { }

        public BENovedadFacturacion(IDataRecord row)
        {
            CodigoMotivo = Convert.ToString(row["CodigoMotivo"]);
            DescripcionMotivo = Convert.ToString(row["DescripcionMotivo"]);
        }
    }
}
