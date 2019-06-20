using Portal.Consultoras.Common;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class LogroCaminoBrillanteModel
    {
        public string Id { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public List<IndicadorCaminoBrillanteModel> Indicadores { get; set; }

        public class IndicadorCaminoBrillanteModel
        {
            public string Codigo { get; set; }
            public string Titulo { get; set; }
            public string Descripcion { get; set; }
            public List<MedallaCaminoBrillanteModel> Medallas { get; set; }

            public class MedallaCaminoBrillanteModel
            {
                public string Id { get; set; }
                public string Tipo { get; set; }
                public string Titulo { get; set; }
                public string Subtitulo { get; set; }
                public string Valor { get; set; }
                public bool Estado { get; set; }
                public string ModalTitulo { get; set; }
                public string ModalDescripcion { get; set; }
                public string UrlMedalla { get { return buildMedalla(Tipo, Valor, Estado, false); } }
                public string UrlMedallaFull { get { return buildMedalla(Tipo, Valor, true, true); } }

                private string buildMedalla(string tipo, string valor, bool estado, bool full)
                {
                    if (string.IsNullOrEmpty(tipo)) return string.Empty;
                    switch (tipo)
                    {
                        case Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.NIV:
                            return Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Niveles.ContainsKey(valor) ?
                                Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Niveles[valor][estado ? 1 : 0] : string.Empty;
                        case Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PIE:
                            if (full)
                            {
                                return Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Constancia["6"];
                            }
                            if (valor == null) return string.Empty;
                            var parts = valor.Split('-');
                            if (parts.Length < 3) return string.Empty;
                            var key = parts[2];
                            return Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Constancia.ContainsKey(key) ?
                                Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Constancia[key] : string.Empty;
                        case Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.TIM:
                            return estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Corazon["1"] :
                                Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Corazon["0"];
                        case Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PED:
                            return estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Pedido["1"] :
                                Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Pedido["0"];
                        default:
                            return string.Empty;
                    }
                }

            }

        }

    }

}