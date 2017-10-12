using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

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
        private string msNombreCliente;
        private string msApellidoCliente;

        public BECliente()
        {
            msNombre = string.Empty;
            mseMail = string.Empty;
            msTelefono = string.Empty;
            msCelular = string.Empty;
            miCodigoCliente = 0;
            miFavorito = 0;
            miTipoContactoFavorito = 0;

            msNombreCliente = string.Empty;
            msApellidoCliente = string.Empty;
        }

        public BECliente(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "ConsultoraID") && datarec["ConsultoraID"] != DBNull.Value)
                miConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);

            if (DataRecord.HasColumn(datarec, "ClienteID") && datarec["ClienteID"] != DBNull.Value)
                miClienteID = Convert.ToInt32(datarec["ClienteID"]);

            if (DataRecord.HasColumn(datarec, "Nombre") && datarec["Nombre"] != DBNull.Value)
                msNombre = datarec["Nombre"].ToString();

            if (DataRecord.HasColumn(datarec, "eMail") && datarec["eMail"] != DBNull.Value)
                mseMail = datarec["eMail"].ToString();

            if (DataRecord.HasColumn(datarec, "Activo") && datarec["Activo"] != DBNull.Value)
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

            if (DataRecord.HasColumn(datarec, "NombreCliente") && datarec["NombreCliente"] != DBNull.Value)
                msNombreCliente = datarec["NombreCliente"].ToString();

            if (DataRecord.HasColumn(datarec, "ApellidoCliente") && datarec["ApellidoCliente"] != DBNull.Value)
                msApellidoCliente = datarec["ApellidoCliente"].ToString();

            if (DataRecord.HasColumn(datarec, "Saldo") && datarec["Saldo"] != DBNull.Value)
                Saldo = Convert.ToDecimal(datarec["Saldo"]);

            if (DataRecord.HasColumn(datarec, "CantidadProductos") && datarec["CantidadProductos"] != DBNull.Value)
                CantidadProductos = Convert.ToInt32(datarec["CantidadProductos"]);
        }

        [DataMember]
        public string NombreCliente
        {
            get { return msNombreCliente; }
            set { msNombreCliente = value; }
        }
        [DataMember]
        public string ApellidoCliente
        {
            get { return msApellidoCliente; }
            set { msApellidoCliente = value; }
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
        public decimal Saldo { get; set; }

        [DataMember]
        public int CantidadProductos { get; set; }

        [DataMember]
        public IEnumerable<BEClienteRecordatorio> Recordatorios { get; set; }

        public List<BEClienteContactoDB> Contactos { get; set; }
    }
}
