using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPais : BaseEntidad
    {
        [DataMember]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public bool Excluyente { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        [DataMember]
        public bool Validado { get; set; }
        [DataMember]
        public bool TienePerfil { get; set; }
        [DataMember]
        public string MobileTituloMenu { get; set; }
        [DataMember]
        public string DesktopTituloMenu { get; set; }
        [DataMember]
        public string Logo { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public int DesdeCampania { get; set; }
        [DataMember]
        public string DesktopTituloBanner { get; set; }
        [DataMember]
        public string MobileTituloBanner { get; set; }
        [DataMember]
        public string DesktopSubTituloBanner { get; set; }
        [DataMember]
        public string MobileSubTituloBanner { get; set; }

        [DataMember]
        public string DesktopFondoBanner { get; set; }
        [DataMember]
        public string MobileFondoBanner { get; set; }
        [DataMember]
        public string DesktopLogoBanner { get; set; }
        [DataMember]
        public string MobileLogoBanner { get; set; }

        [DataMember]
        public BEConfiguracionPaisDetalle Detalle  { get; set; }

        public BEConfiguracionPais() {
            Detalle = new BEConfiguracionPaisDetalle();
        }

        public BEConfiguracionPais(IDataRecord row)
        {
            if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
            if (row.HasColumn("Codigo")) Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Excluyente")) Excluyente = Convert.ToBoolean(row["Excluyente"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToBoolean(row["Estado"]);
            if (row.HasColumn("TienePerfil")) TienePerfil = Convert.ToBoolean(row["TienePerfil"]);
            if (row.HasColumn("DesdeCampania")) DesdeCampania = Convert.ToInt32(row["DesdeCampania"]);
            if (row.HasColumn("MobileTituloMenu")) MobileTituloMenu = Convert.ToString(row["MobileTituloMenu"]);
            if (row.HasColumn("DesktopTituloMenu")) DesktopTituloMenu = Convert.ToString(row["DesktopTituloMenu"]);
            if (row.HasColumn("Logo")) Logo = Convert.ToString(row["Logo"]);
            if (row.HasColumn("Orden")) Orden = Convert.ToInt32(row["Orden"]);
            if (row.HasColumn("DesktopTituloBanner")) DesktopTituloBanner = Convert.ToString(row["DesktopTituloBanner"]);
            if (row.HasColumn("MobileTituloBanner")) MobileTituloBanner = Convert.ToString(row["MobileTituloBanner"]);
            if (row.HasColumn("DesktopSubTituloBanner")) DesktopSubTituloBanner = Convert.ToString(row["DesktopSubTituloBanner"]);
            if (row.HasColumn("MobileSubTituloBanner")) MobileSubTituloBanner = Convert.ToString(row["MobileSubTituloBanner"]);
            if (row.HasColumn("DesktopFondoBanner")) DesktopFondoBanner = Convert.ToString(row["DesktopFondoBanner"]);
            if (row.HasColumn("MobileFondoBanner")) MobileFondoBanner = Convert.ToString(row["MobileFondoBanner"]);
            if (row.HasColumn("DesktopLogoBanner")) DesktopLogoBanner = Convert.ToString(row["DesktopLogoBanner"]);
            if (row.HasColumn("MobileLogoBanner")) MobileLogoBanner = Convert.ToString(row["MobileLogoBanner"]);
            Detalle = new BEConfiguracionPaisDetalle();
        }
    }
}
