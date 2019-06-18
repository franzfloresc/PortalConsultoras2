using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class IncentivosController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                List<BEIncentivo> lstTemp;

                int paisId = userData.PaisID;
                int campaniaId = userData.CampaniaID;
                string iso = userData.CodigoISO;
                bool isDigital = IndicadorConsultoraDigital();


                if (paisId == Constantes.PaisID.Peru && isDigital)
                {
                    string NumeroDocumento = userData.DocumentoIdentidad;
                    if (iso == Constantes.CodigosISOPais.Peru)
                    {
                        NumeroDocumento = userData.DocumentoIdentidad.Substring(NumeroDocumento.Length - 8);
                    }
                    BonificacionesModel model = new BonificacionesModel
                    {
                        CodigoIso = userData.CodigoISO,
                        Codigoconsultora = userData.CodigoConsultora,
                        NumeroDocumento = NumeroDocumento
                    };

                    string secretKey = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);

                    var token = JWT.JsonWebToken.Encode(model, secretKey, JWT.JwtHashAlgorithm.HS256);

                    ViewBag.Token = token;
                    return View("IndexExterno");

                }
                else
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lstTemp = sv.SelectIncentivos(paisId, campaniaId).ToList();
                    }

                    int segmentoId;
                    if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                    {
                        segmentoId = userData.SegmentoID;
                    }
                    else
                    {
                        segmentoId = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
                    }
                    string segmentoServicio = segmentoId.ToString();


                    string zonaIdStr = "," + userData.ZonaID.ToString().Trim() + ",";
                    lstTemp.Where(p => p.Zona != string.Empty).Update(p => p.Zona = "," + p.Zona + ",");
                    lstTemp = lstTemp.Where(p => p.Zona == string.Empty || p.Zona.Contains(zonaIdStr)).ToList();
                    List<BEIncentivo> lst = lstTemp.Where(p => p.Segmento == "-1" || p.Segmento.Contains(segmentoServicio)).ToList();

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

        public ActionResult IndexExterno()
        {
            try
            {
                string NumeroDocumento = userData.DocumentoIdentidad;

                if (userData.CodigoISO == Constantes.CodigosISOPais.Peru)
                {
                    NumeroDocumento = userData.DocumentoIdentidad.Substring(NumeroDocumento.Length - 8);
                }

                BonificacionesModel model = new BonificacionesModel
                {
                    CodigoIso = userData.CodigoISO,
                    Codigoconsultora = userData.CodigoConsultora,
                    NumeroDocumento = NumeroDocumento
                };

                string secretKey = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);

                var token = JWT.JsonWebToken.Encode(model, secretKey, JWT.JwtHashAlgorithm.HS256);

                ViewBag.Token = token;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View();
        }

    }
}
