using Portal.Consultoras.Common;

using System;
using System.Data;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPais : BaseEntidad
    {
        [DataMember]
        [Column("ConfiguracionPaisID")]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Excluyente")]
        public bool Excluyente { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }

        [DataMember]
        public bool Validado { get; set; }
        [DataMember]
        [Column("TienePerfil")]
        public bool TienePerfil { get; set; }
        [DataMember]
        [Column("MobileTituloMenu")]
        public string MobileTituloMenu { get; set; }
        [DataMember]
        [Column("DesktopTituloMenu")]
        public string DesktopTituloMenu { get; set; }
        [DataMember]
        [Column("Logo")]
        public string Logo { get; set; }
        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }
        [DataMember]
        [Column("DesdeCampania")]
        public int DesdeCampania { get; set; }
        [DataMember]
        [Column("DesktopTituloBanner")]
        public string DesktopTituloBanner { get; set; }
        [DataMember]
        [Column("MobileTituloBanner")]
        public string MobileTituloBanner { get; set; }
        [DataMember]
        [Column("DesktopSubTituloBanner")]
        public string DesktopSubTituloBanner { get; set; }
        [DataMember]
        [Column("MobileSubTituloBanner")]
        public string MobileSubTituloBanner { get; set; }

        [DataMember]
        [Column("DesktopFondoBanner")]
        public string DesktopFondoBanner { get; set; }
        [DataMember]
        [Column("MobileFondoBanner")]
        public string MobileFondoBanner { get; set; }
        [DataMember]
        [Column("DesktopLogoBanner")]
        public string DesktopLogoBanner { get; set; }
        [DataMember]
        [Column("MobileLogoBanner")]
        public string MobileLogoBanner { get; set; }
        [DataMember]
        [Column("UrlMenu")]
        public string UrlMenu { get; set; }
        [DataMember]
        [Column("OrdenBpt")]
        public int OrdenBpt { get; set; }
        [DataMember]
        [Column("BloqueoRevistaImpresa")]
        public bool BloqueoRevistaImpresa { get; set; }

        [DataMember]
        [Column("MobileOrden")]
        public int MobileOrden { get; set; }
        [DataMember]
        [Column("MobileOrdenBpt")]
        public int MobileOrdenBpt { get; set; }

        private BEConfiguracionPaisDetalle detalle = new BEConfiguracionPaisDetalle();
        [DataMember]
        public BEConfiguracionPaisDetalle Detalle
        {
            get
            {
                return detalle;
            }
            set
            {
                detalle = value;
            }
        }

        //public BEConfiguracionPais()
        //{
        //    Detalle = new BEConfiguracionPaisDetalle();
        //}

        //public BEConfiguracionPais(IDataRecord row)
        //{
        //    if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
        //    if (row.HasColumn("Codigo")) Codigo = Convert.ToString(row["Codigo"]);
        //    if (row.HasColumn("Excluyente")) Excluyente = Convert.ToBoolean(row["Excluyente"]);
        //    if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
        //    if (row.HasColumn("Estado")) Estado = Convert.ToBoolean(row["Estado"]);
        //    if (row.HasColumn("TienePerfil")) TienePerfil = Convert.ToBoolean(row["TienePerfil"]);
        //    if (row.HasColumn("DesdeCampania")) DesdeCampania = Convert.ToInt32(row["DesdeCampania"]);
        //    if (row.HasColumn("MobileTituloMenu")) MobileTituloMenu = Convert.ToString(row["MobileTituloMenu"]);
        //    if (row.HasColumn("DesktopTituloMenu")) DesktopTituloMenu = Convert.ToString(row["DesktopTituloMenu"]);
        //    if (row.HasColumn("Logo")) Logo = Convert.ToString(row["Logo"]);
        //    if (row.HasColumn("Orden")) Orden = Convert.ToInt32(row["Orden"]);
        //    if (row.HasColumn("DesktopTituloBanner")) DesktopTituloBanner = Convert.ToString(row["DesktopTituloBanner"]);
        //    if (row.HasColumn("MobileTituloBanner")) MobileTituloBanner = Convert.ToString(row["MobileTituloBanner"]);
        //    if (row.HasColumn("DesktopSubTituloBanner")) DesktopSubTituloBanner = Convert.ToString(row["DesktopSubTituloBanner"]);
        //    if (row.HasColumn("MobileSubTituloBanner")) MobileSubTituloBanner = Convert.ToString(row["MobileSubTituloBanner"]);
        //    if (row.HasColumn("DesktopFondoBanner")) DesktopFondoBanner = Convert.ToString(row["DesktopFondoBanner"]);
        //    if (row.HasColumn("MobileFondoBanner")) MobileFondoBanner = Convert.ToString(row["MobileFondoBanner"]);
        //    if (row.HasColumn("DesktopLogoBanner")) DesktopLogoBanner = Convert.ToString(row["DesktopLogoBanner"]);
        //    if (row.HasColumn("MobileLogoBanner")) MobileLogoBanner = Convert.ToString(row["MobileLogoBanner"]);
        //    if (row.HasColumn("UrlMenu")) UrlMenu = Convert.ToString(row["UrlMenu"]);
        //    if (row.HasColumn("OrdenBpt")) OrdenBpt = Convert.ToInt32(row["OrdenBpt"]);
        //    if (row.HasColumn("BloqueoRevistaImpresa")) BloqueoRevistaImpresa = Convert.ToBoolean(row["BloqueoRevistaImpresa"]);
        //    if (row.HasColumn("MobileOrden")) MobileOrden = Convert.ToInt32(row["MobileOrden"]);
        //    if (row.HasColumn("MobileOrdenBPT")) MobileOrdenBpt = Convert.ToInt32(row["MobileOrdenBPT"]);
        //    Detalle = new BEConfiguracionPaisDetalle();
        //}
    }
}
