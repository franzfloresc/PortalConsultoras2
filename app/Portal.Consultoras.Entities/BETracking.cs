﻿
using Portal.Consultoras.Common;
using System;
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
        public string NumeroPedido { get; set; }

        [DataMember]
        public int Campana { get; set; }

        [DataMember]
        public string Estado { get; set; }

        [DataMember]
        public int Etapa { get; set; }

        [DataMember]
        public string Situacion { get; set; }

        [DataMember]
        public DateTime? Fecha { get; set; }


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
                Fecha = row["Fecha"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Fecha"]);
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
        public string Boleta { get; set; }//R20150710
        [DataMember]
        public string Foto { get; set; }//R20150710

        public BENovedadTracking()
        { }

        public BENovedadTracking(IDataRecord row)
        {
            TipoEntrega = Convert.ToString(row["TipoEntrega"]);
            DesTipoEntrega = Convert.ToString(row["DesTipoEntrega"]);
            Novedad = Convert.ToString(row["Novedad"]);
            DesNovedad = Convert.ToString(row["DesNovedad"]);
            MensajeNovedad = Convert.ToString(row["MensajeNovedad"]);
            FechaNovedad = row["FechaNovedad"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["FechaNovedad"]);
            Latitud = Convert.ToString(row["Latitud"]);
            Longitud = Convert.ToString(row["Longitud"]);
            Observacion = Convert.ToString(row["Observacion"]);
            if (DataRecord.HasColumn(row, "Boleta") && row["Boleta"] != DBNull.Value)
                Boleta = Convert.ToString(row["Boleta"]);//R20150710
            if (DataRecord.HasColumn(row, "Foto") && row["Foto"] != DBNull.Value)
                Foto = Convert.ToString(row["Foto"]);//R20150710
        }
    }

    //R2004
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
            DescripcionMotivo = Convert.ToString(row["DescripcionMotivo"]); ;
        }
    }


}
