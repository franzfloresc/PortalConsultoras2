$(document).ready(function () {
   
});

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
