var fallingObjects = new Array();

function newObject(url, height, width) {
    fallingObjects[fallingObjects.length] = new Array(url, height, width);
}

var numObjects = 8,
	waft = 50,
	fallSpeed = 4,
	wind = 0;
newObject("https://gallery.mailchimp.com/883823c911a0035bf43f31618/images/9e284583-5cb7-4ae0-9cd1-5a4e59afb5c8.png", 22, 22);
newObject("https://gallery.mailchimp.com/883823c911a0035bf43f31618/images/9e284583-5cb7-4ae0-9cd1-5a4e59afb5c8.png", 35, 35);

function winSize() {
    winWidthSR = (moz) ? window.innerWidth - 180 : document.body.clientWidth - 180;
    winHeightSR = (moz) ? window.innerHeight - 200 : document.body.clientHeight - 200;
}

function winOfy() {
    winOffset = (moz) ? window.pageYOffset : document.body.scrollTop;
}

function fallObject(num, vari, nu) {
    objects[num] = new Array(parseInt(Math.random() * (winWidthSR - waft)), -30, (parseInt(Math.random() * waft)) * ((Math.random() > 0.5) ? 1 : -1), 0.02 + Math.random() / 20, 0, 1 + parseInt(Math.random() * fallSpeed), vari, fallingObjects[vari][1], fallingObjects[vari][2]);
    if (nu == 1) {
        $('body').append('<img id="fO' + i + '" style="position:absolute; z-index:999999;" src="' + fallingObjects[vari][0] + '" width="' + fallingObjects[vari][1] + '">');
    }
}

function fall() {
	for (i = 0; i < numObjects; i++) {
		var fallingObject = document.getElementById('fO' + i);
		if ((objects[i][1] > (winHeightSR - (objects[i][5] + objects[i][7]))) || (objects[i][0] > (winWidthSR - (objects[i][2] + objects[i][8])))) {
			fallObject(i, objects[i][6], 0);
		}
		objects[i][0] += wind;
		objects[i][1] += objects[i][5];
		objects[i][4] += objects[i][3];
		var k = (100 - (objects[i][1] * 100 / winHeightSR)) / 100;
			k = Math.round(k * 100) / 100;
		with(fallingObject.style) {
			top = objects[i][1] + winOffset + 'px';
			left = objects[i][0] + (objects[i][2] * Math.cos(objects[i][4])) + 'px';
			opacity = k;
		}
	}
	setTimeout("fall()", 30);
	$("img[id^='fO']").show();
}

var objects = new Array(),
	winOffset = 0,
	winHeightSR, winWidthSR, togvis, moz = (document.getElementById && !document.all) ? 1 : 0;
winSize();
for (i = 0; i < numObjects; i++) {
    fallObject(i, parseInt(Math.random() * fallingObjects.length), 1);
}
fall();