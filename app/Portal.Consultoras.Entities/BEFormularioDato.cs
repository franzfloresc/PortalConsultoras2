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
    public class BEFormularioDato
    {
        private int miPaisID;
        private ETipoFormulario miTipoFormularioID;
        private int miFormularioDatoID;
        private string msDescripcion;
        private string msArchivo;
        private string msURL;

        public BEFormularioDato() { }
        public BEFormularioDato(IDataRecord datarec)
        {
	        miPaisID = Convert.ToInt32(datarec["PaisID"]);
            miTipoFormularioID = (ETipoFormulario)Convert.ToInt32(datarec["TipoFormularioID"]);
	        miFormularioDatoID = Convert.ToInt32(datarec["FormularioDatoID"]);
	        msDescripcion = (string)datarec["Descripcion"];
            msArchivo = (string)datarec["Archivo"];
            msURL = (string)datarec["URL"];
        }

        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public ETipoFormulario TipoFormularioID
        {
            get { return miTipoFormularioID; }
            set { miTipoFormularioID = value; }
        }
        [DataMember]
        public int FormularioDatoID
        {
            get { return miFormularioDatoID; }
            set { miFormularioDatoID = value; }
        }
        [DataMember]
        public string Descripcion
        {
            get { return msDescripcion; }
            set { msDescripcion = value; }
        }
        [DataMember]
        public string Archivo
        {
            get { return msArchivo; }
            set { msArchivo = value; }
        }
        [DataMember]
        public string URL
        {
            get { return msURL; }
            set { msURL = value; }
        }
    }
}
