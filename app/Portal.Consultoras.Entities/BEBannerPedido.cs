using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBannerPedido
    {
        [DataMember]
        public int BannerPedidoID { set; get; }
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
        public string ArchivoPortada { set; get; }
        [DataMember]
        public string ArchivoPortadaAnterior { set; get; }
        [DataMember]
        public string Archivo { set; get; }
        [DataMember]
        public string Url { set; get; }
        [DataMember]
        public int Posicion { set; get; }
        [DataMember]
        public string TipoUrl { set; get; }
        [DataMember]
        public string UsuarioCreacion { set; get; }
        [DataMember]
        public string UsuarioModificacion { set; get; }

        public BEBannerPedido()
        {
            this.Url = string.Empty;
        }

        public BEBannerPedido(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "BannerPedidoID"))
                BannerPedidoID = Convert.ToInt32(row["BannerPedidoID"]);
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
            if (DataRecord.HasColumn(row, "ArchivoPortada"))
                ArchivoPortada = Convert.ToString(row["ArchivoPortada"]);
            if (DataRecord.HasColumn(row, "Archivo"))
                Archivo = Convert.ToString(row["Archivo"]);
            if (DataRecord.HasColumn(row, "Url"))
                Url = Convert.ToString(row["Url"]);
            if (DataRecord.HasColumn(row, "Posicion"))
                Posicion = Convert.ToInt32(row["Posicion"]);
            if (DataRecord.HasColumn(row, "TipoUrl"))
                TipoUrl = Convert.ToString(row["TipoUrl"]);
            else
                TipoUrl = string.Empty;

            if (DataRecord.HasColumn(row, "UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);
            else
                UsuarioCreacion = string.Empty;

            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            else
                UsuarioModificacion = string.Empty;
        }
    }
}
