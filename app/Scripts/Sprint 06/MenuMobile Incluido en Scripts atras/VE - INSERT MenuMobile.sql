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
						,'Términos y Condiciones'
						,101
						,1
						,'https://www.somosbelcorp.com/WebPages/TerminosyReferencias_VE.aspx'
						,''
						,1
						,'Footer'
						,'Completa')