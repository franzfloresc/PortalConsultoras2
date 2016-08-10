using Portal.Consultoras.BizLogic;
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
            string paisesCodigoDocumento = ConfigurationManager.AppSettings["CONSULTORA_CATALOGO_PAISES_POR_DOCUMENTO"];
            bool parametroEsDocumento = paisesCodigoDocumento.Contains(PaisISO.ToUpper());
            int PaisID = GetPaisID(PaisISO);

            BLConsultoraCatalogo oConsultoraCatalogo = new BLConsultoraCatalogo();
            BEConsultoraCatalogo Result = oConsultoraCatalogo.GetConsultoraCatalogo(PaisID, CodigoConsultora, parametroEsDocumento);
            return Result;
        }

        public int InsSolicitudClienteCatalogo(string PaisISO, string CodigoConsultora, string AsuntoNotificacion, string DetalleNotificacion, string Campania, string CorreoCliente, string NombreCliente, string Telefono, string DireccionCliente)
        {
            string paisesCodigoDocumento = ConfigurationManager.AppSettings["SOLICITUD_CLIENTE_CATALOGO_PAISES_POR_DOCUMENTO"];
            bool parametroEsDocumento = paisesCodigoDocumento.Contains(PaisISO.ToUpper());
            int PaisID = GetPaisID(PaisISO);

            BLSolicitudClienteCatalogo oSolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            int Result = oSolicitudClienteCatalogo.InsSolicitudClienteCatalogo(PaisID, CodigoConsultora, AsuntoNotificacion, DetalleNotificacion, Campania, CorreoCliente, NombreCliente, Telefono, DireccionCliente, parametroEsDocumento);
            return Result;
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
    }
}
