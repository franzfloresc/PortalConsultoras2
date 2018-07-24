using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{

    [DataContract]
    public class BEProveedorDespachoCobranza
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int ProveedorDespachoCobranzaID { get; set; }
        [DataMember]
        public string NombreComercial { get; set; }
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string RFC { get; set; }
        [DataMember]
        public string NombreSocios { get; set; }
        [DataMember]
        public string RepresentanteLegales { get; set; }
        [DataMember]
        public string DomicilioFiscal { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string Telefonos { get; set; }
        [DataMember]
        public string CorreosElectronicos { get; set; }
        [DataMember]
        public string PaginaElectronica { get; set; }
        [DataMember]
        public string NombreEjecutivos { get; set; }
        [DataMember]
        public string Valor { get; set; }
        [DataMember]
        public string ValorAnterior { get; set; }
        [DataMember]
        public int Accion { get; set; }
        [DataMember]
        public int CampoId { get; set; }
        [DataMember]
        public string NombreCampo { get; set; }

        public BEProveedorDespachoCobranza() { }
        public BEProveedorDespachoCobranza(IDataRecord row)
        {
            ProveedorDespachoCobranzaID = row.ToInt32("ProveedorDespachoCobranzaID");
            NombreComercial = row.ToString("NombreComercial");
            RazonSocial = row.ToString("RazonSocial");
            RFC = row.ToString("RFC");
            NombreSocios = row.ToString("NombreSocios");
            RepresentanteLegales = row.ToString("RepresentanteLegales");
            DomicilioFiscal = row.ToString("DomicilioFiscal");
            Direccion = row.ToString("Direccion");
            Telefonos = row.ToString("Telefonos");
            CorreosElectronicos = row.ToString("CorreosElectronicos");
            PaginaElectronica = row.ToString("PaginaElectronica");
            NombreEjecutivos = row.ToString("NombreEjecutivos");
            Valor = row.ToString("valor");
            CampoId = row.ToInt16("campoid");
            NombreCampo = row.ToString("nombrecampo");
        }


    }

}
