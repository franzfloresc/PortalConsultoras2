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
    public class BEItemCarruselInicio // Modificación TiSmart 2014/12/12 - 2014/12/17
    {
        [DataMember]
        public int ItemCarruselInicioID { get; set; }

        [DataMember]
        public string UrlImagenPrincipal { get; set; }

        [DataMember]
        public string UrlImagenTitulo { get; set; }

        [DataMember]
        public string TextoDescripcion { get; set; }

        [DataMember]
        public string TextoLink { get; set; }

        [DataMember]
        public string UrlLink { get; set; }

        [DataMember]
        public bool EsVideo { get; set; }

        [DataMember]
        public string UrlLinkPrincipal { get; set; }

        [DataMember]
        public bool UrlLinkPrincipalExterno { get; set; }

        [DataMember]
        public string TextoDescripcion2 { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string NombreItem { get; set; }

        public BEItemCarruselInicio() { }
        public BEItemCarruselInicio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ItemCarruselInicioID"))
            {
                ItemCarruselInicioID = Convert.ToInt32(row["ItemCarruselInicioID"]);
            }

            if (DataRecord.HasColumn(row, "UrlImagenPrincipal"))
            {
                UrlImagenPrincipal = Convert.ToString(row["UrlImagenPrincipal"]);
            }

            if (DataRecord.HasColumn(row, "UrlImagenTitulo"))
            {
                UrlImagenTitulo = Convert.ToString(row["UrlImagenTitulo"]);
            }

            if (DataRecord.HasColumn(row, "TextoDescripcion"))
            {
                TextoDescripcion = Convert.ToString(row["TextoDescripcion"]);
            }

            if (DataRecord.HasColumn(row, "TextoLink"))
            {
                TextoLink = Convert.ToString(row["TextoLink"]);
            }

            if (DataRecord.HasColumn(row, "UrlLink"))
            {
                UrlLink = Convert.ToString(row["UrlLink"]);
            }

            if (DataRecord.HasColumn(row, "EsVideo"))
            {
                EsVideo = Convert.ToBoolean(row["EsVideo"]);
            }

            if (DataRecord.HasColumn(row, "UrlLinkPrincipal"))
            {
                UrlLinkPrincipal = Convert.ToString(row["UrlLinkPrincipal"]);
            }

            if (DataRecord.HasColumn(row, "UrlLinkPrincipalExterno"))
            {
                UrlLinkPrincipalExterno = Convert.ToBoolean(row["UrlLinkPrincipalExterno"]);
            }

            if (DataRecord.HasColumn(row, "TextoDescripcion2"))
            {
                TextoDescripcion2 = Convert.ToString(row["TextoDescripcion2"]);
            }

            if (DataRecord.HasColumn(row, "Orden"))
            {
                Orden = Convert.ToInt32(row["Orden"]);
            }

            if (DataRecord.HasColumn(row, "NombreItem"))
            {
                NombreItem = Convert.ToString(row["NombreItem"]);
            }
        }
    }
}
