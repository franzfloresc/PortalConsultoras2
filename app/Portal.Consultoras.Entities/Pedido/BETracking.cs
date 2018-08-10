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
            CodigoConsultora = row.ToString("CodigoConsultora");
            NumeroPedido = row.ToString("NumeroPedido");
            Campana = row.ToInt32("Campana");
            Estado = row.ToString("Estado");
            Etapa = row.ToInt32("Etapa");
            Situacion = row.ToString("Situacion");
            Fecha = row.ToDateTime("Fecha");
            ValorTurno = row.ToString("ValorTurno");
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
            TipoEntrega = row.ToString("TipoEntrega");
            DesTipoEntrega = row.ToString("DesTipoEntrega");
            Novedad = row.ToString("Novedad");
            DesNovedad = row.ToString("DesNovedad");
            MensajeNovedad = row.ToString("MensajeNovedad");
            Latitud = row.ToString("Latitud");
            Longitud = row.ToString("Longitud");
            Observacion = row.ToString("Observacion");
            Boleta = row.ToString("Boleta");
            Foto = row.ToString("Foto");
            FechaNovedad = row.ToDateTimeNull("FechaNovedad", (DateTime?)null);
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
            CodigoMotivo = row.ToString("CodigoMotivo");
            DescripcionMotivo = row.ToString("DescripcionMotivo");
        }
    }
}
