GO
USE BelcorpPeru
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpMexico
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpColombia
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpSalvador
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpPuertoRico
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpPanama
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpGuatemala
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpEcuador
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpDominicana
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpCostaRica
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpChile
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
USE BelcorpBolivia
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_COMPARTIR')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_COMPARTIR',0,'¡Hola! te invito a conocer mi catálogo digital donde podrás encontrar los mejores productos que te trae Ésika, L´Bel y Cyzone. No te olvides que me puedes mandar tu pedido desde el mismo catálogo ',null,null,'mensaje al compartir catálogo por redes sociales',1,null)
	END
END


GO
