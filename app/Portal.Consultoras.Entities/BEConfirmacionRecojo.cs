using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfirmacionRecojo
    {

        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoPlataforma { get; set; }
        [DataMember]
        public string NumeroRecojo { get; set; }
        [DataMember]
        public string NumeroPedido { get; set; }
        [DataMember]
        public DateTime FechaRecojo { get; set; }
        [DataMember]
        public DateTime? FechaEstimadoRecojo { get; set; }
        [DataMember]
        public int EstadoRecojo { get; set; }
        [DataMember]
        public string CodigoTipoNovedadRecojo { get; set; }
        [DataMember]
        public string Latitud { get; set; }
        [DataMember]
        public string Longitud { get; set; }
        [DataMember]
        public string Foto1 { get; set; }
        [DataMember]
        public string Foto2 { get; set; }
        [DataMember]
        public string PaisISO { get; set; }


        public BEConfirmacionRecojo(IDataRecord row)
        {
            Campania = row.ToInt32("CampaniaID");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CodigoPlataforma = row.ToString("CodigoPlataforma");
            NumeroRecojo = row.ToString("NumeroRecojo");
            NumeroPedido = row.ToString("NumeroPedido");
            FechaRecojo = row.ToDateTime("FechaRecojo");
            FechaEstimadoRecojo = row.ToDateTime("FechaEstimadoRecojo");
            EstadoRecojo = row.ToInt32("EstadoRecojoID");
            CodigoTipoNovedadRecojo = row.ToString("CodigoTipoNovedadRecojo");
            Latitud = row.ToString("Latitud");
            Longitud = row.ToString("Longitud");
            Foto1 = row.ToString("Foto1");
            Foto2 = row.ToString("Foto2");
            PaisISO = row.ToString("PaisISO");
        }

    }

    [DataContract]
    public class BEPostVenta
    {
        [DataMember]
        public int ConfirmacionRecojoID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoPlataforma { get; set; }
        [DataMember]
        public string NumeroRecojo { get; set; }
        [DataMember]
        public string NumeroPedido { get; set; }
        [DataMember]
        public DateTime FechaRecojo { get; set; }
        [DataMember]
        public DateTime? FechaEstimadoRecojo { get; set; }
        [DataMember]
        public int EstadoRecojoID { get; set; }
        [DataMember]
        public string EstadoRecojo { get; set; }
        [DataMember]
        public string Situacion { get; set; }
        [DataMember]
        public string CodigoTipoNovedadRecojo { get; set; }
        [DataMember]
        public string Novedad { get; set; }
        [DataMember]
        public string MensajeTipoNovedad { get; set; }
        [DataMember]
        public string Latitud { get; set; }
        [DataMember]
        public string Longitud { get; set; }
        [DataMember]
        public string Foto1 { get; set; }
        [DataMember]
        public string Foto2 { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string PaisISO { get; set; }
        [DataMember]
        public int PaisID { get; set; }

        public BEPostVenta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ConfirmacionRecojoID"))
                ConfirmacionRecojoID = Convert.ToInt32(row["ConfirmacionRecojoID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, " CodigoPlataforma"))
                CodigoPlataforma = Convert.ToString(row["CodigoPlataforma"]);
            if (DataRecord.HasColumn(row, "NumeroRecojo"))
                NumeroRecojo = Convert.ToString(row["NumeroRecojo"]);
            if (DataRecord.HasColumn(row, "NumeroPedido"))
                NumeroPedido = Convert.ToString(row["NumeroPedido"]);
            if (DataRecord.HasColumn(row, "FechaRecojo"))
                FechaRecojo = Convert.ToDateTime(row["FechaRecojo"]);

            if (DataRecord.HasColumn(row, "FechaEstimadoRecojo"))
                FechaEstimadoRecojo = Convert.ToDateTime(row["FechaEstimadoRecojo"]);
            if (DataRecord.HasColumn(row, "EstadoRecojoID"))
                EstadoRecojoID = Convert.ToInt32(row["EstadoRecojoID"]);
            if (DataRecord.HasColumn(row, "EstadoRecojo"))
                EstadoRecojo = Convert.ToString(row["EstadoRecojo"]);
            if (DataRecord.HasColumn(row, "CodigoTipoNovedadRecojo"))
                CodigoTipoNovedadRecojo = Convert.ToString(row["CodigoTipoNovedadRecojo"]);
            if (DataRecord.HasColumn(row, "Novedad"))
                Novedad = Convert.ToString(row["Novedad"]);
            if (DataRecord.HasColumn(row, "MensajeTipoNovedad"))
                MensajeTipoNovedad = Convert.ToString(row["MensajeTipoNovedad"]);
            if (DataRecord.HasColumn(row, "Situacion"))
                Situacion = Convert.ToString(row["Situacion"]);
            if (DataRecord.HasColumn(row, "Latitud"))
                Latitud = Convert.ToString(row["Latitud"]);
            if (DataRecord.HasColumn(row, "Longitud"))
                Longitud = Convert.ToString(row["Longitud"]);
            if (DataRecord.HasColumn(row, "Foto1"))
                Foto1 = Convert.ToString(row["Foto1"]);
            if (DataRecord.HasColumn(row, "Foto2"))
                Foto2 = Convert.ToString(row["Foto2"]);
            if (DataRecord.HasColumn(row, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
            if (DataRecord.HasColumn(row, "PaisISO"))
                PaisISO = Convert.ToString(row["PaisISO"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
        }
    }
}
