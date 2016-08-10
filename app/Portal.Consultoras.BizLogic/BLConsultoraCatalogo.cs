using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraCatalogo
    {
        public BEConsultoraCatalogo GetConsultoraCatalogo(int paisID, string codigoConsultora, bool parametroEsDocumento)
        {
            BEConsultoraCatalogo beConsultoraCatalogo = new BEConsultoraCatalogo();
            DAConsultoraCatalogo daConsultoraCatalogo = new DAConsultoraCatalogo(paisID);

            using (IDataReader reader = daConsultoraCatalogo.GetConsultoraCatalogo(paisID, codigoConsultora, parametroEsDocumento))
            {
                if (reader.Read())
                {
                    beConsultoraCatalogo = new BEConsultoraCatalogo(reader);
                }
            }

            int estadoInfoPreLogin = new BLUsuario().GetInfoPreLoginConsultoraCatalogo(paisID, beConsultoraCatalogo.CodigoUsuario);
            switch (estadoInfoPreLogin)
            {
                case 3:
                    beConsultoraCatalogo.Estado = 1;
                    break;
                case 1:
                    beConsultoraCatalogo.Estado = 0;
                    break;
                case 2:
                    beConsultoraCatalogo.Estado = 0;
                    break;
                default:
                    beConsultoraCatalogo.Estado = -1;
                    break;
            }

            return beConsultoraCatalogo;
        }
    }
}
