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

        public BECliente(IDataRecord row)
        {
            ConsultoraID = row.ToInt64("ConsultoraID");
            ClienteID = row.ToInt32("ClienteID");
            Nombre = row.ToString("Nombre");
            eMail = row.ToString("eMail");
            Activo = row.ToBoolean("Activo");
            Telefono = row.ToString("Telefono");
            Celular = row.ToString("Celular");
            CodigoCliente = row.ToInt64("CodigoCliente");
            Favorito = row.ToInt16("Favorito");
            TipoContactoFavorito = row.ToInt16("TipoContactoFavorito");
            NombreCliente = row.ToString("NombreCliente");
            ApellidoCliente = row.ToString("ApellidoCliente");
            Saldo = row.ToDecimal("Saldo");
            CantidadProductos = row.ToInt32("CantidadProductos");
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
