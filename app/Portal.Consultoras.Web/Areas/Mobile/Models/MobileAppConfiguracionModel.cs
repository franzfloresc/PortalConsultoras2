﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable]
    public class MobileAppConfiguracionModel
    {
        /// <summary>
        /// Establece si se mostrara o no el boton atras en las vistas
        /// </summary>
        public bool MostrarBotonAtras { get; set; }
        public int ClienteID { get; set; }

        /// <summary>
        /// Determina si se muestra o no un hipervinculo
        /// </summary>
        public bool MostrarHipervinculo { get; set; }

        public MobileAppConfiguracionModel()
        {
            MostrarBotonAtras = true;
            MostrarHipervinculo = true;
        }
    }
}
