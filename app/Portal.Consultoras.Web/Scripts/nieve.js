var fallingObjects = new Array();
var listaIconoLluvia = listaIconoLluvia || null;
var iconoLluvia = iconoLluvia || null;
var esMobile = isMobile();
var vfallSpeed = vfallSpeed || 15;
var vnumObjects = vnumObjects || 100;
var noIniciarLluvia = noIniciarLluvia || false;
var lluviaContainerId = lluviaContainerId || 'body';
var closeImagenRain = 0;    //si es 0 se mostrara,
var timeCloseRain = timeCloseRain || 30000;   //tiempo de visualización del efecto
var esShowRoom = esShowRoom || false;

var numObjects = vnumObjects,
	waft = 50,
    fallSpeed = vfallSpeed,
	wind = 0;

var heightIcon = esMobile ? 7 : 10;
var widthIcon = esMobile ? 7 : 10;

var objects = new Array(),
    timer,
    winOffset = 0,
    winHeightSR, winWidthSR, togvis, moz = (document.getElementById && !document.all) ? 1 : 0;

function mostrarLluvia() {
    fallingObjects = new Array();
    objects = new Array();

    closeImagenRain = 0;
    if (listaIconoLluvia != null) {
        var par = 0;
        $.each(listaIconoLluvia, function (index, value) {
            newObject(value, heightIcon, widthIcon);
        });
    }
    else if (iconoLluvia != null) {
        if (esShowRoom) {
            newObject(iconoLluvia, 22, 22);
            newObject(iconoLluvia, 35, 35);
        } else {
            newObject(iconoLluvia, heightIcon, widthIcon);
            newObject(iconoLluvia, heightIcon, widthIcon);
        }
    } else {
        return;
    }

    winSize();
    for (i = 0; i < numObjects; i++) {
        fallObject(i, parseInt(Math.random() * fallingObjects.length), 1);
    }

    fall();

    timer = setTimeout(function () {
        hideImages();
    }, timeCloseRain);

}

function ocultarLluvia() {
    if (timer) {
        clearTimeout(timer);
    }
    hideImages();
}

function hideImages() {
    closeImagenRain = 1;
    //$("img[id^='fO']").fadeOut(200);
    $("img[id^='fO']").remove();
}

function newObject(url, height, width) {
    fallingObjects[fallingObjects.length] = new Array(url, height, width);
}

function winSize() {
    winWidthSR = (moz) ? window.innerWidth - 20 : document.body.clientWidth - 20;
    winHeightSR = (moz) ? window.innerHeight : document.body.clientHeight;
}

function winOfy() {
    winOffset = (moz) ? window.pageYOffset : document.body.scrollTop;
}

function fallObject(num, vari, nu) {
    objects[num] = new Array(parseInt(Math.random() * (winWidthSR - waft)), -30, (parseInt(Math.random() * waft)) * ((Math.random() > 0.5) ? 1 : -1), 0.02 + Math.random() / 20, 0, 1 + parseInt(Math.random() * fallSpeed), vari, fallingObjects[vari][1], fallingObjects[vari][2]);
    if (nu == 1) {
        $(lluviaContainerId).append('<img id="fO' + i + '" style="position:absolute; z-index:999999;" src="' + fallingObjects[vari][0] + '" width="' + fallingObjects[vari][1] + '">');
    }
}

function fall() {
    for (i = 0; i < numObjects; i++) {
        var fallingObject = document.getElementById('fO' + i);
        if (!fallingObject) continue;

        if ((objects[i][1] > (winHeightSR - (objects[i][5] + objects[i][7]))) || (objects[i][0] > (winWidthSR - (objects[i][2] + objects[i][8])))) {
            fallObject(i, objects[i][6], 0);
        }
        objects[i][0] += wind;
        objects[i][1] += objects[i][5];
        objects[i][4] += objects[i][3];
        var k = (100 - (objects[i][1] * 100 / winHeightSR)) / 100;
        k = Math.round(k * 100) / 100;
        with (fallingObject.style) {
            top = objects[i][1] + winOffset + 'px';
            left = objects[i][0] + (objects[i][2] * Math.cos(objects[i][4])) + 'px';
            opacity = k;
        }
    }

    if (closeImagenRain == 0) {
        setTimeout("fall()", 15);
        $("img[id^='fO']").show();
    }
}

if (!noIniciarLluvia) {
    mostrarLluvia();
}