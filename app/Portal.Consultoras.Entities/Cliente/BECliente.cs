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
        public BECliente()
        {
            Nombre = string.Empty;
            eMail = string.Empty;
            Telefono = string.Empty;
            Celular = string.Empty;
            CodigoCliente = 0;
            Favorito = 0;
            TipoContactoFavorito = 0;

            NombreCliente = string.Empty;
            ApellidoCliente = string.Empty;
        }

        public BECliente(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);

            if (DataRecord.HasColumn(datarec, "ClienteID"))
                ClienteID = Convert.ToInt32(datarec["ClienteID"]);

            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = Convert.ToString(datarec["Nombre"]);

            if (DataRecord.HasColumn(datarec, "eMail"))
                eMail = Convert.ToString(datarec["eMail"]);

            if (DataRecord.HasColumn(datarec, "Activo"))
                Activo = Convert.ToBoolean(datarec["Activo"]);

            if (DataRecord.HasColumn(datarec, "Telefono"))
                Telefono = Convert.ToString(datarec["Telefono"]);

            if (DataRecord.HasColumn(datarec, "Celular"))
                Celular = Convert.ToString(datarec["Celular"]);

            if (DataRecord.HasColumn(datarec, "CodigoCliente"))
                CodigoCliente = Convert.ToInt64(datarec["CodigoCliente"]);

            if (DataRecord.HasColumn(datarec, "Favorito"))
                Favorito = Convert.ToInt16(datarec["Favorito"]);

            if (DataRecord.HasColumn(datarec, "TipoContactoFavorito"))
                TipoContactoFavorito = Convert.ToInt16(datarec["TipoContactoFavorito"]);

            if (DataRecord.HasColumn(datarec, "NombreCliente"))
                NombreCliente = Convert.ToString(datarec["NombreCliente"]);

            if (DataRecord.HasColumn(datarec, "ApellidoCliente"))
                ApellidoCliente = Convert.ToString(datarec["ApellidoCliente"]);

            if (DataRecord.HasColumn(datarec, "Saldo"))
                Saldo = Convert.ToDecimal(datarec["Saldo"]);

            if (DataRecord.HasColumn(datarec, "CantidadProductos"))
                CantidadProductos = Convert.ToInt32(datarec["CantidadProductos"]);
        }

        [DataMember]
        public string NombreCliente { get; set; }

        [DataMember]
        public string ApellidoCliente { get; set; }

        [DataMember]
        public int Pagina { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        [Column("ClienteID")]
        public int ClienteID { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string eMail { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string Telefono { get; set; }

        [DataMember]
        public string Celular { get; set; }

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
        public long CodigoCliente { get; set; }

        [DataMember]
        public short Favorito { get; set; }

        [DataMember]
        public short TipoContactoFavorito { get; set; }

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
