using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Service
{
    public class UbigeoWebService : IUbigeoWebService
    {
        #region Miembros de IUbigeoWebService

        public List<BEUnidadGeografica> GetUnidadesGeograficas(string paisID, int nivel, string codigoPadre)
        {
            int idPais = GetPaisID(paisID);
            if (codigoPadre == null) codigoPadre = "";
            if (paisID == null) paisID = "";
            if (codigoPadre.Length > 30) throw new Exception("El campo CódigoPadre recibido tiene más de 30 caracteres");
            if (paisID.Length > 5) throw new Exception("El campo Pais recibido tiene más de 5 caracteres");
            return new BLUbigeo().GetUnidadesGeograficasPorNivel(idPais, nivel, codigoPadre);

        }

        #endregion

        public int GetPaisID(string ISO)
        {
            try
            {
                List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
                {
                    new KeyValuePair<string, string>("1", "AR"),
                    new KeyValuePair<string, string>("2", "BO"),
                    new KeyValuePair<string, string>("3", "CL"),
                    new KeyValuePair<string, string>("4", "CO"),
                    new KeyValuePair<string, string>("5", "CR"),
                    new KeyValuePair<string, string>("6", "EC"),
                    new KeyValuePair<string, string>("7", "SV"),
                    new KeyValuePair<string, string>("8", "GT"),
                    new KeyValuePair<string, string>("9", "MX"),
                    new KeyValuePair<string, string>("10", "PA"),
                    new KeyValuePair<string, string>("11", "PE"),
                    new KeyValuePair<string, string>("12", "PR"),
                    new KeyValuePair<string, string>("13", "DO"),
                    new KeyValuePair<string, string>("14", "VE"),
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

        public List<BEUnidadGeografica> ObtenerUbigeosPais(string paisCodigoISO)
        {
            var blUbigeo = new BLUbigeo();
            int paisId = GetPaisID(paisCodigoISO);
            return blUbigeo.GetUbigeosPorPais(paisId);
        }
    }
}