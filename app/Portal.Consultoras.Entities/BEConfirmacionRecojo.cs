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
            
                ConfirmacionRecojoID = row.ToInt32("ConfirmacionRecojoID");
            
                CampaniaID = row.ToInt32("CampaniaID");
            
                Campania = row.ToString("Campania");
            
                CodigoConsultora = row.ToString("CodigoConsultora");
            
                CodigoPlataforma = row.ToString("CodigoPlataforma");
            
                NumeroRecojo = row.ToString("NumeroRecojo");
            
                NumeroPedido = row.ToString("NumeroPedido");
            
                FechaRecojo = row.ToDateTime("FechaRecojo");

            
                FechaEstimadoRecojo = row.ToDateTime("FechaEstimadoRecojo");
            
                EstadoRecojoID = row.ToInt32("EstadoRecojoID");
            
                EstadoRecojo = row.ToString("EstadoRecojo");
            
                CodigoTipoNovedadRecojo = row.ToString("CodigoTipoNovedadRecojo");
            
                Novedad = row.ToString("Novedad");
            
                MensajeTipoNovedad = row.ToString("MensajeTipoNovedad");
            
                Situacion = row.ToString("Situacion");
            
                Latitud = row.ToString("Latitud");
            
                Longitud = row.ToString("Longitud");
            
                Foto1 = row.ToString("Foto1");
            
                Foto2 = row.ToString("Foto2");
            
                FechaCreacion = row.ToDateTime("FechaCreacion");
            
                PaisISO = row.ToString("PaisISO");
            
                PaisID = row.ToInt32("PaisID");
        }
    }
}
