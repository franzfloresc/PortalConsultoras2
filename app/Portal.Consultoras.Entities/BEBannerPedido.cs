using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
                CampaniaIDInicio = DbConvert.ToInt32(row["CampaniaIDInicio"]);
            if (DataRecord.HasColumn(row, "CampaniaIDFin"))
                CampaniaIDFin = DbConvert.ToInt32(row["CampaniaIDFin"]);
            if (DataRecord.HasColumn(row, "NombreCortoInicio"))
                NombreCortoInicio = DbConvert.ToString(row["NombreCortoInicio"]);
            if (DataRecord.HasColumn(row, "NombreCortoFin"))
                NombreCortoFin = DbConvert.ToString(row["NombreCortoFin"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = DbConvert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ArchivoPortada"))
                ArchivoPortada = DbConvert.ToString(row["ArchivoPortada"]);
            if (DataRecord.HasColumn(row, "Archivo"))
                Archivo = DbConvert.ToString(row["Archivo"]);
            if (DataRecord.HasColumn(row, "Url"))
                Url = DbConvert.ToString(row["Url"]);
            if (DataRecord.HasColumn(row, "Posicion"))
                Posicion = Convert.ToInt32(row["Posicion"]);
            if (DataRecord.HasColumn(row, "TipoUrl"))
                TipoUrl = DbConvert.ToString(row["TipoUrl"]);
            else
                TipoUrl = string.Empty;

            if (DataRecord.HasColumn(row, "UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(row["UsuarioCreacion"]);
            else
                UsuarioCreacion = string.Empty;

            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(row["UsuarioModificacion"]);
            else
                UsuarioModificacion = string.Empty;
        }
    }
}
