using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.AutoMapper
{
    public class ModelToDomainMappingProfile : Profile
    {
        public override string ProfileName
        {
            get { return "ModelToDomainMappings"; }
        }

        protected override void Configure()
        {
            Mapper.CreateMap<PedidoDetalleModel, ServiceCliente.BECliente>()
                .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

            Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>();
        }
    }
}