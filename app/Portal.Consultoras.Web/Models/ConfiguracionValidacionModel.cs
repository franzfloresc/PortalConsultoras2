using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionValidacionModel
    {
        public int PaisID { set; get; }
        public Int16 DiasAntes { set; get; }
        public TimeSpan HoraInicio { set; get; }
        public TimeSpan HoraFin { set; get; }
        public TimeSpan HoraInicioNoFacturable { set; get; }
        public TimeSpan HoraCierreNoFacturable { set; get; }
        public IEnumerable<ConfiguracionValidacionZonaModel> listaZonasActivas { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int CampaniaID { set; get; }
        public int FlagRegistro { set; get; }
        public bool FlagNoValidados { set; get; }
        public Int16 ProcesoRegular { set; get; }
        public Int16 ProcesoDA { set; get; }
        public Int16 ProcesoDAPRD { set; get; }
        public Int16 DiasDuracionCronograma { get; set; }
        public bool HabilitarRestriccionHoraria { get; set; }
    }
}