using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.Response
{
    public class GenericResponse
    {
        public object Result { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }

        public GenericResponse(object result, string message, bool success)
        {
            this.Result = result;
            this.Message = message;
            this.Success = success;
        }
    }
}
