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
    public class BECliente
    {
        private long miConsultoraID;
        private int miClienteID;
        private string msNombre;
        private string msTelefono;
        private string msCelular;
        private string mseMail;
        private bool mbActivo;
        private int miPaisID;
        private int mPagina;
        private long mCodigoCliente;


        public BECliente()
        {
            msNombre = string.Empty;
            mseMail = string.Empty;
            msTelefono = string.Empty;
            msCelular = string.Empty;
        }

        public BECliente(IDataRecord datarec)
        {
            miConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);
            miClienteID = Convert.ToInt32(datarec["ClienteID"]);
            msNombre = datarec["Nombre"].ToString();
            msTelefono = datarec["Telefono"].ToString();
            msCelular = datarec["Celular"].ToString();
            mseMail = datarec["eMail"].ToString();
            mbActivo = Convert.ToBoolean(datarec["Activo"]);

            if (datarec["CodigoCliente"]!= DBNull.Value)
                mCodigoCliente = Convert.ToInt64(datarec["CodigoCliente"]);
        }

        [DataMember]
        public int Pagina
        {
            get { return mPagina; }
            set { mPagina = value; }
        }

        [DataMember]
        public long ConsultoraID
        {
            get { return miConsultoraID; }
            set { miConsultoraID = value; }
        }

        [DataMember]
        public int ClienteID
        {
            get { return miClienteID; }
            set { miClienteID = value; }
        }

        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }

        [DataMember]
        public string eMail
        {
            get { return mseMail; }
            set { mseMail = value; }
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
        public short TieneTelefono
        {
            get
            {
                short resultado = 0;

                if (!string.IsNullOrEmpty(Telefono) || !string.IsNullOrEmpty(Celular))
                    resultado = 1;

                return resultado;
            }
            set
            {

            }
        }

        [DataMember]
        public long CodigoCliente
        {
            get { return mCodigoCliente; }
            set { mCodigoCliente = value; }
        }
    }
}
