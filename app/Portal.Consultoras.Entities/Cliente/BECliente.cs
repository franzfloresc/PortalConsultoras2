using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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
            if (DataRecord.HasColumn(datarec, "ConsultoraID"))
                miConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);

            if (DataRecord.HasColumn(datarec, "ClienteID"))
                miClienteID = Convert.ToInt32(datarec["ClienteID"]);

            if (DataRecord.HasColumn(datarec, "Nombre"))
                msNombre = datarec["Nombre"].ToString();

            if (DataRecord.HasColumn(datarec, "eMail"))
                mseMail = datarec["eMail"].ToString();

            if (DataRecord.HasColumn(datarec, "Activo"))
                mbActivo = Convert.ToBoolean(datarec["Activo"]);

            if (DataRecord.HasColumn(datarec, "Telefono"))
                msTelefono = datarec["Telefono"].ToString();

            if (DataRecord.HasColumn(datarec, "Celular"))
                msCelular = datarec["Celular"].ToString();

            if (DataRecord.HasColumn(datarec, "CodigoCliente"))
                miCodigoCliente = Convert.ToInt64(datarec["CodigoCliente"]);

            if (DataRecord.HasColumn(datarec, "Favorito"))
                miFavorito = Convert.ToInt16(datarec["Favorito"]);

            if (DataRecord.HasColumn(datarec, "TipoContactoFavorito"))
                miTipoContactoFavorito = Convert.ToInt16(datarec["TipoContactoFavorito"]);

            if (DataRecord.HasColumn(datarec, "NombreCliente"))
                msNombreCliente = datarec["NombreCliente"].ToString();

            if (DataRecord.HasColumn(datarec, "ApellidoCliente"))
                msApellidoCliente = datarec["ApellidoCliente"].ToString();

            if (DataRecord.HasColumn(datarec, "Saldo"))
                Saldo = Convert.ToDecimal(datarec["Saldo"]);

            if (DataRecord.HasColumn(datarec, "CantidadProductos"))
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
        [Column("ClienteID")]
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
            set { }
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
        [Column("Saldo")]
        public decimal Saldo { get; set; }

        [DataMember]
        [Column("CantidadProductos")]
        public int CantidadProductos { get; set; }

        [DataMember]
        [Column("MontoPedido")]
        public decimal MontoPedido { get; set; }

        [DataMember]
        [Column("CantidadPedido")]
        public int CantidadPedido { get; set; }

        [DataMember]
        public string Origen { get; set; }

        [DataMember]
        public IEnumerable<BEClienteRecordatorio> Recordatorios { get; set; }

        public List<BEClienteContactoDB> Contactos { get; set; }
    }
}
