using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPermiso
    {
        [DataMember]
        public int PermisoID { get; set; }

        [DataMember]
        public int PaisID { set; get; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int IdPadre { get; set; }

        [DataMember]
        public string DescripcionPadre { get; set; }

        [DataMember]
        public int OrdenItem { get; set; }

        [DataMember]
        public string UrlItem { get; set; }

        [DataMember]
        public bool PaginaNueva { get; set; }

        [DataMember]
        public int RolId { get; set; }

        [DataMember]
        public bool Mostrar { get; set; }

        [DataMember]
        public string Posicion { get; set; }

        [DataMember]
        public string DescripcionPaginaNueva { get; set; }

        /*Inicio Cambios_Landing_Comunidad*/
        [DataMember]
        public string UrlImagen { get; set; }

        [DataMember]
        public bool EsSoloImagen { get; set; }

        [DataMember]
        public bool EsMenuEspecial { get; set; }

        [DataMember]
        public bool EsServicios { get; set; }
        /*Fin Cambios_Landing_Comunidad*/

        public BEPermiso() { }
        public BEPermiso(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "PermisoID"))
                PermisoID = Convert.ToInt32(row["PermisoID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "IdPadre"))
                IdPadre = Convert.ToInt32(row["IdPadre"]);
            if (DataRecord.HasColumn(row, "OrdenItem"))
                OrdenItem = Convert.ToInt32(row["OrdenItem"]);
            if (DataRecord.HasColumn(row, "UrlItem"))
                UrlItem = Convert.ToString(row["UrlItem"]);
            if (DataRecord.HasColumn(row, "PaginaNueva"))
                PaginaNueva = Convert.ToBoolean(row["PaginaNueva"]);
            if (DataRecord.HasColumn(row, "RolId") && row["RolId"] != DBNull.Value)
                RolId = Convert.ToInt32(row["RolId"]);
            if (DataRecord.HasColumn(row, "Mostrar") && row["Mostrar"] != DBNull.Value)
                Mostrar = Convert.ToBoolean(row["Mostrar"]);
            if (DataRecord.HasColumn(row, "Posicion"))
                Posicion = Convert.ToString(row["Posicion"]);
            if (DataRecord.HasColumn(row, "DescripcionPadre"))
                DescripcionPadre = Convert.ToString(row["DescripcionPadre"]);
            if (DataRecord.HasColumn(row, "DescripcionPaginaNueva"))
                DescripcionPaginaNueva = Convert.ToString(row["DescripcionPaginaNueva"]);

            /*Inicio Cambios_Landing_Comunidad*/
            if (DataRecord.HasColumn(row, "UrlImagen") && row["UrlImagen"] != DBNull.Value)
            {
                UrlImagen = Convert.ToString(row["UrlImagen"]);
            }

            if (DataRecord.HasColumn(row, "EsSoloImagen") && row["EsSoloImagen"] != DBNull.Value)
            {
                EsSoloImagen = Convert.ToBoolean(row["EsSoloImagen"]);
            }

            if (DataRecord.HasColumn(row, "EsMenuEspecial") && row["EsMenuEspecial"] != DBNull.Value)
            {
                EsMenuEspecial = Convert.ToBoolean(row["EsMenuEspecial"]);
            }

            if (DataRecord.HasColumn(row, "EsServicios") && row["EsServicios"] != DBNull.Value)
            {
                EsServicios = Convert.ToBoolean(row["EsServicios"]);
            }
            /*Fin Cambios_Landing_Comunidad*/

        }
    }
}
