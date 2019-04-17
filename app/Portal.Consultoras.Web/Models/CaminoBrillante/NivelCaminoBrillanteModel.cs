﻿using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class NivelCaminoBrillanteModel
    {
        public string CodigoNivel { get; set; }
        public string DescripcionNivel { get; set; }
        public string MontoMinimo { get; set; }
        public string MontoMaximo { get; set; }
        public decimal? MontoFaltante { get; set; }
        public bool TieneOfertasEspeciales { get; set; }
        public List<BeneficioCaminoBrillanteModel> Beneficios { get; set; }
        public bool EsPasado { get; set; }
        public string UrlImagenNivel
        {
            get
            {
                if (Constantes.CaminoBrillante.Niveles.Iconos.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Iconos[CodigoNivel][EsPasado ? 1 : 0];
                return null;
            }
        }

        public class BeneficioCaminoBrillanteModel{

            public string CodigoNivel { get; set; }
            public string CodigoBeneficio { get; set; }
            public string NombreBeneficio { get; set; }
            public string Descripcion { get; set; }
            public string Icono { get; set; }
            public string UrlIcono
            {
                get
                {
                    if (Constantes.CaminoBrillante.Beneficios.Iconos.ContainsKey(Icono))
                        return Constantes.CaminoBrillante.Beneficios.Iconos[Icono];
                    return null;
                }
            }

        }
    }
}