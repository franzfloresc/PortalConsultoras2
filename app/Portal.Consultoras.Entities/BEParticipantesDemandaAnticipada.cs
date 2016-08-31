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
            ConfiguracionConsultoraDAID = Convert.ToInt32(row["ConfiguracionConsultoraDAID"]);
            ZonaID = Convert.ToInt32(row["ZonaID"]);
            ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            CodigoZona = Convert.ToString(row["CodigoZona"]);
            NombreZona = Convert.ToString(row["NombreZona"]);
            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            TipoConfiguracion = Convert.ToByte(row["TipoConfiguracion"]);
            Fecha = Convert.ToDateTime(row["Fecha"]);
            FechaModificada = Convert.ToDateTime(row["FechaModificada"]);
            CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            AceptoParticipar = Convert.ToString(row["AceptoParticipar"]);
            FechaFormato = Convert.ToString(row["FechaFormato"]);
            FechaModificadaFormato = Convert.ToString(row["FechaModificadaFormato"]);
        }
    }
}
