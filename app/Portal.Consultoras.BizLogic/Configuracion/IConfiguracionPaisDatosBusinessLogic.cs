﻿using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionPaisDatosBusinessLogic
    {
        bool ConfiguracionPaisComponenteDeshabilitar(BEConfiguracionPaisDatos entidad);
        int ConfiguracionPaisDatosGuardar(int paisId, List<BEConfiguracionPaisDatos> listaEntidad);
        List<BEConfiguracionPaisDatos> GetList(BEConfiguracionPaisDatos entidad);
        List<BEConfiguracionPaisDatos> GetListComponente(BEConfiguracionPaisDatos entidad);
        List<BEConfiguracionPaisDatos> GetListComponenteDatos(BEConfiguracionPaisDatos entidad);
    }
}