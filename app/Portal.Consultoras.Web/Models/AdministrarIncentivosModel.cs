using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarIncentivosModel
    {
        public int IncentivoID { get; set; }
        public int PaisID { set; get; }
        public string PaisNombre { set; get; }
        public int CampaniaIDInicio { set; get; }
        public int CampaniaIDFin { set; get; }
        public long ConsultoraID { set; get; }
        public string Titulo { set; get; }
        public string Subtitulo { set; get; }
        public string ArchivoPortada { set; get; }
        public string ArchivoPortadaAnterior { set; get; }
        public string ArchivoPDF { set; get; }
        public string Url { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public string grupoUrlPDF { get; set; }

        public AdministrarIncentivosModel()
        {
            this.ArchivoPDF = string.Empty;
            this.Url = string.Empty;
        }
    }
}