using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaProductoComentarioModel
    {
        public long ProdComentarioDetalleId { get; set; }
        public int ProdComentarioId { get; set; }
        public Int16 Valorizado { get; set; }
        public bool Recomendado { get; set; }
        public string Comentario { get; set; }
        public string CodigoConsultora { get; set; }
        public int CampaniaID { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string FechaRegistroFormateada { get; set; }
        public DateTime FechaAprobacion { get; set; }
        public int CodTipoOrigen { get; set; }
        public Int16 Estado { get; set; }
        public string CodigoSAP { get; set; }
        public string CodigoGenerico { get; set; }
        public string URLFotoConsultora { get; set; }
        public string NombreConsultora { get; set; }
    }
}