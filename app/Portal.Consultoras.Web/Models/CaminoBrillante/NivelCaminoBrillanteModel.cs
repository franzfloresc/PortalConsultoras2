using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class NivelCaminoBrillanteModel
    {
        public string CodigoNivel { get; set; }
        public string DescripcionNivel { get; set; }
        public string MontoMinimo { get; set; }
        public string MontoMaximo { get; set; }
        public decimal? MontoAcumulado { get; set; }
        public decimal? MontoFaltante { get; set; }
        public bool TieneOfertasEspeciales { get; set; }
        public int EnterateMas { get; set; }
        public string EnterateMasParam { get; set; }
        public List<BeneficioCaminoBrillanteModel> Beneficios { get; set; }
        public bool EsPasado { get; set; }
        public bool EsActual { get; set; }
        public string UrlImagenNivel
        {
            get
            {
                if (CodigoNivel != null && Constantes.CaminoBrillante.Niveles.Iconos.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Iconos[CodigoNivel][EsPasado ? 1 : 0];
                return null;
            }
        }
        public string UrlImagenNivelFull
        {
            get
            {
                if (CodigoNivel != null &&  Constantes.CaminoBrillante.Niveles.Iconos.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Iconos[CodigoNivel][1];
                return null;
            }
        }
        public int Puntaje { get; set; }
        public int? PuntajeAcumulado { get; set; }

        public List<BeneficioCaminoBrillanteModel> BeneficiosShow
        {
            get
            {
                if (Beneficios == null) return null;
                return Beneficios.Take(3).ToList();
            }
        }

        public List<BeneficioCaminoBrillanteModel> BeneficiosHide
        {
            get
            {
                if (Beneficios == null) return null;
                return Beneficios.Skip(3).ToList();
            }
        }

        public decimal MontoAlcanzado { get {
                if (MontoAcumulado == null) return 0;
                if (MontoAcumulado.HasValue) return MontoAcumulado.Value;
                return 0;
            } }

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
                    if (Icono!= null && Constantes.CaminoBrillante.Beneficios.Iconos.ContainsKey(Icono))
                        return Constantes.CaminoBrillante.Beneficios.Iconos[Icono];
                    return null;
                }
            }
        }
    }
}