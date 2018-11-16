using System.Collections.Generic;

namespace Portal.Consultoras.Web.Infraestructure.Validator
{
    public interface IEntityValidator<in T>
        where T: new()
    {
        IEnumerable<KeyValuePair<string, string>> Errors { get; }

        bool IsValid(T data);
    }
}
