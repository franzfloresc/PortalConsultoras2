var emt_chat = "";

$(document).ready(function (){
		var route= "https://web.emtelco.co/yggdrasil/belcorp/emt_chat";
        
        emt_chat += '<link href="' + route +'/css/style-client.css" rel="stylesheet"><link rel="stylesheet" href="' + route +'/css/font-awesome.min.css"><div class="CMXD-containment-wrapper"></div><div id="marca"> <div class="CMXD-btn-help"> <div id="btn_init" class="CMXD-help"></div><div id="btn_open" class="CMXD-open" style="display: none"></div></div><div class="container-movil"></div><div id="CMXD-container-chat" class="CMXD-container-chat" style="display: none"> <div class="CMXD-header-chat"><i class="fa fa-comments-o" aria-hidden="true"></i>CHAT EN LÍNEA <div class="CMXD-icons"><a class="display-a" id="btn_minimize" href=""><i class="fa fa-minus" aria-hidden="true"></i></a><a class="display-a" id="btn_wClose" href="" style="display: none"><i class="fa fa-times" aria-hidden="true"></i></a><a class="display-a" id="btn_PollClose" href="" style="display: none"><i class="fa fa-times" aria-hidden="true"/></a></div><hr class="CMXD-line"> </div><div id="chat"> <div id="interaction" class="CMXD-container-welcome" style="display: none"> <div class="chat-wrapper"> <div id="transcript" class="chat-message padding container-chat"></div></div><div id="slideDownTranscript" class="message-end CMXD-animate2"><span class="fa fa-angle-double-down"></span></div><div class="container-txt"> <textarea class="txtarea" rows="2" id="Entry" placeholder="Escribe un Mensaje..." disabled="disabled"></textarea> <a class="" href=""> <div class="send send2" id="btn_Send"><i class="fa fa-paper-plane-o" aria-hidden="true"></i> <br>Enviar</div></a><div id="CMXD-emogi"><i class="fa fa-smile-o" title="Emoticones"></i> <span>Emoticones</span></div><div class="CMXD-emogi-container"><ul class="CMXD-emogi-content"></ul></div></div></div><div id="loading" class="pop-up"> <div class="CMXD-container-welcome"> <div class="CMXD-img-welcome"><img id="loading_image" src="" alt=""></div><div id="loading_title" class="CMXD-welcome">Bienvenida a nuestro <br>chat en línea</div><div id="loading_description" class="CMXD-description">En un momento uno de nuestros asesores estará contigo</div></div></div><div id="schedule" class="pop-up"> <div class="CMXD-container-welcome"> <div class="CMXD-img-welcome"><img id="schedule_image" src="" alt="Imagen fuera de horario"></div><div id="schedule_title" class="CMXD-welcome"></div><div id="schedule_description" class="CMXD-description"></div></div></div><div id="Error" class="pop-up"> <div class="CMXD-container-welcome"> <div class="CMXD-img-welcome"><img id="Error_image" src="" alt=""></div><div class="CMXD-welcome">Error de conexión</div><div class="CMXD-description">En estos momentos no es posible establecer conexión.Por favor intenta más tarde. <br/> <br/><a href="" class="btn-no display-a" id="btn_mclose">OK</a></div></div></div><div id="alert" class="pop-up"> <div class="CMXD-container-welcome"> <div class="CMXD-img-welcome"><img id="alert_image" src="" alt=""></div><div class="CMXD-welcome">¿Desea cerrar la sesión de chat?</div><div class="CMXD-description"><a href="" class="btn-yes display-a" id="btn_close">Si</a><a href="" class="btn-no display-a" id="btn_nwClose">No</a></div></div></div></div><div id="poll"> <div class="CMXD-container-welcome"> <div id="poll_title" class="CMXD-welcome"> <div id="poll_description" class="CMXD-poll-description"> <iframe id="pollEmbed" frameborder="0" style="overflow:hidden;height:100%;width:100%" height="100%" width="100%" seamless allowfullscreen></iframe> </div></div></div></div></div><script type="text/javascript" src="' + route +'/js/gen.js"></script>';

        //Inserción del chat en la ágina del cliente
        $("body").after(emt_chat);

        if (typeof OcultarChatEmtelco === 'function') {
            OcultarChatEmtelco();
        }
});