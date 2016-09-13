using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGrupoBanner
    {
        private int miCampaniaID;
        private int miGrupoBannerID;
        private int miTiempoRotacion;
        private BEGrupoConsultora[] moConsultoras;
        private string msNombre;
        private string msDimension;
        private int miAncho;
        private int miAlto;
        private string msDimensionEsika;
        private int miAnchoEsika;
        private int miAltoEsika;

        public BEGrupoBanner() { }
        public BEGrupoBanner(IDataRecord row)
        {
            miCampaniaID = DbConvert.ToInt32(row["CampaniaID"]);
            miGrupoBannerID = Convert.ToInt32(row["GrupoBannerID"]);
            miTiempoRotacion = DbConvert.ToInt32(row["TiempoRotacion"]);
            msNombre = row["Nombre"].ToString();
            msDimension = row["Dimension"].ToString();
            miAncho = DbConvert.ToInt32(row["Ancho"]);
            miAlto = DbConvert.ToInt32(row["Alto"]);
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                msDimensionEsika = row["DimensionEsika"].ToString();
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                miAnchoEsika = DbConvert.ToInt32(row["AnchoEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                miAltoEsika = DbConvert.ToInt32(row["AltoEsika"]);
        }

        [DataMember]
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }
        [DataMember]
        public int GrupoBannerID
        {
            get { return miGrupoBannerID; }
            set { miGrupoBannerID = value; }
        }
        [DataMember]
        public int TiempoRotacion
        {
            get { return miTiempoRotacion; }
            set { miTiempoRotacion = value; }
        }
        [DataMember]
        public BEGrupoConsultora[] Consultoras
        {
            get { return moConsultoras; }
            set { moConsultoras = value; }
        }

        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }

        [DataMember]
        public string Dimension
        {
            get { return msDimension; }
            set { msDimension = value; }
        }

        [DataMember]
        public int Ancho
        {
            get { return miAncho; }
            set { miAncho = value; }
        }

        [DataMember]
        public int Alto
        {
            get { return miAlto; }
            set { miAlto = value; }
        }

        [DataMember]
        public string DimensionEsika
        {
            get { return msDimensionEsika; }
            set { msDimensionEsika = value; }
        }

        [DataMember]
        public int AnchoEsika
        {
            get { return miAnchoEsika; }
            set { miAnchoEsika = value; }
        }

        [DataMember]
        public int AltoEsika
        {
            get { return miAltoEsika; }
            set { miAltoEsika = value; }
        }
    }
}