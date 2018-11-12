using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;

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

            int idPais = GetPaisID(codigoPais);
            if (codigoPais.Length > 5) throw new Exception("El campo Pais recibido tiene más de 5 caracteres");
            if (codigoPais == "") throw new Exception("El Servicio no recibió el parámetro  codigoPais correcto");
            if (codigoUbigeo == "") throw new Exception("El Servicio no recibió el parámetro CodigoUbigeo correcto");
            if (campania == "") throw new Exception("El Servicio no recibió el parámetro Campania correcto");
            if (campania.Length != 6) throw new Exception("El parámetro Campania no recibió el formato correcto");
            if (marcaId == 0) throw new Exception("El Servicio no recibió el parámetro marcaID correcto");

            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 58);
            BETablaLogicaDatos longitudUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 5801);
            if (longitudUbigeo != null)
            {
                int limiteInferior;
                int.TryParse(longitudUbigeo.Codigo, out limiteInferior);
                int factorUbigeo;
                vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetList(idPais, 67);
                BETablaLogicaDatos configFactorUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6701);
                int.TryParse(configFactorUbigeo.Codigo, out factorUbigeo);
                limiteInferior *= factorUbigeo;
                string mensajeValidacion = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                if (codigoUbigeo.Length < limiteInferior) throw new Exception(mensajeValidacion);
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

        #endregion
    }
}