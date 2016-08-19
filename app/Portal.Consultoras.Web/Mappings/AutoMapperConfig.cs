using AutoMapper;

namespace Portal.Consultoras.Web.Mappings
{
    public class AutoMapperConfig
    {
        public static void RegisterMapppings()
        {
            Mapper.Initialize((x) =>
            {
                x.AddProfile<HojaInscripcionMappings>();
            });
        }
    }
}