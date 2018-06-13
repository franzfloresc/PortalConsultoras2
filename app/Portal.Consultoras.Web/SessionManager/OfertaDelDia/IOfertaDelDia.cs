using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;

namespace Portal.Consultoras.Web.SessionManager.OfertaDelDia
{
    public interface IOfertaDelDia
    {
        DataModel Estrategia { get; set; }
    }
}
