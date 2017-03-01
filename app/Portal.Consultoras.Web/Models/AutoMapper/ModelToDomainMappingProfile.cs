using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;

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

            Mapper.CreateMap<ProductoModel, Producto>()
                .ForMember(t => t.IdMarca, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cuv, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.NombreMarca, f => f.MapFrom(c => c.DescripcionMarca));
        }
    }
}