using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECampania
    {
        private int miCampaniaID;
        private string msCodigo;
        private int miAnio;
        private string msNombreCorto;
        private int miPaisID;
        private bool mbActivo;

        public BECampania() { }
        public BECampania(IDataRecord row)
        {
            miCampaniaID = Convert.ToInt32(row["CampaniaID"]);
            msCodigo = row["Codigo"].ToString();
            miAnio = Convert.ToInt32(row["Anio"]);
            msNombreCorto = row["NombreCorto"].ToString();
            miPaisID = Convert.ToInt32(row["PaisID"]);
            mbActivo = Convert.ToBoolean(row["Activo"]);
        }

        [DataMember]
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }
        [DataMember]
        public string Codigo
        {
            get { return msCodigo; }
            set { msCodigo = value; }
        }
        [DataMember]
        public int Anio
        {
            get { return miAnio; }
            set { miAnio = value; }
        }
        [DataMember]
        public string NombreCorto
        {
            get { return msNombreCorto; }
            set { msNombreCorto = value; }
        }
        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public bool Activo
        {
            get { return mbActivo; }
            set { mbActivo = value; }
        }
    }
}
