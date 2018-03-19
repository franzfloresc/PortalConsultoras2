using AutoMapper;

namespace Portal.Consultoras.Data.Hana.AutoMapper
{
    public class AutoMapperConfiguration
    {
        public static void Configure()
        {
            Mapper.Initialize(x =>
            {
                x.AddProfile<HanaEntitiesToBEEntititesMappingProfile>();
            });
        }
    }
}