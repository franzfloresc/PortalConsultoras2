﻿using Portal.Consultoras.Common;
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
            if (DataRecord.HasColumn(row, "ProveedorDespachoCobranzaID"))
                ProveedorDespachoCobranzaID = Convert.ToInt32(row["ProveedorDespachoCobranzaID"]);
            if (DataRecord.HasColumn(row, "NombreComercial"))
                NombreComercial = Convert.ToString(row["NombreComercial"]);
            if (DataRecord.HasColumn(row, "RazonSocial"))
                RazonSocial = Convert.ToString(row["RazonSocial"]);
            if (DataRecord.HasColumn(row, "RFC"))
                RFC = Convert.ToString(row["RFC"]);
            if (DataRecord.HasColumn(row, "NombreSocios"))
                NombreSocios = Convert.ToString(row["NombreSocios"]);
            if (DataRecord.HasColumn(row, "RepresentanteLegales"))
                RepresentanteLegales = Convert.ToString(row["RepresentanteLegales"]);
            if (DataRecord.HasColumn(row, "DomicilioFiscal"))
                DomicilioFiscal = Convert.ToString(row["DomicilioFiscal"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "Telefonos"))
                Telefonos = Convert.ToString(row["Telefonos"]);
            if (DataRecord.HasColumn(row, "CorreosElectronicos"))
                CorreosElectronicos = Convert.ToString(row["CorreosElectronicos"]);
            if (DataRecord.HasColumn(row, "PaginaElectronica"))
                PaginaElectronica = Convert.ToString(row["PaginaElectronica"]);
            if (DataRecord.HasColumn(row, "NombreEjecutivos"))
                NombreEjecutivos = Convert.ToString(row["NombreEjecutivos"]);

            if (DataRecord.HasColumn(row, "valor"))
                Valor = Convert.ToString(row["valor"]);
            if (DataRecord.HasColumn(row, "campoid"))
                CampoId = Convert.ToInt16(row["campoid"]);
            if (DataRecord.HasColumn(row, "nombrecampo"))
                NombreCampo = Convert.ToString(row["nombrecampo"]);
        }


    }

}
