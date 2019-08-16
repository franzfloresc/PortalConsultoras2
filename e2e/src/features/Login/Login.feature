Feature: Realizar el ingreso al portal web Somos Belcorp
  Como una consultora suscrita
  Yo quiero ingresar al portal Somos Belcorp
  para ver mi estado de cuenta, mis ganancias e ingresar mi pedido
   
@Login @LoginExitoso
Scenario Outline:  Login exitoso
    Given Ingreso el "<Pais>"  mi "<Usuario>" y mi "<Password>"
    When  click en el boton "Ingresa a tu cuenta" 
    Then  puedo ver mi estado de cuenta, mis ganancias e ingresar mi pedido
    Then  cierro la sesion
    

Examples:
    |Pais   |Usuario              |Password | 
    |PE     |usuariopruebape      |1234567|
    |CO     |0052036722           |0052036722|
    |MX     |usuariopruebamx      |1234567|
    |CR     |usuariopruebacr      |1234567|
    |CL     |157225960            |fdwhh6bh|
    |BO     |usuariopruebabo      |1234567|
    |SV     |usuariopruebasv      |1234567|
    |GT     |usuariopruebagt      |1234567|
    |PA     |usuariopruebapa      |1234567|
    |PR     |usuariopruebapr      |1234567|
    |EC     |usuariopruebaec      |1234567|
    |DO     |usuariopruebado      |1234567|