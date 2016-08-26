ALTER TABLE MenuMobile
ALTER COLUMN Descripcion VARCHAR(70) NOT NULL

--SELECT * FROM MenuMobile
DELETE MenuMobile
WHERE Posicion = 'Footer'

--PADRES

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (100
						,'Ayuda'
						,0
						,3
						,''
						,''
						,0
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (101
						,'Legal'
						,0
						,4
						,''
						,''
						,0
						,'Footer'
						,'Completa')

--HIJOS

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (102
						,'Preguntas Frecuentes'
						,100
						,1
						,'http://comunidad.somosbelcorp.com/t5/Blog-editorial/RESUELVE-TUS-DUDAS-O-ADQUIERE-TUS-PRODUCTOS-FAVORITOS/ba-p/9082'
						,''
						,1
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (103
						,'Contáctanos'
						,100
						,2
						,'http://belcorprespondeqa.somosbelcorp.com/'
						,''
						,1
						,'Footer'
						,'Mobile')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (104
						,'Tutorial'
						,100
						,3
						,''
						,''
						,1
						,'Footer'
						,'Completa')

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (105
						,'Política de privacidad'
						,101
						,1
						,'https://www.somosbelcorp.com/Content/FAQ/POLITICA_DE_PRIVACIDAD_PE.pdf'
						,''
						,1
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (106
						,'Condiciones de uso web'
						,101
						,2
						,'https://www.somosbelcorp.com/Content/FAQ/CONDICIONES_DE_USO_WEB_PE.pdf'
						,''
						,1
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (107
						,'Procedimiento y formulario para el ejercicio de derechos arco'
						,101
						,3
						,'https://www.somosbelcorp.com/Content/FAQ/PROCEDIMIENTO_Y_FORMULARIO_PARA_EL_EJERCICIO_DE_DERECHOS_ARCO_PE.pdf'
						,''
						,1
						,'Footer'
						,'Completa')