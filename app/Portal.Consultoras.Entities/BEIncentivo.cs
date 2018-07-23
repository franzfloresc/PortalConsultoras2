using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivo
    {
        [DataMember]
        public int IncentivoID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public int CampaniaIDInicio { set; get; }
        [DataMember]
        public int CampaniaIDFin { set; get; }
        [DataMember]
        public string NombreCortoInicio { set; get; }
        [DataMember]
        public string NombreCortoFin { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public string Titulo { set; get; }
        [DataMember]
        public string Subtitulo { set; get; }
        [DataMember]
        public string ArchivoPortada { set; get; }
        [DataMember]
        public string ArchivoPortadaAnterior { set; get; }
        [DataMember]
        public string ArchivoPDF { set; get; }
        [DataMember]
        public string Url { set; get; }

        public BEIncentivo()
        {
            ArchivoPDF = string.Empty;
            Url = string.Empty;
        }

        public BEIncentivo(IDataRecord row)
        {
            IncentivoID = row.ToInt32("IncentivoID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("Nombre");
            CampaniaIDInicio = row.ToInt32("CampaniaIDInicio");
            CampaniaIDFin = row.ToInt32("CampaniaIDFin");
            NombreCortoInicio = row.ToString("NombreCortoInicio");
            NombreCortoFin = row.ToString("NombreCortoFin");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Titulo = row.ToString("Titulo");
            Subtitulo = row.ToString("Subtitulo");
            ArchivoPortada = row.ToString("ArchivoPortada");
            ArchivoPDF = row.ToString("ArchivoPDF");
            Url = row.ToString("Url");
        }
    }
}
