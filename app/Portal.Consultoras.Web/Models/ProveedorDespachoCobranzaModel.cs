using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ProveedorDespachoCobranzaModel
    {
        public int PaisID { get; set; }
        public int ProveedorDespachoCobranzaID { get; set; }
        public string NombreComercial { get; set; }
        public string RazonSocial { get; set; }
        public string RFC { get; set; }
        public string NombreSocios { get; set; }
        public string RepresentanteLegales { get; set; }
        public string DomicilioFiscal { get; set; }
        public string Direccion { get; set; }
        public string Telefonos { get; set; }
        public string CorreosElectronicos { get; set; }
        public string PaginaElectronica { get; set; }
        public string NombreEjecutivos { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<ProveedorDespachoCobranzaModel> lstProveedores { get; set; }

        public string Valor { get; set; }
        public string ValorAnterior { get; set; }
        public int Accion { get; set; }
        public int CampoId { get; set; }

        public IEnumerable<Campo> lstCampo { set; get; }

        public ProveedorDespachoCobranzaModel()
        {
            this.lstCampo = new List<Campo>
            {
                new Campo { Campoid = 1, Nombre= "NombreSocios",CantidadRegistros =7,CampoSimple=1},
                new Campo { Campoid = 2, Nombre= "RepresentanteLegales",CantidadRegistros =7,CampoSimple=1},
                new Campo { Campoid = 3, Nombre= "DomicilioFiscal",CantidadRegistros =1,CampoSimple=0},
                new Campo { Campoid = 4, Nombre= "Direccion",CantidadRegistros =1,CampoSimple=0},
                new Campo { Campoid = 5, Nombre= "Telefonos",CantidadRegistros =500,CampoSimple=1},
                new Campo { Campoid = 6, Nombre= "CorreosElectronicos",CantidadRegistros =7,CampoSimple=1},
                new Campo { Campoid = 7, Nombre= "PaginaElectronica",CantidadRegistros =3,CampoSimple=1},
                new Campo { Campoid = 8, Nombre= "NombreEjecutivos",CantidadRegistros =50,CampoSimple=1}
            };
        }

    }

    public class Campo
    {
        public int Campoid { get; set; }
        public string Nombre { get; set; }
        public int CantidadRegistros { get; set; }
        public int CampoSimple { get; set; }
    }
}