using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
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
                throw new Exception(mensaje);
            }

            //if (codigoPais.Length > 5) throw new Exception("El campo Pais recibido tiene más de 5 caracteres");
            //if (codigoPais == "") throw new Exception("El Servicio no recibió el parámetro  codigoPais correcto");
            //if (codigoUbigeo == "") throw new Exception("El Servicio no recibió el parámetro CodigoUbigeo correcto");
            //if (campania == "") throw new Exception("El Servicio no recibió el parámetro Campania correcto");
            //if (campania.Length != 6) throw new Exception("El parámetro Campania no recibió el formato correcto");
            //if (marcaId == 0) throw new Exception("El Servicio no recibió el parámetro marcaID correcto");
            
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
                    throw new Exception(mensajeValidacion);
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
        
        // se movio a Util.GetPaisID
        //public int GetPaisID(string ISO)
        //{
        //    try
        //    {
        //        List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
        //        {
        //            new KeyValuePair<string, string>("1", Constantes.CodigosISOPais.Argentina),
        //            new KeyValuePair<string, string>("2", Constantes.CodigosISOPais.Bolivia),
        //            new KeyValuePair<string, string>("3", Constantes.CodigosISOPais.Chile),
        //            new KeyValuePair<string, string>("4", Constantes.CodigosISOPais.Colombia),
        //            new KeyValuePair<string, string>("5", Constantes.CodigosISOPais.CostaRica),
        //            new KeyValuePair<string, string>("6", Constantes.CodigosISOPais.Ecuador),
        //            new KeyValuePair<string, string>("7", Constantes.CodigosISOPais.Salvador),
        //            new KeyValuePair<string, string>("8", Constantes.CodigosISOPais.Guatemala),
        //            new KeyValuePair<string, string>("9", Constantes.CodigosISOPais.Mexico),
        //            new KeyValuePair<string, string>("10", Constantes.CodigosISOPais.Panama),
        //            new KeyValuePair<string, string>("11", Constantes.CodigosISOPais.Peru),
        //            new KeyValuePair<string, string>("12", Constantes.CodigosISOPais.PuertoRico),
        //            new KeyValuePair<string, string>("13", Constantes.CodigosISOPais.Dominicana),
        //            new KeyValuePair<string, string>("14", Constantes.CodigosISOPais.Venezuela),
        //        };
        //        string paisId = (from c in listaPaises
        //                         where c.Value == ISO.ToUpper()
        //                         select c.Key).SingleOrDefault() ?? "";
        //        int outVal;
        //        int.TryParse(paisId, out outVal);
        //        return outVal;
        //    }
        //    catch (Exception)
        //    {
        //        throw new Exception("Hubo un error en obtener el País");
        //    }
        //}

        #endregion
    }
}