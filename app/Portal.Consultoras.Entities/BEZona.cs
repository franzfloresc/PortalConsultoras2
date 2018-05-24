using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEZona
    {
        private int miZonaID;
        private int miRegionID;
        private string msCodigo;
        private string msNombre;
        private string msNombreGerenteZona;
        private int msCantidadDias;

        public BEZona() { }
        public BEZona(IDataRecord row)
        {
            miZonaID = Convert.ToInt32(row["ZonaID"]);
            miRegionID = Convert.ToInt32(row["RegionID"]);
            msCodigo = row["Codigo"].ToString();
            msNombre = row["Nombre"].ToString();
            msNombreGerenteZona = row["NombreGerenteZona"] == null ? "" : row["NombreGerenteZona"].ToString();
            if (DataRecord.HasColumn(row, "CantidadDias"))
                msCantidadDias = Convert.ToInt32(row["CantidadDias"]);
        }

        [DataMember]
        public int ZonaID
        {
            get { return miZonaID; }
            set { miZonaID = value; }
        }

        [DataMember]
        public int RegionID
        {
            get { return miRegionID; }
            set { miRegionID = value; }
        }

        [DataMember]
        public string Codigo
        {
            get { return msCodigo; }
            set { msCodigo = value; }
        }

        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }

        [DataMember]
        public string NombreGerenteZona
        {
            get { return msNombreGerenteZona; }
            set { msNombreGerenteZona = value; }
        }

        [DataMember]
        public int CantidadDias
        {
            get { return msCantidadDias; }
            set { msCantidadDias = value; }
        }
    }
}
