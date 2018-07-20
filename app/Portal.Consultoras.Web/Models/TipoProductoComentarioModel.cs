using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class TipoProductoComentarioModel
    {
        readonly Enumeradores.TipoProductoComentario _tipoComentario;

        public TipoProductoComentarioModel(Enumeradores.TipoProductoComentario tipoComentario)
        {
            this._tipoComentario = tipoComentario;
            this.TipoComentarioProductoId = (int)_tipoComentario;
            this.Nombre = _tipoComentario.ToString();
        }

        public int TipoComentarioProductoId { get; private set; }
        public string Nombre { get; private set; }
    }
}