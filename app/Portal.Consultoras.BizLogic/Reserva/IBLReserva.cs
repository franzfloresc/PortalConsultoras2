﻿using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;

namespace Portal.Consultoras.BizLogic
{
    public interface IBLReserva
    {
        string CargarSesionAndDeshacerPedidoValidado(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, string tipo);
        Task<BEResultadoReservaProl> CargarSesionAndEjecutarReservaProl(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo);
        string DeshacerPedidoValidado(BEUsuario usuario, string tipo);
        Task<BEResultadoReservaProl> EjecutarReservaProl(BEInputReservaProl input);
        bool EnviarCorreoReservaProl(BEInputReservaProl input);
        int InsertarDesglose(BEInputReservaProl input);
    }
}