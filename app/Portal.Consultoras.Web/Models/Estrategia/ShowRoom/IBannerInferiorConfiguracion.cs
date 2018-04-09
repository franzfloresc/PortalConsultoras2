using System.Collections.Generic;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    public interface IBannerInferiorConfiguracion
    {
        bool Activo { get; set; }

        /// <summary>
        /// Rutas parciales donde no se mostrara
        /// </summary>
        IEnumerable<string> RutasParcialesExcluidas { get; set; }
        string UrlImagen { get; set; }
        string UrlRedireccion { get; set; }

        /// <summary>
        /// Determina si se mostrar o no de acuerdo a las rutas parciales excluidas
        /// </summary>
        /// <param name="request">Web Request</param>
        /// <returns>True si se muestra, false caso contrario</returns>
        bool SeDebeMostrar(HttpRequestBase request);
    }
}