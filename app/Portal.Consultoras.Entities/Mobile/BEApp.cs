using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Mobile
{
    [DataContract]
    public class BEApp
    {
        [DataMember]
        public string CodigoPais { get; set; }

        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public string SO { get; set; }

        [DataMember]
        public string Version { get; set; }

        [DataMember]
        public string Url { get; set; }

        [DataMember]
        public bool RequiereActualizacion { get; set; }

        [DataMember]
        public short TipoDescarga { get; set; }

        [DataMember]
        public DateTime FechaLanzamiento { get; set; }

        [DataMember]
        public DateTime FechaActualizacion { get; set; }

        public BEApp()
        { }

        public BEApp(IDataRecord row)
        {
            if (row.HasColumn("CodigoPais"))
                CodigoPais = row.GetValue<string>("CodigoPais");

            if (row.HasColumn("Name"))
                Name = row.GetValue<string>("Name");

            if (row.HasColumn("SO"))
                SO = row.GetValue<string>("SO");

            if (row.HasColumn("Version"))
                Version = row.GetValue<string>("Version");

            if (row.HasColumn("Url"))
                Url = row.GetValue<string>("Url");

            if (row.HasColumn("RequiereActualizacion"))
                RequiereActualizacion = row.GetValue<bool>("RequiereActualizacion");

            if (row.HasColumn("TipoDescarga"))
                TipoDescarga = row.GetValue<short>("TipoDescarga");

            if (row.HasColumn("FechaLanzamiento"))
                FechaLanzamiento = row.GetValue<DateTime>("FechaLanzamiento");

            if (row.HasColumn("FechaActualizacion"))
                FechaActualizacion = row.GetValue<DateTime>("FechaActualizacion");
        }
    }
}
