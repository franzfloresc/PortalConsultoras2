using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class LogroCaminoBrillanteModel
    {
        public string Id { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public List<IndicadorCaminoBrillanteModel> Indicadores { get; set; }
    }

    public class IndicadorCaminoBrillanteModel
    {
        //public int Orden { get; set; }
        public string Codigo { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public List<MedallaCaminoBrillanteModel> Medallas { get; set; }

    }

    public class MedallaCaminoBrillanteModel
    {
        //public int Orden { get; set; }
        public string Id { get; set; }
        public string Tipo { get; set; }
        public string Titulo { get; set; }
        public string Subtitulo { get; set; }
        public string Valor { get; set; }
        public bool Estado { get; set; }
        public string ModalTitulo { get; set; }
        public string ModalDescripcion { get; set; }
        //public decimal MontoSuperior { get; set; }
        //public string DescripcionNivel { get; set; }
        //public string MontoAcumulado { get; set; }
        public string UrlMedalla { get {
                return null;
            } }
        public string UrlMedallaFull {
            get
            {
                return null;
            }
        }
    }

}