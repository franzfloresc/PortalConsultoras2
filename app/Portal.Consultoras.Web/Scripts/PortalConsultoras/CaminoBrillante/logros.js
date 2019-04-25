﻿$(document).ready(function () {
    cargarLogros(categoriaLogro)
});

function cargarLogros(category) {
    waitingDialog();
    $.ajax({
        type: 'GET',
        url: urlGetLogros,
        data: { category: category},
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                var htmlDiv = SetHandlebars("#template-logros", data.data);
                $('#logros').append(htmlDiv);
                $('#logros').show();                
             }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            $('#loadingScreen').hide();
        }
    });
}

function ComoLograrlo(categoria, caracteristica,titulo,descripcion) {
   
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios – Mis Logros',
        'action': { categoria } + '–' + { caracteristica},
        'label': 'Selección: ¿Cómo lograrlo?'
    });

    if (titulo != "" && descripcion != "") {
     
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Nivel y beneficios – Mis Logros',
            'action': { categoria } + '–' + { caracteristica },
            'label': 'Ver Detalle: ¿Cómo lograrlo?'
        });
    }
}

function CerrarComoLograrlo(categoria, caracteristica) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios – Mis Logros',
        'action': { categoria } + '–' + { caracteristica },
        'label': ' Cerrar detalle: ¿Cómo lograrlo?'
    });
}
