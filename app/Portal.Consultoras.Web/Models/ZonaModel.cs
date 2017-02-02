﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class ZonaModel
    {
        public int RegionID
        {
            get;
            set;
        }

        public int ZonaID
        {
            get;
            set;
        }
        public string Codigo
        {
            get;
            set;
        }
        public string Nombre
        {
            get;
            set;
        }

        //R20151221 - view

        public int DiasParametroCarga
        {
            get;
            set;
        }

        //R20151221 - Fín
    }
}