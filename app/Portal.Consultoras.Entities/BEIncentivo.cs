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
            this.ArchivoPDF = string.Empty;
            this.Url = string.Empty;
        }

        public BEIncentivo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IncentivoID"))
                IncentivoID = Convert.ToInt32(row["IncentivoID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                PaisNombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "CampaniaIDInicio"))
                CampaniaIDInicio = Convert.ToInt32(row["CampaniaIDInicio"]);
            if (DataRecord.HasColumn(row, "CampaniaIDFin"))
                CampaniaIDFin = Convert.ToInt32(row["CampaniaIDFin"]);
            if (DataRecord.HasColumn(row, "NombreCortoInicio"))
                NombreCortoInicio = Convert.ToString(row["NombreCortoInicio"]);
            if (DataRecord.HasColumn(row, "NombreCortoFin"))
                NombreCortoFin = Convert.ToString(row["NombreCortoFin"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Titulo"))
                Titulo = Convert.ToString(row["Titulo"]);
            if (DataRecord.HasColumn(row, "Subtitulo"))
                Subtitulo = Convert.ToString(row["Subtitulo"]);
            if (DataRecord.HasColumn(row, "ArchivoPortada"))
                ArchivoPortada = Convert.ToString(row["ArchivoPortada"]);
            if (DataRecord.HasColumn(row, "ArchivoPDF"))
                ArchivoPDF = Convert.ToString(row["ArchivoPDF"]);
            if (DataRecord.HasColumn(row, "Url"))
                Url = Convert.ToString(row["Url"]);
        }
    }
}
