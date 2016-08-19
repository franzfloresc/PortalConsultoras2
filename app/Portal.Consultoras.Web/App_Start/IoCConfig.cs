using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Autofac;
using Autofac.Integration.Mvc;
using System.Reflection;
using Portal.Consultoras.Web.ServiceCliente;
using System.Web.Mvc;
using AutoMapper;

namespace Portal.Consultoras.Web
{
    public class IoCConfig
    {
        public static void RegistrarDependencias()
        {
            //var builder = new ContainerBuilder();
            //builder.RegisterControllers(Assembly.GetExecutingAssembly());
            //builder.RegisterModelBinders(Assembly.GetExecutingAssembly());
            //builder.RegisterModelBinderProvider();
            //builder.RegisterModule(new AutofacWebTypesModule());

            //builder.RegisterType<ClienteServiceClient>().As<IClienteService>().InstancePerHttpRequest();
            //builder.RegisterFilterProvider();

            //IContainer container = builder.Build();
            //DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        }
    }
}