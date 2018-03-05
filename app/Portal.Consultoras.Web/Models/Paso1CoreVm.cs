using System.Web.Mvc;

namespace Portal.Consultoras.Web.Models
{
    public class Paso1CoreVm : BaseVM
    {
        public virtual string PrimerNombre { get; set; }
        public virtual string SegundoNombre { get; set; }
        public virtual string ApellidoPaterno { get; set; }
        public virtual string ApellidoMaterno { get; set; }
        public virtual string NumeroDocumento { get; set; }
        public virtual string CorreoElectronico { get; set; }
        public virtual string Anio { get; set; }
        public virtual string Mes { get; set; }
        public virtual string Dia { get; set; }

        public SelectList Anios { get; set; }
        public SelectList Meses { get; set; }
        public SelectList Dias { get; set; }
        public SelectList Generos { get; set; }
    }
}