using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class GestionaPostulanteModel
    {
        public string CodigoIso { get; set; }
        public int PrefijoISOPais { get; set; }

        public string FechaDesde { get; set; }

        public string FechaHasta { get; set; }

        public string Nombre { get; set; }

        public int Estado { get; set; }

        public string DocumentoIdentidad { get; set; }

        public string sidx { get; set; }

        public string sord { get; set; }

        public int page { get; set; }

        public int rows { get; set; }

        public string CodigoZona { get; set; }
        public string CodigoRegion { get; set; }
        public string FuenteIngreso { get; set; }
        public List<FuenteIngresoModel> FuenteIngresoListAvailable { get; set; }
    }

    public class FuenteIngresoModel
    {
        public string ID { get; set; }
        public string Descripcion { get; set; }

        public bool IsSelected { get; set; }
        public string Titulo { get; set; }
    }
}