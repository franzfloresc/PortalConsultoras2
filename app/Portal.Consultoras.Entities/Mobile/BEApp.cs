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

        [DataMember]
        public string MinimaVersion { get; set; }

        public BEApp()
        { }

        public BEApp(IDataRecord row)
        {
            
                AplicacionNombre = row.GetColumn<string>("Aplicacion");

            
                PaisISO = row.GetColumn<string>("CodigoPais");

            
                SistemaOperativo = row.GetColumn<string>("SistemaOperativo");

            
                Url = row.GetColumn<string>("Url");

            
                Version = row.GetColumn<string>("Version");

            
                RequiereActualizacion = row.GetColumn<bool>("RequiereActualizacion");

            
                TipoDescarga = row.GetColumn<short>("TipoDescarga");

            
                FechaLanzamiento = row.GetColumn<DateTime>("FechaLanzamiento");

            
                FechaActualizacion = row.GetColumn<DateTime>("FechaActualizacion");

            
                MinimaVersion = row.GetColumn<string>("MinimaVersion");
        }
    }
}
