GO
USE BelcorpPeru
GO
declare @id int;
if not exists (select * from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS')
BEGIN
	insert into configuracionpais
	values ('COMPARTIR_CATALOGO_RRSS', 0, 'compartir catálogo por redes sociales',1,0,0,null,null,null,1,null,null,null,null,null,null,null,null,null,0,0,0);

	 SELECT @id = @@IDENTITY
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
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
	 insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
END
ELSE
BEGIN
	SELECT @id = ConfiguracionPaisID from configuracionpais WHERE codigo = 'COMPARTIR_CATALOGO_RRSS'

	if NOT EXISTS (select * from configuracionpaisDatos WHERE codigo = 'MENSAJE_PRINCIPAL')
	BEGIN
		insert into configuracionpaisDatos values (@id,'MENSAJE_PRINCIPAL',0,'Comparte tu catálogo digital a través de un link único a tus clientes y ellos podrán enviar sus pedidos desde ahí para que tú los apruebes desde tu app o Somos Belcorp.',null,null,'mensaje en la pantalla principal de catalogos (antes de compartir)',1,null)
	END
END


GO
