﻿using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;
using System.Web;
using static Portal.Consultoras.Common.Constantes;

namespace Portal.Consultoras.Web.Providers
{
    public class MiPerfilProvider
    {
        protected ISessionManager sessionManager;

        public MiPerfilProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public List<UsuarioOpcionesModel> GetUsuarioOpciones(int paisId, string codigoUsuario , bool sesion)
        {
            var datos = sesion ? sessionManager.GetUsuarioOpciones() : null;
            if (datos == null)
            {
                datos = ObtenerUsuarioOpciones(paisId, codigoUsuario);
                if (sesion)
                {
                    sessionManager.SetUsuarioOpciones(datos);
                }
            }
            return datos;
        }
        public List<ParametroUneteBE> ObtenerUbigeoPrincipal(string CodigoISO)
        {
            List<ParametroUneteBE> result;
            int IdPadre = 0;
            using (var sv = new PortalServiceClient())
            {
                
                result =  sv.ObtenerParametrosUnete(CodigoISO, EnumsTipoParametro.LugarNivel1, IdPadre);
            }

            return result;
        }

        public virtual List<UsuarioOpcionesModel> ObtenerUsuarioOpciones(int paisId, string codigoUsuario)
        {
            using (var usuario = new UsuarioServiceClient())
            {
                var datos = usuario.GetUsuarioOpciones(paisId, codigoUsuario);
                return Mapper.Map<IEnumerable<BEUsuarioOpciones>, List<UsuarioOpcionesModel>>(datos);
            }
        }
        public async Task<List<ParametroUneteBE>> ObtenerUbigeoDependiente(string CodigoISO , int Nivel , int IdPadre)
        {
            List<ParametroUneteBE> result;
            using (var sv = new PortalServiceClient())
            {
                EnumsTipoParametro NivelEnumerado = (EnumsTipoParametro)Nivel;
                result = await sv.ObtenerParametrosUneteAsync(CodigoISO, NivelEnumerado, IdPadre);
            }

            return result;
        }
        public DireccionEntregaModel ObtenerDireccionPorConsultora(DireccionEntregaModel Direccion)
        {

            BEDireccionEntrega BlEntidad;
            DireccionEntregaModel response;
            var request = Mapper.Map<BEDireccionEntrega>(Direccion);
            using (var sv = new UsuarioServiceClient())
            {
                BlEntidad =sv.ObtenerDireccionPorConsultora(request);
            }
            response = Mapper.Map<DireccionEntregaModel>(BlEntidad);
            response.Operacion = response.DireccionEntregaID == OperacionBD.Insertar ? OperacionBD.Insertar : OperacionBD.Editar;
            return response;

        }

        public async Task<DireccionEntregaModel> ObtenerDireccionPorConsultoraAsync(DireccionEntregaModel Direccion)
        {

            BEDireccionEntrega BlEntidad;
            DireccionEntregaModel response;
            var request = Mapper.Map<BEDireccionEntrega>(Direccion);
            using (var sv = new UsuarioServiceClient())
            {
                BlEntidad = await sv.ObtenerDireccionPorConsultoraAsync(request);
            }
            response = Mapper.Map<DireccionEntregaModel>(BlEntidad);
            response.Operacion = response.DireccionEntregaID == OperacionBD.Insertar ? OperacionBD.Insertar : OperacionBD.Editar;
            return response;

        }
    
        private async Task<BEDireccionEntrega> BinderDireccionAsync(DireccionEntregaModel model)
        {
            var entidad = Mapper.Map<DireccionEntregaModel, BEDireccionEntrega>(model);

            if (model.Operacion == OperacionBD.Editar)
            {
                DireccionEntregaModel direccionAnterior = await ObtenerDireccionPorConsultoraAsync(model);
                entidad.Ubigeo1Anterior = direccionAnterior.Ubigeo1;
                entidad.Ubigeo2Anterior = direccionAnterior.Ubigeo2;
                entidad.Ubigeo3Anterior = direccionAnterior.Ubigeo3;
                entidad.DireccionAnterior = direccionAnterior.Direccion;
                entidad.LatitudAnterior = direccionAnterior.Latitud;
                entidad.LongitudAnterior = direccionAnterior.Longitud;
                entidad.CampaniaAnteriorID = direccionAnterior.CampaniaID;
            }

            entidad.DireccionAnterior = entidad.DireccionAnterior ?? string.Empty;
            entidad.Referencia = entidad.Referencia ?? string.Empty;
            return entidad;
        }
        private BEUsuario BinderMisDatos(MisDatosModel model)
        {
            var entidad = Mapper.Map<MisDatosModel, BEUsuario>(model);
            entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : model.DatosExtra.CodigoUsuario;
            entidad.EMail = entidad.EMail ?? "";
            entidad.Telefono = entidad.Telefono ?? "";
            entidad.TelefonoTrabajo = entidad.TelefonoTrabajo ?? "";
            entidad.Celular = entidad.Celular ?? "";
            entidad.Sobrenombre = entidad.Sobrenombre ?? "";
            entidad.ZonaID = model.DatosExtra.ZonaID;
            entidad.RegionID = model.DatosExtra.RegionID;
            entidad.ConsultoraID = model.DatosExtra.ConsultoraID;
            entidad.PaisID = model.DatosExtra.PaisID;
            entidad.PrimerNombre = model.DatosExtra.PrimerNombre;
            entidad.CodigoISO = model.DatosExtra.CodigoISO;

            return entidad;
        }

        public async Task<string> RegistrarAsync(MisDatosModel model)
        {

            string resultado = string.Empty;
            try
            {
                var usuario = BinderMisDatos(model);
                var direccion = await BinderDireccionAsync(model.DireccionEntrega);
                usuario.DireccionEntrega = direccion;
                usuario.CorreoAnterior = model.CorreoAnterior;
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    resultado = await svr.RegistrarPerfilAsync(usuario);
                }

            }
            catch (Exception ex)
            {

            }
            return resultado;

        }


    }
}