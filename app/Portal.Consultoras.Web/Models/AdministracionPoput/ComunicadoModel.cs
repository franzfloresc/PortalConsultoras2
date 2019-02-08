using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.AdministracionPoput
{
    public class ComunicadoModel
    {
        public int ComunicadoId { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string Descripcion { get; set; }
        public bool Activo { get; set; }
        public string CodigoCampania { get; set; }
        public string Accion { get; set; }
        public string DescripcionAccion { get; set; }
        public int SegmentacionID { get; set; }
        public string UrlImagen { get; set; }
        public string Url{ get; set; }
        public string NombreImagen { get; set; }
        public string Titulo { get; set; }
        public int Orden { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public bool SegmentacionConsultora { get; set; }
        public bool SegmentacionRegionZona { get; set; }
        public bool SegmentacionEstadoActividad { get; set; }
        public int CampaniaID { get; set; }
        public int Numero { get; set; }
        public string FechaInicio_ { get; set; }
        public string FechaFin_ { get; set; }
        public string NombreArchivoCCV { get; set; }
        public int TipoDispositivo { get; set; }
        public IEnumerable<SegmentacionComunicadoModel> ListaSegmentacionComunicado { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { get; set; }

    }


    public class Archivo
    {
        public int RegionId { get; set; }
        public int ZonaId{ get; set; }
        public int Estado { get; set; }
        public int Consultoraid{ get; set; }
    }
   
}