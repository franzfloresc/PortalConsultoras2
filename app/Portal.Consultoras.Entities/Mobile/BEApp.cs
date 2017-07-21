using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Mobile
{
    [DataContract]
    public class BEApp
    {
        [DataMember]
        public string AplicacionNombre { get; set; }

        [DataMember]
        public string PaisISO { get; set; }

        [DataMember]
        public string SistemaOperativo { get; set; }

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
            if (row.HasColumn("Aplicacion"))
                AplicacionNombre = row.GetValue<string>("Aplicacion");

            if (row.HasColumn("CodigoPais"))
                PaisISO = row.GetValue<string>("CodigoPais");

            if (row.HasColumn("SistemaOperativo"))
                SistemaOperativo = row.GetValue<string>("SistemaOperativo");

            if (row.HasColumn("Url"))
                Url = row.GetValue<string>("Url");

            if (row.HasColumn("Version"))
                Version = row.GetValue<string>("Version");
            
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
