using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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

        public BEGrupoBanner()
        {
            moConsultoras = new BEGrupoConsultora[0];
        }
        public BEGrupoBanner(IDataRecord row)
        {
            msNombre = row["Nombre"].ToString();
            msDimension = row["Dimension"].ToString();

            if (DataRecord.HasColumn(row, "CampaniaID")) miCampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "GrupoBannerID")) miGrupoBannerID = Convert.ToInt32(row["GrupoBannerID"]);
            if (DataRecord.HasColumn(row, "TiempoRotacion")) miTiempoRotacion = Convert.ToInt32(row["TiempoRotacion"]);
            if (DataRecord.HasColumn(row, "Ancho")) miAncho = Convert.ToInt32(row["Ancho"]);
            if (DataRecord.HasColumn(row, "Alto")) miAlto = Convert.ToInt32(row["Alto"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) msDimensionEsika = row["DimensionEsika"].ToString();
            if (DataRecord.HasColumn(row, "AnchoEsika")) miAnchoEsika = Convert.ToInt32(row["AnchoEsika"]);
            if (DataRecord.HasColumn(row, "AltoEsika")) miAltoEsika = Convert.ToInt32(row["AltoEsika"]);

            moConsultoras = new BEGrupoConsultora[0];
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