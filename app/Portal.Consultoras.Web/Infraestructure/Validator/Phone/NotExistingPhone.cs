﻿using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    public class NotExistingPhone : IPhoneValidator
    {
        private const string ErrorMessage = "El número ya esta en uso.";

        public int PaisId { get; set; }
        public string CodigoConsultora { get; set; }

        public async Task<SimpleResult> Valid(string number)
        {
            var result = new SimpleResult();

            using (var sv = new UsuarioServiceClient())
            {
                var count = await sv.ValidarTelefonoConsultoraAsync(PaisId, number, CodigoConsultora);
                result.Success = count == 0;
            }

            if (!result.Success)
            {
                result.Message = ErrorMessage;
            }

            return result;
        }
    }
}