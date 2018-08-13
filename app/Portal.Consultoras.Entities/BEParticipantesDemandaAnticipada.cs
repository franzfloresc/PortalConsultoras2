using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEParticipantesDemandaAnticipada
    {
        [DataMember]
        public int ConfiguracionConsultoraDAID { set; get; }
        [DataMember]
        public int ZonaID { set; get; }
        [DataMember]
        public int ConsultoraID { set; get; }
        [DataMember]
        public string CodigoCampania { set; get; }
        [DataMember]
        public string CodigoZona { set; get; }
        [DataMember]
        public string NombreZona { set; get; }
        [DataMember]
        public string CodigoConsultora { set; get; }
        [DataMember]
        public string NombreCompleto { set; get; }
        [DataMember]
        public byte TipoConfiguracion { set; get; }
        [DataMember]
        public decimal ImporteTotal { set; get; }
        [DataMember]
        public DateTime Fecha { set; get; }
        [DataMember]
        public DateTime FechaModificada { set; get; }
        [DataMember]
        public string CodigoUsuario { set; get; }
        [DataMember]
        public string AceptoParticipar { set; get; }
        [DataMember]
        public string FechaFormato { set; get; }
        [DataMember]
        public string FechaModificadaFormato { set; get; }


        public BEParticipantesDemandaAnticipada()
        { }

        public BEParticipantesDemandaAnticipada(IDataRecord row)
        {
            ConfiguracionConsultoraDAID = row.ToInt32("ConfiguracionConsultoraDAID");
            ZonaID = row.ToInt32("ZonaID");
            ConsultoraID = row.ToInt32("ConsultoraID");
            CodigoCampania = row.ToString("CodigoCampania");
            CodigoZona = row.ToString("CodigoZona");
            NombreZona = row.ToString("NombreZona");
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("NombreCompleto");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            TipoConfiguracion = row.ToByte("TipoConfiguracion");
            Fecha = row.ToDateTime("Fecha");
            FechaModificada = row.ToDateTime("FechaModificada");
            CodigoUsuario = row.ToString("CodigoUsuario");
            AceptoParticipar = row.ToString("AceptoParticipar");
            FechaFormato = row.ToString("FechaFormato");
            FechaModificadaFormato = row.ToString("FechaModificadaFormato");
        }
    }
}
