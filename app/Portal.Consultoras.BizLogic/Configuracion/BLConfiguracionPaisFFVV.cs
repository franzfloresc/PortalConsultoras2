using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic.Configuracion
{
    public class BLConfiguracionPaisFFVV : IConfiguracionPaisFFVVDatosBusinessLogic
    {

        public List<BEConfiguracionPaisFFVVDatos> GetList(BEConfiguracionPaisFFVVDatos entidad)
        {
            var lista = new List<BEConfiguracionPaisFFVVDatos>();

            try
            {
                ///                                    procedimiento almacenado solo en Perú
                using (var reader = new DAConfiguracionPaisFFVV(Constantes.PaisID.Peru).GetList(entidad))
                {
                    lista = reader.MapToCollection<BEConfiguracionPaisFFVVDatos>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
            }

            return lista ?? new List<BEConfiguracionPaisFFVVDatos>();
        }

        public List<BEParametroUnete> GetListZonasUnete(BEParametroUnete entidad) {
            var lista = new List<BEParametroUnete>();

            try
            {                
                using (var reader = new DAConfiguracionPaisFFVV(entidad.PaisID).GetListZonasUnete())
                {
                    lista = reader.MapToCollection<BEParametroUnete>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
            }

            return lista ?? new List<BEParametroUnete>();
        }

        //public GetActualizarContraseniaDefault


    }
}
