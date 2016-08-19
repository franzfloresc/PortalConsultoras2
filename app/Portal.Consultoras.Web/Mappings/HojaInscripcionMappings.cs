using System;
using System.Globalization;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.Mappings
{
    public class HojaInscripcionMappings : Profile
    {
        protected override void Configure()
        {
            var ui = new CultureInfo("es-PE");
            ui.NumberFormat = new NumberFormatInfo() { NumberDecimalSeparator = "." };

            Mapper.CreateMap<HojaInscripcionPaso1Model, HojaInscripcionPaso2Model>();
            Mapper.CreateMap<HojaInscripcionPaso2Model, HojaInscripcionPaso3Model>();
            Mapper.CreateMap<HojaInscripcionPaso3Model, SolicitudPostulante>()
                // Formulario paso 1
                .ForMember(d => d.FechaNacimiento, o => o.MapFrom(s => Convert.ToDateTime(s.FechaNacimiento, ui)))
                // .ForMember(d => d.FechaNacimiento, o => o.MapFrom(s => new DateTime(s.Anio.ToInt(), s.Mes.ToInt(), s.Dia.ToInt()).ToNullableDatetime()))
                .ForMember(d => d.TipoNacionalidad, o => o.MapFrom(s => s.Nacionalidad))

                // Formulario paso 2
                .ForMember(d => d.Ciudad, o => o.MapFrom(s => s.Region))
                .ForMember(d => d.Direccion, o => o.MapFrom(s =>
                    string.Format("{0} {1}",
                        string.IsNullOrWhiteSpace(s.CalleOAvenida) ? string.Empty : s.CalleOAvenida.Trim(),
                        string.IsNullOrWhiteSpace(s.Numero) ? string.Empty : s.Numero.Trim()).ToUpper()
                        ))
                .ForMember(d => d.Referencia, o => o.MapFrom(s => s.DptoCasa))
                .ForMember(d => d.Latitud, o => o.MapFrom(s => string.IsNullOrWhiteSpace(s.Latitud) ? 0 : s.Latitud.ToDecimal()))
                .ForMember(d => d.Longitud, o => o.MapFrom(s => string.IsNullOrWhiteSpace(s.Longitud) ? 0 : s.Longitud.ToDecimal()))
                .ForMember(d => d.LugarPadre, o => o.MapFrom(s => s.NombreRegion))
                .ForMember(d => d.LugarHijo, o => o.MapFrom(s => s.NombreComuna))

                // Formulario paso 3                

                .AfterMap((s, d) => d.Direccion = string.IsNullOrWhiteSpace(d.Direccion) ? null : d.Direccion.Trim())
                .AfterMap((s, d) => d.DireccionEntrega = string.IsNullOrWhiteSpace(d.DireccionEntrega) ? null : d.DireccionEntrega.Trim());


            Mapper.CreateMap<HojaInscripcionPaso1Model, Paso1CoreVm>();
            Mapper.CreateMap<HojaInscripcionPaso2Model, Paso2CoreVm>();
            Mapper.CreateMap<HojaInscripcionPaso3Model, Paso3CoreVm>();
        }
    }
}