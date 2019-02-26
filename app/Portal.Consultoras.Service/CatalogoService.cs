using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Service
{
    public class CatalogoService : ICatalogoService
    {
        public BEConsultoraCatalogo GetConsultoraCatalogo(string PaisISO, string CodigoConsultora)
        {
            int paisId = Util.GetPaisID(PaisISO);
            #region Validacion de parámetros

            var mensaje = GetConsultoraCatalogoValidarMensaje(PaisISO, CodigoConsultora, paisId);
            if (mensaje != "")
            {
                throw new Exception(mensaje);
            }

            #endregion

            string paisesCodigoDocumento = ConfigurationManager.AppSettings["CONSULTORA_CATALOGO_PAISES_POR_DOCUMENTO"];
            bool parametroEsDocumento = paisesCodigoDocumento.Contains(PaisISO.ToUpper());

            int tipoFiltroUbigeo;
            var listTablaLogicaDatos = new BLTablaLogicaDatos().GetList(paisId, 66);
            BETablaLogicaDatos filtroUbigeo = listTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            BLConsultoraCatalogo consultoraCatalogo = new BLConsultoraCatalogo();
            BEConsultoraCatalogo result = consultoraCatalogo.GetConsultoraCatalogo(paisId, CodigoConsultora, parametroEsDocumento, tipoFiltroUbigeo);
            result.Pais = PaisISO;
            return result;
        }

        public int InsSolicitudClienteCatalogo(string PaisISO, string CodigoConsultora, string AsuntoNotificacion, string DetalleNotificacion, string Campania, string CorreoCliente, string NombreCliente, string Telefono, string DireccionCliente)
        {
            string paisesCodigoDocumento = ConfigurationManager.AppSettings["SOLICITUD_CLIENTE_CATALOGO_PAISES_POR_DOCUMENTO"];
            bool parametroEsDocumento = paisesCodigoDocumento.Contains(PaisISO.ToUpper());
            int paisId = Util.GetPaisID(PaisISO);

            BLSolicitudClienteCatalogo oSolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            int result = oSolicitudClienteCatalogo.InsSolicitudClienteCatalogo(paisId, CodigoConsultora, AsuntoNotificacion, DetalleNotificacion, Campania, CorreoCliente, NombreCliente, Telefono, DireccionCliente, parametroEsDocumento);
            return result;
        }

        public BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeo(string codigoPais, string codigoUbigeo, int marcaId)
        {
            var mensaje = ValidarMensaje(codigoPais, codigoUbigeo, marcaId);
            if (mensaje != "")
            {
                throw new Exception(mensaje);
            }

            int idPais = Util.GetPaisID(codigoPais);
            ValidarCodigoUbigeo(idPais, codigoUbigeo);

            var vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 66);
            BETablaLogicaDatos filtroUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);
            int tipoFiltroUbigeo;
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            BEListaConsultoraCatalogo bEListaConsultoraCatalogo = new BEListaConsultoraCatalogo();
            bEListaConsultoraCatalogo.ConsultorasCatalogos = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeo(idPais, codigoUbigeo, marcaId, tipoFiltroUbigeo);
            bEListaConsultoraCatalogo.NumeroRegistros = bEListaConsultoraCatalogo.ConsultorasCatalogos.Count;
            bEListaConsultoraCatalogo.ConsultorasCatalogos.Update(x => x.Pais = codigoPais);
            return bEListaConsultoraCatalogo;
        }

        public BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(string codigoPais, string codigoUbigeo, int marcaId, string nombres, string apellidos)
        {
            var mensaje = ValidarMensaje(codigoPais, codigoUbigeo, marcaId);
            if (mensaje != "")
            {
                throw new Exception(mensaje);
            }

            int idPais = Util.GetPaisID(codigoPais);
            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 66);
            BETablaLogicaDatos filtroUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);

            int tipoFiltroUbigeo;
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            BEListaConsultoraCatalogo bEListaConsultoraCatalogo = new BEListaConsultoraCatalogo();
            bEListaConsultoraCatalogo.ConsultorasCatalogos = GetConsultorasCatalogos(codigoPais, codigoUbigeo, idPais, marcaId, nombres, apellidos, tipoFiltroUbigeo);

            bEListaConsultoraCatalogo.NumeroRegistros = bEListaConsultoraCatalogo.ConsultorasCatalogos.Count;
            if (bEListaConsultoraCatalogo.NumeroRegistros > 10) bEListaConsultoraCatalogo.ConsultorasCatalogos = null;
            else bEListaConsultoraCatalogo.ConsultorasCatalogos.Update(x => x.Pais = codigoPais);
            return bEListaConsultoraCatalogo;
        }

        public List<BEConsultoraCatalogo> GetConsultorasPorCodigoTerritorioGeo(string codigoPais, string codigoTerritorioGeo)
        {
            try
            {
                int idPais = Util.GetPaisID(codigoPais ?? "");
                codigoTerritorioGeo = codigoTerritorioGeo ?? "";

                if (idPais == 0) throw new Exception("El código de Pais recibido no es válido.");
                if (codigoTerritorioGeo.Length != 13) throw new Exception("El codigo de TerritorioGeo recibido no es válido.");

                string codigoRegion = codigoTerritorioGeo.Substring(0, 2);
                string codigoZona = codigoTerritorioGeo.Substring(2, 4);
                string codigoSeccion = codigoTerritorioGeo.Substring(6, 1);
                string codigoTerritorio = codigoTerritorioGeo.Substring(7, 6).TrimStart(new char[] { '0' });

                return new BLConsultoraCatalogo().GetConsultorasPorCodigoTerritorioGeo(idPais, codigoRegion, codigoZona, codigoSeccion, codigoTerritorio);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", codigoPais);
                throw new Exception("Ocurrió un error al intentar obtener las consultoras.");
            }
        }

        public int InsLogClienteRegistraConsultoraCatalogo(string PaisISO, int consultoraId, string codigoConsultora,
            int campaniaId, string tipoBusqueda, int conoceConsultora, string codigoDispositivo, string soDispotivivo,
            string unidadGeo1, string unidadGeo2, string unidadGeo3, string nombreCliente, string emailCliente,
            string telefonoCliente, int nuevaConsultora)
        {
            int paisId = Util.GetPaisID(PaisISO);

            BLConsultoraCatalogo oConsultoraCatalogo = new BLConsultoraCatalogo();
            int result = oConsultoraCatalogo.InsLogClienteRegistraConsultoraCatalogo(paisId, consultoraId, codigoConsultora, campaniaId,
                    tipoBusqueda, conoceConsultora, codigoDispositivo, soDispotivivo, unidadGeo1, unidadGeo2, unidadGeo3,
                    nombreCliente, emailCliente, telefonoCliente, nuevaConsultora);
            return result;
        }

        private string GetConsultoraCatalogoValidarMensaje(string paisIso, string codigoConsultora, int paisId)
        {
            var respuesta = "";

            if (string.IsNullOrEmpty(paisIso)) respuesta = ("El parámetro PaisISO no puede ser vacio.");
            if (string.IsNullOrEmpty(codigoConsultora)) respuesta = ("El parámetro CodigoConsultora no puede ser vacio.");
            if (paisId == 0) respuesta = ("El parámetro PaisISO no es válido");

            return respuesta;
        }

        private string ValidarMensaje(string codigoPais, string codigoUbigeo, int marcaId)
        {
            var respuesta = "";

            if (string.IsNullOrEmpty(codigoPais)) respuesta = ("El Servicio no recibió el parámetro codigoPais correcto");
            else if (codigoPais.Length > 2) respuesta = ("El campo Pais recibido tiene más de 2 caracteres");
            if (string.IsNullOrEmpty(codigoUbigeo)) respuesta = ("El Servicio no recibió el parámetro CodigoUbigeo correcto");
            if (marcaId == 0) respuesta = ("El Servicio no recibió el parámetro marcaID correcto");

            return respuesta;
        }

        private List<BEConsultoraCatalogo> GetConsultorasCatalogos(string codigoPais, string codigoUbigeo, int idPais, int marcaId, string nombres, string apellidos, int tipoFiltroUbigeo)
        {
            var lista = new List<BEConsultoraCatalogo>();

            if (codigoPais == Constantes.CodigosISOPais.Peru || codigoPais == Constantes.CodigosISOPais.Ecuador || codigoPais == Constantes.CodigosISOPais.Bolivia)
            {
                if (codigoUbigeo.Length == 18) lista = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
                else if (codigoUbigeo.Length == 12) lista = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
                else throw new Exception("La longitud del parámetro CodigoUbigeo debe ser 12 o 18");
            }
            else
            {
                ValidarCodigoUbigeo(idPais, codigoUbigeo);
                lista = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
            }

            return lista;
        }

        private void ValidarCodigoUbigeo(int idPais, string codigoUbigeo)
        {
            var vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 58);
            BETablaLogicaDatos longitudUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 5801);
            if (longitudUbigeo != null)
            {
                int limiteInferior;
                int.TryParse(longitudUbigeo.Codigo, out limiteInferior);
                vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 67);
                BETablaLogicaDatos configFactorUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6701);
                int factorUbigeo;
                int.TryParse(configFactorUbigeo.Codigo, out factorUbigeo);
                limiteInferior *= factorUbigeo;
                if (codigoUbigeo.Length < limiteInferior)
                {
                    var mensaje = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                    throw new Exception(mensaje);
                }
            }
        }

    }
}