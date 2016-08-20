using System.Collections.Generic;
using CORP.BEL.Unete.UI.UB.GestionPasos;
using Portal.Consultoras.Web.GestionPasos.Ejecuciones;
using Portal.Consultoras.Web.GestionPasos.Validaciones;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos
{
    public static class ValidationFactory
    {
        public static Dictionary<string, Ejecucion3Pasos> ValidacionPaises = new Dictionary<string, Ejecucion3Pasos>();

        static ValidationFactory()
        {
            ValidacionPaises.Add("CO", new Ejecucion3Pasos
            {
                Paso1 = new ValidationPaso<Paso1CoreVm>
                {
                    Validaciones = new List<IValidation<Paso1CoreVm>>
                    {
                        new MayorDeEdadValidation(),
                        new SolicitudPendienteValidation(),
                        new YaEsConsultoraValidation(),
                        new EvaluacionCrediticiaInternaValidation()
                    }
                },

                Paso2 = new ValidationPaso<Paso2CoreVm>
                {
                    Validaciones = new List<IValidation<Paso2CoreVm>>
                    {
                        //new GeoLocalizacionLocalValidation()
                    }
                },
                Paso3 = new EjecucionPaso<Paso3CoreVm, SolicitudPostulante>()
                {
                    Ejecuciones = new List<IEjecucion<Paso3CoreVm, SolicitudPostulante>>
                    {
                        new ObtenerDatosConsultoraRecomendadaEjecucion(),
                        new AsignarValidacionTelefonicaEjecucion(),
                        new ObtenerDatosAdicionalesEjecucion(),
                        new GuardarActualizarEjecucion(),
                        new GeoLocalizacionLocalEjecucion
                        {
                            OperacionesSiguientes =
                                new List<IEjecucion<Paso3CoreVm, SolicitudPostulante>>
                                {
                                    new ObtenerEvaluacionCrediticiaColombiaEjecucion(),
                                    new ObtenerEstadoPostulanteEjecucion(),
                                    new GuardarActualizarEjecucion(),
                                    new ObtenerEnvioCorreoGerenteZonaEjecucion()
                                }
                        }
                    }
                }
            });

            ValidacionPaises.Add("CL", new Ejecucion3Pasos
            {
                Paso1 = new ValidationPaso<Paso1CoreVm>
                {
                    Validaciones = new List<IValidation<Paso1CoreVm>>
                    {
                        new MayorDeEdadValidation(),
                        new SolicitudPendienteValidation(),
                        new YaEsConsultoraValidation()
                    }
                },
                Paso2 = new ValidationPaso<Paso2CoreVm>
                {
                    Validaciones = new List<IValidation<Paso2CoreVm>>
                    {
                        new GeoLocalizacionValidation()
                    }
                },
                Paso3 = new EjecucionPaso<Paso3CoreVm, SolicitudPostulante>()
                {
                    Ejecuciones = new List<IEjecucion<Paso3CoreVm, SolicitudPostulante>>
                    {
                        new ObtenerTerritorioEjecucion(),
                        new ObtenerDatosConsultoraRecomendadaEjecucion(),
                        new AsignarValidacionTelefonicaEjecucion(),
                        new ObtenerEvaluacionCrediticiaChileEjecucion(),
                        new ObtenerEstadoPostulanteEjecucion(),
                        new ObtenerDatosAdicionalesEjecucion(),
                        new GuardarActualizarEjecucion(),
                        new ObtenerEnvioCorreoGerenteZonaEjecucion()
                    }
                }
            });

            ValidacionPaises.Add("MX", new Ejecucion3Pasos
            {
                Paso1 = new ValidationPaso<Paso1CoreVm>
                {
                    Validaciones = new List<IValidation<Paso1CoreVm>>
                    {
                        new MayorDeEdadValidation(),
                        new SolicitudPendienteValidation(),
                        new YaEsConsultoraValidation()
                    }
                },
                Paso2 = new ValidationPaso<Paso2CoreVm>
                {
                    Validaciones = new List<IValidation<Paso2CoreVm>>
                    {
                        new GeoLocalizacionValidation()
                    }
                },
                Paso3 = new EjecucionPaso<Paso3CoreVm, SolicitudPostulante>()
                {
                    Ejecuciones = new List<IEjecucion<Paso3CoreVm, SolicitudPostulante>>
                    {
                        new ObtenerTerritorioEjecucion(),
                        new ObtenerDatosConsultoraRecomendadaEjecucion(),
                        new ObtenerEvaluacionCrediticiaMexicoEjecucion(),
                        new ObtenerEstadoPostulanteEjecucion(),
                        new ObtenerDatosAdicionalesEjecucion(),
                        new GuardarActualizarEjecucion(),
                        new ObtenerEnvioCorreoGerenteZonaEjecucion()
                    }
                }
            });
        }
    }
}