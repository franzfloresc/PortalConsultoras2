
﻿using Portal.Consultoras.Common;
using System;
using System.Data;

using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppHistoria
    {
        [DataMember]
        public int IdContenido { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string UrlMiniatura { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public int DesdeCampania { get; set; }

        [DataMember]
        public int CantidadContenido { get; set; }

        [DataMember]
        public string RutaImagen { get; set; }

        public BEContenidoAppHistoria(IDataRecord row)
        {
            IdContenido = row.ToInt32("IdContenido");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
            UrlMiniatura = row.ToString("UrlMiniatura");
            Estado = row.ToInt32("Estado");
            DesdeCampania = row.ToInt32("DesdeCampania");
            CantidadContenido = row.ToInt32("CantidadContenido");
            RutaImagen = row.ToString("RutaImagen");
        }

        public BEContenidoAppHistoria()
        {

        }

    }
}

