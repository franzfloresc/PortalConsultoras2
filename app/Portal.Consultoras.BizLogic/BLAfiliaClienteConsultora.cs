using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using System.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLAfiliaClienteConsultora
    {

        public BLAfiliaClienteConsultora()
        {
        }

        public BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID,string ConsultoraID)
        {
            BEAfiliaClienteConsultora beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora();

            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            using (IDataReader reader =  DAAfiliaClienteConsultora.GetAfiliaClienteConsultoraByConsultora(ConsultoraID))
            {
                while (reader.Read())
                {
                    // ha sido afiliado y activo -> 1 //afiliado y inactivo -> 0
                    beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora(reader);
                }
            }

            return beAfiliacionClienteConsultora;
        }

        public int InsAfiliaClienteConsultora(int paisID,long ConsultoraID)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.InsAfiliaClienteConsultora(ConsultoraID);
        }

        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion);
        }

        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion, MotivoDesafiliacionID);
        }
    }
}
