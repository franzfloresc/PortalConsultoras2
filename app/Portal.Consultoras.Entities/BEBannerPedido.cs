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
            Url = string.Empty;
        }

        public BEBannerPedido(IDataRecord row)
        {
            BannerPedidoID = row.ToInt32("BannerPedidoID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("Nombre");
            CampaniaIDInicio = row.ToInt32("CampaniaIDInicio");
            CampaniaIDFin = row.ToInt32("CampaniaIDFin");
            NombreCortoInicio = row.ToString("NombreCortoInicio");
            NombreCortoFin = row.ToString("NombreCortoFin");
            ConsultoraID = row.ToInt64("ConsultoraID");
            ArchivoPortada = row.ToString("ArchivoPortada");
            Archivo = row.ToString("Archivo");
            Url = row.ToString("Url");
            Posicion = row.ToInt32("Posicion");
            
            TipoUrl = row.ToString("TipoUrl", string.Empty);
            UsuarioCreacion = row.ToString("UsuarioCreacion", string.Empty);
            UsuarioModificacion = row.ToString("UsuarioModificacion", string.Empty);
        }
    }
}
