USE BelcorpBolivia
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpChile
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpColombia
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpCostaRica
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpDominicana
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpEcuador
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpGuatemala
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpMexico
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpPanama
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpPeru
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpPuertoRico
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO
/*end*/

USE BelcorpSalvador
GO
declare @TablaLogicaID smallint = 145;
declare @CodigoEsCupon varchar(150) = 'ESCUPONNUEVAS';
declare @CodigoEsElecMultiple varchar(150) = 'ESELECMULTIPLENUEVAS';

delete TablaLogicaDatos
where TablaLogicaID = @TablaLogicaID and Codigo in (@CodigoEsCupon, @CodigoEsElecMultiple);

insert into TablaLogicaDatos
values
	(14518, @TablaLogicaID, @CodigoEsCupon, 'PACK DE NUEVAS', null),
	(14519, @TablaLogicaID, @CodigoEsElecMultiple, 'DÚO PERFECTO', null);
GO