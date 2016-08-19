using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Models
{
    public class Paso2CoreVm : BaseVM
    {
        public virtual string Telefono { get; set; }
        public virtual string Celular { get; set; }
        public virtual string Region { get; set; }
        public virtual string Comuna { get; set; }
        public virtual string CalleOAvenida { get; set; }
        public virtual string DptoCasa { get; set; }
        public virtual string Numero { get; set; }


        public string Direccion { get; set; }
        public string Area { get; set; }
        public string Ciudad { get; set; }
        public bool ConsultoServicioGEO { get; set; }
        public List<Tuple<decimal, decimal, string>> Puntos { get; set; }
        public SelectList LugaresPadre { get; set; }
        public SelectList LugaresHijo { get; set; }
        public SelectList DireccionesCo { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public char? DireccionCorrecta { get; set; }

        public Paso2CoreVm()
        {
            Puntos = new List<Tuple<decimal, decimal, string>>();
        }
    }
}