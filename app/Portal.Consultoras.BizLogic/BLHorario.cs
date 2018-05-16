using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLHorario
    {
        public BLHorario() { }

        public BEHorario GetHorarioByCodigo(int paisID, string codigo, bool loadEstaDisponible = true)
        {
            var dAHorario = new DAHorario(paisID);
            var horario = dAHorario.GetHorarioByCodigo(codigo);
            if (horario != null && loadEstaDisponible) horario.EstaDisponible = dAHorario.HorarioEstaDisponible(codigo);
            return horario;
        }
    }
}
