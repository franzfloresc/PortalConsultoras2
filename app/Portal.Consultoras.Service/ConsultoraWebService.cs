﻿using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class ConsultoraWebService : IConsultoraWebService
    {
        #region Miembros de IConsultoraWebService

        public List<BEConsultoraUbigeo> GetConsultorasPorUbigeo(string codigoPais, string codigoUbigeo, string campania, int marcaId)
        {
            if (codigoPais == null) codigoPais = "";
            if (codigoUbigeo == null) codigoUbigeo = "";
            if (campania == null) campania = "";

            var mensaje = ValidarMensaje(codigoPais, codigoUbigeo, campania, marcaId);

            if (mensaje != "")
            {
                throw new ClientInformationException(mensaje);
            }

            int idPais = Util.GetPaisID(codigoPais);
            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 58);
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
                    string mensajeValidacion = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                    throw new ClientInformationException(mensajeValidacion);
                }
            }
            int tipoFiltroUbigeo;
            vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 66);
            BETablaLogicaDatos filtroUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6601);
            int.TryParse(filtroUbigeo.Codigo, out tipoFiltroUbigeo);

            List<BEConsultora> vListaConsultora = new BLConsultora().GetConsultorasPorUbigeo(idPais, codigoUbigeo, campania, marcaId, tipoFiltroUbigeo);
            List<BEConsultoraUbigeo> vListaConsultoraUbigeo = new List<BEConsultoraUbigeo>();
            foreach (BEConsultora item in vListaConsultora)
            {
                vListaConsultoraUbigeo.Add(new BEConsultoraUbigeo(item));
            }

            return vListaConsultoraUbigeo;

        }

        private string ValidarMensaje(string codigoPais, string codigoUbigeo, string campania, int marcaId)
        {
            var respuesta = "";

            if (codigoPais.Length > 5) respuesta = "El campo Pais recibido tiene más de 5 caracteres";
            if (codigoPais == "") respuesta = "El Servicio no recibió el parámetro  codigoPais correcto";
            if (codigoUbigeo == "") respuesta = "El Servicio no recibió el parámetro CodigoUbigeo correcto";
            if (campania == "") respuesta = "El Servicio no recibió el parámetro Campania correcto";
            if (campania.Length != 6) respuesta = "El parámetro Campania no recibió el formato correcto";
            if (marcaId == 0) respuesta = "El Servicio no recibió el parámetro marcaID correcto";

            return respuesta;
        }

        #endregion
    }
}