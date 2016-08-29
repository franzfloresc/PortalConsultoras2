using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEtiqueta
    {
        private int etiquetaID;
        private string descripcion;
        private string usuarioCreacion;
        private string usuarioModificacion;
        private int estado;
        private int paisID;

        [DataMember]
        public int EtiquetaID
        {
            get { return etiquetaID; }
            set { etiquetaID = value; }
        }
        [DataMember]
        public string Descripcion
        {
            get { return descripcion; }
            set { descripcion = value; }
        }
        [DataMember]
        public string UsuarioCreacion
        {
            get { return usuarioCreacion; }
            set { usuarioCreacion = value; }
        }
        [DataMember]
        public string UsuarioModificacion
        {
            get { return usuarioModificacion; }
            set { usuarioModificacion = value; }
        }
        [DataMember]
        public int Estado
        {
            get { return estado; }
            set { estado = value; }
        }
        [DataMember]
        public int PaisID
        {
            get { return paisID; }
            set { paisID = value; }
        }

        [DataMember]
        public int CodigoGeneral { get; set; }

        public BEEtiqueta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "EtiquetaID") && row["EtiquetaID"] != DBNull.Value)
                EtiquetaID = Convert.ToInt32(row["EtiquetaID"]);

            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = row["Descripcion"].ToString();

            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToInt32(row["Estado"]);

            if (DataRecord.HasColumn(row, "CodigoGeneral") && row["CodigoGeneral"] != DBNull.Value)
                this.CodigoGeneral = Convert.ToInt32(row["CodigoGeneral"]);
        }
    }

}
