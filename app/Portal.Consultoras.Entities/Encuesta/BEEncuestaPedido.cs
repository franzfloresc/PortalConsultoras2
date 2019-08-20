using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaPedido
    {
        [DataMember]
        public string EncuestaResultadoId { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public bool FlagTieneEncuesta { get; set; }

        public BEEncuestaPedido()
        {
        }
            public BEEncuestaPedido(IDataRecord row)
        {
            CodigoCampania = row.ToString("CodigoCampania");
            CodigoConsultora = row.ToString("CodigoConsultora");
            EncuestaResultadoId = row.ToString("EncuestaResultadoId");
            FlagTieneEncuesta = row.ToBoolean("FlagTieneEncuesta");
            ConsultoraID= row.ToInt32("ConsultoraID");
        }

    }
}
