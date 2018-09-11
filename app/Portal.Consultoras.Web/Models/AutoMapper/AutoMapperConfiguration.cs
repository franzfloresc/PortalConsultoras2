using AutoMapper;

namespace Portal.Consultoras.Web.Models.AutoMapper
{
    public static class AutoMapperConfiguration
    {
        public static void Configure()
        {
            Mapper.Initialize(x =>
            {
                x.AddProfile<DomainToModelMappingProfile>();
                x.AddProfile<ModelToDomainMappingProfile>();
            });
        }
    }
}