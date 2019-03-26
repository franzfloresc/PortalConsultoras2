﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BonificacionesController : BaseController
    {
       

        public ActionResult Index()
        {
            try
            {
                List<BEIncentivo> lst;
                int paisId = userData.PaisID;
                int campaniaId = userData.CampaniaID;
                string iso = userData.CodigoISO;
                bool isDigital = IndicadorConsultoraDigital();

                if (isDigital)
                {
                    BonificacionesModel model = new BonificacionesModel {   CodigoIso = userData.CodigoISO ,
                                                                            Codigoconsultora =userData.CodigoConsultora ,
                                                                            NumeroDocumento = userData.DocumentoIdentidad
                                                                        };
                    
                    string secretKey = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);

                    var token = JWT.JsonWebToken.Encode(model, secretKey,JWT.JwtHashAlgorithm.HS256);

                    ViewBag.Token = token;

                    //ViewBag.Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJDb2RpZ29Jc28iOiJQRSIsIkNvZGlnb2NvbnN1bHRvcmEiOiIwNDQ2MzI5MjYiLCJOdW1lcm9Eb2N1bWVudG8iOiI3NTUxODA0OCIsImlhdCI6MTU1MjU5OTM5OH0.dtfzBzaqJUXqFWzXpBM-_6UCy5hrvLtfkFF4b-aQFnQ";

                    return View("IndexExterno");
                }
                else
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.SelectIncentivos(paisId, campaniaId).ToList();
                    }

                    if (lst != null && lst.Count > 0)
                    {
                        var carpetaPaisIncentivos = Globals.UrlIncentivos + "/" + userData.CodigoISO;
                        var carpetaPaisFileConsultoras = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                        lst.Update(x => x.ArchivoPortada = ConfigCdn.GetUrlFileCdn(carpetaPaisIncentivos, x.ArchivoPortada));
                        lst.Update(x => x.ArchivoPDF = ConfigCdn.GetUrlFileCdn(carpetaPaisFileConsultoras, x.ArchivoPDF));
                    }

                    var incentivosModel = new IncentivosModel()
                    {
                        PaisID = paisId,
                        CampaniaID = campaniaId,
                        ISO = iso,
                        listaIncentivos = lst
                    };
                    return View(incentivosModel);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new IncentivosModel());
        }
    }
}
