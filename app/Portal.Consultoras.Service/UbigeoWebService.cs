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
            int idPais = Util.GetPaisID(paisID);
            if (codigoPadre == null) codigoPadre = "";
            if (paisID == null) paisID = "";
            if (codigoPadre.Length > 30) throw new Exception("El campo CódigoPadre recibido tiene más de 30 caracteres");
            if (paisID.Length > 5) throw new Exception("El campo Pais recibido tiene más de 5 caracteres");
            return new BLUbigeo().GetUnidadesGeograficasPorNivel(idPais, nivel, codigoPadre);

        }

        #endregion

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

        public List<BEUnidadGeografica> ObtenerUbigeosPais(string paisCodigoISO)
        {
            var blUbigeo = new BLUbigeo();
            int paisId = Util.GetPaisID(paisCodigoISO);
            return blUbigeo.GetUbigeosPorPais(paisId);
        }
    }
}