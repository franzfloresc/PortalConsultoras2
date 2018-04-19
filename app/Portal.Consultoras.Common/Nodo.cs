using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class Nodo<T>
    {
        public Nodo(T actual)
        {
            Padres = new List<Nodo<T>>();
            Hijos = new List<Nodo<T>>();
            Actual = actual;
        }

        public List<Nodo<T>> Padres { get; set; }
        public List<Nodo<T>> Hijos { get; set; }
        public T Actual { get; set; }

        public void AddHijo(Nodo<T> hijo)
        {
            Hijos.Add(hijo);
            hijo.Padres.Add(this);
        }

        public void AddPadre(Nodo<T> padre)
        {
            Padres.Add(padre);
            padre.Hijos.Add(this);
        }
    }
}
