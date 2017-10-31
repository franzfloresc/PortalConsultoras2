using Autofac;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.Providersx;

namespace Portal.Consultoras.Web.Autofac
{
    public class ProviderModuleResolver : Module
    {
        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterType<UserProvider>().AsImplementedInterfaces();
            builder.RegisterType<ConfiguracionDatosProvider>().AsImplementedInterfaces();
            builder.RegisterType<ConfiguracionPaisProvider>().AsImplementedInterfaces();
            builder.RegisterType<FlexiPagoProvider>().AsImplementedInterfaces();
            builder.RegisterType<NotificacionProvider>().AsImplementedInterfaces();
            builder.RegisterType<RevistaDigitalProvider>().AsImplementedInterfaces();
            builder.RegisterType<PedidoRechazadoProvider>().AsImplementedInterfaces();
        }
    }
}
