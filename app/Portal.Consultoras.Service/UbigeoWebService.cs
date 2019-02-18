using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class UbigeoWebService : IUbigeoWebService
    {
        #region Miembros de IUbigeoWebService

        public List<BEUnidadGeografica> GetUnidadesGeograficas(string paisID, int nivel, string codigoPadre)
        {
            if (codigoPadre == null) codigoPadre = "";
            if (paisID == null) paisID = "";
            var mensaje = ValidarMensaje(paisID, codigoPadre);
            if (mensaje != "")
            {
                throw new Exception(mensaje);
            }

            int idPais = Util.GetPaisID(paisID);
            return new BLUbigeo().GetUnidadesGeograficasPorNivel(idPais, nivel, codigoPadre);

        }

        #endregion


        private string ValidarMensaje(string paisID, string codigoPadre)
        {
            var respuesta = "";

            if (codigoPadre.Length > 30) respuesta = ("El campo CódigoPadre recibido tiene más de 30 caracteres");
            if (paisID.Length > 5) respuesta = ("El campo Pais recibido tiene más de 5 caracteres");

            return respuesta;
        }

        public List<BEUnidadGeografica> ObtenerUbigeosPais(string paisCodigoISO)
        {
            var blUbigeo = new BLUbigeo();
            int paisId = Util.GetPaisID(paisCodigoISO);
            return blUbigeo.GetUbigeosPorPais(paisId);
        }
    }
}