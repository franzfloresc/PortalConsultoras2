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
    public class BEDupla
    {
        private string msCodigoUsuario;
        private string msNombre;
        private string msSegundoNombre;
        private string msApellidoPaterno;
        private string msApellidoMaterno;
        private string msSobrenombre;
        private DateTime mdFechaNacimiento;
        private string mseMail;
        private string msSexo;
        private string msTelefono;
        private string msCelular;
        private string msDireccion;
        private bool mbActivo;
        private int miPaisID;

        public BEDupla(IDataRecord row)
        {
	        msCodigoUsuario = row["CodigoUsuario"].ToString();
	        msNombre = row["Nombre"].ToString();
	        msSegundoNombre = row["SegundoNombre"].ToString();
	        msApellidoPaterno = row["ApellidoPaterno"].ToString();
	        msApellidoMaterno = row["ApellidoMaterno"].ToString();
	        msSobrenombre = row["Sobrenombre"].ToString();
	        mdFechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
	        mseMail = row["eMail"].ToString();
	        msSexo = row["Sexo"].ToString();
	        msTelefono = row["Telefono"].ToString();
	        msCelular = row["Celular"].ToString();
	        msDireccion = row["Direccion"].ToString();
	        mbActivo = Convert.ToBoolean(row["Activo"]);
        }

        [DataMember]
        public string CodigoUsuario
        {
            get { return msCodigoUsuario; }
            set { msCodigoUsuario = value; }
        }
        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }
        [DataMember]
        public string SegundoNombre
        {
            get { return msSegundoNombre; }
            set { msSegundoNombre = value; }
        }
        [DataMember]
        public string ApellidoPaterno
        {
            get { return msApellidoPaterno; }
            set { msApellidoPaterno = value; }
        }
        [DataMember]
        public string ApellidoMaterno
        {
            get { return msApellidoMaterno; }
            set { msApellidoMaterno = value; }
        }
        [DataMember]
        public string Sobrenombre
        {
            get { return msSobrenombre; }
            set { msSobrenombre = value; }
        }
        [DataMember]
        public DateTime FechaNacimiento
        {
            get { return mdFechaNacimiento; }
            set { mdFechaNacimiento = value; }
        }
        [DataMember]
        public string eMail
        {
            get { return mseMail; }
            set { mseMail = value; }
        }
        [DataMember]
        public string Sexo
        {
            get { return msSexo; }
            set { msSexo = value; }
        }
        [DataMember]
        public string Telefono
        {
            get { return msTelefono; }
            set { msTelefono = value; }
        }
        [DataMember]
        public string Celular
        {
            get { return msCelular; }
            set { msCelular = value; }
        }
        [DataMember]
        public string Direccion
        {
            get { return msDireccion; }
            set { msDireccion = value; }
        }
        [DataMember]
        public bool Activo
        {
            get { return mbActivo; }
            set { mbActivo = value; }
        }
        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
    }
}
