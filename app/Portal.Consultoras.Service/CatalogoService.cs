using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Service
{
    public class CatalogoService : ICatalogoService
    {
        public BEConsultoraCatalogo GetConsultoraCatalogo(string PaisISO, string CodigoConsultora)
        {
            #region Validacion de parámetros

            if (string.IsNullOrEmpty(PaisISO)) throw new Exception("El parámetro PaisISO no puede ser vacio.");
            if (string.IsNullOrEmpty(CodigoConsultora)) throw new Exception("El parámetro CodigoConsultora no puede ser vacio.");
            int paisId = GetPaisID(PaisISO);
            if (paisId == 0) throw new Exception("El parámetro PaisISO no es válido");

            #endregion

            string paisesCodigoDocumento = ConfigurationManager.AppSettings["CONSULTORA_CATALOGO_PAISES_POR_DOCUMENTO"];
            bool parametroEsDocumento = paisesCodigoDocumento.Contains(PaisISO.ToUpper());

            int tipoFiltroUbigeo;
            var listTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(paisId, 66);
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
            int paisId = GetPaisID(PaisISO);

            BLSolicitudClienteCatalogo oSolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            int result = oSolicitudClienteCatalogo.InsSolicitudClienteCatalogo(paisId, CodigoConsultora, AsuntoNotificacion, DetalleNotificacion, Campania, CorreoCliente, NombreCliente, Telefono, DireccionCliente, parametroEsDocumento);
            return result;
        }

        public BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeo(string codigoPais, string codigoUbigeo, int marcaId)
        {
            if (codigoPais.Length > 2) throw new Exception("El campo Pais recibido tiene más de 2 caracteres");
            if (string.IsNullOrEmpty(codigoPais)) throw new Exception("El Servicio no recibió el parámetro codigoPais correcto");
            if (string.IsNullOrEmpty(codigoUbigeo)) throw new Exception("El Servicio no recibió el parámetro CodigoUbigeo correcto");
            if (marcaId == 0) throw new Exception("El Servicio no recibió el parámetro marcaID correcto");

            int idPais = GetPaisID(codigoPais);
            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 58);
            BETablaLogicaDatos longitudUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 5801);
            if (longitudUbigeo != null)
            {
                int limiteInferior;
                int.TryParse(longitudUbigeo.Codigo, out limiteInferior);
                vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 67);
                BETablaLogicaDatos configFactorUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6701);
                int factorUbigeo;
                int.TryParse(configFactorUbigeo.Codigo, out factorUbigeo);
                limiteInferior *= factorUbigeo;
                string mensajeValidacion = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                if (codigoUbigeo.Length < limiteInferior) throw new Exception(mensajeValidacion);
            }
            int tipoFiltroUbigeo;
            vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 66);
            BETablaLogicaDatos filtroUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            BEListaConsultoraCatalogo bEListaConsultoraCatalogo = new BEListaConsultoraCatalogo();
            bEListaConsultoraCatalogo.ConsultorasCatalogos = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeo(idPais, codigoUbigeo, marcaId, tipoFiltroUbigeo);
            bEListaConsultoraCatalogo.NumeroRegistros = bEListaConsultoraCatalogo.ConsultorasCatalogos.Count;
            bEListaConsultoraCatalogo.ConsultorasCatalogos.Update(x => x.Pais = codigoPais);
            return bEListaConsultoraCatalogo;
        }

        public BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(string codigoPais, string codigoUbigeo, int marcaId, string nombres, string apellidos)
        {
            if (codigoPais.Length > 2) throw new Exception("El campo Pais recibido tiene más de 2 caracteres");
            if (string.IsNullOrEmpty(codigoPais)) throw new Exception("El Servicio no recibió el parámetro codigoPais correcto");
            if (string.IsNullOrEmpty(codigoUbigeo)) throw new Exception("El Servicio no recibió el parámetro CodigoUbigeo correcto");
            if (marcaId == 0) throw new Exception("El Servicio no recibió el parámetro marcaID correcto");

            BEListaConsultoraCatalogo bEListaConsultoraCatalogo = new BEListaConsultoraCatalogo();
            int idPais = GetPaisID(codigoPais);

            int tipoFiltroUbigeo;
            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 66);
            BETablaLogicaDatos filtroUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            if (codigoPais == Constantes.CodigosISOPais.Peru || codigoPais == Constantes.CodigosISOPais.Ecuador || codigoPais == Constantes.CodigosISOPais.Bolivia)
            {
                if (codigoUbigeo.Length == 18) bEListaConsultoraCatalogo.ConsultorasCatalogos = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
                else if (codigoUbigeo.Length == 12) bEListaConsultoraCatalogo.ConsultorasCatalogos = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
                else throw new Exception("La longitud del parámetro CodigoUbigeo debe ser 12 o 18");
            }
            else
            {
                vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 58);
                BETablaLogicaDatos longitudUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 5801);
                if (longitudUbigeo != null)
                {
                    int limiteInferior;
                    int.TryParse(longitudUbigeo.Codigo, out limiteInferior);
                    vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 67);
                    BETablaLogicaDatos configFactorUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6701);
                    int factorUbigeo;
                    int.TryParse(configFactorUbigeo.Codigo, out factorUbigeo);
                    limiteInferior *= factorUbigeo;
                    string mensajeValidacion = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                    if (codigoUbigeo.Length < limiteInferior) throw new Exception(mensajeValidacion);
                }

                bEListaConsultoraCatalogo.ConsultorasCatalogos = new BLConsultoraCatalogo().GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(idPais, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo);
            }

            bEListaConsultoraCatalogo.NumeroRegistros = bEListaConsultoraCatalogo.ConsultorasCatalogos.Count;
            if (bEListaConsultoraCatalogo.NumeroRegistros > 10) bEListaConsultoraCatalogo.ConsultorasCatalogos = null;
            else bEListaConsultoraCatalogo.ConsultorasCatalogos.Update(x => x.Pais = codigoPais);
            return bEListaConsultoraCatalogo;
        }

        public List<BEConsultoraCatalogo> GetConsultorasPorCodigoTerritorioGeo(string codigoPais, string codigoTerritorioGeo)
        {
            int idPais = GetPaisID(codigoPais ?? "");
            if (idPais == 0) throw new Exception("El código de Pais recibido no es válido.");
            codigoTerritorioGeo = codigoTerritorioGeo ?? "";
            if (codigoTerritorioGeo.Length != 13) throw new Exception("El codigo de TerritorioGeo recibido no es válido.");
            string codigoRegion = codigoTerritorioGeo.Substring(0, 2);
            string codigoZona = codigoTerritorioGeo.Substring(2, 4);
            string codigoSeccion = codigoTerritorioGeo.Substring(6, 1);
            string codigoTerritorio = codigoTerritorioGeo.Substring(7, 6).TrimStart(new char[] { '0' });

            try
            {
                return new BLConsultoraCatalogo().GetConsultorasPorCodigoTerritorioGeo(idPais, codigoRegion, codigoZona, codigoSeccion, codigoTerritorio);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", codigoPais);
                throw new Exception("Ocurrió un error al intentar obtener las consultoras.");
            }
        }

        public int GetPaisID(string ISO)
        {
            try
            {
                List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", Constantes.CodigosISOPais.Argentina),
                new KeyValuePair<string, string>("2", Constantes.CodigosISOPais.Bolivia),
                new KeyValuePair<string, string>("3", Constantes.CodigosISOPais.Chile),
                new KeyValuePair<string, string>("4", Constantes.CodigosISOPais.Colombia),
                new KeyValuePair<string, string>("5", Constantes.CodigosISOPais.CostaRica),
                new KeyValuePair<string, string>("6", Constantes.CodigosISOPais.Ecuador),
                new KeyValuePair<string, string>("7", Constantes.CodigosISOPais.Salvador),
                new KeyValuePair<string, string>("8", Constantes.CodigosISOPais.Guatemala),
                new KeyValuePair<string, string>("9", Constantes.CodigosISOPais.Mexico),
                new KeyValuePair<string, string>("10", Constantes.CodigosISOPais.Panama),
                new KeyValuePair<string, string>("11", Constantes.CodigosISOPais.Peru),
                new KeyValuePair<string, string>("12", Constantes.CodigosISOPais.PuertoRico),
                new KeyValuePair<string, string>("13", Constantes.CodigosISOPais.Dominicana),
                new KeyValuePair<string, string>("14", Constantes.CodigosISOPais.Venezuela),
            };

                string paisId = (from c in listaPaises
                                 where c.Value == ISO.ToUpper()
                                 select c.Key).SingleOrDefault() ?? "";

                int outVal;
                int.TryParse(paisId, out outVal);
                return outVal;
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }

        }

        public int InsLogClienteRegistraConsultoraCatalogo(string PaisISO, int consultoraId, string codigoConsultora,
            int campaniaId, string tipoBusqueda, int conoceConsultora, string codigoDispositivo, string soDispotivivo,
            string unidadGeo1, string unidadGeo2, string unidadGeo3, string nombreCliente, string emailCliente,
            string telefonoCliente, int nuevaConsultora)
        {
            int paisId = GetPaisID(PaisISO);

            BLConsultoraCatalogo oConsultoraCatalogo = new BLConsultoraCatalogo();
            int result = oConsultoraCatalogo.InsLogClienteRegistraConsultoraCatalogo(paisId, consultoraId, codigoConsultora, campaniaId,
                    tipoBusqueda, conoceConsultora, codigoDispositivo, soDispotivivo, unidadGeo1, unidadGeo2, unidadGeo3,
                    nombreCliente, emailCliente, telefonoCliente, nuevaConsultora);
            return result;
        }
    }
}