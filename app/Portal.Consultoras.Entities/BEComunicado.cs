using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

//R2004
namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEComunicado
    {
        [DataMember]
        public long ComunicadoId { get; set; }
        [DataMember]
        public bool Visualizo { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string Accion { get; set; }
        [DataMember]
        public string DescripcionAccion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string UrlImagen { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        public BEComunicado()
        { }

        public BEComunicado(IDataRecord record)
        {
            ComunicadoId = Convert.ToInt64(record["ComunicadoId"]);
            Visualizo = record["Visualizo"] != DBNull.Value ? Convert.ToBoolean(record["Visualizo"]) : false;
            CodigoConsultora = record["CodigoConsultora"] != DBNull.Value ?  record["CodigoConsultora"].ToString() : string.Empty;
            CodigoCampania = (record["CodigoCampania"] != DBNull.Value) ? record["CodigoCampania"].ToString() : string.Empty;
            Accion = record["Accion"]!= DBNull.Value ?   record["Accion"].ToString(): string.Empty;
            DescripcionAccion = record["DescripcionAccion"] != DBNull.Value ? record["DescripcionAccion"].ToString() : string.Empty;
            Orden = record["Orden"] != DBNull.Value ? Convert.ToInt32(record["Orden"]) : 0;
            UrlImagen = record["UrlImagen"] != DBNull.Value ? record["UrlImagen"].ToString() : string.Empty;
            Descripcion = record["Descripcion"] != DBNull.Value ? record["Descripcion"].ToString() : string.Empty;
        }
    }
}
