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
    public class BETerritorio
    {
        private int miRegionID;
        private int miZonaID;
        private int miTerritorioID;
        private string msCodigo;
        private string msDescripcion;
        private int miSeccionID;

        public BETerritorio() { }
        public BETerritorio(IDataRecord row)
        {
            miRegionID = Convert.ToInt32(row["RegionID"]);
            miZonaID = Convert.ToInt32(row["ZonaID"]);
            miTerritorioID = Convert.ToInt32(row["TerritorioID"]);
            msCodigo = row["Codigo"].ToString();
            msDescripcion = row["Descripcion"].ToString();
            miSeccionID = Convert.ToInt32(row["SeccionID"]);
        }

        [DataMember]
        public int RegionID
        {
            get { return miRegionID; }
            set { miRegionID = value; }
        }
        [DataMember]
        public int ZonaID
        {
            get { return miZonaID; }
            set { miZonaID = value; }
        }
        [DataMember]
        public int TerritorioID
        {
            get { return miTerritorioID; }
            set { miTerritorioID = value; }
        }
        [DataMember]
        public string Codigo
        {
            get { return msCodigo; }
            set { msCodigo = value; }
        }
        [DataMember]
        public string Descripcion
        {
            get { return msDescripcion; }
            set { msDescripcion = value; }
        }
        [DataMember]
        public int SeccionID
        {
            get { return miSeccionID; }
            set { miSeccionID = value; }
        }
    }
}