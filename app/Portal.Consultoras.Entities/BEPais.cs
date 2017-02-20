using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPais
    {
        private int miPaisID;
        private string msCodigoISO;
        private string msNombreSimple;
        private string msNombreComplejo;
        private int nroCampanias;
        private string msCodigoISOProd;

        public BEPais() { }
        public BEPais(IDataRecord row)
        {
	        miPaisID = Convert.ToInt32(row["PaisID"]);
	        msCodigoISO = row["CodigoISO"].ToString();
	        msNombreSimple = row["NombreSimple"].ToString();
	        msNombreComplejo = row["NombreComplejo"].ToString();

            if (DataRecord.HasColumn(row, "NroCampanias") && row["NroCampanias"] != DBNull.Value) nroCampanias = Convert.ToInt32(row["nroCampanias"]);

            if (DataRecord.HasColumn(row, "CodigoISOProd") && row["CodigoISOProd"] != DBNull.Value) msCodigoISOProd = row["CodigoISOProd"].ToString();
            else msCodigoISOProd = "";
        }

        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public string CodigoISO
        {
            get { return msCodigoISO; }
            set { msCodigoISO = value; }
        }
        [DataMember]
        public string NombreCorto
        {
            get { return msNombreSimple; }
            set { msNombreSimple = value; }
        }
        [DataMember]
        public string Nombre
        {
            get { return msNombreComplejo; }
            set { msNombreComplejo = value; }
        }
        [DataMember]
        public string CodigoISOProd
        {
            get { return msCodigoISOProd; }
            set { msCodigoISOProd = value; }
        }
        [DataMember]
        public int NroCampanias
        {
            get { return nroCampanias; }
            set { nroCampanias = value; }
        }
    }
}