using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGetZonaByPaisParametroCarga
    {
        private int myZonaID;
        private int myRegionID;
        private string myCodigo;
        private string myNombre;
        private int myCantidadDias;

        public BEGetZonaByPaisParametroCarga() { }

        public BEGetZonaByPaisParametroCarga(IDataRecord row)
        {
            myZonaID = Convert.ToInt32(row["ZonaID"]);
            myRegionID = Convert.ToInt32(row["RegionID"]);
            myCodigo = row["Codigo"].ToString();
            myNombre = row["Nombre"].ToString();
            if (DataRecord.HasColumn(row, "CantidadDias"))
                myCantidadDias = Convert.ToInt32(row["CantidadDias"]);
        }

        [DataMember]
        public int ZonaID
        {
            get { return myZonaID; }
            set { myZonaID = value; }
        }

        [DataMember]
        public int RegionID
        {
            get { return myRegionID; }
            set { myRegionID = value; }
        }

        [DataMember]
        public string Codigo
        {
            get { return myCodigo; }
            set { myCodigo = value; }
        }

        [DataMember]
        public string Nombre
        {
            get { return myNombre; }
            set { myNombre = value; }
        }

        [DataMember]
        public int CantidadDias
        {
            get { return myCantidadDias; }
            set { myCantidadDias = value; }
        }
    }
}
