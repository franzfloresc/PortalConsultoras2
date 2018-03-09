using Portal.Consultoras.Web.ServiceZonificacion;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ReportePedidoDDWebModel
    {
        public int PaisID { get; set; }
        public string NombreCampania { set; get; }
        public string NombreRegion { set; get; }
        public string NombreZona { set; get; }
        public string lblCampaniaCod { set; get; }
        public string lblConsultoraCod { set; get; }
        public string lblConsultoraNombre { set; get; }
        public string lblUsuarioNombre { set; get; }
        public string lblOrigen { set; get; }
        public string lblValidado { set; get; }
        public string lblSaldo { set; get; }
        public string lblImporte { set; get; }
        public string lblImporteConDescuento { set; get; }
        public string hdnpaisISO { set; get; }
        public string Usuario { get; set; }
        public string TipoProceso { get; set; }
        public string Zona { get; set; }
        public string IndicadorEnviado { get; set; }

        public List<BECampania> DropDownListCampania { get; set; }
        public List<BEZona> DropDownListZona { get; set; }
        public List<BERegion> DropDownListRegion { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }

        public string vpage { set; get; }
        public string vsortname { set; get; }
        public string vsortorder { set; get; }
        public string vrowNum { set; get; }
        public string MotivoRechazo { get; set; }
    }
}