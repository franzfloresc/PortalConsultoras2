using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.DetalleEstrategia
{
    public class BreadCrumbModel
    {
        public string Texto { get; set; }
        public string Url { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;

            var breadcrumb = (BreadCrumbModel)obj;

            return this.Texto == breadcrumb.Texto &&
                this.Url == breadcrumb.Url;
        }
    }
}