using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLChatBot
    {

        public List<BEChatBotListResultados> ChatBotListResultados(int paisID, BEChatBotListResultados entidad)
        {
            List<BEChatBotListResultados> lista;

            try
            {
                var da = new DAChatBot(paisID);
                using (var reader = da.ChatBotListResultados(entidad))
                {
                    lista = reader.MapToCollection<BEChatBotListResultados>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                lista = new List<BEChatBotListResultados>();
            }
            return lista;
        }

        public BEChatBotInsertResultadosResponse ChatBotInsertResultados(int paisID, BEChatBotInsertResultadosRequest p)
        {
            var da = new DAChatBot(paisID);
            int result =  da.ChatBotInsertResultados(p);

            BEChatBotInsertResultadosResponse objBEChatBotInsertResultadosResponse = new BEChatBotInsertResultadosResponse();
            objBEChatBotInsertResultadosResponse.ResultadoId = result;
            return objBEChatBotInsertResultadosResponse;

        }

        public bool ChatBotInsertDetalleResultados(int paisID, BEChatBotInsertDetalleResultadosRequest p)
        {
            var da = new DAChatBot(paisID);
            bool resp = false;
            
            resp = da.ChatBotUpdateResultados(p);
            if (resp == true) {
                var objRespuestasModel = new BEChatBotInsertDetalleResultadosRequest.RespuestasModel();
                foreach (var item in p.Respuestas)
                {
                    objRespuestasModel.ResultadosID = item.ResultadosID;
                    objRespuestasModel.PreguntaID = item.PreguntaID;
                    objRespuestasModel.CalificacionID = item.CalificacionID;
                    objRespuestasModel.Cualitativo = item.Cualitativo;
                    da.ChatBotInsertDetalleResultados(objRespuestasModel);
                }
            }            

            return resp;
        }

        

    }
}