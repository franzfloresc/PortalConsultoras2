﻿using AutoMapper;
using Portal.Consultoras.Data.Hana.HanaService;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data.Hana.AutoMapper
{
    public class HanaEntitiesToBEEntititesMappingProfile: Profile
    {
        public override string ProfileName
        {
            get { return "HanaEntitiesToBEEntititesMappingProfile"; }
        }

        protected override void Configure()
        {
            Mapper.CreateMap<CuentaCorriente, BEEstadoCuenta>()
                .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.codigo.ToString()))
                .ForMember(t => t.FechaRegistro, f => f.MapFrom(c => c.fechaRegistro))
                .ForMember(t => t.DescripcionOperacion, f => f.MapFrom(c => c.descripcionOperacion))
                .ForMember(t => t.MontoOperacion, f => f.MapFrom(c => c.montoOperacion))
                .ForMember(t => t.TipoOperacion, f => f.MapFrom(c => c.tipoCargoAbono));
        }
    }
}
