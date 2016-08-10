﻿using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

            List<BETablaLogicaDatos> vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 58);
            BETablaLogicaDatos longitudUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 5801);
            if (longitudUbigeo != null)
            {
                int limiteInferior = 6;//por default
                int.TryParse(longitudUbigeo.Codigo, out limiteInferior);
                int factorUbigeo = 3;
                vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 67);
                BETablaLogicaDatos configFactorUbigeo = vListaTablaLogicaDatos.Find(x => x.TablaLogicaDatosID == 6701);
                int.TryParse(configFactorUbigeo.Codigo, out factorUbigeo); 
                limiteInferior *= factorUbigeo;// se multiplica por 3
                string MensajeValidacion = string.Format("La longitud del parámetro CodigoUbigeo debe tener como valor mínimo {0}", limiteInferior);
                if (codigoUbigeo.Length < limiteInferior) throw new Exception(MensajeValidacion);
            }
            int tipoFiltroUbigeo = 1;
            vListaTablaLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(idPais, 66);
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
            string paisID = "0";
            try
            {
                paisID = (from c in listaPaises
                          where c.Value == ISO.ToUpper()
                          select c.Key).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
            if (paisID != null)
            {
                return int.Parse(paisID);
            }
            else return 0;
        }


        #endregion
    }
}
