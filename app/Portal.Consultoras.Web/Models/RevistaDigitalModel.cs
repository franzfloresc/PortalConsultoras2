using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalModel
    {
        public RevistaDigitalModel()
        {
            SuscripcionModel = new RevistaDigitalSuscripcionModel();
            SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel();
            SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel();
            ListaTabs = new List<ComunModel>();
            NombreRevista = "SABER MÁS DE {0}ÉSIKA PARA MÍ";
            DiasAntesFacturaHoy = -1;
            EstadoRdcAnalytics = "(not available)";
        }

        public int EstadoSuscripcion { get; set; }
        public int EstadoAccion { get; set; }
        public List<ComunModel> ListaTabs { get; set; }
        public bool NoVolverMostrar { get; set; }
        public string NombreRevista { get; set; }
        public string Titulo { get; set; }
        public string TituloDescripcion { get; set; }
        public int Campania { get; set; }
        public int CampaniaMasUno { get; set; }
        public int CampaniaMasDos { get; set; }
        public string NumeroContacto { get; set; }
        public bool TieneRDR { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneRDS { get; set; }
        public int DiasAntesFacturaHoy { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior2Model { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior1Model { get; set; }
        public bool BloqueoRevistaImpresa { get; set; }
        public string EstadoRdcAnalytics { get; set; }

        public bool EsSuscritaInactiva()
        {
            return TieneRDC &&
                SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo &&
                //SuscripcionAnterior1Model.EstadoRegistro != Constantes.EstadoRDSuscripcion.Desactivo &&
                SuscripcionAnterior2Model.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo;
            ;
        }

        public bool EsSuscritaActiva()
        {
            return TieneRDC &&
                SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo &&
                SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
        }

        public bool EsNoSuscrita()
        {
            return TieneRDC &&
                SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo &&
                SuscripcionAnterior2Model.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo;
        }
    }
}