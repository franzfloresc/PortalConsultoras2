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
        private string mseMail;
        private bool mbActivo;
        private int miPaisID;
        private int mPagina;


        public BECliente()
        {
            msNombre = string.Empty;
            mseMail = string.Empty;
        }

        public BECliente(IDataRecord datarec)
        {
            miConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);
            miClienteID = Convert.ToInt32(datarec["ClienteID"]);
            msNombre = datarec["Nombre"].ToString();
            mseMail = datarec["eMail"].ToString();
            mbActivo = Convert.ToBoolean(datarec["Activo"]);
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
            get;
            set;
        }

    }
}
