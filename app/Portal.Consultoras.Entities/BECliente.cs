using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;

using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;

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
        private long miCodigoCliente;
        private short miFavorito;
        private short miTipoContactoFavorito;
        private decimal saldo;

        public BECliente()
        {
            msNombre = string.Empty;
            mseMail = string.Empty;
            msTelefono = string.Empty;
            msCelular = string.Empty;
            miCodigoCliente = 0;
            miFavorito = 0;
            miTipoContactoFavorito = 0;
        }

        public BECliente(IDataRecord datarec)
        {
            miConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);
            miClienteID = Convert.ToInt32(datarec["ClienteID"]);
            msNombre = datarec["Nombre"].ToString();
            mseMail = datarec["eMail"].ToString();
            mbActivo = Convert.ToBoolean(datarec["Activo"]);

            if (DataRecord.HasColumn(datarec, "Telefono") && datarec["Telefono"] != DBNull.Value)
                msTelefono = datarec["Telefono"].ToString();

            if (DataRecord.HasColumn(datarec, "Celular") && datarec["Celular"] != DBNull.Value)
                msCelular = datarec["Celular"].ToString();

            if (DataRecord.HasColumn(datarec, "CodigoCliente") && datarec["CodigoCliente"] != DBNull.Value)
                miCodigoCliente = Convert.ToInt64(datarec["CodigoCliente"]);

            if (DataRecord.HasColumn(datarec, "Favorito") && datarec["Favorito"] != DBNull.Value)
                miFavorito = Convert.ToInt16(datarec["Favorito"]);

            if (DataRecord.HasColumn(datarec, "TipoContactoFavorito") && datarec["TipoContactoFavorito"] != DBNull.Value)
                miTipoContactoFavorito = Convert.ToInt16(datarec["TipoContactoFavorito"]);

            if (datarec.HasColumn("Saldo"))
                saldo = datarec.GetValue<decimal>("Saldo");
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
            get { return miCodigoCliente; }
            set { miCodigoCliente = value; }
        }

        [DataMember]
        public short Favorito
        {
            get { return miFavorito; }
            set { miFavorito = value; }
        }


        [DataMember]
        public short TipoContactoFavorito
        {
            get { return miTipoContactoFavorito; }
            set { miTipoContactoFavorito = value; }
        }

        [DataMember]
        public decimal Saldo
        {
            get { return saldo; }
            set { saldo = value; }
        }

        [DataMember]
        public IEnumerable<BEClienteRecordatorio> Recordatorios { get; set; }
    }
}
