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
        //[DataMember]
        //public int PaisID { get; set; }
        [DataMember]
        public int DesdeCampania { get; set; }
        [DataMember]
        public string TipoEstrategia { get; set; }
        [DataMember]
        public bool MostrarCampaniaSiguiente { get; set; }
        [DataMember]
        public bool MostrarPagInformativa { get; set; }
        [DataMember]

        public string HImagenFondo { get; set; }
        [DataMember]
        public int HTipoPresentacion { get; set; }
        [DataMember]
        public int HMaxProductos { get; set; }
        [DataMember]
        public string HTipoEstrategia { get; set; }

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
            if (row.HasColumn("TipoEstrategia")) TipoEstrategia = Convert.ToString(row["TipoEstrategia"]);
            if (row.HasColumn("MostrarCampaniaSiguiente")) MostrarCampaniaSiguiente = Convert.ToBoolean(row["MostrarCampaniaSiguiente"]);
            if (row.HasColumn("MostrarPagInformativa")) MostrarPagInformativa = Convert.ToBoolean(row["MostrarPagInformativa"]);
            if (row.HasColumn("HImagenFondo")) HImagenFondo = Convert.ToString(row["HImagenFondo"]);
            if (row.HasColumn("HTipoPresentacion")) HTipoPresentacion = Convert.ToInt32(row["HTipoPresentacion"]);
            if (row.HasColumn("HMaxProductos")) HMaxProductos = Convert.ToInt32(row["HMaxProductos"]);
            if (row.HasColumn("HTipoEstrategia")) HTipoEstrategia = Convert.ToString(row["HTipoEstrategia"]);
            Detalle = new BEConfiguracionPaisDetalle();
        }
    }
}
