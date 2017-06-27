using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;
using static Portal.Consultoras.Common.Enumeradores;

namespace Portal.Consultoras.Web.Models
{
    public class EstadoProductoComentarioModel
    {
        private Enumeradores.EstadoProductoComentario _estado;

        public EstadoProductoComentarioModel(EstadoProductoComentario estado)
        {
            this._estado = estado;
            EstadoComentarioProductoId = (int)this._estado;
            Nombre = this._estado.ToString();
        }

        public int EstadoComentarioProductoId { get; private set; }
        public string Nombre { get; private set; }
    }
}