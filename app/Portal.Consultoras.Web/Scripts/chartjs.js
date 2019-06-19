/*!
 * Chart.js v2.8.0
 * https://www.chartjs.org
 * (c) 2019 Chart.js Contributors
 * Released under the MIT License
 */
! function(t, e) {
    "object" == typeof exports && "undefined" != typeof module ? module.exports = e(function() {
        try {
            return require("moment")
        } catch (t) {}
    }()) : "function" == typeof define && define.amd ? define(["require"], function(t) {
        return e(function() {
            try {
                return t("moment")
            } catch (t) {}
        }())
    }) : t.Chart = e(t.moment)
}(this, function(t) {
    "use strict";
    t = t && t.hasOwnProperty("default") ? t.default : t;
    var e = {
        rgb2hsl: i,
        rgb2hsv: n,
        rgb2hwb: a,
        rgb2cmyk: o,
        rgb2keyword: s,
        rgb2xyz: l,
        rgb2lab: d,
        rgb2lch: function(t) {
            return x(d(t))
        },
        hsl2rgb: u,
        hsl2hsv: function(t) {
            var e = t[0],
                i = t[1] / 100,
                n = t[2] / 100;
            if (0 === n) return [0, 0, 0];
            return [e, 100 * (2 * (i *= (n *= 2) <= 1 ? n : 2 - n) / (n + i)), 100 * ((n + i) / 2)]
        },
        hsl2hwb: function(t) {
            return a(u(t))
        },
        hsl2cmyk: function(t) {
            return o(u(t))
        },
        hsl2keyword: function(t) {
            return s(u(t))
        },
        hsv2rgb: h,
        hsv2hsl: function(t) {
            var e, i, n = t[0],
                a = t[1] / 100,
                o = t[2] / 100;
            return e = a * o, [n, 100 * (e = (e /= (i = (2 - a) * o) <= 1 ? i : 2 - i) || 0), 100 * (i /= 2)]
        },
        hsv2hwb: function(t) {
            return a(h(t))
        },
        hsv2cmyk: function(t) {
            return o(h(t))
        },
        hsv2keyword: function(t) {
            return s(h(t))
        },
        hwb2rgb: c,
        hwb2hsl: function(t) {
            return i(c(t))
        },
        hwb2hsv: function(t) {
            return n(c(t))
        },
        hwb2cmyk: function(t) {
            return o(c(t))
        },
        hwb2keyword: function(t) {
            return s(c(t))
        },
        cmyk2rgb: f,
        cmyk2hsl: function(t) {
            return i(f(t))
        },
        cmyk2hsv: function(t) {
            return n(f(t))
        },
        cmyk2hwb: function(t) {
            return a(f(t))
        },
        cmyk2keyword: function(t) {
            return s(f(t))
        },
        keyword2rgb: w,
        keyword2hsl: function(t) {
            return i(w(t))
        },
        keyword2hsv: function(t) {
            return n(w(t))
        },
        keyword2hwb: function(t) {
            return a(w(t))
        },
        keyword2cmyk: function(t) {
            return o(w(t))
        },
        keyword2lab: function(t) {
            return d(w(t))
        },
        keyword2xyz: function(t) {
            return l(w(t))
        },
        xyz2rgb: p,
        xyz2lab: m,
        xyz2lch: function(t) {
            return x(m(t))
        },
        lab2xyz: v,
        lab2rgb: y,
        lab2lch: x,
        lch2lab: k,
        lch2xyz: function(t) {
            return v(k(t))
        },
        lch2rgb: function(t) {
            return y(k(t))
        }
    };

    function i(t) {
        var e, i, n = t[0] / 255,
            a = t[1] / 255,
            o = t[2] / 255,
            r = Math.min(n, a, o),
            s = Math.max(n, a, o),
            l = s - r;
        return s == r ? e = 0 : n == s ? e = (a - o) / l : a == s ? e = 2 + (o - n) / l : o == s && (e = 4 + (n - a) / l), (e = Math.min(60 * e, 360)) < 0 && (e += 360), i = (r + s) / 2, [e, 100 * (s == r ? 0 : i <= .5 ? l / (s + r) : l / (2 - s - r)), 100 * i]
    }

    function n(t) {
        var e, i, n = t[0],
            a = t[1],
            o = t[2],
            r = Math.min(n, a, o),
            s = Math.max(n, a, o),
            l = s - r;
        return i = 0 == s ? 0 : l / s * 1e3 / 10, s == r ? e = 0 : n == s ? e = (a - o) / l : a == s ? e = 2 + (o - n) / l : o == s && (e = 4 + (n - a) / l), (e = Math.min(60 * e, 360)) < 0 && (e += 360), [e, i, s / 255 * 1e3 / 10]
    }

    function a(t) {
        var e = t[0],
            n = t[1],
            a = t[2];
        return [i(t)[0], 100 * (1 / 255 * Math.min(e, Math.min(n, a))), 100 * (a = 1 - 1 / 255 * Math.max(e, Math.max(n, a)))]
    }

    function o(t) {
        var e, i = t[0] / 255,
            n = t[1] / 255,
            a = t[2] / 255;
        return [100 * ((1 - i - (e = Math.min(1 - i, 1 - n, 1 - a))) / (1 - e) || 0), 100 * ((1 - n - e) / (1 - e) || 0), 100 * ((1 - a - e) / (1 - e) || 0), 100 * e]
    }

    function s(t) {
        return _[JSON.stringify(t)]
    }

    function l(t) {
        var e = t[0] / 255,
            i = t[1] / 255,
            n = t[2] / 255;
        return [100 * (.4124 * (e = e > .04045 ? Math.pow((e + .055) / 1.055, 2.4) : e / 12.92) + .3576 * (i = i > .04045 ? Math.pow((i + .055) / 1.055, 2.4) : i / 12.92) + .1805 * (n = n > .04045 ? Math.pow((n + .055) / 1.055, 2.4) : n / 12.92)), 100 * (.2126 * e + .7152 * i + .0722 * n), 100 * (.0193 * e + .1192 * i + .9505 * n)]
    }

    function d(t) {
        var e = l(t),
            i = e[0],
            n = e[1],
            a = e[2];
        return n /= 100, a /= 108.883, i = (i /= 95.047) > .008856 ? Math.pow(i, 1 / 3) : 7.787 * i + 16 / 116, [116 * (n = n > .008856 ? Math.pow(n, 1 / 3) : 7.787 * n + 16 / 116) - 16, 500 * (i - n), 200 * (n - (a = a > .008856 ? Math.pow(a, 1 / 3) : 7.787 * a + 16 / 116))]
    }

    function u(t) {
        var e, i, n, a, o, r = t[0] / 360,
            s = t[1] / 100,
            l = t[2] / 100;
        if (0 == s) return [o = 255 * l, o, o];
        e = 2 * l - (i = l < .5 ? l * (1 + s) : l + s - l * s), a = [0, 0, 0];
        for (var d = 0; d < 3; d++)(n = r + 1 / 3 * -(d - 1)) < 0 && n++, n > 1 && n--, o = 6 * n < 1 ? e + 6 * (i - e) * n : 2 * n < 1 ? i : 3 * n < 2 ? e + (i - e) * (2 / 3 - n) * 6 : e, a[d] = 255 * o;
        return a
    }

    function h(t) {
        var e = t[0] / 60,
            i = t[1] / 100,
            n = t[2] / 100,
            a = Math.floor(e) % 6,
            o = e - Math.floor(e),
            r = 255 * n * (1 - i),
            s = 255 * n * (1 - i * o),
            l = 255 * n * (1 - i * (1 - o));
        n *= 255;
        switch (a) {
            case 0:
                return [n, l, r];
            case 1:
                return [s, n, r];
            case 2:
                return [r, n, l];
            case 3:
                return [r, s, n];
            case 4:
                return [l, r, n];
            case 5:
                return [n, r, s]
        }
    }

    function c(t) {
        var e, i, n, a, o = t[0] / 360,
            s = t[1] / 100,
            l = t[2] / 100,
            d = s + l;
        switch (d > 1 && (s /= d, l /= d), n = 6 * o - (e = Math.floor(6 * o)), 0 != (1 & e) && (n = 1 - n), a = s + n * ((i = 1 - l) - s), e) {
            default:
            case 6:
            case 0:
                r = i, g = a, b = s;
                break;
            case 1:
                r = a, g = i, b = s;
                break;
            case 2:
                r = s, g = i, b = a;
                break;
            case 3:
                r = s, g = a, b = i;
                break;
            case 4:
                r = a, g = s, b = i;
                break;
            case 5:
                r = i, g = s, b = a
        }
        return [255 * r, 255 * g, 255 * b]
    }

    function f(t) {
        var e = t[0] / 100,
            i = t[1] / 100,
            n = t[2] / 100,
            a = t[3] / 100;
        return [255 * (1 - Math.min(1, e * (1 - a) + a)), 255 * (1 - Math.min(1, i * (1 - a) + a)), 255 * (1 - Math.min(1, n * (1 - a) + a))]
    }

    function p(t) {
        var e, i, n, a = t[0] / 100,
            o = t[1] / 100,
            r = t[2] / 100;
        return i = -.9689 * a + 1.8758 * o + .0415 * r, n = .0557 * a + -.204 * o + 1.057 * r, e = (e = 3.2406 * a + -1.5372 * o + -.4986 * r) > .0031308 ? 1.055 * Math.pow(e, 1 / 2.4) - .055 : e *= 12.92, i = i > .0031308 ? 1.055 * Math.pow(i, 1 / 2.4) - .055 : i *= 12.92, n = n > .0031308 ? 1.055 * Math.pow(n, 1 / 2.4) - .055 : n *= 12.92, [255 * (e = Math.min(Math.max(0, e), 1)), 255 * (i = Math.min(Math.max(0, i), 1)), 255 * (n = Math.min(Math.max(0, n), 1))]
    }

    function m(t) {
        var e = t[0],
            i = t[1],
            n = t[2];
        return i /= 100, n /= 108.883, e = (e /= 95.047) > .008856 ? Math.pow(e, 1 / 3) : 7.787 * e + 16 / 116, [116 * (i = i > .008856 ? Math.pow(i, 1 / 3) : 7.787 * i + 16 / 116) - 16, 500 * (e - i), 200 * (i - (n = n > .008856 ? Math.pow(n, 1 / 3) : 7.787 * n + 16 / 116))]
    }

    function v(t) {
        var e, i, n, a, o = t[0],
            r = t[1],
            s = t[2];
        return o <= 8 ? a = (i = 100 * o / 903.3) / 100 * 7.787 + 16 / 116 : (i = 100 * Math.pow((o + 16) / 116, 3), a = Math.pow(i / 100, 1 / 3)), [e = e / 95.047 <= .008856 ? e = 95.047 * (r / 500 + a - 16 / 116) / 7.787 : 95.047 * Math.pow(r / 500 + a, 3), i, n = n / 108.883 <= .008859 ? n = 108.883 * (a - s / 200 - 16 / 116) / 7.787 : 108.883 * Math.pow(a - s / 200, 3)]
    }

    function x(t) {
        var e, i = t[0],
            n = t[1],
            a = t[2];
        return (e = 360 * Math.atan2(a, n) / 2 / Math.PI) < 0 && (e += 360), [i, Math.sqrt(n * n + a * a), e]
    }

    function y(t) {
        return p(v(t))
    }

    function k(t) {
        var e, i = t[0],
            n = t[1];
        return e = t[2] / 360 * 2 * Math.PI, [i, n * Math.cos(e), n * Math.sin(e)]
    }

    function w(t) {
        return M[t]
    }
    var M = {
            aliceblue: [240, 248, 255],
            antiquewhite: [250, 235, 215],
            aqua: [0, 255, 255],
            aquamarine: [127, 255, 212],
            azure: [240, 255, 255],
            beige: [245, 245, 220],
            bisque: [255, 228, 196],
            black: [0, 0, 0],
            blanchedalmond: [255, 235, 205],
            blue: [0, 0, 255],
            blueviolet: [138, 43, 226],
            brown: [165, 42, 42],
            burlywood: [222, 184, 135],
            cadetblue: [95, 158, 160],
            chartreuse: [127, 255, 0],
            chocolate: [210, 105, 30],
            coral: [255, 127, 80],
            cornflowerblue: [100, 149, 237],
            cornsilk: [255, 248, 220],
            crimson: [220, 20, 60],
            cyan: [0, 255, 255],
            darkblue: [0, 0, 139],
            darkcyan: [0, 139, 139],
            darkgoldenrod: [184, 134, 11],
            darkgray: [169, 169, 169],
            darkgreen: [0, 100, 0],
            darkgrey: [169, 169, 169],
            darkkhaki: [189, 183, 107],
            darkmagenta: [139, 0, 139],
            darkolivegreen: [85, 107, 47],
            darkorange: [255, 140, 0],
            darkorchid: [153, 50, 204],
            darkred: [139, 0, 0],
            darksalmon: [233, 150, 122],
            darkseagreen: [143, 188, 143],
            darkslateblue: [72, 61, 139],
            darkslategray: [47, 79, 79],
            darkslategrey: [47, 79, 79],
            darkturquoise: [0, 206, 209],
            darkviolet: [148, 0, 211],
            deeppink: [255, 20, 147],
            deepskyblue: [0, 191, 255],
            dimgray: [105, 105, 105],
            dimgrey: [105, 105, 105],
            dodgerblue: [30, 144, 255],
            firebrick: [178, 34, 34],
            floralwhite: [255, 250, 240],
            forestgreen: [34, 139, 34],
            fuchsia: [255, 0, 255],
            gainsboro: [220, 220, 220],
            ghostwhite: [248, 248, 255],
            gold: [255, 215, 0],
            goldenrod: [218, 165, 32],
            gray: [128, 128, 128],
            green: [0, 128, 0],
            greenyellow: [173, 255, 47],
            grey: [128, 128, 128],
            honeydew: [240, 255, 240],
            hotpink: [255, 105, 180],
            indianred: [205, 92, 92],
            indigo: [75, 0, 130],
            ivory: [255, 255, 240],
            khaki: [240, 230, 140],
            lavender: [230, 230, 250],
            lavenderblush: [255, 240, 245],
            lawngreen: [124, 252, 0],
            lemonchiffon: [255, 250, 205],
            lightblue: [173, 216, 230],
            lightcoral: [240, 128, 128],
            lightcyan: [224, 255, 255],
            lightgoldenrodyellow: [250, 250, 210],
            lightgray: [211, 211, 211],
            lightgreen: [144, 238, 144],
            lightgrey: [211, 211, 211],
            lightpink: [255, 182, 193],
            lightsalmon: [255, 160, 122],
            lightseagreen: [32, 178, 170],
            lightskyblue: [135, 206, 250],
            lightslategray: [119, 136, 153],
            lightslategrey: [119, 136, 153],
            lightsteelblue: [176, 196, 222],
            lightyellow: [255, 255, 224],
            lime: [0, 255, 0],
            limegreen: [50, 205, 50],
            linen: [250, 240, 230],
            magenta: [255, 0, 255],
            maroon: [128, 0, 0],
            mediumaquamarine: [102, 205, 170],
            mediumblue: [0, 0, 205],
            mediumorchid: [186, 85, 211],
            mediumpurple: [147, 112, 219],
            mediumseagreen: [60, 179, 113],
            mediumslateblue: [123, 104, 238],
            mediumspringgreen: [0, 250, 154],
            mediumturquoise: [72, 209, 204],
            mediumvioletred: [199, 21, 133],
            midnightblue: [25, 25, 112],
            mintcream: [245, 255, 250],
            mistyrose: [255, 228, 225],
            moccasin: [255, 228, 181],
            navajowhite: [255, 222, 173],
            navy: [0, 0, 128],
            oldlace: [253, 245, 230],
            olive: [128, 128, 0],
            olivedrab: [107, 142, 35],
            orange: [255, 165, 0],
            orangered: [255, 69, 0],
            orchid: [218, 112, 214],
            palegoldenrod: [238, 232, 170],
            palegreen: [152, 251, 152],
            paleturquoise: [175, 238, 238],
            palevioletred: [219, 112, 147],
            papayawhip: [255, 239, 213],
            peachpuff: [255, 218, 185],
            peru: [205, 133, 63],
            pink: [255, 192, 203],
            plum: [221, 160, 221],
            powderblue: [176, 224, 230],
            purple: [128, 0, 128],
            rebeccapurple: [102, 51, 153],
            red: [255, 0, 0],
            rosybrown: [188, 143, 143],
            royalblue: [65, 105, 225],
            saddlebrown: [139, 69, 19],
            salmon: [250, 128, 114],
            sandybrown: [244, 164, 96],
            seagreen: [46, 139, 87],
            seashell: [255, 245, 238],
            sienna: [160, 82, 45],
            silver: [192, 192, 192],
            skyblue: [135, 206, 235],
            slateblue: [106, 90, 205],
            slategray: [112, 128, 144],
            slategrey: [112, 128, 144],
            snow: [255, 250, 250],
            springgreen: [0, 255, 127],
            steelblue: [70, 130, 180],
            tan: [210, 180, 140],
            teal: [0, 128, 128],
            thistle: [216, 191, 216],
            tomato: [255, 99, 71],
            turquoise: [64, 224, 208],
            violet: [238, 130, 238],
            wheat: [245, 222, 179],
            white: [255, 255, 255],
            whitesmoke: [245, 245, 245],
            yellow: [255, 255, 0],
            yellowgreen: [154, 205, 50]
        },
        _ = {};
    for (var C in M) _[JSON.stringify(M[C])] = C;
    var S = function() {
        return new T
    };
    for (var P in e) {
        S[P + "Raw"] = function(t) {
            return function(i) {
                return "number" == typeof i && (i = Array.prototype.slice.call(arguments)), e[t](i)
            }
        }(P);
        var I = /(\w+)2(\w+)/.exec(P),
            A = I[1],
            D = I[2];
        (S[A] = S[A] || {})[D] = S[P] = function(t) {
            return function(i) {
                "number" == typeof i && (i = Array.prototype.slice.call(arguments));
                var n = e[t](i);
                if ("string" == typeof n || void 0 === n) return n;
                for (var a = 0; a < n.length; a++) n[a] = Math.round(n[a]);
                return n
            }
        }(P)
    }
    var T = function() {
        this.convs = {}
    };
    T.prototype.routeSpace = function(t, e) {
        var i = e[0];
        return void 0 === i ? this.getValues(t) : ("number" == typeof i && (i = Array.prototype.slice.call(e)), this.setValues(t, i))
    }, T.prototype.setValues = function(t, e) {
        return this.space = t, this.convs = {}, this.convs[t] = e, this
    }, T.prototype.getValues = function(t) {
        var e = this.convs[t];
        if (!e) {
            var i = this.space,
                n = this.convs[i];
            e = S[i][t](n), this.convs[t] = e
        }
        return e
    }, ["rgb", "hsl", "hsv", "cmyk", "keyword"].forEach(function(t) {
        T.prototype[t] = function(e) {
            return this.routeSpace(t, arguments)
        }
    });
    var F = S,
        L = {
            aliceblue: [240, 248, 255],
            antiquewhite: [250, 235, 215],
            aqua: [0, 255, 255],
            aquamarine: [127, 255, 212],
            azure: [240, 255, 255],
            beige: [245, 245, 220],
            bisque: [255, 228, 196],
            black: [0, 0, 0],
            blanchedalmond: [255, 235, 205],
            blue: [0, 0, 255],
            blueviolet: [138, 43, 226],
            brown: [165, 42, 42],
            burlywood: [222, 184, 135],
            cadetblue: [95, 158, 160],
            chartreuse: [127, 255, 0],
            chocolate: [210, 105, 30],
            coral: [255, 127, 80],
            cornflowerblue: [100, 149, 237],
            cornsilk: [255, 248, 220],
            crimson: [220, 20, 60],
            cyan: [0, 255, 255],
            darkblue: [0, 0, 139],
            darkcyan: [0, 139, 139],
            darkgoldenrod: [184, 134, 11],
            darkgray: [169, 169, 169],
            darkgreen: [0, 100, 0],
            darkgrey: [169, 169, 169],
            darkkhaki: [189, 183, 107],
            darkmagenta: [139, 0, 139],
            darkolivegreen: [85, 107, 47],
            darkorange: [255, 140, 0],
            darkorchid: [153, 50, 204],
            darkred: [139, 0, 0],
            darksalmon: [233, 150, 122],
            darkseagreen: [143, 188, 143],
            darkslateblue: [72, 61, 139],
            darkslategray: [47, 79, 79],
            darkslategrey: [47, 79, 79],
            darkturquoise: [0, 206, 209],
            darkviolet: [148, 0, 211],
            deeppink: [255, 20, 147],
            deepskyblue: [0, 191, 255],
            dimgray: [105, 105, 105],
            dimgrey: [105, 105, 105],
            dodgerblue: [30, 144, 255],
            firebrick: [178, 34, 34],
            floralwhite: [255, 250, 240],
            forestgreen: [34, 139, 34],
            fuchsia: [255, 0, 255],
            gainsboro: [220, 220, 220],
            ghostwhite: [248, 248, 255],
            gold: [255, 215, 0],
            goldenrod: [218, 165, 32],
            gray: [128, 128, 128],
            green: [0, 128, 0],
            greenyellow: [173, 255, 47],
            grey: [128, 128, 128],
            honeydew: [240, 255, 240],
            hotpink: [255, 105, 180],
            indianred: [205, 92, 92],
            indigo: [75, 0, 130],
            ivory: [255, 255, 240],
            khaki: [240, 230, 140],
            lavender: [230, 230, 250],
            lavenderblush: [255, 240, 245],
            lawngreen: [124, 252, 0],
            lemonchiffon: [255, 250, 205],
            lightblue: [173, 216, 230],
            lightcoral: [240, 128, 128],
            lightcyan: [224, 255, 255],
            lightgoldenrodyellow: [250, 250, 210],
            lightgray: [211, 211, 211],
            lightgreen: [144, 238, 144],
            lightgrey: [211, 211, 211],
            lightpink: [255, 182, 193],
            lightsalmon: [255, 160, 122],
            lightseagreen: [32, 178, 170],
            lightskyblue: [135, 206, 250],
            lightslategray: [119, 136, 153],
            lightslategrey: [119, 136, 153],
            lightsteelblue: [176, 196, 222],
            lightyellow: [255, 255, 224],
            lime: [0, 255, 0],
            limegreen: [50, 205, 50],
            linen: [250, 240, 230],
            magenta: [255, 0, 255],
            maroon: [128, 0, 0],
            mediumaquamarine: [102, 205, 170],
            mediumblue: [0, 0, 205],
            mediumorchid: [186, 85, 211],
            mediumpurple: [147, 112, 219],
            mediumseagreen: [60, 179, 113],
            mediumslateblue: [123, 104, 238],
            mediumspringgreen: [0, 250, 154],
            mediumturquoise: [72, 209, 204],
            mediumvioletred: [199, 21, 133],
            midnightblue: [25, 25, 112],
            mintcream: [245, 255, 250],
            mistyrose: [255, 228, 225],
            moccasin: [255, 228, 181],
            navajowhite: [255, 222, 173],
            navy: [0, 0, 128],
            oldlace: [253, 245, 230],
            olive: [128, 128, 0],
            olivedrab: [107, 142, 35],
            orange: [255, 165, 0],
            orangered: [255, 69, 0],
            orchid: [218, 112, 214],
            palegoldenrod: [238, 232, 170],
            palegreen: [152, 251, 152],
            paleturquoise: [175, 238, 238],
            palevioletred: [219, 112, 147],
            papayawhip: [255, 239, 213],
            peachpuff: [255, 218, 185],
            peru: [205, 133, 63],
            pink: [255, 192, 203],
            plum: [221, 160, 221],
            powderblue: [176, 224, 230],
            purple: [128, 0, 128],
            rebeccapurple: [102, 51, 153],
            red: [255, 0, 0],
            rosybrown: [188, 143, 143],
            royalblue: [65, 105, 225],
            saddlebrown: [139, 69, 19],
            salmon: [250, 128, 114],
            sandybrown: [244, 164, 96],
            seagreen: [46, 139, 87],
            seashell: [255, 245, 238],
            sienna: [160, 82, 45],
            silver: [192, 192, 192],
            skyblue: [135, 206, 235],
            slateblue: [106, 90, 205],
            slategray: [112, 128, 144],
            slategrey: [112, 128, 144],
            snow: [255, 250, 250],
            springgreen: [0, 255, 127],
            steelblue: [70, 130, 180],
            tan: [210, 180, 140],
            teal: [0, 128, 128],
            thistle: [216, 191, 216],
            tomato: [255, 99, 71],
            turquoise: [64, 224, 208],
            violet: [238, 130, 238],
            wheat: [245, 222, 179],
            white: [255, 255, 255],
            whitesmoke: [245, 245, 245],
            yellow: [255, 255, 0],
            yellowgreen: [154, 205, 50]
        },
        R = {
            getRgba: O,
            getHsla: z,
            getRgb: function(t) {
                var e = O(t);
                return e && e.slice(0, 3)
            },
            getHsl: function(t) {
                var e = z(t);
                return e && e.slice(0, 3)
            },
            getHwb: B,
            getAlpha: function(t) {
                var e = O(t);
                if (e) return e[3];
                if (e = z(t)) return e[3];
                if (e = B(t)) return e[3]
            },
            hexString: function(t, e) {
                var e = void 0 !== e && 3 === t.length ? e : t[3];
                return "#" + H(t[0]) + H(t[1]) + H(t[2]) + (e >= 0 && e < 1 ? H(Math.round(255 * e)) : "")
            },
            rgbString: function(t, e) {
                if (e < 1 || t[3] && t[3] < 1) return N(t, e);
                return "rgb(" + t[0] + ", " + t[1] + ", " + t[2] + ")"
            },
            rgbaString: N,
            percentString: function(t, e) {
                if (e < 1 || t[3] && t[3] < 1) return W(t, e);
                var i = Math.round(t[0] / 255 * 100),
                    n = Math.round(t[1] / 255 * 100),
                    a = Math.round(t[2] / 255 * 100);
                return "rgb(" + i + "%, " + n + "%, " + a + "%)"
            },
            percentaString: W,
            hslString: function(t, e) {
                if (e < 1 || t[3] && t[3] < 1) return V(t, e);
                return "hsl(" + t[0] + ", " + t[1] + "%, " + t[2] + "%)"
            },
            hslaString: V,
            hwbString: function(t, e) {
                void 0 === e && (e = void 0 !== t[3] ? t[3] : 1);
                return "hwb(" + t[0] + ", " + t[1] + "%, " + t[2] + "%" + (void 0 !== e && 1 !== e ? ", " + e : "") + ")"
            },
            keyword: function(t) {
                return j[t.slice(0, 3)]
            }
        };

    function O(t) {
        if (t) {
            var e = [0, 0, 0],
                i = 1,
                n = t.match(/^#([a-fA-F0-9]{3,4})$/i),
                a = "";
            if (n) {
                a = (n = n[1])[3];
                for (var o = 0; o < e.length; o++) e[o] = parseInt(n[o] + n[o], 16);
                a && (i = Math.round(parseInt(a + a, 16) / 255 * 100) / 100)
            } else if (n = t.match(/^#([a-fA-F0-9]{6}([a-fA-F0-9]{2})?)$/i)) {
                a = n[2], n = n[1];
                for (o = 0; o < e.length; o++) e[o] = parseInt(n.slice(2 * o, 2 * o + 2), 16);
                a && (i = Math.round(parseInt(a, 16) / 255 * 100) / 100)
            } else if (n = t.match(/^rgba?\(\s*([+-]?\d+)\s*,\s*([+-]?\d+)\s*,\s*([+-]?\d+)\s*(?:,\s*([+-]?[\d\.]+)\s*)?\)$/i)) {
                for (o = 0; o < e.length; o++) e[o] = parseInt(n[o + 1]);
                i = parseFloat(n[4])
            } else if (n = t.match(/^rgba?\(\s*([+-]?[\d\.]+)\%\s*,\s*([+-]?[\d\.]+)\%\s*,\s*([+-]?[\d\.]+)\%\s*(?:,\s*([+-]?[\d\.]+)\s*)?\)$/i)) {
                for (o = 0; o < e.length; o++) e[o] = Math.round(2.55 * parseFloat(n[o + 1]));
                i = parseFloat(n[4])
            } else if (n = t.match(/(\w+)/)) {
                if ("transparent" == n[1]) return [0, 0, 0, 0];
                if (!(e = L[n[1]])) return
            }
            for (o = 0; o < e.length; o++) e[o] = E(e[o], 0, 255);
            return i = i || 0 == i ? E(i, 0, 1) : 1, e[3] = i, e
        }
    }

    function z(t) {
        if (t) {
            var e = t.match(/^hsla?\(\s*([+-]?\d+)(?:deg)?\s*,\s*([+-]?[\d\.]+)%\s*,\s*([+-]?[\d\.]+)%\s*(?:,\s*([+-]?[\d\.]+)\s*)?\)/);
            if (e) {
                var i = parseFloat(e[4]);
                return [E(parseInt(e[1]), 0, 360), E(parseFloat(e[2]), 0, 100), E(parseFloat(e[3]), 0, 100), E(isNaN(i) ? 1 : i, 0, 1)]
            }
        }
    }

    function B(t) {
        if (t) {
            var e = t.match(/^hwb\(\s*([+-]?\d+)(?:deg)?\s*,\s*([+-]?[\d\.]+)%\s*,\s*([+-]?[\d\.]+)%\s*(?:,\s*([+-]?[\d\.]+)\s*)?\)/);
            if (e) {
                var i = parseFloat(e[4]);
                return [E(parseInt(e[1]), 0, 360), E(parseFloat(e[2]), 0, 100), E(parseFloat(e[3]), 0, 100), E(isNaN(i) ? 1 : i, 0, 1)]
            }
        }
    }

    function N(t, e) {
        return void 0 === e && (e = void 0 !== t[3] ? t[3] : 1), "rgba(" + t[0] + ", " + t[1] + ", " + t[2] + ", " + e + ")"
    }

    function W(t, e) {
        return "rgba(" + Math.round(t[0] / 255 * 100) + "%, " + Math.round(t[1] / 255 * 100) + "%, " + Math.round(t[2] / 255 * 100) + "%, " + (e || t[3] || 1) + ")"
    }

    function V(t, e) {
        return void 0 === e && (e = void 0 !== t[3] ? t[3] : 1), "hsla(" + t[0] + ", " + t[1] + "%, " + t[2] + "%, " + e + ")"
    }

    function E(t, e, i) {
        return Math.min(Math.max(e, t), i)
    }

    function H(t) {
        var e = t.toString(16).toUpperCase();
        return e.length < 2 ? "0" + e : e
    }
    var j = {};
    for (var q in L) j[L[q]] = q;
    var Y = function(t) {
        return t instanceof Y ? t : this instanceof Y ? (this.valid = !1, this.values = {
            rgb: [0, 0, 0],
            hsl: [0, 0, 0],
            hsv: [0, 0, 0],
            hwb: [0, 0, 0],
            cmyk: [0, 0, 0, 0],
            alpha: 1
        }, void("string" == typeof t ? (e = R.getRgba(t)) ? this.setValues("rgb", e) : (e = R.getHsla(t)) ? this.setValues("hsl", e) : (e = R.getHwb(t)) && this.setValues("hwb", e) : "object" == typeof t && (void 0 !== (e = t).r || void 0 !== e.red ? this.setValues("rgb", e) : void 0 !== e.l || void 0 !== e.lightness ? this.setValues("hsl", e) : void 0 !== e.v || void 0 !== e.value ? this.setValues("hsv", e) : void 0 !== e.w || void 0 !== e.whiteness ? this.setValues("hwb", e) : void 0 === e.c && void 0 === e.cyan || this.setValues("cmyk", e)))) : new Y(t);
        var e
    };
    Y.prototype = {
        isValid: function() {
            return this.valid
        },
        rgb: function() {
            return this.setSpace("rgb", arguments)
        },
        hsl: function() {
            return this.setSpace("hsl", arguments)
        },
        hsv: function() {
            return this.setSpace("hsv", arguments)
        },
        hwb: function() {
            return this.setSpace("hwb", arguments)
        },
        cmyk: function() {
            return this.setSpace("cmyk", arguments)
        },
        rgbArray: function() {
            return this.values.rgb
        },
        hslArray: function() {
            return this.values.hsl
        },
        hsvArray: function() {
            return this.values.hsv
        },
        hwbArray: function() {
            var t = this.values;
            return 1 !== t.alpha ? t.hwb.concat([t.alpha]) : t.hwb
        },
        cmykArray: function() {
            return this.values.cmyk
        },
        rgbaArray: function() {
            var t = this.values;
            return t.rgb.concat([t.alpha])
        },
        hslaArray: function() {
            var t = this.values;
            return t.hsl.concat([t.alpha])
        },
        alpha: function(t) {
            return void 0 === t ? this.values.alpha : (this.setValues("alpha", t), this)
        },
        red: function(t) {
            return this.setChannel("rgb", 0, t)
        },
        green: function(t) {
            return this.setChannel("rgb", 1, t)
        },
        blue: function(t) {
            return this.setChannel("rgb", 2, t)
        },
        hue: function(t) {
            return t && (t = (t %= 360) < 0 ? 360 + t : t), this.setChannel("hsl", 0, t)
        },
        saturation: function(t) {
            return this.setChannel("hsl", 1, t)
        },
        lightness: function(t) {
            return this.setChannel("hsl", 2, t)
        },
        saturationv: function(t) {
            return this.setChannel("hsv", 1, t)
        },
        whiteness: function(t) {
            return this.setChannel("hwb", 1, t)
        },
        blackness: function(t) {
            return this.setChannel("hwb", 2, t)
        },
        value: function(t) {
            return this.setChannel("hsv", 2, t)
        },
        cyan: function(t) {
            return this.setChannel("cmyk", 0, t)
        },
        magenta: function(t) {
            return this.setChannel("cmyk", 1, t)
        },
        yellow: function(t) {
            return this.setChannel("cmyk", 2, t)
        },
        black: function(t) {
            return this.setChannel("cmyk", 3, t)
        },
        hexString: function() {
            return R.hexString(this.values.rgb)
        },
        rgbString: function() {
            return R.rgbString(this.values.rgb, this.values.alpha)
        },
        rgbaString: function() {
            return R.rgbaString(this.values.rgb, this.values.alpha)
        },
        percentString: function() {
            return R.percentString(this.values.rgb, this.values.alpha)
        },
        hslString: function() {
            return R.hslString(this.values.hsl, this.values.alpha)
        },
        hslaString: function() {
            return R.hslaString(this.values.hsl, this.values.alpha)
        },
        hwbString: function() {
            return R.hwbString(this.values.hwb, this.values.alpha)
        },
        keyword: function() {
            return R.keyword(this.values.rgb, this.values.alpha)
        },
        rgbNumber: function() {
            var t = this.values.rgb;
            return t[0] << 16 | t[1] << 8 | t[2]
        },
        luminosity: function() {
            for (var t = this.values.rgb, e = [], i = 0; i < t.length; i++) {
                var n = t[i] / 255;
                e[i] = n <= .03928 ? n / 12.92 : Math.pow((n + .055) / 1.055, 2.4)
            }
            return .2126 * e[0] + .7152 * e[1] + .0722 * e[2]
        },
        contrast: function(t) {
            var e = this.luminosity(),
                i = t.luminosity();
            return e > i ? (e + .05) / (i + .05) : (i + .05) / (e + .05)
        },
        level: function(t) {
            var e = this.contrast(t);
            return e >= 7.1 ? "AAA" : e >= 4.5 ? "AA" : ""
        },
        dark: function() {
            var t = this.values.rgb;
            return (299 * t[0] + 587 * t[1] + 114 * t[2]) / 1e3 < 128
        },
        light: function() {
            return !this.dark()
        },
        negate: function() {
            for (var t = [], e = 0; e < 3; e++) t[e] = 255 - this.values.rgb[e];
            return this.setValues("rgb", t), this
        },
        lighten: function(t) {
            var e = this.values.hsl;
            return e[2] += e[2] * t, this.setValues("hsl", e), this
        },
        darken: function(t) {
            var e = this.values.hsl;
            return e[2] -= e[2] * t, this.setValues("hsl", e), this
        },
        saturate: function(t) {
            var e = this.values.hsl;
            return e[1] += e[1] * t, this.setValues("hsl", e), this
        },
        desaturate: function(t) {
            var e = this.values.hsl;
            return e[1] -= e[1] * t, this.setValues("hsl", e), this
        },
        whiten: function(t) {
            var e = this.values.hwb;
            return e[1] += e[1] * t, this.setValues("hwb", e), this
        },
        blacken: function(t) {
            var e = this.values.hwb;
            return e[2] += e[2] * t, this.setValues("hwb", e), this
        },
        greyscale: function() {
            var t = this.values.rgb,
                e = .3 * t[0] + .59 * t[1] + .11 * t[2];
            return this.setValues("rgb", [e, e, e]), this
        },
        clearer: function(t) {
            var e = this.values.alpha;
            return this.setValues("alpha", e - e * t), this
        },
        opaquer: function(t) {
            var e = this.values.alpha;
            return this.setValues("alpha", e + e * t), this
        },
        rotate: function(t) {
            var e = this.values.hsl,
                i = (e[0] + t) % 360;
            return e[0] = i < 0 ? 360 + i : i, this.setValues("hsl", e), this
        },
        mix: function(t, e) {
            var i = t,
                n = void 0 === e ? .5 : e,
                a = 2 * n - 1,
                o = this.alpha() - i.alpha(),
                r = ((a * o == -1 ? a : (a + o) / (1 + a * o)) + 1) / 2,
                s = 1 - r;
            return this.rgb(r * this.red() + s * i.red(), r * this.green() + s * i.green(), r * this.blue() + s * i.blue()).alpha(this.alpha() * n + i.alpha() * (1 - n))
        },
        toJSON: function() {
            return this.rgb()
        },
        clone: function() {
            var t, e, i = new Y,
                n = this.values,
                a = i.values;
            for (var o in n) n.hasOwnProperty(o) && (t = n[o], "[object Array]" === (e = {}.toString.call(t)) ? a[o] = t.slice(0) : "[object Number]" === e ? a[o] = t : console.error("unexpected color value:", t));
            return i
        }
    }, Y.prototype.spaces = {
        rgb: ["red", "green", "blue"],
        hsl: ["hue", "saturation", "lightness"],
        hsv: ["hue", "saturation", "value"],
        hwb: ["hue", "whiteness", "blackness"],
        cmyk: ["cyan", "magenta", "yellow", "black"]
    }, Y.prototype.maxes = {
        rgb: [255, 255, 255],
        hsl: [360, 100, 100],
        hsv: [360, 100, 100],
        hwb: [360, 100, 100],
        cmyk: [100, 100, 100, 100]
    }, Y.prototype.getValues = function(t) {
        for (var e = this.values, i = {}, n = 0; n < t.length; n++) i[t.charAt(n)] = e[t][n];
        return 1 !== e.alpha && (i.a = e.alpha), i
    }, Y.prototype.setValues = function(t, e) {
        var i, n, a = this.values,
            o = this.spaces,
            r = this.maxes,
            s = 1;
        if (this.valid = !0, "alpha" === t) s = e;
        else if (e.length) a[t] = e.slice(0, t.length), s = e[t.length];
        else if (void 0 !== e[t.charAt(0)]) {
            for (i = 0; i < t.length; i++) a[t][i] = e[t.charAt(i)];
            s = e.a
        } else if (void 0 !== e[o[t][0]]) {
            var l = o[t];
            for (i = 0; i < t.length; i++) a[t][i] = e[l[i]];
            s = e.alpha
        }
        if (a.alpha = Math.max(0, Math.min(1, void 0 === s ? a.alpha : s)), "alpha" === t) return !1;
        for (i = 0; i < t.length; i++) n = Math.max(0, Math.min(r[t][i], a[t][i])), a[t][i] = Math.round(n);
        for (var d in o) d !== t && (a[d] = F[t][d](a[t]));
        return !0
    }, Y.prototype.setSpace = function(t, e) {
        var i = e[0];
        return void 0 === i ? this.getValues(t) : ("number" == typeof i && (i = Array.prototype.slice.call(e)), this.setValues(t, i), this)
    }, Y.prototype.setChannel = function(t, e, i) {
        var n = this.values[t];
        return void 0 === i ? n[e] : i === n[e] ? this : (n[e] = i, this.setValues(t, n), this)
    }, "undefined" != typeof window && (window.Color = Y);
    var U, X = Y,
        K = {
            noop: function() {},
            uid: (U = 0, function() {
                return U++
            }),
            isNullOrUndef: function(t) {
                return null == t
            },
            isArray: function(t) {
                if (Array.isArray && Array.isArray(t)) return !0;
                var e = Object.prototype.toString.call(t);
                return "[object" === e.substr(0, 7) && "Array]" === e.substr(-6)
            },
            isObject: function(t) {
                return null !== t && "[object Object]" === Object.prototype.toString.call(t)
            },
            isFinite: function(t) {
                return ("number" == typeof t || t instanceof Number) && isFinite(t)
            },
            valueOrDefault: function(t, e) {
                return void 0 === t ? e : t
            },
            valueAtIndexOrDefault: function(t, e, i) {
                return K.valueOrDefault(K.isArray(t) ? t[e] : t, i)
            },
            callback: function(t, e, i) {
                if (t && "function" == typeof t.call) return t.apply(i, e)
            },
            each: function(t, e, i, n) {
                var a, o, r;
                if (K.isArray(t))
                    if (o = t.length, n)
                        for (a = o - 1; a >= 0; a--) e.call(i, t[a], a);
                    else
                        for (a = 0; a < o; a++) e.call(i, t[a], a);
                else if (K.isObject(t))
                    for (o = (r = Object.keys(t)).length, a = 0; a < o; a++) e.call(i, t[r[a]], r[a])
            },
            arrayEquals: function(t, e) {
                var i, n, a, o;
                if (!t || !e || t.length !== e.length) return !1;
                for (i = 0, n = t.length; i < n; ++i)
                    if (a = t[i], o = e[i], a instanceof Array && o instanceof Array) {
                        if (!K.arrayEquals(a, o)) return !1
                    } else if (a !== o) return !1;
                return !0
            },
            clone: function(t) {
                if (K.isArray(t)) return t.map(K.clone);
                if (K.isObject(t)) {
                    for (var e = {}, i = Object.keys(t), n = i.length, a = 0; a < n; ++a) e[i[a]] = K.clone(t[i[a]]);
                    return e
                }
                return t
            },
            _merger: function(t, e, i, n) {
                var a = e[t],
                    o = i[t];
                K.isObject(a) && K.isObject(o) ? K.merge(a, o, n) : e[t] = K.clone(o)
            },
            _mergerIf: function(t, e, i) {
                var n = e[t],
                    a = i[t];
                K.isObject(n) && K.isObject(a) ? K.mergeIf(n, a) : e.hasOwnProperty(t) || (e[t] = K.clone(a))
            },
            merge: function(t, e, i) {
                var n, a, o, r, s, l = K.isArray(e) ? e : [e],
                    d = l.length;
                if (!K.isObject(t)) return t;
                for (n = (i = i || {}).merger || K._merger, a = 0; a < d; ++a)
                    if (e = l[a], K.isObject(e))
                        for (s = 0, r = (o = Object.keys(e)).length; s < r; ++s) n(o[s], t, e, i);
                return t
            },
            mergeIf: function(t, e) {
                return K.merge(t, e, {
                    merger: K._mergerIf
                })
            },
            extend: function(t) {
                for (var e = function(e, i) {
                        t[i] = e
                    }, i = 1, n = arguments.length; i < n; ++i) K.each(arguments[i], e);
                return t
            },
            inherits: function(t) {
                var e = this,
                    i = t && t.hasOwnProperty("constructor") ? t.constructor : function() {
                        return e.apply(this, arguments)
                    },
                    n = function() {
                        this.constructor = i
                    };
                return n.prototype = e.prototype, i.prototype = new n, i.extend = K.inherits, t && K.extend(i.prototype, t), i.__super__ = e.prototype, i
            }
        },
        G = K;
    K.callCallback = K.callback, K.indexOf = function(t, e, i) {
        return Array.prototype.indexOf.call(t, e, i)
    }, K.getValueOrDefault = K.valueOrDefault, K.getValueAtIndexOrDefault = K.valueAtIndexOrDefault;
    var Z = {
            linear: function(t) {
                return t
            },
            easeInQuad: function(t) {
                return t * t
            },
            easeOutQuad: function(t) {
                return -t * (t - 2)
            },
            easeInOutQuad: function(t) {
                return (t /= .5) < 1 ? .5 * t * t : -.5 * (--t * (t - 2) - 1)
            },
            easeInCubic: function(t) {
                return t * t * t
            },
            easeOutCubic: function(t) {
                return (t -= 1) * t * t + 1
            },
            easeInOutCubic: function(t) {
                return (t /= .5) < 1 ? .5 * t * t * t : .5 * ((t -= 2) * t * t + 2)
            },
            easeInQuart: function(t) {
                return t * t * t * t
            },
            easeOutQuart: function(t) {
                return -((t -= 1) * t * t * t - 1)
            },
            easeInOutQuart: function(t) {
                return (t /= .5) < 1 ? .5 * t * t * t * t : -.5 * ((t -= 2) * t * t * t - 2)
            },
            easeInQuint: function(t) {
                return t * t * t * t * t
            },
            easeOutQuint: function(t) {
                return (t -= 1) * t * t * t * t + 1
            },
            easeInOutQuint: function(t) {
                return (t /= .5) < 1 ? .5 * t * t * t * t * t : .5 * ((t -= 2) * t * t * t * t + 2)
            },
            easeInSine: function(t) {
                return 1 - Math.cos(t * (Math.PI / 2))
            },
            easeOutSine: function(t) {
                return Math.sin(t * (Math.PI / 2))
            },
            easeInOutSine: function(t) {
                return -.5 * (Math.cos(Math.PI * t) - 1)
            },
            easeInExpo: function(t) {
                return 0 === t ? 0 : Math.pow(2, 10 * (t - 1))
            },
            easeOutExpo: function(t) {
                return 1 === t ? 1 : 1 - Math.pow(2, -10 * t)
            },
            easeInOutExpo: function(t) {
                return 0 === t ? 0 : 1 === t ? 1 : (t /= .5) < 1 ? .5 * Math.pow(2, 10 * (t - 1)) : .5 * (2 - Math.pow(2, -10 * --t))
            },
            easeInCirc: function(t) {
                return t >= 1 ? t : -(Math.sqrt(1 - t * t) - 1)
            },
            easeOutCirc: function(t) {
                return Math.sqrt(1 - (t -= 1) * t)
            },
            easeInOutCirc: function(t) {
                return (t /= .5) < 1 ? -.5 * (Math.sqrt(1 - t * t) - 1) : .5 * (Math.sqrt(1 - (t -= 2) * t) + 1)
            },
            easeInElastic: function(t) {
                var e = 1.70158,
                    i = 0,
                    n = 1;
                return 0 === t ? 0 : 1 === t ? 1 : (i || (i = .3), n < 1 ? (n = 1, e = i / 4) : e = i / (2 * Math.PI) * Math.asin(1 / n), -n * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / i))
            },
            easeOutElastic: function(t) {
                var e = 1.70158,
                    i = 0,
                    n = 1;
                return 0 === t ? 0 : 1 === t ? 1 : (i || (i = .3), n < 1 ? (n = 1, e = i / 4) : e = i / (2 * Math.PI) * Math.asin(1 / n), n * Math.pow(2, -10 * t) * Math.sin((t - e) * (2 * Math.PI) / i) + 1)
            },
            easeInOutElastic: function(t) {
                var e = 1.70158,
                    i = 0,
                    n = 1;
                return 0 === t ? 0 : 2 == (t /= .5) ? 1 : (i || (i = .45), n < 1 ? (n = 1, e = i / 4) : e = i / (2 * Math.PI) * Math.asin(1 / n), t < 1 ? n * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / i) * -.5 : n * Math.pow(2, -10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / i) * .5 + 1)
            },
            easeInBack: function(t) {
                var e = 1.70158;
                return t * t * ((e + 1) * t - e)
            },
            easeOutBack: function(t) {
                var e = 1.70158;
                return (t -= 1) * t * ((e + 1) * t + e) + 1
            },
            easeInOutBack: function(t) {
                var e = 1.70158;
                return (t /= .5) < 1 ? t * t * ((1 + (e *= 1.525)) * t - e) * .5 : .5 * ((t -= 2) * t * ((1 + (e *= 1.525)) * t + e) + 2)
            },
            easeInBounce: function(t) {
                return 1 - Z.easeOutBounce(1 - t)
            },
            easeOutBounce: function(t) {
                return t < 1 / 2.75 ? 7.5625 * t * t : t < 2 / 2.75 ? 7.5625 * (t -= 1.5 / 2.75) * t + .75 : t < 2.5 / 2.75 ? 7.5625 * (t -= 2.25 / 2.75) * t + .9375 : 7.5625 * (t -= 2.625 / 2.75) * t + .984375
            },
            easeInOutBounce: function(t) {
                return t < .5 ? .5 * Z.easeInBounce(2 * t) : .5 * Z.easeOutBounce(2 * t - 1) + .5
            }
        },
        $ = {
            effects: Z
        };
    G.easingEffects = Z;
    var J = Math.PI,
        Q = J / 180,
        tt = 2 * J,
        et = J / 2,
        it = J / 4,
        nt = 2 * J / 3,
        at = {
            clear: function(t) {
                t.ctx.clearRect(0, 0, t.width, t.height)
            },
            roundedRect: function(t, e, i, n, a, o) {
                if (o) {
                    var r = Math.min(o, a / 2, n / 2),
                        s = e + r,
                        l = i + r,
                        d = e + n - r,
                        u = i + a - r;
                    t.moveTo(e, l), s < d && l < u ? (t.arc(s, l, r, -J, -et), t.arc(d, l, r, -et, 0), t.arc(d, u, r, 0, et), t.arc(s, u, r, et, J)) : s < d ? (t.moveTo(s, i), t.arc(d, l, r, -et, et), t.arc(s, l, r, et, J + et)) : l < u ? (t.arc(s, l, r, -J, 0), t.arc(s, u, r, 0, J)) : t.arc(s, l, r, -J, J), t.closePath(), t.moveTo(e, i)
                } else t.rect(e, i, n, a)
            },
            drawPoint: function(t, e, i, n, a, o) {
                var r, s, l, d, u, h = (o || 0) * Q;
                if (!e || "object" != typeof e || "[object HTMLImageElement]" !== (r = e.toString()) && "[object HTMLCanvasElement]" !== r) {
                    if (!(isNaN(i) || i <= 0)) {
                        switch (t.beginPath(), e) {
                            default:
                                t.arc(n, a, i, 0, tt), t.closePath();
                                break;
                            case "triangle":
                                t.moveTo(n + Math.sin(h) * i, a - Math.cos(h) * i), h += nt, t.lineTo(n + Math.sin(h) * i, a - Math.cos(h) * i), h += nt, t.lineTo(n + Math.sin(h) * i, a - Math.cos(h) * i), t.closePath();
                                break;
                            case "rectRounded":
                                d = i - (u = .516 * i), s = Math.cos(h + it) * d, l = Math.sin(h + it) * d, t.arc(n - s, a - l, u, h - J, h - et), t.arc(n + l, a - s, u, h - et, h), t.arc(n + s, a + l, u, h, h + et), t.arc(n - l, a + s, u, h + et, h + J), t.closePath();
                                break;
                            case "rect":
                                if (!o) {
                                    d = Math.SQRT1_2 * i, t.rect(n - d, a - d, 2 * d, 2 * d);
                                    break
                                }
                                h += it;
                            case "rectRot":
                                s = Math.cos(h) * i, l = Math.sin(h) * i, t.moveTo(n - s, a - l), t.lineTo(n + l, a - s), t.lineTo(n + s, a + l), t.lineTo(n - l, a + s), t.closePath();
                                break;
                            case "crossRot":
                                h += it;
                            case "cross":
                                s = Math.cos(h) * i, l = Math.sin(h) * i, t.moveTo(n - s, a - l), t.lineTo(n + s, a + l), t.moveTo(n + l, a - s), t.lineTo(n - l, a + s);
                                break;
                            case "star":
                                s = Math.cos(h) * i, l = Math.sin(h) * i, t.moveTo(n - s, a - l), t.lineTo(n + s, a + l), t.moveTo(n + l, a - s), t.lineTo(n - l, a + s), h += it, s = Math.cos(h) * i, l = Math.sin(h) * i, t.moveTo(n - s, a - l), t.lineTo(n + s, a + l), t.moveTo(n + l, a - s), t.lineTo(n - l, a + s);
                                break;
                            case "line":
                                s = Math.cos(h) * i, l = Math.sin(h) * i, t.moveTo(n - s, a - l), t.lineTo(n + s, a + l);
                                break;
                            case "dash":
                                t.moveTo(n, a), t.lineTo(n + Math.cos(h) * i, a + Math.sin(h) * i)
                        }
                        t.fill(), t.stroke()
                    }
                } else t.drawImage(e, n - e.width / 2, a - e.height / 2, e.width, e.height)
            },
            _isPointInArea: function(t, e) {
                return t.x > e.left - 1e-6 && t.x < e.right + 1e-6 && t.y > e.top - 1e-6 && t.y < e.bottom + 1e-6
            },
            clipArea: function(t, e) {
                t.save(), t.beginPath(), t.rect(e.left, e.top, e.right - e.left, e.bottom - e.top), t.clip()
            },
            unclipArea: function(t) {
                t.restore()
            },
            lineTo: function(t, e, i, n) {
                var a = i.steppedLine;
                if (a) {
                    if ("middle" === a) {
                        var o = (e.x + i.x) / 2;
                        t.lineTo(o, n ? i.y : e.y), t.lineTo(o, n ? e.y : i.y)
                    } else "after" === a && !n || "after" !== a && n ? t.lineTo(e.x, i.y) : t.lineTo(i.x, e.y);
                    t.lineTo(i.x, i.y)
                } else i.tension ? t.bezierCurveTo(n ? e.controlPointPreviousX : e.controlPointNextX, n ? e.controlPointPreviousY : e.controlPointNextY, n ? i.controlPointNextX : i.controlPointPreviousX, n ? i.controlPointNextY : i.controlPointPreviousY, i.x, i.y) : t.lineTo(i.x, i.y)
            }
        },
        ot = at;
    G.clear = at.clear, G.drawRoundedRectangle = function(t) {
        t.beginPath(), at.roundedRect.apply(at, arguments)
    };
    var rt = {
        _set: function(t, e) {
            return G.merge(this[t] || (this[t] = {}), e)
        }
    };
    rt._set("global", {
        defaultColor: "rgba(0,0,0,0.1)",
        defaultFontColor: "#666",
        defaultFontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
        defaultFontSize: 12,
        defaultFontStyle: "normal",
        defaultLineHeight: 1.2,
        showLines: !0
    });
    var st = rt,
        lt = G.valueOrDefault;
    var dt = {
            toLineHeight: function(t, e) {
                var i = ("" + t).match(/^(normal|(\d+(?:\.\d+)?)(px|em|%)?)$/);
                if (!i || "normal" === i[1]) return 1.2 * e;
                switch (t = +i[2], i[3]) {
                    case "px":
                        return t;
                    case "%":
                        t /= 100
                }
                return e * t
            },
            toPadding: function(t) {
                var e, i, n, a;
                return G.isObject(t) ? (e = +t.top || 0, i = +t.right || 0, n = +t.bottom || 0, a = +t.left || 0) : e = i = n = a = +t || 0, {
                    top: e,
                    right: i,
                    bottom: n,
                    left: a,
                    height: e + n,
                    width: a + i
                }
            },
            _parseFont: function(t) {
                var e = st.global,
                    i = lt(t.fontSize, e.defaultFontSize),
                    n = {
                        family: lt(t.fontFamily, e.defaultFontFamily),
                        lineHeight: G.options.toLineHeight(lt(t.lineHeight, e.defaultLineHeight), i),
                        size: i,
                        style: lt(t.fontStyle, e.defaultFontStyle),
                        weight: null,
                        string: ""
                    };
                return n.string = function(t) {
                    return !t || G.isNullOrUndef(t.size) || G.isNullOrUndef(t.family) ? null : (t.style ? t.style + " " : "") + (t.weight ? t.weight + " " : "") + t.size + "px " + t.family
                }(n), n
            },
            resolve: function(t, e, i) {
                var n, a, o;
                for (n = 0, a = t.length; n < a; ++n)
                    if (void 0 !== (o = t[n]) && (void 0 !== e && "function" == typeof o && (o = o(e)), void 0 !== i && G.isArray(o) && (o = o[i]), void 0 !== o)) return o
            }
        },
        ut = G,
        ht = $,
        ct = ot,
        ft = dt;
    ut.easing = ht, ut.canvas = ct, ut.options = ft;
    var gt = function(t) {
        ut.extend(this, t), this.initialize.apply(this, arguments)
    };
    ut.extend(gt.prototype, {
        initialize: function() {
            this.hidden = !1
        },
        pivot: function() {
            var t = this;
            return t._view || (t._view = ut.clone(t._model)), t._start = {}, t
        },
        transition: function(t) {
            var e = this,
                i = e._model,
                n = e._start,
                a = e._view;
            return i && 1 !== t ? (a || (a = e._view = {}), n || (n = e._start = {}), function(t, e, i, n) {
                var a, o, r, s, l, d, u, h, c, f = Object.keys(i);
                for (a = 0, o = f.length; a < o; ++a)
                    if (d = i[r = f[a]], e.hasOwnProperty(r) || (e[r] = d), (s = e[r]) !== d && "_" !== r[0]) {
                        if (t.hasOwnProperty(r) || (t[r] = s), (u = typeof d) == typeof(l = t[r]))
                            if ("string" === u) {
                                if ((h = X(l)).valid && (c = X(d)).valid) {
                                    e[r] = c.mix(h, n).rgbString();
                                    continue
                                }
                            } else if (ut.isFinite(l) && ut.isFinite(d)) {
                            e[r] = l + (d - l) * n;
                            continue
                        }
                        e[r] = d
                    }
            }(n, a, i, t), e) : (e._view = i, e._start = null, e)
        },
        tooltipPosition: function() {
            return {
                x: this._model.x,
                y: this._model.y
            }
        },
        hasValue: function() {
            return ut.isNumber(this._model.x) && ut.isNumber(this._model.y)
        }
    }), gt.extend = ut.inherits;
    var pt = gt,
        mt = pt.extend({
            chart: null,
            currentStep: 0,
            numSteps: 60,
            easing: "",
            render: null,
            onAnimationProgress: null,
            onAnimationComplete: null
        }),
        vt = mt;
    Object.defineProperty(mt.prototype, "animationObject", {
        get: function() {
            return this
        }
    }), Object.defineProperty(mt.prototype, "chartInstance", {
        get: function() {
            return this.chart
        },
        set: function(t) {
            this.chart = t
        }
    }), st._set("global", {
        animation: {
            duration: 1e3,
            easing: "easeOutQuart",
            onProgress: ut.noop,
            onComplete: ut.noop
        }
    });
    var bt = {
            animations: [],
            request: null,
            addAnimation: function(t, e, i, n) {
                var a, o, r = this.animations;
                for (e.chart = t, e.startTime = Date.now(), e.duration = i, n || (t.animating = !0), a = 0, o = r.length; a < o; ++a)
                    if (r[a].chart === t) return void(r[a] = e);
                r.push(e), 1 === r.length && this.requestAnimationFrame()
            },
            cancelAnimation: function(t) {
                var e = ut.findIndex(this.animations, function(e) {
                    return e.chart === t
                }); - 1 !== e && (this.animations.splice(e, 1), t.animating = !1)
            },
            requestAnimationFrame: function() {
                var t = this;
                null === t.request && (t.request = ut.requestAnimFrame.call(window, function() {
                    t.request = null, t.startDigest()
                }))
            },
            startDigest: function() {
                this.advance(), this.animations.length > 0 && this.requestAnimationFrame()
            },
            advance: function() {
                for (var t, e, i, n, a = this.animations, o = 0; o < a.length;) e = (t = a[o]).chart, i = t.numSteps, n = Math.floor((Date.now() - t.startTime) / t.duration * i) + 1, t.currentStep = Math.min(n, i), ut.callback(t.render, [e, t], e), ut.callback(t.onAnimationProgress, [t], e), t.currentStep >= i ? (ut.callback(t.onAnimationComplete, [t], e), e.animating = !1, a.splice(o, 1)) : ++o
            }
        },
        xt = ut.options.resolve,
        yt = ["push", "pop", "shift", "splice", "unshift"];

    function kt(t, e) {
        var i = t._chartjs;
        if (i) {
            var n = i.listeners,
                a = n.indexOf(e); - 1 !== a && n.splice(a, 1), n.length > 0 || (yt.forEach(function(e) {
                delete t[e]
            }), delete t._chartjs)
        }
    }
    var wt = function(t, e) {
        this.initialize(t, e)
    };
    ut.extend(wt.prototype, {
        datasetElementType: null,
        dataElementType: null,
        initialize: function(t, e) {
            this.chart = t, this.index = e, this.linkScales(), this.addElements()
        },
        updateIndex: function(t) {
            this.index = t
        },
        linkScales: function() {
            var t = this,
                e = t.getMeta(),
                i = t.getDataset();
            null !== e.xAxisID && e.xAxisID in t.chart.scales || (e.xAxisID = i.xAxisID || t.chart.options.scales.xAxes[0].id), null !== e.yAxisID && e.yAxisID in t.chart.scales || (e.yAxisID = i.yAxisID || t.chart.options.scales.yAxes[0].id)
        },
        getDataset: function() {
            return this.chart.data.datasets[this.index]
        },
        getMeta: function() {
            return this.chart.getDatasetMeta(this.index)
        },
        getScaleForId: function(t) {
            return this.chart.scales[t]
        },
        _getValueScaleId: function() {
            return this.getMeta().yAxisID
        },
        _getIndexScaleId: function() {
            return this.getMeta().xAxisID
        },
        _getValueScale: function() {
            return this.getScaleForId(this._getValueScaleId())
        },
        _getIndexScale: function() {
            return this.getScaleForId(this._getIndexScaleId())
        },
        reset: function() {
            this.update(!0)
        },
        destroy: function() {
            this._data && kt(this._data, this)
        },
        createMetaDataset: function() {
            var t = this.datasetElementType;
            return t && new t({
                _chart: this.chart,
                _datasetIndex: this.index
            })
        },
        createMetaData: function(t) {
            var e = this.dataElementType;
            return e && new e({
                _chart: this.chart,
                _datasetIndex: this.index,
                _index: t
            })
        },
        addElements: function() {
            var t, e, i = this.getMeta(),
                n = this.getDataset().data || [],
                a = i.data;
            for (t = 0, e = n.length; t < e; ++t) a[t] = a[t] || this.createMetaData(t);
            i.dataset = i.dataset || this.createMetaDataset()
        },
        addElementAndReset: function(t) {
            var e = this.createMetaData(t);
            this.getMeta().data.splice(t, 0, e), this.updateElement(e, t, !0)
        },
        buildOrUpdateElements: function() {
            var t, e, i = this,
                n = i.getDataset(),
                a = n.data || (n.data = []);
            i._data !== a && (i._data && kt(i._data, i), a && Object.isExtensible(a) && (e = i, (t = a)._chartjs ? t._chartjs.listeners.push(e) : (Object.defineProperty(t, "_chartjs", {
                configurable: !0,
                enumerable: !1,
                value: {
                    listeners: [e]
                }
            }), yt.forEach(function(e) {
                var i = "onData" + e.charAt(0).toUpperCase() + e.slice(1),
                    n = t[e];
                Object.defineProperty(t, e, {
                    configurable: !0,
                    enumerable: !1,
                    value: function() {
                        var e = Array.prototype.slice.call(arguments),
                            a = n.apply(this, e);
                        return ut.each(t._chartjs.listeners, function(t) {
                            "function" == typeof t[i] && t[i].apply(t, e)
                        }), a
                    }
                })
            }))), i._data = a), i.resyncElements()
        },
        update: ut.noop,
        transition: function(t) {
            for (var e = this.getMeta(), i = e.data || [], n = i.length, a = 0; a < n; ++a) i[a].transition(t);
            e.dataset && e.dataset.transition(t)
        },
        draw: function() {
            var t = this.getMeta(),
                e = t.data || [],
                i = e.length,
                n = 0;
            for (t.dataset && t.dataset.draw(); n < i; ++n) e[n].draw()
        },
        removeHoverStyle: function(t) {
            ut.merge(t._model, t.$previousStyle || {}), delete t.$previousStyle
        },
        setHoverStyle: function(t) {
            var e = this.chart.data.datasets[t._datasetIndex],
                i = t._index,
                n = t.custom || {},
                a = t._model,
                o = ut.getHoverColor;
            t.$previousStyle = {
                backgroundColor: a.backgroundColor,
                borderColor: a.borderColor,
                borderWidth: a.borderWidth
            }, a.backgroundColor = xt([n.hoverBackgroundColor, e.hoverBackgroundColor, o(a.backgroundColor)], void 0, i), a.borderColor = xt([n.hoverBorderColor, e.hoverBorderColor, o(a.borderColor)], void 0, i), a.borderWidth = xt([n.hoverBorderWidth, e.hoverBorderWidth, a.borderWidth], void 0, i)
        },
        resyncElements: function() {
            var t = this.getMeta(),
                e = this.getDataset().data,
                i = t.data.length,
                n = e.length;
            n < i ? t.data.splice(n, i - n) : n > i && this.insertElements(i, n - i)
        },
        insertElements: function(t, e) {
            for (var i = 0; i < e; ++i) this.addElementAndReset(t + i)
        },
        onDataPush: function() {
            var t = arguments.length;
            this.insertElements(this.getDataset().data.length - t, t)
        },
        onDataPop: function() {
            this.getMeta().data.pop()
        },
        onDataShift: function() {
            this.getMeta().data.shift()
        },
        onDataSplice: function(t, e) {
            this.getMeta().data.splice(t, e), this.insertElements(t, arguments.length - 2)
        },
        onDataUnshift: function() {
            this.insertElements(0, arguments.length)
        }
    }), wt.extend = ut.inherits;
    var Mt = wt;
    st._set("global", {
        elements: {
            arc: {
                backgroundColor: st.global.defaultColor,
                borderColor: "#fff",
                borderWidth: 2,
                borderAlign: "center"
            }
        }
    });
    var _t = pt.extend({
            inLabelRange: function(t) {
                var e = this._view;
                return !!e && Math.pow(t - e.x, 2) < Math.pow(e.radius + e.hoverRadius, 2)
            },
            inRange: function(t, e) {
                var i = this._view;
                if (i) {
                    for (var n = ut.getAngleFromPoint(i, {
                            x: t,
                            y: e
                        }), a = n.angle, o = n.distance, r = i.startAngle, s = i.endAngle; s < r;) s += 2 * Math.PI;
                    for (; a > s;) a -= 2 * Math.PI;
                    for (; a < r;) a += 2 * Math.PI;
                    var l = a >= r && a <= s,
                        d = o >= i.innerRadius && o <= i.outerRadius;
                    return l && d
                }
                return !1
            },
            getCenterPoint: function() {
                var t = this._view,
                    e = (t.startAngle + t.endAngle) / 2,
                    i = (t.innerRadius + t.outerRadius) / 2;
                return {
                    x: t.x + Math.cos(e) * i,
                    y: t.y + Math.sin(e) * i
                }
            },
            getArea: function() {
                var t = this._view;
                return Math.PI * ((t.endAngle - t.startAngle) / (2 * Math.PI)) * (Math.pow(t.outerRadius, 2) - Math.pow(t.innerRadius, 2))
            },
            tooltipPosition: function() {
                var t = this._view,
                    e = t.startAngle + (t.endAngle - t.startAngle) / 2,
                    i = (t.outerRadius - t.innerRadius) / 2 + t.innerRadius;
                return {
                    x: t.x + Math.cos(e) * i,
                    y: t.y + Math.sin(e) * i
                }
            },
            draw: function() {
                var t, e = this._chart.ctx,
                    i = this._view,
                    n = i.startAngle,
                    a = i.endAngle,
                    o = "inner" === i.borderAlign ? .33 : 0;
                e.save(), e.beginPath(), e.arc(i.x, i.y, Math.max(i.outerRadius - o, 0), n, a), e.arc(i.x, i.y, i.innerRadius, a, n, !0), e.closePath(), e.fillStyle = i.backgroundColor, e.fill(), i.borderWidth && ("inner" === i.borderAlign ? (e.beginPath(), t = o / i.outerRadius, e.arc(i.x, i.y, i.outerRadius, n - t, a + t), i.innerRadius > o ? (t = o / i.innerRadius, e.arc(i.x, i.y, i.innerRadius - o, a + t, n - t, !0)) : e.arc(i.x, i.y, o, a + Math.PI / 2, n - Math.PI / 2), e.closePath(), e.clip(), e.beginPath(), e.arc(i.x, i.y, i.outerRadius, n, a), e.arc(i.x, i.y, i.innerRadius, a, n, !0), e.closePath(), e.lineWidth = 2 * i.borderWidth, e.lineJoin = "round") : (e.lineWidth = i.borderWidth, e.lineJoin = "bevel"), e.strokeStyle = i.borderColor, e.stroke()), e.restore()
            }
        }),
        Ct = ut.valueOrDefault,
        St = st.global.defaultColor;
    st._set("global", {
        elements: {
            line: {
                tension: .4,
                backgroundColor: St,
                borderWidth: 3,
                borderColor: St,
                borderCapStyle: "butt",
                borderDash: [],
                borderDashOffset: 0,
                borderJoinStyle: "miter",
                capBezierPoints: !0,
                fill: !0
            }
        }
    });
    var Pt = pt.extend({
            draw: function() {
                var t, e, i, n, a = this._view,
                    o = this._chart.ctx,
                    r = a.spanGaps,
                    s = this._children.slice(),
                    l = st.global,
                    d = l.elements.line,
                    u = -1;
                for (this._loop && s.length && s.push(s[0]), o.save(), o.lineCap = a.borderCapStyle || d.borderCapStyle, o.setLineDash && o.setLineDash(a.borderDash || d.borderDash), o.lineDashOffset = Ct(a.borderDashOffset, d.borderDashOffset), o.lineJoin = a.borderJoinStyle || d.borderJoinStyle, o.lineWidth = Ct(a.borderWidth, d.borderWidth), o.strokeStyle = a.borderColor || l.defaultColor, o.beginPath(), u = -1, t = 0; t < s.length; ++t) e = s[t], i = ut.previousItem(s, t), n = e._view, 0 === t ? n.skip || (o.moveTo(n.x, n.y), u = t) : (i = -1 === u ? i : s[u], n.skip || (u !== t - 1 && !r || -1 === u ? o.moveTo(n.x, n.y) : ut.canvas.lineTo(o, i._view, e._view), u = t));
                o.stroke(), o.restore()
            }
        }),
        It = ut.valueOrDefault,
        At = st.global.defaultColor;

    function Dt(t) {
        var e = this._view;
        return !!e && Math.abs(t - e.x) < e.radius + e.hitRadius
    }
    st._set("global", {
        elements: {
            point: {
                radius: 3,
                pointStyle: "circle",
                backgroundColor: At,
                borderColor: At,
                borderWidth: 1,
                hitRadius: 1,
                hoverRadius: 4,
                hoverBorderWidth: 1
            }
        }
    });
    var Tt = pt.extend({
            inRange: function(t, e) {
                var i = this._view;
                return !!i && Math.pow(t - i.x, 2) + Math.pow(e - i.y, 2) < Math.pow(i.hitRadius + i.radius, 2)
            },
            inLabelRange: Dt,
            inXRange: Dt,
            inYRange: function(t) {
                var e = this._view;
                return !!e && Math.abs(t - e.y) < e.radius + e.hitRadius
            },
            getCenterPoint: function() {
                var t = this._view;
                return {
                    x: t.x,
                    y: t.y
                }
            },
            getArea: function() {
                return Math.PI * Math.pow(this._view.radius, 2)
            },
            tooltipPosition: function() {
                var t = this._view;
                return {
                    x: t.x,
                    y: t.y,
                    padding: t.radius + t.borderWidth
                }
            },
            draw: function(t) {
                var e = this._view,
                    i = this._chart.ctx,
                    n = e.pointStyle,
                    a = e.rotation,
                    o = e.radius,
                    r = e.x,
                    s = e.y,
                    l = st.global,
                    d = l.defaultColor;
                e.skip || (void 0 === t || ut.canvas._isPointInArea(e, t)) && (i.strokeStyle = e.borderColor || d, i.lineWidth = It(e.borderWidth, l.elements.point.borderWidth), i.fillStyle = e.backgroundColor || d, ut.canvas.drawPoint(i, n, o, r, s, a))
            }
        }),
        Ft = st.global.defaultColor;

    function Lt(t) {
        return t && void 0 !== t.width
    }

    function Rt(t) {
        var e, i, n, a, o;
        return Lt(t) ? (o = t.width / 2, e = t.x - o, i = t.x + o, n = Math.min(t.y, t.base), a = Math.max(t.y, t.base)) : (o = t.height / 2, e = Math.min(t.x, t.base), i = Math.max(t.x, t.base), n = t.y - o, a = t.y + o), {
            left: e,
            top: n,
            right: i,
            bottom: a
        }
    }

    function Ot(t, e, i) {
        return t === e ? i : t === i ? e : t
    }

    function zt(t, e, i) {
        var n, a, o, r, s = t.borderWidth,
            l = function(t) {
                var e = t.borderSkipped,
                    i = {};
                return e ? (t.horizontal ? t.base > t.x && (e = Ot(e, "left", "right")) : t.base < t.y && (e = Ot(e, "bottom", "top")), i[e] = !0, i) : i
            }(t);
        return ut.isObject(s) ? (n = +s.top || 0, a = +s.right || 0, o = +s.bottom || 0, r = +s.left || 0) : n = a = o = r = +s || 0, {
            t: l.top || n < 0 ? 0 : n > i ? i : n,
            r: l.right || a < 0 ? 0 : a > e ? e : a,
            b: l.bottom || o < 0 ? 0 : o > i ? i : o,
            l: l.left || r < 0 ? 0 : r > e ? e : r
        }
    }

    function Bt(t, e, i) {
        var n = null === e,
            a = null === i,
            o = !(!t || n && a) && Rt(t);
        return o && (n || e >= o.left && e <= o.right) && (a || i >= o.top && i <= o.bottom)
    }
    st._set("global", {
        elements: {
            rectangle: {
                backgroundColor: Ft,
                borderColor: Ft,
                borderSkipped: "bottom",
                borderWidth: 0
            }
        }
    });
    var Nt = pt.extend({
            draw: function() {
                var t = this._chart.ctx,
                    e = this._view,
                    i = function(t) {
                        var e = Rt(t),
                            i = e.right - e.left,
                            n = e.bottom - e.top,
                            a = zt(t, i / 2, n / 2);
                        return {
                            outer: {
                                x: e.left,
                                y: e.top,
                                w: i,
                                h: n
                            },
                            inner: {
                                x: e.left + a.l,
                                y: e.top + a.t,
                                w: i - a.l - a.r,
                                h: n - a.t - a.b
                            }
                        }
                    }(e),
                    n = i.outer,
                    a = i.inner;
                t.fillStyle = e.backgroundColor, t.fillRect(n.x, n.y, n.w, n.h), n.w === a.w && n.h === a.h || (t.save(), t.beginPath(), t.rect(n.x, n.y, n.w, n.h), t.clip(), t.fillStyle = e.borderColor, t.rect(a.x, a.y, a.w, a.h), t.fill("evenodd"), t.restore())
            },
            height: function() {
                var t = this._view;
                return t.base - t.y
            },
            inRange: function(t, e) {
                return Bt(this._view, t, e)
            },
            inLabelRange: function(t, e) {
                var i = this._view;
                return Lt(i) ? Bt(i, t, null) : Bt(i, null, e)
            },
            inXRange: function(t) {
                return Bt(this._view, t, null)
            },
            inYRange: function(t) {
                return Bt(this._view, null, t)
            },
            getCenterPoint: function() {
                var t, e, i = this._view;
                return Lt(i) ? (t = i.x, e = (i.y + i.base) / 2) : (t = (i.x + i.base) / 2, e = i.y), {
                    x: t,
                    y: e
                }
            },
            getArea: function() {
                var t = this._view;
                return Lt(t) ? t.width * Math.abs(t.y - t.base) : t.height * Math.abs(t.x - t.base)
            },
            tooltipPosition: function() {
                var t = this._view;
                return {
                    x: t.x,
                    y: t.y
                }
            }
        }),
        Wt = {},
        Vt = _t,
        Et = Pt,
        Ht = Tt,
        jt = Nt;
    Wt.Arc = Vt, Wt.Line = Et, Wt.Point = Ht, Wt.Rectangle = jt;
    var qt = ut.options.resolve;
    st._set("bar", {
        hover: {
            mode: "label"
        },
        scales: {
            xAxes: [{
                type: "category",
                categoryPercentage: .8,
                barPercentage: .9,
                offset: !0,
                gridLines: {
                    offsetGridLines: !0
                }
            }],
            yAxes: [{
                type: "linear"
            }]
        }
    });
    var Yt = Mt.extend({
            dataElementType: Wt.Rectangle,
            initialize: function() {
                var t;
                Mt.prototype.initialize.apply(this, arguments), (t = this.getMeta()).stack = this.getDataset().stack, t.bar = !0
            },
            update: function(t) {
                var e, i, n = this.getMeta().data;
                for (this._ruler = this.getRuler(), e = 0, i = n.length; e < i; ++e) this.updateElement(n[e], e, t)
            },
            updateElement: function(t, e, i) {
                var n = this,
                    a = n.getMeta(),
                    o = n.getDataset(),
                    r = n._resolveElementOptions(t, e);
                t._xScale = n.getScaleForId(a.xAxisID), t._yScale = n.getScaleForId(a.yAxisID), t._datasetIndex = n.index, t._index = e, t._model = {
                    backgroundColor: r.backgroundColor,
                    borderColor: r.borderColor,
                    borderSkipped: r.borderSkipped,
                    borderWidth: r.borderWidth,
                    datasetLabel: o.label,
                    label: n.chart.data.labels[e]
                }, n._updateElementGeometry(t, e, i), t.pivot()
            },
            _updateElementGeometry: function(t, e, i) {
                var n = this,
                    a = t._model,
                    o = n._getValueScale(),
                    r = o.getBasePixel(),
                    s = o.isHorizontal(),
                    l = n._ruler || n.getRuler(),
                    d = n.calculateBarValuePixels(n.index, e),
                    u = n.calculateBarIndexPixels(n.index, e, l);
                a.horizontal = s, a.base = i ? r : d.base, a.x = s ? i ? r : d.head : u.center, a.y = s ? u.center : i ? r : d.head, a.height = s ? u.size : void 0, a.width = s ? void 0 : u.size
            },
            _getStacks: function(t) {
                var e, i, n = this.chart,
                    a = this._getIndexScale().options.stacked,
                    o = void 0 === t ? n.data.datasets.length : t + 1,
                    r = [];
                for (e = 0; e < o; ++e)(i = n.getDatasetMeta(e)).bar && n.isDatasetVisible(e) && (!1 === a || !0 === a && -1 === r.indexOf(i.stack) || void 0 === a && (void 0 === i.stack || -1 === r.indexOf(i.stack))) && r.push(i.stack);
                return r
            },
            getStackCount: function() {
                return this._getStacks().length
            },
            getStackIndex: function(t, e) {
                var i = this._getStacks(t),
                    n = void 0 !== e ? i.indexOf(e) : -1;
                return -1 === n ? i.length - 1 : n
            },
            getRuler: function() {
                var t, e, i = this._getIndexScale(),
                    n = this.getStackCount(),
                    a = this.index,
                    o = i.isHorizontal(),
                    r = o ? i.left : i.top,
                    s = r + (o ? i.width : i.height),
                    l = [];
                for (t = 0, e = this.getMeta().data.length; t < e; ++t) l.push(i.getPixelForValue(null, t, a));
                return {
                    min: ut.isNullOrUndef(i.options.barThickness) ? function(t, e) {
                        var i, n, a, o, r = t.isHorizontal() ? t.width : t.height,
                            s = t.getTicks();
                        for (a = 1, o = e.length; a < o; ++a) r = Math.min(r, Math.abs(e[a] - e[a - 1]));
                        for (a = 0, o = s.length; a < o; ++a) n = t.getPixelForTick(a), r = a > 0 ? Math.min(r, n - i) : r, i = n;
                        return r
                    }(i, l) : -1,
                    pixels: l,
                    start: r,
                    end: s,
                    stackCount: n,
                    scale: i
                }
            },
            calculateBarValuePixels: function(t, e) {
                var i, n, a, o, r, s, l = this.chart,
                    d = this.getMeta(),
                    u = this._getValueScale(),
                    h = u.isHorizontal(),
                    c = l.data.datasets,
                    f = +u.getRightValue(c[t].data[e]),
                    g = u.options.minBarLength,
                    p = u.options.stacked,
                    m = d.stack,
                    v = 0;
                if (p || void 0 === p && void 0 !== m)
                    for (i = 0; i < t; ++i)(n = l.getDatasetMeta(i)).bar && n.stack === m && n.controller._getValueScaleId() === u.id && l.isDatasetVisible(i) && (a = +u.getRightValue(c[i].data[e]), (f < 0 && a < 0 || f >= 0 && a > 0) && (v += a));
                return o = u.getPixelForValue(v), s = (r = u.getPixelForValue(v + f)) - o, void 0 !== g && Math.abs(s) < g && (s = g, r = f >= 0 && !h || f < 0 && h ? o - g : o + g), {
                    size: s,
                    base: o,
                    head: r,
                    center: r + s / 2
                }
            },
            calculateBarIndexPixels: function(t, e, i) {
                var n = i.scale.options,
                    a = "flex" === n.barThickness ? function(t, e, i) {
                        var n, a = e.pixels,
                            o = a[t],
                            r = t > 0 ? a[t - 1] : null,
                            s = t < a.length - 1 ? a[t + 1] : null,
                            l = i.categoryPercentage;
                        return null === r && (r = o - (null === s ? e.end - e.start : s - o)), null === s && (s = o + o - r), n = o - (o - Math.min(r, s)) / 2 * l, {
                            chunk: Math.abs(s - r) / 2 * l / e.stackCount,
                            ratio: i.barPercentage,
                            start: n
                        }
                    }(e, i, n) : function(t, e, i) {
                        var n, a, o = i.barThickness,
                            r = e.stackCount,
                            s = e.pixels[t];
                        return ut.isNullOrUndef(o) ? (n = e.min * i.categoryPercentage, a = i.barPercentage) : (n = o * r, a = 1), {
                            chunk: n / r,
                            ratio: a,
                            start: s - n / 2
                        }
                    }(e, i, n),
                    o = this.getStackIndex(t, this.getMeta().stack),
                    r = a.start + a.chunk * o + a.chunk / 2,
                    s = Math.min(ut.valueOrDefault(n.maxBarThickness, 1 / 0), a.chunk * a.ratio);
                return {
                    base: r - s / 2,
                    head: r + s / 2,
                    center: r,
                    size: s
                }
            },
            draw: function() {
                var t = this.chart,
                    e = this._getValueScale(),
                    i = this.getMeta().data,
                    n = this.getDataset(),
                    a = i.length,
                    o = 0;
                for (ut.canvas.clipArea(t.ctx, t.chartArea); o < a; ++o) isNaN(e.getRightValue(n.data[o])) || i[o].draw();
                ut.canvas.unclipArea(t.ctx)
            },
            _resolveElementOptions: function(t, e) {
                var i, n, a, o = this.chart,
                    r = o.data.datasets[this.index],
                    s = t.custom || {},
                    l = o.options.elements.rectangle,
                    d = {},
                    u = {
                        chart: o,
                        dataIndex: e,
                        dataset: r,
                        datasetIndex: this.index
                    },
                    h = ["backgroundColor", "borderColor", "borderSkipped", "borderWidth"];
                for (i = 0, n = h.length; i < n; ++i) d[a = h[i]] = qt([s[a], r[a], l[a]], u, e);
                return d
            }
        }),
        Ut = ut.valueOrDefault,
        Xt = ut.options.resolve;
    st._set("bubble", {
        hover: {
            mode: "single"
        },
        scales: {
            xAxes: [{
                type: "linear",
                position: "bottom",
                id: "x-axis-0"
            }],
            yAxes: [{
                type: "linear",
                position: "left",
                id: "y-axis-0"
            }]
        },
        tooltips: {
            callbacks: {
                title: function() {
                    return ""
                },
                label: function(t, e) {
                    var i = e.datasets[t.datasetIndex].label || "",
                        n = e.datasets[t.datasetIndex].data[t.index];
                    return i + ": (" + t.xLabel + ", " + t.yLabel + ", " + n.r + ")"
                }
            }
        }
    });
    var Kt = Mt.extend({
            dataElementType: Wt.Point,
            update: function(t) {
                var e = this,
                    i = e.getMeta().data;
                ut.each(i, function(i, n) {
                    e.updateElement(i, n, t)
                })
            },
            updateElement: function(t, e, i) {
                var n = this,
                    a = n.getMeta(),
                    o = t.custom || {},
                    r = n.getScaleForId(a.xAxisID),
                    s = n.getScaleForId(a.yAxisID),
                    l = n._resolveElementOptions(t, e),
                    d = n.getDataset().data[e],
                    u = n.index,
                    h = i ? r.getPixelForDecimal(.5) : r.getPixelForValue("object" == typeof d ? d : NaN, e, u),
                    c = i ? s.getBasePixel() : s.getPixelForValue(d, e, u);
                t._xScale = r, t._yScale = s, t._options = l, t._datasetIndex = u, t._index = e, t._model = {
                    backgroundColor: l.backgroundColor,
                    borderColor: l.borderColor,
                    borderWidth: l.borderWidth,
                    hitRadius: l.hitRadius,
                    pointStyle: l.pointStyle,
                    rotation: l.rotation,
                    radius: i ? 0 : l.radius,
                    skip: o.skip || isNaN(h) || isNaN(c),
                    x: h,
                    y: c
                }, t.pivot()
            },
            setHoverStyle: function(t) {
                var e = t._model,
                    i = t._options,
                    n = ut.getHoverColor;
                t.$previousStyle = {
                    backgroundColor: e.backgroundColor,
                    borderColor: e.borderColor,
                    borderWidth: e.borderWidth,
                    radius: e.radius
                }, e.backgroundColor = Ut(i.hoverBackgroundColor, n(i.backgroundColor)), e.borderColor = Ut(i.hoverBorderColor, n(i.borderColor)), e.borderWidth = Ut(i.hoverBorderWidth, i.borderWidth), e.radius = i.radius + i.hoverRadius
            },
            _resolveElementOptions: function(t, e) {
                var i, n, a, o = this.chart,
                    r = o.data.datasets[this.index],
                    s = t.custom || {},
                    l = o.options.elements.point,
                    d = r.data[e],
                    u = {},
                    h = {
                        chart: o,
                        dataIndex: e,
                        dataset: r,
                        datasetIndex: this.index
                    },
                    c = ["backgroundColor", "borderColor", "borderWidth", "hoverBackgroundColor", "hoverBorderColor", "hoverBorderWidth", "hoverRadius", "hitRadius", "pointStyle", "rotation"];
                for (i = 0, n = c.length; i < n; ++i) u[a = c[i]] = Xt([s[a], r[a], l[a]], h, e);
                return u.radius = Xt([s.radius, d ? d.r : void 0, r.radius, l.radius], h, e), u
            }
        }),
        Gt = ut.options.resolve,
        Zt = ut.valueOrDefault;
    st._set("doughnut", {
        animation: {
            animateRotate: !0,
            animateScale: !1
        },
        hover: {
            mode: "single"
        },
        legendCallback: function(t) {
            var e = [];
            e.push('<ul class="' + t.id + '-legend">');
            var i = t.data,
                n = i.datasets,
                a = i.labels;
            if (n.length)
                for (var o = 0; o < n[0].data.length; ++o) e.push('<li><span style="background-color:' + n[0].backgroundColor[o] + '"></span>'), a[o] && e.push(a[o]), e.push("</li>");
            return e.push("</ul>"), e.join("")
        },
        legend: {
            labels: {
                generateLabels: function(t) {
                    var e = t.data;
                    return e.labels.length && e.datasets.length ? e.labels.map(function(i, n) {
                        var a = t.getDatasetMeta(0),
                            o = e.datasets[0],
                            r = a.data[n],
                            s = r && r.custom || {},
                            l = t.options.elements.arc;
                        return {
                            text: i,
                            fillStyle: Gt([s.backgroundColor, o.backgroundColor, l.backgroundColor], void 0, n),
                            strokeStyle: Gt([s.borderColor, o.borderColor, l.borderColor], void 0, n),
                            lineWidth: Gt([s.borderWidth, o.borderWidth, l.borderWidth], void 0, n),
                            hidden: isNaN(o.data[n]) || a.data[n].hidden,
                            index: n
                        }
                    }) : []
                }
            },
            onClick: function(t, e) {
                var i, n, a, o = e.index,
                    r = this.chart;
                for (i = 0, n = (r.data.datasets || []).length; i < n; ++i)(a = r.getDatasetMeta(i)).data[o] && (a.data[o].hidden = !a.data[o].hidden);
                r.update()
            }
        },
        cutoutPercentage: 50,
        rotation: -.5 * Math.PI,
        circumference: 2 * Math.PI,
        tooltips: {
            callbacks: {
                title: function() {
                    return ""
                },
                label: function(t, e) {
                    var i = e.labels[t.index],
                        n = ": " + e.datasets[t.datasetIndex].data[t.index];
                    return ut.isArray(i) ? (i = i.slice())[0] += n : i += n, i
                }
            }
        }
    });
    var $t = Mt.extend({
        dataElementType: Wt.Arc,
        linkScales: ut.noop,
        getRingIndex: function(t) {
            for (var e = 0, i = 0; i < t; ++i) this.chart.isDatasetVisible(i) && ++e;
            return e
        },
        update: function(t) {
            var e, i, n = this,
                a = n.chart,
                o = a.chartArea,
                r = a.options,
                s = o.right - o.left,
                l = o.bottom - o.top,
                d = Math.min(s, l),
                u = {
                    x: 0,
                    y: 0
                },
                h = n.getMeta(),
                c = h.data,
                f = r.cutoutPercentage,
                g = r.circumference,
                p = n._getRingWeight(n.index);
            if (g < 2 * Math.PI) {
                var m = r.rotation % (2 * Math.PI),
                    v = (m += 2 * Math.PI * (m >= Math.PI ? -1 : m < -Math.PI ? 1 : 0)) + g,
                    b = {
                        x: Math.cos(m),
                        y: Math.sin(m)
                    },
                    x = {
                        x: Math.cos(v),
                        y: Math.sin(v)
                    },
                    y = m <= 0 && v >= 0 || m <= 2 * Math.PI && 2 * Math.PI <= v,
                    k = m <= .5 * Math.PI && .5 * Math.PI <= v || m <= 2.5 * Math.PI && 2.5 * Math.PI <= v,
                    w = m <= -Math.PI && -Math.PI <= v || m <= Math.PI && Math.PI <= v,
                    M = m <= .5 * -Math.PI && .5 * -Math.PI <= v || m <= 1.5 * Math.PI && 1.5 * Math.PI <= v,
                    _ = f / 100,
                    C = {
                        x: w ? -1 : Math.min(b.x * (b.x < 0 ? 1 : _), x.x * (x.x < 0 ? 1 : _)),
                        y: M ? -1 : Math.min(b.y * (b.y < 0 ? 1 : _), x.y * (x.y < 0 ? 1 : _))
                    },
                    S = {
                        x: y ? 1 : Math.max(b.x * (b.x > 0 ? 1 : _), x.x * (x.x > 0 ? 1 : _)),
                        y: k ? 1 : Math.max(b.y * (b.y > 0 ? 1 : _), x.y * (x.y > 0 ? 1 : _))
                    },
                    P = {
                        width: .5 * (S.x - C.x),
                        height: .5 * (S.y - C.y)
                    };
                d = Math.min(s / P.width, l / P.height), u = {
                    x: -.5 * (S.x + C.x),
                    y: -.5 * (S.y + C.y)
                }
            }
            for (e = 0, i = c.length; e < i; ++e) c[e]._options = n._resolveElementOptions(c[e], e);
            for (a.borderWidth = n.getMaxBorderWidth(), a.outerRadius = Math.max((d - a.borderWidth) / 2, 0), a.innerRadius = Math.max(f ? a.outerRadius / 100 * f : 0, 0), a.radiusLength = (a.outerRadius - a.innerRadius) / (n._getVisibleDatasetWeightTotal() || 1), a.offsetX = u.x * a.outerRadius, a.offsetY = u.y * a.outerRadius, h.total = n.calculateTotal(), n.outerRadius = a.outerRadius - a.radiusLength * n._getRingWeightOffset(n.index), n.innerRadius = Math.max(n.outerRadius - a.radiusLength * p, 0), e = 0, i = c.length; e < i; ++e) n.updateElement(c[e], e, t)
        },
        updateElement: function(t, e, i) {
            var n = this,
                a = n.chart,
                o = a.chartArea,
                r = a.options,
                s = r.animation,
                l = (o.left + o.right) / 2,
                d = (o.top + o.bottom) / 2,
                u = r.rotation,
                h = r.rotation,
                c = n.getDataset(),
                f = i && s.animateRotate ? 0 : t.hidden ? 0 : n.calculateCircumference(c.data[e]) * (r.circumference / (2 * Math.PI)),
                g = i && s.animateScale ? 0 : n.innerRadius,
                p = i && s.animateScale ? 0 : n.outerRadius,
                m = t._options || {};
            ut.extend(t, {
                _datasetIndex: n.index,
                _index: e,
                _model: {
                    backgroundColor: m.backgroundColor,
                    borderColor: m.borderColor,
                    borderWidth: m.borderWidth,
                    borderAlign: m.borderAlign,
                    x: l + a.offsetX,
                    y: d + a.offsetY,
                    startAngle: u,
                    endAngle: h,
                    circumference: f,
                    outerRadius: p,
                    innerRadius: g,
                    label: ut.valueAtIndexOrDefault(c.label, e, a.data.labels[e])
                }
            });
            var v = t._model;
            i && s.animateRotate || (v.startAngle = 0 === e ? r.rotation : n.getMeta().data[e - 1]._model.endAngle, v.endAngle = v.startAngle + v.circumference), t.pivot()
        },
        calculateTotal: function() {
            var t, e = this.getDataset(),
                i = this.getMeta(),
                n = 0;
            return ut.each(i.data, function(i, a) {
                t = e.data[a], isNaN(t) || i.hidden || (n += Math.abs(t))
            }), n
        },
        calculateCircumference: function(t) {
            var e = this.getMeta().total;
            return e > 0 && !isNaN(t) ? 2 * Math.PI * (Math.abs(t) / e) : 0
        },
        getMaxBorderWidth: function(t) {
            var e, i, n, a, o, r, s, l, d = 0,
                u = this.chart;
            if (!t)
                for (e = 0, i = u.data.datasets.length; e < i; ++e)
                    if (u.isDatasetVisible(e)) {
                        t = (n = u.getDatasetMeta(e)).data, e !== this.index && (o = n.controller);
                        break
                    } if (!t) return 0;
            for (e = 0, i = t.length; e < i; ++e) a = t[e], "inner" !== (r = o ? o._resolveElementOptions(a, e) : a._options).borderAlign && (s = r.borderWidth, d = (l = r.hoverBorderWidth) > (d = s > d ? s : d) ? l : d);
            return d
        },
        setHoverStyle: function(t) {
            var e = t._model,
                i = t._options,
                n = ut.getHoverColor;
            t.$previousStyle = {
                backgroundColor: e.backgroundColor,
                borderColor: e.borderColor,
                borderWidth: e.borderWidth
            }, e.backgroundColor = Zt(i.hoverBackgroundColor, n(i.backgroundColor)), e.borderColor = Zt(i.hoverBorderColor, n(i.borderColor)), e.borderWidth = Zt(i.hoverBorderWidth, i.borderWidth)
        },
        _resolveElementOptions: function(t, e) {
            var i, n, a, o = this.chart,
                r = this.getDataset(),
                s = t.custom || {},
                l = o.options.elements.arc,
                d = {},
                u = {
                    chart: o,
                    dataIndex: e,
                    dataset: r,
                    datasetIndex: this.index
                },
                h = ["backgroundColor", "borderColor", "borderWidth", "borderAlign", "hoverBackgroundColor", "hoverBorderColor", "hoverBorderWidth"];
            for (i = 0, n = h.length; i < n; ++i) d[a = h[i]] = Gt([s[a], r[a], l[a]], u, e);
            return d
        },
        _getRingWeightOffset: function(t) {
            for (var e = 0, i = 0; i < t; ++i) this.chart.isDatasetVisible(i) && (e += this._getRingWeight(i));
            return e
        },
        _getRingWeight: function(t) {
            return Math.max(Zt(this.chart.data.datasets[t].weight, 1), 0)
        },
        _getVisibleDatasetWeightTotal: function() {
            return this._getRingWeightOffset(this.chart.data.datasets.length)
        }
    });
    st._set("horizontalBar", {
        hover: {
            mode: "index",
            axis: "y"
        },
        scales: {
            xAxes: [{
                type: "linear",
                position: "bottom"
            }],
            yAxes: [{
                type: "category",
                position: "left",
                categoryPercentage: .8,
                barPercentage: .9,
                offset: !0,
                gridLines: {
                    offsetGridLines: !0
                }
            }]
        },
        elements: {
            rectangle: {
                borderSkipped: "left"
            }
        },
        tooltips: {
            mode: "index",
            axis: "y"
        }
    });
    var Jt = Yt.extend({
            _getValueScaleId: function() {
                return this.getMeta().xAxisID
            },
            _getIndexScaleId: function() {
                return this.getMeta().yAxisID
            }
        }),
        Qt = ut.valueOrDefault,
        te = ut.options.resolve,
        ee = ut.canvas._isPointInArea;

    function ie(t, e) {
        return Qt(t.showLine, e.showLines)
    }
    st._set("line", {
        showLines: !0,
        spanGaps: !1,
        hover: {
            mode: "label"
        },
        scales: {
            xAxes: [{
                type: "category",
                id: "x-axis-0"
            }],
            yAxes: [{
                type: "linear",
                id: "y-axis-0"
            }]
        }
    });
    var ne = Mt.extend({
            datasetElementType: Wt.Line,
            dataElementType: Wt.Point,
            update: function(t) {
                var e, i, n = this,
                    a = n.getMeta(),
                    o = a.dataset,
                    r = a.data || [],
                    s = n.getScaleForId(a.yAxisID),
                    l = n.getDataset(),
                    d = ie(l, n.chart.options);
                for (d && (void 0 !== l.tension && void 0 === l.lineTension && (l.lineTension = l.tension), o._scale = s, o._datasetIndex = n.index, o._children = r, o._model = n._resolveLineOptions(o), o.pivot()), e = 0, i = r.length; e < i; ++e) n.updateElement(r[e], e, t);
                for (d && 0 !== o._model.tension && n.updateBezierControlPoints(), e = 0, i = r.length; e < i; ++e) r[e].pivot()
            },
            updateElement: function(t, e, i) {
                var n, a, o = this,
                    r = o.getMeta(),
                    s = t.custom || {},
                    l = o.getDataset(),
                    d = o.index,
                    u = l.data[e],
                    h = o.getScaleForId(r.yAxisID),
                    c = o.getScaleForId(r.xAxisID),
                    f = r.dataset._model,
                    g = o._resolvePointOptions(t, e);
                n = c.getPixelForValue("object" == typeof u ? u : NaN, e, d), a = i ? h.getBasePixel() : o.calculatePointY(u, e, d), t._xScale = c, t._yScale = h, t._options = g, t._datasetIndex = d, t._index = e, t._model = {
                    x: n,
                    y: a,
                    skip: s.skip || isNaN(n) || isNaN(a),
                    radius: g.radius,
                    pointStyle: g.pointStyle,
                    rotation: g.rotation,
                    backgroundColor: g.backgroundColor,
                    borderColor: g.borderColor,
                    borderWidth: g.borderWidth,
                    tension: Qt(s.tension, f ? f.tension : 0),
                    steppedLine: !!f && f.steppedLine,
                    hitRadius: g.hitRadius
                }
            },
            _resolvePointOptions: function(t, e) {
                var i, n, a, o = this.chart,
                    r = o.data.datasets[this.index],
                    s = t.custom || {},
                    l = o.options.elements.point,
                    d = {},
                    u = {
                        chart: o,
                        dataIndex: e,
                        dataset: r,
                        datasetIndex: this.index
                    },
                    h = {
                        backgroundColor: "pointBackgroundColor",
                        borderColor: "pointBorderColor",
                        borderWidth: "pointBorderWidth",
                        hitRadius: "pointHitRadius",
                        hoverBackgroundColor: "pointHoverBackgroundColor",
                        hoverBorderColor: "pointHoverBorderColor",
                        hoverBorderWidth: "pointHoverBorderWidth",
                        hoverRadius: "pointHoverRadius",
                        pointStyle: "pointStyle",
                        radius: "pointRadius",
                        rotation: "pointRotation"
                    },
                    c = Object.keys(h);
                for (i = 0, n = c.length; i < n; ++i) d[a = c[i]] = te([s[a], r[h[a]], r[a], l[a]], u, e);
                return d
            },
            _resolveLineOptions: function(t) {
                var e, i, n, a = this.chart,
                    o = a.data.datasets[this.index],
                    r = t.custom || {},
                    s = a.options,
                    l = s.elements.line,
                    d = {},
                    u = ["backgroundColor", "borderWidth", "borderColor", "borderCapStyle", "borderDash", "borderDashOffset", "borderJoinStyle", "fill", "cubicInterpolationMode"];
                for (e = 0, i = u.length; e < i; ++e) d[n = u[e]] = te([r[n], o[n], l[n]]);
                return d.spanGaps = Qt(o.spanGaps, s.spanGaps), d.tension = Qt(o.lineTension, l.tension), d.steppedLine = te([r.steppedLine, o.steppedLine, l.stepped]), d
            },
            calculatePointY: function(t, e, i) {
                var n, a, o, r = this.chart,
                    s = this.getMeta(),
                    l = this.getScaleForId(s.yAxisID),
                    d = 0,
                    u = 0;
                if (l.options.stacked) {
                    for (n = 0; n < i; n++)
                        if (a = r.data.datasets[n], "line" === (o = r.getDatasetMeta(n)).type && o.yAxisID === l.id && r.isDatasetVisible(n)) {
                            var h = Number(l.getRightValue(a.data[e]));
                            h < 0 ? u += h || 0 : d += h || 0
                        } var c = Number(l.getRightValue(t));
                    return c < 0 ? l.getPixelForValue(u + c) : l.getPixelForValue(d + c)
                }
                return l.getPixelForValue(t)
            },
            updateBezierControlPoints: function() {
                var t, e, i, n, a = this.chart,
                    o = this.getMeta(),
                    r = o.dataset._model,
                    s = a.chartArea,
                    l = o.data || [];

                function d(t, e, i) {
                    return Math.max(Math.min(t, i), e)
                }
                if (r.spanGaps && (l = l.filter(function(t) {
                        return !t._model.skip
                    })), "monotone" === r.cubicInterpolationMode) ut.splineCurveMonotone(l);
                else
                    for (t = 0, e = l.length; t < e; ++t) i = l[t]._model, n = ut.splineCurve(ut.previousItem(l, t)._model, i, ut.nextItem(l, t)._model, r.tension), i.controlPointPreviousX = n.previous.x, i.controlPointPreviousY = n.previous.y, i.controlPointNextX = n.next.x, i.controlPointNextY = n.next.y;
                if (a.options.elements.line.capBezierPoints)
                    for (t = 0, e = l.length; t < e; ++t) i = l[t]._model, ee(i, s) && (t > 0 && ee(l[t - 1]._model, s) && (i.controlPointPreviousX = d(i.controlPointPreviousX, s.left, s.right), i.controlPointPreviousY = d(i.controlPointPreviousY, s.top, s.bottom)), t < l.length - 1 && ee(l[t + 1]._model, s) && (i.controlPointNextX = d(i.controlPointNextX, s.left, s.right), i.controlPointNextY = d(i.controlPointNextY, s.top, s.bottom)))
            },
            draw: function() {
                var t, e = this.chart,
                    i = this.getMeta(),
                    n = i.data || [],
                    a = e.chartArea,
                    o = n.length,
                    r = 0;
                for (ie(this.getDataset(), e.options) && (t = (i.dataset._model.borderWidth || 0) / 2, ut.canvas.clipArea(e.ctx, {
                        left: a.left,
                        right: a.right,
                        top: a.top - t,
                        bottom: a.bottom + t
                    }), i.dataset.draw(), ut.canvas.unclipArea(e.ctx)); r < o; ++r) n[r].draw(a)
            },
            setHoverStyle: function(t) {
                var e = t._model,
                    i = t._options,
                    n = ut.getHoverColor;
                t.$previousStyle = {
                    backgroundColor: e.backgroundColor,
                    borderColor: e.borderColor,
                    borderWidth: e.borderWidth,
                    radius: e.radius
                }, e.backgroundColor = Qt(i.hoverBackgroundColor, n(i.backgroundColor)), e.borderColor = Qt(i.hoverBorderColor, n(i.borderColor)), e.borderWidth = Qt(i.hoverBorderWidth, i.borderWidth), e.radius = Qt(i.hoverRadius, i.radius)
            }
        }),
        ae = ut.options.resolve;
    st._set("polarArea", {
        scale: {
            type: "radialLinear",
            angleLines: {
                display: !1
            },
            gridLines: {
                circular: !0
            },
            pointLabels: {
                display: !1
            },
            ticks: {
                beginAtZero: !0
            }
        },
        animation: {
            animateRotate: !0,
            animateScale: !0
        },
        startAngle: -.5 * Math.PI,
        legendCallback: function(t) {
            var e = [];
            e.push('<ul class="' + t.id + '-legend">');
            var i = t.data,
                n = i.datasets,
                a = i.labels;
            if (n.length)
                for (var o = 0; o < n[0].data.length; ++o) e.push('<li><span style="background-color:' + n[0].backgroundColor[o] + '"></span>'), a[o] && e.push(a[o]), e.push("</li>");
            return e.push("</ul>"), e.join("")
        },
        legend: {
            labels: {
                generateLabels: function(t) {
                    var e = t.data;
                    return e.labels.length && e.datasets.length ? e.labels.map(function(i, n) {
                        var a = t.getDatasetMeta(0),
                            o = e.datasets[0],
                            r = a.data[n].custom || {},
                            s = t.options.elements.arc;
                        return {
                            text: i,
                            fillStyle: ae([r.backgroundColor, o.backgroundColor, s.backgroundColor], void 0, n),
                            strokeStyle: ae([r.borderColor, o.borderColor, s.borderColor], void 0, n),
                            lineWidth: ae([r.borderWidth, o.borderWidth, s.borderWidth], void 0, n),
                            hidden: isNaN(o.data[n]) || a.data[n].hidden,
                            index: n
                        }
                    }) : []
                }
            },
            onClick: function(t, e) {
                var i, n, a, o = e.index,
                    r = this.chart;
                for (i = 0, n = (r.data.datasets || []).length; i < n; ++i)(a = r.getDatasetMeta(i)).data[o].hidden = !a.data[o].hidden;
                r.update()
            }
        },
        tooltips: {
            callbacks: {
                title: function() {
                    return ""
                },
                label: function(t, e) {
                    return e.labels[t.index] + ": " + t.yLabel
                }
            }
        }
    });
    var oe = Mt.extend({
        dataElementType: Wt.Arc,
        linkScales: ut.noop,
        update: function(t) {
            var e, i, n, a = this,
                o = a.getDataset(),
                r = a.getMeta(),
                s = a.chart.options.startAngle || 0,
                l = a._starts = [],
                d = a._angles = [],
                u = r.data;
            for (a._updateRadius(), r.count = a.countVisibleElements(), e = 0, i = o.data.length; e < i; e++) l[e] = s, n = a._computeAngle(e), d[e] = n, s += n;
            for (e = 0, i = u.length; e < i; ++e) u[e]._options = a._resolveElementOptions(u[e], e), a.updateElement(u[e], e, t)
        },
        _updateRadius: function() {
            var t = this,
                e = t.chart,
                i = e.chartArea,
                n = e.options,
                a = Math.min(i.right - i.left, i.bottom - i.top);
            e.outerRadius = Math.max(a / 2, 0), e.innerRadius = Math.max(n.cutoutPercentage ? e.outerRadius / 100 * n.cutoutPercentage : 1, 0), e.radiusLength = (e.outerRadius - e.innerRadius) / e.getVisibleDatasetCount(), t.outerRadius = e.outerRadius - e.radiusLength * t.index, t.innerRadius = t.outerRadius - e.radiusLength
        },
        updateElement: function(t, e, i) {
            var n = this,
                a = n.chart,
                o = n.getDataset(),
                r = a.options,
                s = r.animation,
                l = a.scale,
                d = a.data.labels,
                u = l.xCenter,
                h = l.yCenter,
                c = r.startAngle,
                f = t.hidden ? 0 : l.getDistanceFromCenterForValue(o.data[e]),
                g = n._starts[e],
                p = g + (t.hidden ? 0 : n._angles[e]),
                m = s.animateScale ? 0 : l.getDistanceFromCenterForValue(o.data[e]),
                v = t._options || {};
            ut.extend(t, {
                _datasetIndex: n.index,
                _index: e,
                _scale: l,
                _model: {
                    backgroundColor: v.backgroundColor,
                    borderColor: v.borderColor,
                    borderWidth: v.borderWidth,
                    borderAlign: v.borderAlign,
                    x: u,
                    y: h,
                    innerRadius: 0,
                    outerRadius: i ? m : f,
                    startAngle: i && s.animateRotate ? c : g,
                    endAngle: i && s.animateRotate ? c : p,
                    label: ut.valueAtIndexOrDefault(d, e, d[e])
                }
            }), t.pivot()
        },
        countVisibleElements: function() {
            var t = this.getDataset(),
                e = this.getMeta(),
                i = 0;
            return ut.each(e.data, function(e, n) {
                isNaN(t.data[n]) || e.hidden || i++
            }), i
        },
        setHoverStyle: function(t) {
            var e = t._model,
                i = t._options,
                n = ut.getHoverColor,
                a = ut.valueOrDefault;
            t.$previousStyle = {
                backgroundColor: e.backgroundColor,
                borderColor: e.borderColor,
                borderWidth: e.borderWidth
            }, e.backgroundColor = a(i.hoverBackgroundColor, n(i.backgroundColor)), e.borderColor = a(i.hoverBorderColor, n(i.borderColor)), e.borderWidth = a(i.hoverBorderWidth, i.borderWidth)
        },
        _resolveElementOptions: function(t, e) {
            var i, n, a, o = this.chart,
                r = this.getDataset(),
                s = t.custom || {},
                l = o.options.elements.arc,
                d = {},
                u = {
                    chart: o,
                    dataIndex: e,
                    dataset: r,
                    datasetIndex: this.index
                },
                h = ["backgroundColor", "borderColor", "borderWidth", "borderAlign", "hoverBackgroundColor", "hoverBorderColor", "hoverBorderWidth"];
            for (i = 0, n = h.length; i < n; ++i) d[a = h[i]] = ae([s[a], r[a], l[a]], u, e);
            return d
        },
        _computeAngle: function(t) {
            var e = this,
                i = this.getMeta().count,
                n = e.getDataset(),
                a = e.getMeta();
            if (isNaN(n.data[t]) || a.data[t].hidden) return 0;
            var o = {
                chart: e.chart,
                dataIndex: t,
                dataset: n,
                datasetIndex: e.index
            };
            return ae([e.chart.options.elements.arc.angle, 2 * Math.PI / i], o, t)
        }
    });
    st._set("pie", ut.clone(st.doughnut)), st._set("pie", {
        cutoutPercentage: 0
    });
    var re = $t,
        se = ut.valueOrDefault,
        le = ut.options.resolve;
    st._set("radar", {
        scale: {
            type: "radialLinear"
        },
        elements: {
            line: {
                tension: 0
            }
        }
    });
    var de = Mt.extend({
        datasetElementType: Wt.Line,
        dataElementType: Wt.Point,
        linkScales: ut.noop,
        update: function(t) {
            var e, i, n = this,
                a = n.getMeta(),
                o = a.dataset,
                r = a.data || [],
                s = n.chart.scale,
                l = n.getDataset();
            for (void 0 !== l.tension && void 0 === l.lineTension && (l.lineTension = l.tension), o._scale = s, o._datasetIndex = n.index, o._children = r, o._loop = !0, o._model = n._resolveLineOptions(o), o.pivot(), e = 0, i = r.length; e < i; ++e) n.updateElement(r[e], e, t);
            for (n.updateBezierControlPoints(), e = 0, i = r.length; e < i; ++e) r[e].pivot()
        },
        updateElement: function(t, e, i) {
            var n = this,
                a = t.custom || {},
                o = n.getDataset(),
                r = n.chart.scale,
                s = r.getPointPositionForValue(e, o.data[e]),
                l = n._resolvePointOptions(t, e),
                d = n.getMeta().dataset._model,
                u = i ? r.xCenter : s.x,
                h = i ? r.yCenter : s.y;
            t._scale = r, t._options = l, t._datasetIndex = n.index, t._index = e, t._model = {
                x: u,
                y: h,
                skip: a.skip || isNaN(u) || isNaN(h),
                radius: l.radius,
                pointStyle: l.pointStyle,
                rotation: l.rotation,
                backgroundColor: l.backgroundColor,
                borderColor: l.borderColor,
                borderWidth: l.borderWidth,
                tension: se(a.tension, d ? d.tension : 0),
                hitRadius: l.hitRadius
            }
        },
        _resolvePointOptions: function(t, e) {
            var i, n, a, o = this.chart,
                r = o.data.datasets[this.index],
                s = t.custom || {},
                l = o.options.elements.point,
                d = {},
                u = {
                    chart: o,
                    dataIndex: e,
                    dataset: r,
                    datasetIndex: this.index
                },
                h = {
                    backgroundColor: "pointBackgroundColor",
                    borderColor: "pointBorderColor",
                    borderWidth: "pointBorderWidth",
                    hitRadius: "pointHitRadius",
                    hoverBackgroundColor: "pointHoverBackgroundColor",
                    hoverBorderColor: "pointHoverBorderColor",
                    hoverBorderWidth: "pointHoverBorderWidth",
                    hoverRadius: "pointHoverRadius",
                    pointStyle: "pointStyle",
                    radius: "pointRadius",
                    rotation: "pointRotation"
                },
                c = Object.keys(h);
            for (i = 0, n = c.length; i < n; ++i) d[a = c[i]] = le([s[a], r[h[a]], r[a], l[a]], u, e);
            return d
        },
        _resolveLineOptions: function(t) {
            var e, i, n, a = this.chart,
                o = a.data.datasets[this.index],
                r = t.custom || {},
                s = a.options.elements.line,
                l = {},
                d = ["backgroundColor", "borderWidth", "borderColor", "borderCapStyle", "borderDash", "borderDashOffset", "borderJoinStyle", "fill"];
            for (e = 0, i = d.length; e < i; ++e) l[n = d[e]] = le([r[n], o[n], s[n]]);
            return l.tension = se(o.lineTension, s.tension), l
        },
        updateBezierControlPoints: function() {
            var t, e, i, n, a = this.getMeta(),
                o = this.chart.chartArea,
                r = a.data || [];

            function s(t, e, i) {
                return Math.max(Math.min(t, i), e)
            }
            for (t = 0, e = r.length; t < e; ++t) i = r[t]._model, n = ut.splineCurve(ut.previousItem(r, t, !0)._model, i, ut.nextItem(r, t, !0)._model, i.tension), i.controlPointPreviousX = s(n.previous.x, o.left, o.right), i.controlPointPreviousY = s(n.previous.y, o.top, o.bottom), i.controlPointNextX = s(n.next.x, o.left, o.right), i.controlPointNextY = s(n.next.y, o.top, o.bottom)
        },
        setHoverStyle: function(t) {
            var e = t._model,
                i = t._options,
                n = ut.getHoverColor;
            t.$previousStyle = {
                backgroundColor: e.backgroundColor,
                borderColor: e.borderColor,
                borderWidth: e.borderWidth,
                radius: e.radius
            }, e.backgroundColor = se(i.hoverBackgroundColor, n(i.backgroundColor)), e.borderColor = se(i.hoverBorderColor, n(i.borderColor)), e.borderWidth = se(i.hoverBorderWidth, i.borderWidth), e.radius = se(i.hoverRadius, i.radius)
        }
    });
    st._set("scatter", {
        hover: {
            mode: "single"
        },
        scales: {
            xAxes: [{
                id: "x-axis-1",
                type: "linear",
                position: "bottom"
            }],
            yAxes: [{
                id: "y-axis-1",
                type: "linear",
                position: "left"
            }]
        },
        showLines: !1,
        tooltips: {
            callbacks: {
                title: function() {
                    return ""
                },
                label: function(t) {
                    return "(" + t.xLabel + ", " + t.yLabel + ")"
                }
            }
        }
    });
    var ue = {
        bar: Yt,
        bubble: Kt,
        doughnut: $t,
        horizontalBar: Jt,
        line: ne,
        polarArea: oe,
        pie: re,
        radar: de,
        scatter: ne
    };

    function he(t, e) {
        return t.native ? {
            x: t.x,
            y: t.y
        } : ut.getRelativePosition(t, e)
    }

    function ce(t, e) {
        var i, n, a, o, r;
        for (n = 0, o = t.data.datasets.length; n < o; ++n)
            if (t.isDatasetVisible(n))
                for (a = 0, r = (i = t.getDatasetMeta(n)).data.length; a < r; ++a) {
                    var s = i.data[a];
                    s._view.skip || e(s)
                }
    }

    function fe(t, e) {
        var i = [];
        return ce(t, function(t) {
            t.inRange(e.x, e.y) && i.push(t)
        }), i
    }

    function ge(t, e, i, n) {
        var a = Number.POSITIVE_INFINITY,
            o = [];
        return ce(t, function(t) {
            if (!i || t.inRange(e.x, e.y)) {
                var r = t.getCenterPoint(),
                    s = n(e, r);
                s < a ? (o = [t], a = s) : s === a && o.push(t)
            }
        }), o
    }

    function pe(t) {
        var e = -1 !== t.indexOf("x"),
            i = -1 !== t.indexOf("y");
        return function(t, n) {
            var a = e ? Math.abs(t.x - n.x) : 0,
                o = i ? Math.abs(t.y - n.y) : 0;
            return Math.sqrt(Math.pow(a, 2) + Math.pow(o, 2))
        }
    }

    function me(t, e, i) {
        var n = he(e, t);
        i.axis = i.axis || "x";
        var a = pe(i.axis),
            o = i.intersect ? fe(t, n) : ge(t, n, !1, a),
            r = [];
        return o.length ? (t.data.datasets.forEach(function(e, i) {
            if (t.isDatasetVisible(i)) {
                var n = t.getDatasetMeta(i).data[o[0]._index];
                n && !n._view.skip && r.push(n)
            }
        }), r) : []
    }
    var ve = {
        modes: {
            single: function(t, e) {
                var i = he(e, t),
                    n = [];
                return ce(t, function(t) {
                    if (t.inRange(i.x, i.y)) return n.push(t), n
                }), n.slice(0, 1)
            },
            label: me,
            index: me,
            dataset: function(t, e, i) {
                var n = he(e, t);
                i.axis = i.axis || "xy";
                var a = pe(i.axis),
                    o = i.intersect ? fe(t, n) : ge(t, n, !1, a);
                return o.length > 0 && (o = t.getDatasetMeta(o[0]._datasetIndex).data), o
            },
            "x-axis": function(t, e) {
                return me(t, e, {
                    intersect: !1
                })
            },
            point: function(t, e) {
                return fe(t, he(e, t))
            },
            nearest: function(t, e, i) {
                var n = he(e, t);
                i.axis = i.axis || "xy";
                var a = pe(i.axis);
                return ge(t, n, i.intersect, a)
            },
            x: function(t, e, i) {
                var n = he(e, t),
                    a = [],
                    o = !1;
                return ce(t, function(t) {
                    t.inXRange(n.x) && a.push(t), t.inRange(n.x, n.y) && (o = !0)
                }), i.intersect && !o && (a = []), a
            },
            y: function(t, e, i) {
                var n = he(e, t),
                    a = [],
                    o = !1;
                return ce(t, function(t) {
                    t.inYRange(n.y) && a.push(t), t.inRange(n.x, n.y) && (o = !0)
                }), i.intersect && !o && (a = []), a
            }
        }
    };

    function be(t, e) {
        return ut.where(t, function(t) {
            return t.position === e
        })
    }

    function xe(t, e) {
        t.forEach(function(t, e) {
            return t._tmpIndex_ = e, t
        }), t.sort(function(t, i) {
            var n = e ? i : t,
                a = e ? t : i;
            return n.weight === a.weight ? n._tmpIndex_ - a._tmpIndex_ : n.weight - a.weight
        }), t.forEach(function(t) {
            delete t._tmpIndex_
        })
    }

    function ye(t, e) {
        ut.each(t, function(t) {
            e[t.position] += t.isHorizontal() ? t.height : t.width
        })
    }
    st._set("global", {
        layout: {
            padding: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        }
    });
    var ke = {
        defaults: {},
        addBox: function(t, e) {
            t.boxes || (t.boxes = []), e.fullWidth = e.fullWidth || !1, e.position = e.position || "top", e.weight = e.weight || 0, t.boxes.push(e)
        },
        removeBox: function(t, e) {
            var i = t.boxes ? t.boxes.indexOf(e) : -1; - 1 !== i && t.boxes.splice(i, 1)
        },
        configure: function(t, e, i) {
            for (var n, a = ["fullWidth", "position", "weight"], o = a.length, r = 0; r < o; ++r) n = a[r], i.hasOwnProperty(n) && (e[n] = i[n])
        },
        update: function(t, e, i) {
            if (t) {
                var n = t.options.layout || {},
                    a = ut.options.toPadding(n.padding),
                    o = a.left,
                    r = a.right,
                    s = a.top,
                    l = a.bottom,
                    d = be(t.boxes, "left"),
                    u = be(t.boxes, "right"),
                    h = be(t.boxes, "top"),
                    c = be(t.boxes, "bottom"),
                    f = be(t.boxes, "chartArea");
                xe(d, !0), xe(u, !1), xe(h, !0), xe(c, !1);
                var g, p = d.concat(u),
                    m = h.concat(c),
                    v = p.concat(m),
                    b = e - o - r,
                    x = i - s - l,
                    y = (e - b / 2) / p.length,
                    k = b,
                    w = x,
                    M = {
                        top: s,
                        left: o,
                        bottom: l,
                        right: r
                    },
                    _ = [];
                ut.each(v, function(t) {
                    var e, i = t.isHorizontal();
                    i ? (e = t.update(t.fullWidth ? b : k, x / 2), w -= e.height) : (e = t.update(y, w), k -= e.width), _.push({
                        horizontal: i,
                        width: e.width,
                        box: t
                    })
                }), g = function(t) {
                    var e = 0,
                        i = 0,
                        n = 0,
                        a = 0;
                    return ut.each(t, function(t) {
                        if (t.getPadding) {
                            var o = t.getPadding();
                            e = Math.max(e, o.top), i = Math.max(i, o.left), n = Math.max(n, o.bottom), a = Math.max(a, o.right)
                        }
                    }), {
                        top: e,
                        left: i,
                        bottom: n,
                        right: a
                    }
                }(v), ut.each(p, T), ye(p, M), ut.each(m, T), ye(m, M), ut.each(p, function(t) {
                    var e = ut.findNextWhere(_, function(e) {
                            return e.box === t
                        }),
                        i = {
                            left: 0,
                            right: 0,
                            top: M.top,
                            bottom: M.bottom
                        };
                    e && t.update(e.width, w, i)
                }), ye(v, M = {
                    top: s,
                    left: o,
                    bottom: l,
                    right: r
                });
                var C = Math.max(g.left - M.left, 0);
                M.left += C, M.right += Math.max(g.right - M.right, 0);
                var S = Math.max(g.top - M.top, 0);
                M.top += S, M.bottom += Math.max(g.bottom - M.bottom, 0);
                var P = i - M.top - M.bottom,
                    I = e - M.left - M.right;
                I === k && P === w || (ut.each(p, function(t) {
                    t.height = P
                }), ut.each(m, function(t) {
                    t.fullWidth || (t.width = I)
                }), w = P, k = I);
                var A = o + C,
                    D = s + S;
                ut.each(d.concat(h), F), A += k, D += w, ut.each(u, F), ut.each(c, F), t.chartArea = {
                    left: M.left,
                    top: M.top,
                    right: M.left + k,
                    bottom: M.top + w
                }, ut.each(f, function(e) {
                    e.left = t.chartArea.left, e.top = t.chartArea.top, e.right = t.chartArea.right, e.bottom = t.chartArea.bottom, e.update(k, w)
                })
            }

            function T(t) {
                var e = ut.findNextWhere(_, function(e) {
                    return e.box === t
                });
                if (e)
                    if (e.horizontal) {
                        var i = {
                            left: Math.max(M.left, g.left),
                            right: Math.max(M.right, g.right),
                            top: 0,
                            bottom: 0
                        };
                        t.update(t.fullWidth ? b : k, x / 2, i)
                    } else t.update(e.width, w)
            }

            function F(t) {
                t.isHorizontal() ? (t.left = t.fullWidth ? o : M.left, t.right = t.fullWidth ? e - r : M.left + k, t.top = D, t.bottom = D + t.height, D = t.bottom) : (t.left = A, t.right = A + t.width, t.top = M.top, t.bottom = M.top + w, A = t.right)
            }
        }
    };
    var we, Me = (we = Object.freeze({
            default: "@keyframes chartjs-render-animation{from{opacity:.99}to{opacity:1}}.chartjs-render-monitor{animation:chartjs-render-animation 1ms}.chartjs-size-monitor,.chartjs-size-monitor-expand,.chartjs-size-monitor-shrink{position:absolute;direction:ltr;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1}.chartjs-size-monitor-expand>div{position:absolute;width:1000000px;height:1000000px;left:0;top:0}.chartjs-size-monitor-shrink>div{position:absolute;width:200%;height:200%;left:0;top:0}"
        })) && we.default || we,
        _e = "$chartjs",
        Ce = "chartjs-size-monitor",
        Se = "chartjs-render-monitor",
        Pe = "chartjs-render-animation",
        Ie = ["animationstart", "webkitAnimationStart"],
        Ae = {
            touchstart: "mousedown",
            touchmove: "mousemove",
            touchend: "mouseup",
            pointerenter: "mouseenter",
            pointerdown: "mousedown",
            pointermove: "mousemove",
            pointerup: "mouseup",
            pointerleave: "mouseout",
            pointerout: "mouseout"
        };

    function De(t, e) {
        var i = ut.getStyle(t, e),
            n = i && i.match(/^(\d+)(\.\d+)?px$/);
        return n ? Number(n[1]) : void 0
    }
    var Te = !! function() {
        var t = !1;
        try {
            var e = Object.defineProperty({}, "passive", {
                get: function() {
                    t = !0
                }
            });
            window.addEventListener("e", null, e)
        } catch (t) {}
        return t
    }() && {
        passive: !0
    };

    function Fe(t, e, i) {
        t.addEventListener(e, i, Te)
    }

    function Le(t, e, i) {
        t.removeEventListener(e, i, Te)
    }

    function Re(t, e, i, n, a) {
        return {
            type: t,
            chart: e,
            native: a || null,
            x: void 0 !== i ? i : null,
            y: void 0 !== n ? n : null
        }
    }

    function Oe(t) {
        var e = document.createElement("div");
        return e.className = t || "", e
    }

    function ze(t, e, i) {
        var n, a, o, r, s = t[_e] || (t[_e] = {}),
            l = s.resizer = function(t) {
                var e = Oe(Ce),
                    i = Oe(Ce + "-expand"),
                    n = Oe(Ce + "-shrink");
                i.appendChild(Oe()), n.appendChild(Oe()), e.appendChild(i), e.appendChild(n), e._reset = function() {
                    i.scrollLeft = 1e6, i.scrollTop = 1e6, n.scrollLeft = 1e6, n.scrollTop = 1e6
                };
                var a = function() {
                    e._reset(), t()
                };
                return Fe(i, "scroll", a.bind(i, "expand")), Fe(n, "scroll", a.bind(n, "shrink")), e
            }((n = function() {
                if (s.resizer) {
                    var n = i.options.maintainAspectRatio && t.parentNode,
                        a = n ? n.clientWidth : 0;
                    e(Re("resize", i)), n && n.clientWidth < a && i.canvas && e(Re("resize", i))
                }
            }, o = !1, r = [], function() {
                r = Array.prototype.slice.call(arguments), a = a || this, o || (o = !0, ut.requestAnimFrame.call(window, function() {
                    o = !1, n.apply(a, r)
                }))
            }));
        ! function(t, e) {
            var i = t[_e] || (t[_e] = {}),
                n = i.renderProxy = function(t) {
                    t.animationName === Pe && e()
                };
            ut.each(Ie, function(e) {
                Fe(t, e, n)
            }), i.reflow = !!t.offsetParent, t.classList.add(Se)
        }(t, function() {
            if (s.resizer) {
                var e = t.parentNode;
                e && e !== l.parentNode && e.insertBefore(l, e.firstChild), l._reset()
            }
        })
    }

    function Be(t) {
        var e = t[_e] || {},
            i = e.resizer;
        delete e.resizer,
            function(t) {
                var e = t[_e] || {},
                    i = e.renderProxy;
                i && (ut.each(Ie, function(e) {
                    Le(t, e, i)
                }), delete e.renderProxy), t.classList.remove(Se)
            }(t), i && i.parentNode && i.parentNode.removeChild(i)
    }
    var Ne = {
        disableCSSInjection: !1,
        _enabled: "undefined" != typeof window && "undefined" != typeof document,
        _ensureLoaded: function() {
            var t, e, i;
            this._loaded || (this._loaded = !0, this.disableCSSInjection || (e = Me, i = (t = this)._style || document.createElement("style"), t._style || (t._style = i, e = "/* Chart.js */\n" + e, i.setAttribute("type", "text/css"), document.getElementsByTagName("head")[0].appendChild(i)), i.appendChild(document.createTextNode(e))))
        },
        acquireContext: function(t, e) {
            "string" == typeof t ? t = document.getElementById(t) : t.length && (t = t[0]), t && t.canvas && (t = t.canvas);
            var i = t && t.getContext && t.getContext("2d");
            return this._ensureLoaded(), i && i.canvas === t ? (function(t, e) {
                var i = t.style,
                    n = t.getAttribute("height"),
                    a = t.getAttribute("width");
                if (t[_e] = {
                        initial: {
                            height: n,
                            width: a,
                            style: {
                                display: i.display,
                                height: i.height,
                                width: i.width
                            }
                        }
                    }, i.display = i.display || "block", null === a || "" === a) {
                    var o = De(t, "width");
                    void 0 !== o && (t.width = o)
                }
                if (null === n || "" === n)
                    if ("" === t.style.height) t.height = t.width / (e.options.aspectRatio || 2);
                    else {
                        var r = De(t, "height");
                        void 0 !== o && (t.height = r)
                    }
            }(t, e), i) : null
        },
        releaseContext: function(t) {
            var e = t.canvas;
            if (e[_e]) {
                var i = e[_e].initial;
                ["height", "width"].forEach(function(t) {
                    var n = i[t];
                    ut.isNullOrUndef(n) ? e.removeAttribute(t) : e.setAttribute(t, n)
                }), ut.each(i.style || {}, function(t, i) {
                    e.style[i] = t
                }), e.width = e.width, delete e[_e]
            }
        },
        addEventListener: function(t, e, i) {
            var n = t.canvas;
            if ("resize" !== e) {
                var a = i[_e] || (i[_e] = {});
                Fe(n, e, (a.proxies || (a.proxies = {}))[t.id + "_" + e] = function(e) {
                    i(function(t, e) {
                        var i = Ae[t.type] || t.type,
                            n = ut.getRelativePosition(t, e);
                        return Re(i, e, n.x, n.y, t)
                    }(e, t))
                })
            } else ze(n, i, t)
        },
        removeEventListener: function(t, e, i) {
            var n = t.canvas;
            if ("resize" !== e) {
                var a = ((i[_e] || {}).proxies || {})[t.id + "_" + e];
                a && Le(n, e, a)
            } else Be(n)
        }
    };
    ut.addEvent = Fe, ut.removeEvent = Le;
    var We = Ne._enabled ? Ne : {
            acquireContext: function(t) {
                return t && t.canvas && (t = t.canvas), t && t.getContext("2d") || null
            }
        },
        Ve = ut.extend({
            initialize: function() {},
            acquireContext: function() {},
            releaseContext: function() {},
            addEventListener: function() {},
            removeEventListener: function() {}
        }, We);
    st._set("global", {
        plugins: {}
    });
    var Ee = {
            _plugins: [],
            _cacheId: 0,
            register: function(t) {
                var e = this._plugins;
                [].concat(t).forEach(function(t) {
                    -1 === e.indexOf(t) && e.push(t)
                }), this._cacheId++
            },
            unregister: function(t) {
                var e = this._plugins;
                [].concat(t).forEach(function(t) {
                    var i = e.indexOf(t); - 1 !== i && e.splice(i, 1)
                }), this._cacheId++
            },
            clear: function() {
                this._plugins = [], this._cacheId++
            },
            count: function() {
                return this._plugins.length
            },
            getAll: function() {
                return this._plugins
            },
            notify: function(t, e, i) {
                var n, a, o, r, s, l = this.descriptors(t),
                    d = l.length;
                for (n = 0; n < d; ++n)
                    if ("function" == typeof(s = (o = (a = l[n]).plugin)[e]) && ((r = [t].concat(i || [])).push(a.options), !1 === s.apply(o, r))) return !1;
                return !0
            },
            descriptors: function(t) {
                var e = t.$plugins || (t.$plugins = {});
                if (e.id === this._cacheId) return e.descriptors;
                var i = [],
                    n = [],
                    a = t && t.config || {},
                    o = a.options && a.options.plugins || {};
                return this._plugins.concat(a.plugins || []).forEach(function(t) {
                    if (-1 === i.indexOf(t)) {
                        var e = t.id,
                            a = o[e];
                        !1 !== a && (!0 === a && (a = ut.clone(st.global.plugins[e])), i.push(t), n.push({
                            plugin: t,
                            options: a || {}
                        }))
                    }
                }), e.descriptors = n, e.id = this._cacheId, n
            },
            _invalidate: function(t) {
                delete t.$plugins
            }
        },
        He = {
            constructors: {},
            defaults: {},
            registerScaleType: function(t, e, i) {
                this.constructors[t] = e, this.defaults[t] = ut.clone(i)
            },
            getScaleConstructor: function(t) {
                return this.constructors.hasOwnProperty(t) ? this.constructors[t] : void 0
            },
            getScaleDefaults: function(t) {
                return this.defaults.hasOwnProperty(t) ? ut.merge({}, [st.scale, this.defaults[t]]) : {}
            },
            updateScaleDefaults: function(t, e) {
                this.defaults.hasOwnProperty(t) && (this.defaults[t] = ut.extend(this.defaults[t], e))
            },
            addScalesToLayout: function(t) {
                ut.each(t.scales, function(e) {
                    e.fullWidth = e.options.fullWidth, e.position = e.options.position, e.weight = e.options.weight, ke.addBox(t, e)
                })
            }
        },
        je = ut.valueOrDefault;
    st._set("global", {
        tooltips: {
            enabled: !0,
            custom: null,
            mode: "nearest",
            position: "average",
            intersect: !0,
            backgroundColor: "rgba(0,0,0,0.8)",
            titleFontStyle: "bold",
            titleSpacing: 2,
            titleMarginBottom: 6,
            titleFontColor: "#fff",
            titleAlign: "left",
            bodySpacing: 2,
            bodyFontColor: "#fff",
            bodyAlign: "left",
            footerFontStyle: "bold",
            footerSpacing: 2,
            footerMarginTop: 6,
            footerFontColor: "#fff",
            footerAlign: "left",
            yPadding: 6,
            xPadding: 6,
            caretPadding: 2,
            caretSize: 5,
            cornerRadius: 6,
            multiKeyBackground: "#fff",
            displayColors: !0,
            borderColor: "rgba(0,0,0,0)",
            borderWidth: 0,
            callbacks: {
                beforeTitle: ut.noop,
                title: function(t, e) {
                    var i = "",
                        n = e.labels,
                        a = n ? n.length : 0;
                    if (t.length > 0) {
                        var o = t[0];
                        o.label ? i = o.label : o.xLabel ? i = o.xLabel : a > 0 && o.index < a && (i = n[o.index])
                    }
                    return i
                },
                afterTitle: ut.noop,
                beforeBody: ut.noop,
                beforeLabel: ut.noop,
                label: function(t, e) {
                    var i = e.datasets[t.datasetIndex].label || "";
                    return i && (i += ": "), ut.isNullOrUndef(t.value) ? i += t.yLabel : i += t.value, i
                },
                labelColor: function(t, e) {
                    var i = e.getDatasetMeta(t.datasetIndex).data[t.index]._view;
                    return {
                        borderColor: i.borderColor,
                        backgroundColor: i.backgroundColor
                    }
                },
                labelTextColor: function() {
                    return this._options.bodyFontColor
                },
                afterLabel: ut.noop,
                afterBody: ut.noop,
                beforeFooter: ut.noop,
                footer: ut.noop,
                afterFooter: ut.noop
            }
        }
    });
    var qe = {
        average: function(t) {
            if (!t.length) return !1;
            var e, i, n = 0,
                a = 0,
                o = 0;
            for (e = 0, i = t.length; e < i; ++e) {
                var r = t[e];
                if (r && r.hasValue()) {
                    var s = r.tooltipPosition();
                    n += s.x, a += s.y, ++o
                }
            }
            return {
                x: n / o,
                y: a / o
            }
        },
        nearest: function(t, e) {
            var i, n, a, o = e.x,
                r = e.y,
                s = Number.POSITIVE_INFINITY;
            for (i = 0, n = t.length; i < n; ++i) {
                var l = t[i];
                if (l && l.hasValue()) {
                    var d = l.getCenterPoint(),
                        u = ut.distanceBetweenPoints(e, d);
                    u < s && (s = u, a = l)
                }
            }
            if (a) {
                var h = a.tooltipPosition();
                o = h.x, r = h.y
            }
            return {
                x: o,
                y: r
            }
        }
    };

    function Ye(t, e) {
        return e && (ut.isArray(e) ? Array.prototype.push.apply(t, e) : t.push(e)), t
    }

    function Ue(t) {
        return ("string" == typeof t || t instanceof String) && t.indexOf("\n") > -1 ? t.split("\n") : t
    }

    function Xe(t) {
        var e = st.global;
        return {
            xPadding: t.xPadding,
            yPadding: t.yPadding,
            xAlign: t.xAlign,
            yAlign: t.yAlign,
            bodyFontColor: t.bodyFontColor,
            _bodyFontFamily: je(t.bodyFontFamily, e.defaultFontFamily),
            _bodyFontStyle: je(t.bodyFontStyle, e.defaultFontStyle),
            _bodyAlign: t.bodyAlign,
            bodyFontSize: je(t.bodyFontSize, e.defaultFontSize),
            bodySpacing: t.bodySpacing,
            titleFontColor: t.titleFontColor,
            _titleFontFamily: je(t.titleFontFamily, e.defaultFontFamily),
            _titleFontStyle: je(t.titleFontStyle, e.defaultFontStyle),
            titleFontSize: je(t.titleFontSize, e.defaultFontSize),
            _titleAlign: t.titleAlign,
            titleSpacing: t.titleSpacing,
            titleMarginBottom: t.titleMarginBottom,
            footerFontColor: t.footerFontColor,
            _footerFontFamily: je(t.footerFontFamily, e.defaultFontFamily),
            _footerFontStyle: je(t.footerFontStyle, e.defaultFontStyle),
            footerFontSize: je(t.footerFontSize, e.defaultFontSize),
            _footerAlign: t.footerAlign,
            footerSpacing: t.footerSpacing,
            footerMarginTop: t.footerMarginTop,
            caretSize: t.caretSize,
            cornerRadius: t.cornerRadius,
            backgroundColor: t.backgroundColor,
            opacity: 0,
            legendColorBackground: t.multiKeyBackground,
            displayColors: t.displayColors,
            borderColor: t.borderColor,
            borderWidth: t.borderWidth
        }
    }

    function Ke(t, e) {
        return "center" === e ? t.x + t.width / 2 : "right" === e ? t.x + t.width - t.xPadding : t.x + t.xPadding
    }

    function Ge(t) {
        return Ye([], Ue(t))
    }
    var Ze = pt.extend({
            initialize: function() {
                this._model = Xe(this._options), this._lastActive = []
            },
            getTitle: function() {
                var t = this._options.callbacks,
                    e = t.beforeTitle.apply(this, arguments),
                    i = t.title.apply(this, arguments),
                    n = t.afterTitle.apply(this, arguments),
                    a = [];
                return a = Ye(a, Ue(e)), a = Ye(a, Ue(i)), a = Ye(a, Ue(n))
            },
            getBeforeBody: function() {
                return Ge(this._options.callbacks.beforeBody.apply(this, arguments))
            },
            getBody: function(t, e) {
                var i = this,
                    n = i._options.callbacks,
                    a = [];
                return ut.each(t, function(t) {
                    var o = {
                        before: [],
                        lines: [],
                        after: []
                    };
                    Ye(o.before, Ue(n.beforeLabel.call(i, t, e))), Ye(o.lines, n.label.call(i, t, e)), Ye(o.after, Ue(n.afterLabel.call(i, t, e))), a.push(o)
                }), a
            },
            getAfterBody: function() {
                return Ge(this._options.callbacks.afterBody.apply(this, arguments))
            },
            getFooter: function() {
                var t = this._options.callbacks,
                    e = t.beforeFooter.apply(this, arguments),
                    i = t.footer.apply(this, arguments),
                    n = t.afterFooter.apply(this, arguments),
                    a = [];
                return a = Ye(a, Ue(e)), a = Ye(a, Ue(i)), a = Ye(a, Ue(n))
            },
            update: function(t) {
                var e, i, n, a, o, r, s, l, d, u, h = this,
                    c = h._options,
                    f = h._model,
                    g = h._model = Xe(c),
                    p = h._active,
                    m = h._data,
                    v = {
                        xAlign: f.xAlign,
                        yAlign: f.yAlign
                    },
                    b = {
                        x: f.x,
                        y: f.y
                    },
                    x = {
                        width: f.width,
                        height: f.height
                    },
                    y = {
                        x: f.caretX,
                        y: f.caretY
                    };
                if (p.length) {
                    g.opacity = 1;
                    var k = [],
                        w = [];
                    y = qe[c.position].call(h, p, h._eventPosition);
                    var M = [];
                    for (e = 0, i = p.length; e < i; ++e) M.push((n = p[e], a = void 0, o = void 0, r = void 0, s = void 0, l = void 0, d = void 0, u = void 0, a = n._xScale, o = n._yScale || n._scale, r = n._index, s = n._datasetIndex, l = n._chart.getDatasetMeta(s).controller, d = l._getIndexScale(), u = l._getValueScale(), {
                        xLabel: a ? a.getLabelForIndex(r, s) : "",
                        yLabel: o ? o.getLabelForIndex(r, s) : "",
                        label: d ? "" + d.getLabelForIndex(r, s) : "",
                        value: u ? "" + u.getLabelForIndex(r, s) : "",
                        index: r,
                        datasetIndex: s,
                        x: n._model.x,
                        y: n._model.y
                    }));
                    c.filter && (M = M.filter(function(t) {
                        return c.filter(t, m)
                    })), c.itemSort && (M = M.sort(function(t, e) {
                        return c.itemSort(t, e, m)
                    })), ut.each(M, function(t) {
                        k.push(c.callbacks.labelColor.call(h, t, h._chart)), w.push(c.callbacks.labelTextColor.call(h, t, h._chart))
                    }), g.title = h.getTitle(M, m), g.beforeBody = h.getBeforeBody(M, m), g.body = h.getBody(M, m), g.afterBody = h.getAfterBody(M, m), g.footer = h.getFooter(M, m), g.x = y.x, g.y = y.y, g.caretPadding = c.caretPadding, g.labelColors = k, g.labelTextColors = w, g.dataPoints = M, x = function(t, e) {
                        var i = t._chart.ctx,
                            n = 2 * e.yPadding,
                            a = 0,
                            o = e.body,
                            r = o.reduce(function(t, e) {
                                return t + e.before.length + e.lines.length + e.after.length
                            }, 0);
                        r += e.beforeBody.length + e.afterBody.length;
                        var s = e.title.length,
                            l = e.footer.length,
                            d = e.titleFontSize,
                            u = e.bodyFontSize,
                            h = e.footerFontSize;
                        n += s * d, n += s ? (s - 1) * e.titleSpacing : 0, n += s ? e.titleMarginBottom : 0, n += r * u, n += r ? (r - 1) * e.bodySpacing : 0, n += l ? e.footerMarginTop : 0, n += l * h, n += l ? (l - 1) * e.footerSpacing : 0;
                        var c = 0,
                            f = function(t) {
                                a = Math.max(a, i.measureText(t).width + c)
                            };
                        return i.font = ut.fontString(d, e._titleFontStyle, e._titleFontFamily), ut.each(e.title, f), i.font = ut.fontString(u, e._bodyFontStyle, e._bodyFontFamily), ut.each(e.beforeBody.concat(e.afterBody), f), c = e.displayColors ? u + 2 : 0, ut.each(o, function(t) {
                            ut.each(t.before, f), ut.each(t.lines, f), ut.each(t.after, f)
                        }), c = 0, i.font = ut.fontString(h, e._footerFontStyle, e._footerFontFamily), ut.each(e.footer, f), {
                            width: a += 2 * e.xPadding,
                            height: n
                        }
                    }(this, g), b = function(t, e, i, n) {
                        var a = t.x,
                            o = t.y,
                            r = t.caretSize,
                            s = t.caretPadding,
                            l = t.cornerRadius,
                            d = i.xAlign,
                            u = i.yAlign,
                            h = r + s,
                            c = l + s;
                        return "right" === d ? a -= e.width : "center" === d && ((a -= e.width / 2) + e.width > n.width && (a = n.width - e.width), a < 0 && (a = 0)), "top" === u ? o += h : o -= "bottom" === u ? e.height + h : e.height / 2, "center" === u ? "left" === d ? a += h : "right" === d && (a -= h) : "left" === d ? a -= c : "right" === d && (a += c), {
                            x: a,
                            y: o
                        }
                    }(g, x, v = function(t, e) {
                        var i, n, a, o, r, s = t._model,
                            l = t._chart,
                            d = t._chart.chartArea,
                            u = "center",
                            h = "center";
                        s.y < e.height ? h = "top" : s.y > l.height - e.height && (h = "bottom");
                        var c = (d.left + d.right) / 2,
                            f = (d.top + d.bottom) / 2;
                        "center" === h ? (i = function(t) {
                            return t <= c
                        }, n = function(t) {
                            return t > c
                        }) : (i = function(t) {
                            return t <= e.width / 2
                        }, n = function(t) {
                            return t >= l.width - e.width / 2
                        }), a = function(t) {
                            return t + e.width + s.caretSize + s.caretPadding > l.width
                        }, o = function(t) {
                            return t - e.width - s.caretSize - s.caretPadding < 0
                        }, r = function(t) {
                            return t <= f ? "top" : "bottom"
                        }, i(s.x) ? (u = "left", a(s.x) && (u = "center", h = r(s.y))) : n(s.x) && (u = "right", o(s.x) && (u = "center", h = r(s.y)));
                        var g = t._options;
                        return {
                            xAlign: g.xAlign ? g.xAlign : u,
                            yAlign: g.yAlign ? g.yAlign : h
                        }
                    }(this, x), h._chart)
                } else g.opacity = 0;
                return g.xAlign = v.xAlign, g.yAlign = v.yAlign, g.x = b.x, g.y = b.y, g.width = x.width, g.height = x.height, g.caretX = y.x, g.caretY = y.y, h._model = g, t && c.custom && c.custom.call(h, g), h
            },
            drawCaret: function(t, e) {
                var i = this._chart.ctx,
                    n = this._view,
                    a = this.getCaretPosition(t, e, n);
                i.lineTo(a.x1, a.y1), i.lineTo(a.x2, a.y2), i.lineTo(a.x3, a.y3)
            },
            getCaretPosition: function(t, e, i) {
                var n, a, o, r, s, l, d = i.caretSize,
                    u = i.cornerRadius,
                    h = i.xAlign,
                    c = i.yAlign,
                    f = t.x,
                    g = t.y,
                    p = e.width,
                    m = e.height;
                if ("center" === c) s = g + m / 2, "left" === h ? (a = (n = f) - d, o = n, r = s + d, l = s - d) : (a = (n = f + p) + d, o = n, r = s - d, l = s + d);
                else if ("left" === h ? (n = (a = f + u + d) - d, o = a + d) : "right" === h ? (n = (a = f + p - u - d) - d, o = a + d) : (n = (a = i.caretX) - d, o = a + d), "top" === c) s = (r = g) - d, l = r;
                else {
                    s = (r = g + m) + d, l = r;
                    var v = o;
                    o = n, n = v
                }
                return {
                    x1: n,
                    x2: a,
                    x3: o,
                    y1: r,
                    y2: s,
                    y3: l
                }
            },
            drawTitle: function(t, e, i) {
                var n = e.title;
                if (n.length) {
                    t.x = Ke(e, e._titleAlign), i.textAlign = e._titleAlign, i.textBaseline = "top";
                    var a, o, r = e.titleFontSize,
                        s = e.titleSpacing;
                    for (i.fillStyle = e.titleFontColor, i.font = ut.fontString(r, e._titleFontStyle, e._titleFontFamily), a = 0, o = n.length; a < o; ++a) i.fillText(n[a], t.x, t.y), t.y += r + s, a + 1 === n.length && (t.y += e.titleMarginBottom - s)
                }
            },
            drawBody: function(t, e, i) {
                var n, a = e.bodyFontSize,
                    o = e.bodySpacing,
                    r = e._bodyAlign,
                    s = e.body,
                    l = e.displayColors,
                    d = e.labelColors,
                    u = 0,
                    h = l ? Ke(e, "left") : 0;
                i.textAlign = r, i.textBaseline = "top", i.font = ut.fontString(a, e._bodyFontStyle, e._bodyFontFamily), t.x = Ke(e, r);
                var c = function(e) {
                    i.fillText(e, t.x + u, t.y), t.y += a + o
                };
                i.fillStyle = e.bodyFontColor, ut.each(e.beforeBody, c), u = l && "right" !== r ? "center" === r ? a / 2 + 1 : a + 2 : 0, ut.each(s, function(o, r) {
                    n = e.labelTextColors[r], i.fillStyle = n, ut.each(o.before, c), ut.each(o.lines, function(o) {
                        l && (i.fillStyle = e.legendColorBackground, i.fillRect(h, t.y, a, a), i.lineWidth = 1, i.strokeStyle = d[r].borderColor, i.strokeRect(h, t.y, a, a), i.fillStyle = d[r].backgroundColor, i.fillRect(h + 1, t.y + 1, a - 2, a - 2), i.fillStyle = n), c(o)
                    }), ut.each(o.after, c)
                }), u = 0, ut.each(e.afterBody, c), t.y -= o
            },
            drawFooter: function(t, e, i) {
                var n = e.footer;
                n.length && (t.x = Ke(e, e._footerAlign), t.y += e.footerMarginTop, i.textAlign = e._footerAlign, i.textBaseline = "top", i.fillStyle = e.footerFontColor, i.font = ut.fontString(e.footerFontSize, e._footerFontStyle, e._footerFontFamily), ut.each(n, function(n) {
                    i.fillText(n, t.x, t.y), t.y += e.footerFontSize + e.footerSpacing
                }))
            },
            drawBackground: function(t, e, i, n) {
                i.fillStyle = e.backgroundColor, i.strokeStyle = e.borderColor, i.lineWidth = e.borderWidth;
                var a = e.xAlign,
                    o = e.yAlign,
                    r = t.x,
                    s = t.y,
                    l = n.width,
                    d = n.height,
                    u = e.cornerRadius;
                i.beginPath(), i.moveTo(r + u, s), "top" === o && this.drawCaret(t, n), i.lineTo(r + l - u, s), i.quadraticCurveTo(r + l, s, r + l, s + u), "center" === o && "right" === a && this.drawCaret(t, n), i.lineTo(r + l, s + d - u), i.quadraticCurveTo(r + l, s + d, r + l - u, s + d), "bottom" === o && this.drawCaret(t, n), i.lineTo(r + u, s + d), i.quadraticCurveTo(r, s + d, r, s + d - u), "center" === o && "left" === a && this.drawCaret(t, n), i.lineTo(r, s + u), i.quadraticCurveTo(r, s, r + u, s), i.closePath(), i.fill(), e.borderWidth > 0 && i.stroke()
            },
            draw: function() {
                var t = this._chart.ctx,
                    e = this._view;
                if (0 !== e.opacity) {
                    var i = {
                            width: e.width,
                            height: e.height
                        },
                        n = {
                            x: e.x,
                            y: e.y
                        },
                        a = Math.abs(e.opacity < .001) ? 0 : e.opacity,
                        o = e.title.length || e.beforeBody.length || e.body.length || e.afterBody.length || e.footer.length;
                    this._options.enabled && o && (t.save(), t.globalAlpha = a, this.drawBackground(n, e, t, i), n.y += e.yPadding, this.drawTitle(n, e, t), this.drawBody(n, e, t), this.drawFooter(n, e, t), t.restore())
                }
            },
            handleEvent: function(t) {
                var e, i = this,
                    n = i._options;
                return i._lastActive = i._lastActive || [], "mouseout" === t.type ? i._active = [] : i._active = i._chart.getElementsAtEventForMode(t, n.mode, n), (e = !ut.arrayEquals(i._active, i._lastActive)) && (i._lastActive = i._active, (n.enabled || n.custom) && (i._eventPosition = {
                    x: t.x,
                    y: t.y
                }, i.update(!0), i.pivot())), e
            }
        }),
        $e = qe,
        Je = Ze;
    Je.positioners = $e;
    var Qe = ut.valueOrDefault;

    function ti() {
        return ut.merge({}, [].slice.call(arguments), {
            merger: function(t, e, i, n) {
                if ("xAxes" === t || "yAxes" === t) {
                    var a, o, r, s = i[t].length;
                    for (e[t] || (e[t] = []), a = 0; a < s; ++a) r = i[t][a], o = Qe(r.type, "xAxes" === t ? "category" : "linear"), a >= e[t].length && e[t].push({}), !e[t][a].type || r.type && r.type !== e[t][a].type ? ut.merge(e[t][a], [He.getScaleDefaults(o), r]) : ut.merge(e[t][a], r)
                } else ut._merger(t, e, i, n)
            }
        })
    }

    function ei() {
        return ut.merge({}, [].slice.call(arguments), {
            merger: function(t, e, i, n) {
                var a = e[t] || {},
                    o = i[t];
                "scales" === t ? e[t] = ti(a, o) : "scale" === t ? e[t] = ut.merge(a, [He.getScaleDefaults(o.type), o]) : ut._merger(t, e, i, n)
            }
        })
    }

    function ii(t) {
        return "top" === t || "bottom" === t
    }
    st._set("global", {
        elements: {},
        events: ["mousemove", "mouseout", "click", "touchstart", "touchmove"],
        hover: {
            onHover: null,
            mode: "nearest",
            intersect: !0,
            animationDuration: 400
        },
        onClick: null,
        maintainAspectRatio: !0,
        responsive: !0,
        responsiveAnimationDuration: 0
    });
    var ni = function(t, e) {
        return this.construct(t, e), this
    };
    ut.extend(ni.prototype, {
        construct: function(t, e) {
            var i = this;
            e = function(t) {
                var e = (t = t || {}).data = t.data || {};
                return e.datasets = e.datasets || [], e.labels = e.labels || [], t.options = ei(st.global, st[t.type], t.options || {}), t
            }(e);
            var n = Ve.acquireContext(t, e),
                a = n && n.canvas,
                o = a && a.height,
                r = a && a.width;
            i.id = ut.uid(), i.ctx = n, i.canvas = a, i.config = e, i.width = r, i.height = o, i.aspectRatio = o ? r / o : null, i.options = e.options, i._bufferedRender = !1, i.chart = i, i.controller = i, ni.instances[i.id] = i, Object.defineProperty(i, "data", {
                get: function() {
                    return i.config.data
                },
                set: function(t) {
                    i.config.data = t
                }
            }), n && a ? (i.initialize(), i.update()) : console.error("Failed to create chart: can't acquire context from the given item")
        },
        initialize: function() {
            var t = this;
            return Ee.notify(t, "beforeInit"), ut.retinaScale(t, t.options.devicePixelRatio), t.bindEvents(), t.options.responsive && t.resize(!0), t.ensureScalesHaveIDs(), t.buildOrUpdateScales(), t.initToolTip(), Ee.notify(t, "afterInit"), t
        },
        clear: function() {
            return ut.canvas.clear(this), this
        },
        stop: function() {
            return bt.cancelAnimation(this), this
        },
        resize: function(t) {
            var e = this,
                i = e.options,
                n = e.canvas,
                a = i.maintainAspectRatio && e.aspectRatio || null,
                o = Math.max(0, Math.floor(ut.getMaximumWidth(n))),
                r = Math.max(0, Math.floor(a ? o / a : ut.getMaximumHeight(n)));
            if ((e.width !== o || e.height !== r) && (n.width = e.width = o, n.height = e.height = r, n.style.width = o + "px", n.style.height = r + "px", ut.retinaScale(e, i.devicePixelRatio), !t)) {
                var s = {
                    width: o,
                    height: r
                };
                Ee.notify(e, "resize", [s]), i.onResize && i.onResize(e, s), e.stop(), e.update({
                    duration: i.responsiveAnimationDuration
                })
            }
        },
        ensureScalesHaveIDs: function() {
            var t = this.options,
                e = t.scales || {},
                i = t.scale;
            ut.each(e.xAxes, function(t, e) {
                t.id = t.id || "x-axis-" + e
            }), ut.each(e.yAxes, function(t, e) {
                t.id = t.id || "y-axis-" + e
            }), i && (i.id = i.id || "scale")
        },
        buildOrUpdateScales: function() {
            var t = this,
                e = t.options,
                i = t.scales || {},
                n = [],
                a = Object.keys(i).reduce(function(t, e) {
                    return t[e] = !1, t
                }, {});
            e.scales && (n = n.concat((e.scales.xAxes || []).map(function(t) {
                return {
                    options: t,
                    dtype: "category",
                    dposition: "bottom"
                }
            }), (e.scales.yAxes || []).map(function(t) {
                return {
                    options: t,
                    dtype: "linear",
                    dposition: "left"
                }
            }))), e.scale && n.push({
                options: e.scale,
                dtype: "radialLinear",
                isDefault: !0,
                dposition: "chartArea"
            }), ut.each(n, function(e) {
                var n = e.options,
                    o = n.id,
                    r = Qe(n.type, e.dtype);
                ii(n.position) !== ii(e.dposition) && (n.position = e.dposition), a[o] = !0;
                var s = null;
                if (o in i && i[o].type === r)(s = i[o]).options = n, s.ctx = t.ctx, s.chart = t;
                else {
                    var l = He.getScaleConstructor(r);
                    if (!l) return;
                    s = new l({
                        id: o,
                        type: r,
                        options: n,
                        ctx: t.ctx,
                        chart: t
                    }), i[s.id] = s
                }
                s.mergeTicksOptions(), e.isDefault && (t.scale = s)
            }), ut.each(a, function(t, e) {
                t || delete i[e]
            }), t.scales = i, He.addScalesToLayout(this)
        },
        buildOrUpdateControllers: function() {
            var t = this,
                e = [];
            return ut.each(t.data.datasets, function(i, n) {
                var a = t.getDatasetMeta(n),
                    o = i.type || t.config.type;
                if (a.type && a.type !== o && (t.destroyDatasetMeta(n), a = t.getDatasetMeta(n)), a.type = o, a.controller) a.controller.updateIndex(n), a.controller.linkScales();
                else {
                    var r = ue[a.type];
                    if (void 0 === r) throw new Error('"' + a.type + '" is not a chart type.');
                    a.controller = new r(t, n), e.push(a.controller)
                }
            }, t), e
        },
        resetElements: function() {
            var t = this;
            ut.each(t.data.datasets, function(e, i) {
                t.getDatasetMeta(i).controller.reset()
            }, t)
        },
        reset: function() {
            this.resetElements(), this.tooltip.initialize()
        },
        update: function(t) {
            var e, i, n = this;
            if (t && "object" == typeof t || (t = {
                    duration: t,
                    lazy: arguments[1]
                }), i = (e = n).options, ut.each(e.scales, function(t) {
                    ke.removeBox(e, t)
                }), i = ei(st.global, st[e.config.type], i), e.options = e.config.options = i, e.ensureScalesHaveIDs(), e.buildOrUpdateScales(), e.tooltip._options = i.tooltips, e.tooltip.initialize(), Ee._invalidate(n), !1 !== Ee.notify(n, "beforeUpdate")) {
                n.tooltip._data = n.data;
                var a = n.buildOrUpdateControllers();
                ut.each(n.data.datasets, function(t, e) {
                    n.getDatasetMeta(e).controller.buildOrUpdateElements()
                }, n), n.updateLayout(), n.options.animation && n.options.animation.duration && ut.each(a, function(t) {
                    t.reset()
                }), n.updateDatasets(), n.tooltip.initialize(), n.lastActive = [], Ee.notify(n, "afterUpdate"), n._bufferedRender ? n._bufferedRequest = {
                    duration: t.duration,
                    easing: t.easing,
                    lazy: t.lazy
                } : n.render(t)
            }
        },
        updateLayout: function() {
            !1 !== Ee.notify(this, "beforeLayout") && (ke.update(this, this.width, this.height), Ee.notify(this, "afterScaleUpdate"), Ee.notify(this, "afterLayout"))
        },
        updateDatasets: function() {
            if (!1 !== Ee.notify(this, "beforeDatasetsUpdate")) {
                for (var t = 0, e = this.data.datasets.length; t < e; ++t) this.updateDataset(t);
                Ee.notify(this, "afterDatasetsUpdate")
            }
        },
        updateDataset: function(t) {
            var e = this.getDatasetMeta(t),
                i = {
                    meta: e,
                    index: t
                };
            !1 !== Ee.notify(this, "beforeDatasetUpdate", [i]) && (e.controller.update(), Ee.notify(this, "afterDatasetUpdate", [i]))
        },
        render: function(t) {
            var e = this;
            t && "object" == typeof t || (t = {
                duration: t,
                lazy: arguments[1]
            });
            var i = e.options.animation,
                n = Qe(t.duration, i && i.duration),
                a = t.lazy;
            if (!1 !== Ee.notify(e, "beforeRender")) {
                var o = function(t) {
                    Ee.notify(e, "afterRender"), ut.callback(i && i.onComplete, [t], e)
                };
                if (i && n) {
                    var r = new vt({
                        numSteps: n / 16.66,
                        easing: t.easing || i.easing,
                        render: function(t, e) {
                            var i = ut.easing.effects[e.easing],
                                n = e.currentStep,
                                a = n / e.numSteps;
                            t.draw(i(a), a, n)
                        },
                        onAnimationProgress: i.onProgress,
                        onAnimationComplete: o
                    });
                    bt.addAnimation(e, r, n, a)
                } else e.draw(), o(new vt({
                    numSteps: 0,
                    chart: e
                }));
                return e
            }
        },
        draw: function(t) {
            var e = this;
            e.clear(), ut.isNullOrUndef(t) && (t = 1), e.transition(t), e.width <= 0 || e.height <= 0 || !1 !== Ee.notify(e, "beforeDraw", [t]) && (ut.each(e.boxes, function(t) {
                t.draw(e.chartArea)
            }, e), e.drawDatasets(t), e._drawTooltip(t), Ee.notify(e, "afterDraw", [t]))
        },
        transition: function(t) {
            for (var e = 0, i = (this.data.datasets || []).length; e < i; ++e) this.isDatasetVisible(e) && this.getDatasetMeta(e).controller.transition(t);
            this.tooltip.transition(t)
        },
        drawDatasets: function(t) {
            var e = this;
            if (!1 !== Ee.notify(e, "beforeDatasetsDraw", [t])) {
                for (var i = (e.data.datasets || []).length - 1; i >= 0; --i) e.isDatasetVisible(i) && e.drawDataset(i, t);
                Ee.notify(e, "afterDatasetsDraw", [t])
            }
        },
        drawDataset: function(t, e) {
            var i = this.getDatasetMeta(t),
                n = {
                    meta: i,
                    index: t,
                    easingValue: e
                };
            !1 !== Ee.notify(this, "beforeDatasetDraw", [n]) && (i.controller.draw(e), Ee.notify(this, "afterDatasetDraw", [n]))
        },
        _drawTooltip: function(t) {
            var e = this.tooltip,
                i = {
                    tooltip: e,
                    easingValue: t
                };
            !1 !== Ee.notify(this, "beforeTooltipDraw", [i]) && (e.draw(), Ee.notify(this, "afterTooltipDraw", [i]))
        },
        getElementAtEvent: function(t) {
            return ve.modes.single(this, t)
        },
        getElementsAtEvent: function(t) {
            return ve.modes.label(this, t, {
                intersect: !0
            })
        },
        getElementsAtXAxis: function(t) {
            return ve.modes["x-axis"](this, t, {
                intersect: !0
            })
        },
        getElementsAtEventForMode: function(t, e, i) {
            var n = ve.modes[e];
            return "function" == typeof n ? n(this, t, i) : []
        },
        getDatasetAtEvent: function(t) {
            return ve.modes.dataset(this, t, {
                intersect: !0
            })
        },
        getDatasetMeta: function(t) {
            var e = this.data.datasets[t];
            e._meta || (e._meta = {});
            var i = e._meta[this.id];
            return i || (i = e._meta[this.id] = {
                type: null,
                data: [],
                dataset: null,
                controller: null,
                hidden: null,
                xAxisID: null,
                yAxisID: null
            }), i
        },
        getVisibleDatasetCount: function() {
            for (var t = 0, e = 0, i = this.data.datasets.length; e < i; ++e) this.isDatasetVisible(e) && t++;
            return t
        },
        isDatasetVisible: function(t) {
            var e = this.getDatasetMeta(t);
            return "boolean" == typeof e.hidden ? !e.hidden : !this.data.datasets[t].hidden
        },
        generateLegend: function() {
            return this.options.legendCallback(this)
        },
        destroyDatasetMeta: function(t) {
            var e = this.id,
                i = this.data.datasets[t],
                n = i._meta && i._meta[e];
            n && (n.controller.destroy(), delete i._meta[e])
        },
        destroy: function() {
            var t, e, i = this,
                n = i.canvas;
            for (i.stop(), t = 0, e = i.data.datasets.length; t < e; ++t) i.destroyDatasetMeta(t);
            n && (i.unbindEvents(), ut.canvas.clear(i), Ve.releaseContext(i.ctx), i.canvas = null, i.ctx = null), Ee.notify(i, "destroy"), delete ni.instances[i.id]
        },
        toBase64Image: function() {
            return this.canvas.toDataURL.apply(this.canvas, arguments)
        },
        initToolTip: function() {
            var t = this;
            t.tooltip = new Je({
                _chart: t,
                _chartInstance: t,
                _data: t.data,
                _options: t.options.tooltips
            }, t)
        },
        bindEvents: function() {
            var t = this,
                e = t._listeners = {},
                i = function() {
                    t.eventHandler.apply(t, arguments)
                };
            ut.each(t.options.events, function(n) {
                Ve.addEventListener(t, n, i), e[n] = i
            }), t.options.responsive && (i = function() {
                t.resize()
            }, Ve.addEventListener(t, "resize", i), e.resize = i)
        },
        unbindEvents: function() {
            var t = this,
                e = t._listeners;
            e && (delete t._listeners, ut.each(e, function(e, i) {
                Ve.removeEventListener(t, i, e)
            }))
        },
        updateHoverStyle: function(t, e, i) {
            var n, a, o, r = i ? "setHoverStyle" : "removeHoverStyle";
            for (a = 0, o = t.length; a < o; ++a)(n = t[a]) && this.getDatasetMeta(n._datasetIndex).controller[r](n)
        },
        eventHandler: function(t) {
            var e = this,
                i = e.tooltip;
            if (!1 !== Ee.notify(e, "beforeEvent", [t])) {
                e._bufferedRender = !0, e._bufferedRequest = null;
                var n = e.handleEvent(t);
                i && (n = i._start ? i.handleEvent(t) : n | i.handleEvent(t)), Ee.notify(e, "afterEvent", [t]);
                var a = e._bufferedRequest;
                return a ? e.render(a) : n && !e.animating && (e.stop(), e.render({
                    duration: e.options.hover.animationDuration,
                    lazy: !0
                })), e._bufferedRender = !1, e._bufferedRequest = null, e
            }
        },
        handleEvent: function(t) {
            var e, i = this,
                n = i.options || {},
                a = n.hover;
            return i.lastActive = i.lastActive || [], "mouseout" === t.type ? i.active = [] : i.active = i.getElementsAtEventForMode(t, a.mode, a), ut.callback(n.onHover || n.hover.onHover, [t.native, i.active], i), "mouseup" !== t.type && "click" !== t.type || n.onClick && n.onClick.call(i, t.native, i.active), i.lastActive.length && i.updateHoverStyle(i.lastActive, a.mode, !1), i.active.length && a.mode && i.updateHoverStyle(i.active, a.mode, !0), e = !ut.arrayEquals(i.active, i.lastActive), i.lastActive = i.active, e
        }
    }), ni.instances = {};
    var ai = ni;
    ni.Controller = ni, ni.types = {}, ut.configMerge = ei, ut.scaleMerge = ti;

    function oi() {
        throw new Error("This method is not implemented: either no adapter can be found or an incomplete integration was provided.")
    }

    function ri(t) {
        this.options = t || {}
    }
    ut.extend(ri.prototype, {
        formats: oi,
        parse: oi,
        format: oi,
        add: oi,
        diff: oi,
        startOf: oi,
        endOf: oi,
        _create: function(t) {
            return t
        }
    }), ri.override = function(t) {
        ut.extend(ri.prototype, t)
    };
    var si = {
            _date: ri
        },
        li = {
            formatters: {
                values: function(t) {
                    return ut.isArray(t) ? t : "" + t
                },
                linear: function(t, e, i) {
                    var n = i.length > 3 ? i[2] - i[1] : i[1] - i[0];
                    Math.abs(n) > 1 && t !== Math.floor(t) && (n = t - Math.floor(t));
                    var a = ut.log10(Math.abs(n)),
                        o = "";
                    if (0 !== t)
                        if (Math.max(Math.abs(i[0]), Math.abs(i[i.length - 1])) < 1e-4) {
                            var r = ut.log10(Math.abs(t));
                            o = t.toExponential(Math.floor(r) - Math.floor(a))
                        } else {
                            var s = -1 * Math.floor(a);
                            s = Math.max(Math.min(s, 20), 0), o = t.toFixed(s)
                        }
                    else o = "0";
                    return o
                },
                logarithmic: function(t, e, i) {
                    var n = t / Math.pow(10, Math.floor(ut.log10(t)));
                    return 0 === t ? "0" : 1 === n || 2 === n || 5 === n || 0 === e || e === i.length - 1 ? t.toExponential() : ""
                }
            }
        },
        di = ut.valueOrDefault,
        ui = ut.valueAtIndexOrDefault;

    function hi(t) {
        var e, i, n = [];
        for (e = 0, i = t.length; e < i; ++e) n.push(t[e].label);
        return n
    }

    function ci(t, e, i) {
        return ut.isArray(e) ? ut.longestText(t, i, e) : t.measureText(e).width
    }
    st._set("scale", {
        display: !0,
        position: "left",
        offset: !1,
        gridLines: {
            display: !0,
            color: "rgba(0, 0, 0, 0.1)",
            lineWidth: 1,
            drawBorder: !0,
            drawOnChartArea: !0,
            drawTicks: !0,
            tickMarkLength: 10,
            zeroLineWidth: 1,
            zeroLineColor: "rgba(0,0,0,0.25)",
            zeroLineBorderDash: [],
            zeroLineBorderDashOffset: 0,
            offsetGridLines: !1,
            borderDash: [],
            borderDashOffset: 0
        },
        scaleLabel: {
            display: !1,
            labelString: "",
            padding: {
                top: 4,
                bottom: 4
            }
        },
        ticks: {
            beginAtZero: !1,
            minRotation: 0,
            maxRotation: 50,
            mirror: !1,
            padding: 0,
            reverse: !1,
            display: !0,
            autoSkip: !0,
            autoSkipPadding: 0,
            labelOffset: 0,
            callback: li.formatters.values,
            minor: {},
            major: {}
        }
    });
    var fi = pt.extend({
            getPadding: function() {
                return {
                    left: this.paddingLeft || 0,
                    top: this.paddingTop || 0,
                    right: this.paddingRight || 0,
                    bottom: this.paddingBottom || 0
                }
            },
            getTicks: function() {
                return this._ticks
            },
            mergeTicksOptions: function() {
                var t = this.options.ticks;
                for (var e in !1 === t.minor && (t.minor = {
                        display: !1
                    }), !1 === t.major && (t.major = {
                        display: !1
                    }), t) "major" !== e && "minor" !== e && (void 0 === t.minor[e] && (t.minor[e] = t[e]), void 0 === t.major[e] && (t.major[e] = t[e]))
            },
            beforeUpdate: function() {
                ut.callback(this.options.beforeUpdate, [this])
            },
            update: function(t, e, i) {
                var n, a, o, r, s, l, d = this;
                for (d.beforeUpdate(), d.maxWidth = t, d.maxHeight = e, d.margins = ut.extend({
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0
                    }, i), d._maxLabelLines = 0, d.longestLabelWidth = 0, d.longestTextCache = d.longestTextCache || {}, d.beforeSetDimensions(), d.setDimensions(), d.afterSetDimensions(), d.beforeDataLimits(), d.determineDataLimits(), d.afterDataLimits(), d.beforeBuildTicks(), s = d.buildTicks() || [], s = d.afterBuildTicks(s) || s, d.beforeTickToLabelConversion(), o = d.convertTicksToLabels(s) || d.ticks, d.afterTickToLabelConversion(), d.ticks = o, n = 0, a = o.length; n < a; ++n) r = o[n], (l = s[n]) ? l.label = r : s.push(l = {
                    label: r,
                    major: !1
                });
                return d._ticks = s, d.beforeCalculateTickRotation(), d.calculateTickRotation(), d.afterCalculateTickRotation(), d.beforeFit(), d.fit(), d.afterFit(), d.afterUpdate(), d.minSize
            },
            afterUpdate: function() {
                ut.callback(this.options.afterUpdate, [this])
            },
            beforeSetDimensions: function() {
                ut.callback(this.options.beforeSetDimensions, [this])
            },
            setDimensions: function() {
                var t = this;
                t.isHorizontal() ? (t.width = t.maxWidth, t.left = 0, t.right = t.width) : (t.height = t.maxHeight, t.top = 0, t.bottom = t.height), t.paddingLeft = 0, t.paddingTop = 0, t.paddingRight = 0, t.paddingBottom = 0
            },
            afterSetDimensions: function() {
                ut.callback(this.options.afterSetDimensions, [this])
            },
            beforeDataLimits: function() {
                ut.callback(this.options.beforeDataLimits, [this])
            },
            determineDataLimits: ut.noop,
            afterDataLimits: function() {
                ut.callback(this.options.afterDataLimits, [this])
            },
            beforeBuildTicks: function() {
                ut.callback(this.options.beforeBuildTicks, [this])
            },
            buildTicks: ut.noop,
            afterBuildTicks: function(t) {
                var e = this;
                return ut.isArray(t) && t.length ? ut.callback(e.options.afterBuildTicks, [e, t]) : (e.ticks = ut.callback(e.options.afterBuildTicks, [e, e.ticks]) || e.ticks, t)
            },
            beforeTickToLabelConversion: function() {
                ut.callback(this.options.beforeTickToLabelConversion, [this])
            },
            convertTicksToLabels: function() {
                var t = this.options.ticks;
                this.ticks = this.ticks.map(t.userCallback || t.callback, this)
            },
            afterTickToLabelConversion: function() {
                ut.callback(this.options.afterTickToLabelConversion, [this])
            },
            beforeCalculateTickRotation: function() {
                ut.callback(this.options.beforeCalculateTickRotation, [this])
            },
            calculateTickRotation: function() {
                var t = this,
                    e = t.ctx,
                    i = t.options.ticks,
                    n = hi(t._ticks),
                    a = ut.options._parseFont(i);
                e.font = a.string;
                var o = i.minRotation || 0;
                if (n.length && t.options.display && t.isHorizontal())
                    for (var r, s = ut.longestText(e, a.string, n, t.longestTextCache), l = s, d = t.getPixelForTick(1) - t.getPixelForTick(0) - 6; l > d && o < i.maxRotation;) {
                        var u = ut.toRadians(o);
                        if (r = Math.cos(u), Math.sin(u) * s > t.maxHeight) {
                            o--;
                            break
                        }
                        o++, l = r * s
                    }
                t.labelRotation = o
            },
            afterCalculateTickRotation: function() {
                ut.callback(this.options.afterCalculateTickRotation, [this])
            },
            beforeFit: function() {
                ut.callback(this.options.beforeFit, [this])
            },
            fit: function() {
                var t = this,
                    e = t.minSize = {
                        width: 0,
                        height: 0
                    },
                    i = hi(t._ticks),
                    n = t.options,
                    a = n.ticks,
                    o = n.scaleLabel,
                    r = n.gridLines,
                    s = t._isVisible(),
                    l = n.position,
                    d = t.isHorizontal(),
                    u = ut.options._parseFont,
                    h = u(a),
                    c = n.gridLines.tickMarkLength;
                if (e.width = d ? t.isFullWidth() ? t.maxWidth - t.margins.left - t.margins.right : t.maxWidth : s && r.drawTicks ? c : 0, e.height = d ? s && r.drawTicks ? c : 0 : t.maxHeight, o.display && s) {
                    var f = u(o),
                        g = ut.options.toPadding(o.padding),
                        p = f.lineHeight + g.height;
                    d ? e.height += p : e.width += p
                }
                if (a.display && s) {
                    var m = ut.longestText(t.ctx, h.string, i, t.longestTextCache),
                        v = ut.numberOfLabelLines(i),
                        b = .5 * h.size,
                        x = t.options.ticks.padding;
                    if (t._maxLabelLines = v, t.longestLabelWidth = m, d) {
                        var y = ut.toRadians(t.labelRotation),
                            k = Math.cos(y),
                            w = Math.sin(y) * m + h.lineHeight * v + b;
                        e.height = Math.min(t.maxHeight, e.height + w + x), t.ctx.font = h.string;
                        var M, _, C = ci(t.ctx, i[0], h.string),
                            S = ci(t.ctx, i[i.length - 1], h.string),
                            P = t.getPixelForTick(0) - t.left,
                            I = t.right - t.getPixelForTick(i.length - 1);
                        0 !== t.labelRotation ? (M = "bottom" === l ? k * C : k * b, _ = "bottom" === l ? k * b : k * S) : (M = C / 2, _ = S / 2), t.paddingLeft = Math.max(M - P, 0) + 3, t.paddingRight = Math.max(_ - I, 0) + 3
                    } else a.mirror ? m = 0 : m += x + b, e.width = Math.min(t.maxWidth, e.width + m), t.paddingTop = h.size / 2, t.paddingBottom = h.size / 2
                }
                t.handleMargins(), t.width = e.width, t.height = e.height
            },
            handleMargins: function() {
                var t = this;
                t.margins && (t.paddingLeft = Math.max(t.paddingLeft - t.margins.left, 0), t.paddingTop = Math.max(t.paddingTop - t.margins.top, 0), t.paddingRight = Math.max(t.paddingRight - t.margins.right, 0), t.paddingBottom = Math.max(t.paddingBottom - t.margins.bottom, 0))
            },
            afterFit: function() {
                ut.callback(this.options.afterFit, [this])
            },
            isHorizontal: function() {
                return "top" === this.options.position || "bottom" === this.options.position
            },
            isFullWidth: function() {
                return this.options.fullWidth
            },
            getRightValue: function(t) {
                if (ut.isNullOrUndef(t)) return NaN;
                if (("number" == typeof t || t instanceof Number) && !isFinite(t)) return NaN;
                if (t)
                    if (this.isHorizontal()) {
                        if (void 0 !== t.x) return this.getRightValue(t.x)
                    } else if (void 0 !== t.y) return this.getRightValue(t.y);
                return t
            },
            getLabelForIndex: ut.noop,
            getPixelForValue: ut.noop,
            getValueForPixel: ut.noop,
            getPixelForTick: function(t) {
                var e = this,
                    i = e.options.offset;
                if (e.isHorizontal()) {
                    var n = (e.width - (e.paddingLeft + e.paddingRight)) / Math.max(e._ticks.length - (i ? 0 : 1), 1),
                        a = n * t + e.paddingLeft;
                    i && (a += n / 2);
                    var o = e.left + a;
                    return o += e.isFullWidth() ? e.margins.left : 0
                }
                var r = e.height - (e.paddingTop + e.paddingBottom);
                return e.top + t * (r / (e._ticks.length - 1))
            },
            getPixelForDecimal: function(t) {
                var e = this;
                if (e.isHorizontal()) {
                    var i = (e.width - (e.paddingLeft + e.paddingRight)) * t + e.paddingLeft,
                        n = e.left + i;
                    return n += e.isFullWidth() ? e.margins.left : 0
                }
                return e.top + t * e.height
            },
            getBasePixel: function() {
                return this.getPixelForValue(this.getBaseValue())
            },
            getBaseValue: function() {
                var t = this.min,
                    e = this.max;
                return this.beginAtZero ? 0 : t < 0 && e < 0 ? e : t > 0 && e > 0 ? t : 0
            },
            _autoSkip: function(t) {
                var e, i, n = this,
                    a = n.isHorizontal(),
                    o = n.options.ticks.minor,
                    r = t.length,
                    s = !1,
                    l = o.maxTicksLimit,
                    d = n._tickSize() * (r - 1),
                    u = a ? n.width - (n.paddingLeft + n.paddingRight) : n.height - (n.paddingTop + n.PaddingBottom),
                    h = [];
                for (d > u && (s = 1 + Math.floor(d / u)), r > l && (s = Math.max(s, 1 + Math.floor(r / l))), e = 0; e < r; e++) i = t[e], s > 1 && e % s > 0 && delete i.label, h.push(i);
                return h
            },
            _tickSize: function() {
                var t = this,
                    e = t.isHorizontal(),
                    i = t.options.ticks.minor,
                    n = ut.toRadians(t.labelRotation),
                    a = Math.abs(Math.cos(n)),
                    o = Math.abs(Math.sin(n)),
                    r = i.autoSkipPadding || 0,
                    s = t.longestLabelWidth + r || 0,
                    l = ut.options._parseFont(i),
                    d = t._maxLabelLines * l.lineHeight + r || 0;
                return e ? d * a > s * o ? s / a : d / o : d * o < s * a ? d / a : s / o
            },
            _isVisible: function() {
                var t, e, i, n = this.chart,
                    a = this.options.display;
                if ("auto" !== a) return !!a;
                for (t = 0, e = n.data.datasets.length; t < e; ++t)
                    if (n.isDatasetVisible(t) && ((i = n.getDatasetMeta(t)).xAxisID === this.id || i.yAxisID === this.id)) return !0;
                return !1
            },
            draw: function(t) {
                var e = this,
                    i = e.options;
                if (e._isVisible()) {
                    var n, a, o, r = e.chart,
                        s = e.ctx,
                        l = st.global.defaultFontColor,
                        d = i.ticks.minor,
                        u = i.ticks.major || d,
                        h = i.gridLines,
                        c = i.scaleLabel,
                        f = i.position,
                        g = 0 !== e.labelRotation,
                        p = d.mirror,
                        m = e.isHorizontal(),
                        v = ut.options._parseFont,
                        b = d.display && d.autoSkip ? e._autoSkip(e.getTicks()) : e.getTicks(),
                        x = di(d.fontColor, l),
                        y = v(d),
                        k = y.lineHeight,
                        w = di(u.fontColor, l),
                        M = v(u),
                        _ = d.padding,
                        C = d.labelOffset,
                        S = h.drawTicks ? h.tickMarkLength : 0,
                        P = di(c.fontColor, l),
                        I = v(c),
                        A = ut.options.toPadding(c.padding),
                        D = ut.toRadians(e.labelRotation),
                        T = [],
                        F = h.drawBorder ? ui(h.lineWidth, 0, 0) : 0,
                        L = ut._alignPixel;
                    "top" === f ? (n = L(r, e.bottom, F), a = e.bottom - S, o = n - F / 2) : "bottom" === f ? (n = L(r, e.top, F), a = n + F / 2, o = e.top + S) : "left" === f ? (n = L(r, e.right, F), a = e.right - S, o = n - F / 2) : (n = L(r, e.left, F), a = n + F / 2, o = e.left + S);
                    if (ut.each(b, function(n, s) {
                            if (!ut.isNullOrUndef(n.label)) {
                                var l, d, u, c, v, b, x, y, w, M, P, I, A, R, O, z, B = n.label;
                                s === e.zeroLineIndex && i.offset === h.offsetGridLines ? (l = h.zeroLineWidth, d = h.zeroLineColor, u = h.zeroLineBorderDash || [], c = h.zeroLineBorderDashOffset || 0) : (l = ui(h.lineWidth, s), d = ui(h.color, s), u = h.borderDash || [], c = h.borderDashOffset || 0);
                                var N = ut.isArray(B) ? B.length : 1,
                                    W = function(t, e, i) {
                                        var n = t.getPixelForTick(e);
                                        return i && (1 === t.getTicks().length ? n -= t.isHorizontal() ? Math.max(n - t.left, t.right - n) : Math.max(n - t.top, t.bottom - n) : n -= 0 === e ? (t.getPixelForTick(1) - n) / 2 : (n - t.getPixelForTick(e - 1)) / 2), n
                                    }(e, s, h.offsetGridLines);
                                if (m) {
                                    var V = S + _;
                                    W < e.left - 1e-7 && (d = "rgba(0,0,0,0)"), v = x = w = P = L(r, W, l), b = a, y = o, A = e.getPixelForTick(s) + C, "top" === f ? (M = L(r, t.top, F) + F / 2, I = t.bottom, O = ((g ? 1 : .5) - N) * k, z = g ? "left" : "center", R = e.bottom - V) : (M = t.top, I = L(r, t.bottom, F) - F / 2, O = (g ? 0 : .5) * k, z = g ? "right" : "center", R = e.top + V)
                                } else {
                                    var E = (p ? 0 : S) + _;
                                    W < e.top - 1e-7 && (d = "rgba(0,0,0,0)"), v = a, x = o, b = y = M = I = L(r, W, l), R = e.getPixelForTick(s) + C, O = (1 - N) * k / 2, "left" === f ? (w = L(r, t.left, F) + F / 2, P = t.right, z = p ? "left" : "right", A = e.right - E) : (w = t.left, P = L(r, t.right, F) - F / 2, z = p ? "right" : "left", A = e.left + E)
                                }
                                T.push({
                                    tx1: v,
                                    ty1: b,
                                    tx2: x,
                                    ty2: y,
                                    x1: w,
                                    y1: M,
                                    x2: P,
                                    y2: I,
                                    labelX: A,
                                    labelY: R,
                                    glWidth: l,
                                    glColor: d,
                                    glBorderDash: u,
                                    glBorderDashOffset: c,
                                    rotation: -1 * D,
                                    label: B,
                                    major: n.major,
                                    textOffset: O,
                                    textAlign: z
                                })
                            }
                        }), ut.each(T, function(t) {
                            var e = t.glWidth,
                                i = t.glColor;
                            if (h.display && e && i && (s.save(), s.lineWidth = e, s.strokeStyle = i, s.setLineDash && (s.setLineDash(t.glBorderDash), s.lineDashOffset = t.glBorderDashOffset), s.beginPath(), h.drawTicks && (s.moveTo(t.tx1, t.ty1), s.lineTo(t.tx2, t.ty2)), h.drawOnChartArea && (s.moveTo(t.x1, t.y1), s.lineTo(t.x2, t.y2)), s.stroke(), s.restore()), d.display) {
                                s.save(), s.translate(t.labelX, t.labelY), s.rotate(t.rotation), s.font = t.major ? M.string : y.string, s.fillStyle = t.major ? w : x, s.textBaseline = "middle", s.textAlign = t.textAlign;
                                var n = t.label,
                                    a = t.textOffset;
                                if (ut.isArray(n))
                                    for (var o = 0; o < n.length; ++o) s.fillText("" + n[o], 0, a), a += k;
                                else s.fillText(n, 0, a);
                                s.restore()
                            }
                        }), c.display) {
                        var R, O, z = 0,
                            B = I.lineHeight / 2;
                        if (m) R = e.left + (e.right - e.left) / 2, O = "bottom" === f ? e.bottom - B - A.bottom : e.top + B + A.top;
                        else {
                            var N = "left" === f;
                            R = N ? e.left + B + A.top : e.right - B - A.top, O = e.top + (e.bottom - e.top) / 2, z = N ? -.5 * Math.PI : .5 * Math.PI
                        }
                        s.save(), s.translate(R, O), s.rotate(z), s.textAlign = "center", s.textBaseline = "middle", s.fillStyle = P, s.font = I.string, s.fillText(c.labelString, 0, 0), s.restore()
                    }
                    if (F) {
                        var W, V, E, H, j = F,
                            q = ui(h.lineWidth, b.length - 1, 0);
                        m ? (W = L(r, e.left, j) - j / 2, V = L(r, e.right, q) + q / 2, E = H = n) : (E = L(r, e.top, j) - j / 2, H = L(r, e.bottom, q) + q / 2, W = V = n), s.lineWidth = F, s.strokeStyle = ui(h.color, 0), s.beginPath(), s.moveTo(W, E), s.lineTo(V, H), s.stroke()
                    }
                }
            }
        }),
        gi = fi.extend({
            getLabels: function() {
                var t = this.chart.data;
                return this.options.labels || (this.isHorizontal() ? t.xLabels : t.yLabels) || t.labels
            },
            determineDataLimits: function() {
                var t, e = this,
                    i = e.getLabels();
                e.minIndex = 0, e.maxIndex = i.length - 1, void 0 !== e.options.ticks.min && (t = i.indexOf(e.options.ticks.min), e.minIndex = -1 !== t ? t : e.minIndex), void 0 !== e.options.ticks.max && (t = i.indexOf(e.options.ticks.max), e.maxIndex = -1 !== t ? t : e.maxIndex), e.min = i[e.minIndex], e.max = i[e.maxIndex]
            },
            buildTicks: function() {
                var t = this,
                    e = t.getLabels();
                t.ticks = 0 === t.minIndex && t.maxIndex === e.length - 1 ? e : e.slice(t.minIndex, t.maxIndex + 1)
            },
            getLabelForIndex: function(t, e) {
                var i = this,
                    n = i.chart;
                return n.getDatasetMeta(e).controller._getValueScaleId() === i.id ? i.getRightValue(n.data.datasets[e].data[t]) : i.ticks[t - i.minIndex]
            },
            getPixelForValue: function(t, e) {
                var i, n = this,
                    a = n.options.offset,
                    o = Math.max(n.maxIndex + 1 - n.minIndex - (a ? 0 : 1), 1);
                if (null != t && (i = n.isHorizontal() ? t.x : t.y), void 0 !== i || void 0 !== t && isNaN(e)) {
                    t = i || t;
                    var r = n.getLabels().indexOf(t);
                    e = -1 !== r ? r : e
                }
                if (n.isHorizontal()) {
                    var s = n.width / o,
                        l = s * (e - n.minIndex);
                    return a && (l += s / 2), n.left + l
                }
                var d = n.height / o,
                    u = d * (e - n.minIndex);
                return a && (u += d / 2), n.top + u
            },
            getPixelForTick: function(t) {
                return this.getPixelForValue(this.ticks[t], t + this.minIndex, null)
            },
            getValueForPixel: function(t) {
                var e = this,
                    i = e.options.offset,
                    n = Math.max(e._ticks.length - (i ? 0 : 1), 1),
                    a = e.isHorizontal(),
                    o = (a ? e.width : e.height) / n;
                return t -= a ? e.left : e.top, i && (t -= o / 2), (t <= 0 ? 0 : Math.round(t / o)) + e.minIndex
            },
            getBasePixel: function() {
                return this.bottom
            }
        }),
        pi = {
            position: "bottom"
        };
    gi._defaults = pi;
    var mi = ut.noop,
        vi = ut.isNullOrUndef;
    var bi = fi.extend({
            getRightValue: function(t) {
                return "string" == typeof t ? +t : fi.prototype.getRightValue.call(this, t)
            },
            handleTickRangeOptions: function() {
                var t = this,
                    e = t.options.ticks;
                if (e.beginAtZero) {
                    var i = ut.sign(t.min),
                        n = ut.sign(t.max);
                    i < 0 && n < 0 ? t.max = 0 : i > 0 && n > 0 && (t.min = 0)
                }
                var a = void 0 !== e.min || void 0 !== e.suggestedMin,
                    o = void 0 !== e.max || void 0 !== e.suggestedMax;
                void 0 !== e.min ? t.min = e.min : void 0 !== e.suggestedMin && (null === t.min ? t.min = e.suggestedMin : t.min = Math.min(t.min, e.suggestedMin)), void 0 !== e.max ? t.max = e.max : void 0 !== e.suggestedMax && (null === t.max ? t.max = e.suggestedMax : t.max = Math.max(t.max, e.suggestedMax)), a !== o && t.min >= t.max && (a ? t.max = t.min + 1 : t.min = t.max - 1), t.min === t.max && (t.max++, e.beginAtZero || t.min--)
            },
            getTickLimit: function() {
                var t, e = this.options.ticks,
                    i = e.stepSize,
                    n = e.maxTicksLimit;
                return i ? t = Math.ceil(this.max / i) - Math.floor(this.min / i) + 1 : (t = this._computeTickLimit(), n = n || 11), n && (t = Math.min(n, t)), t
            },
            _computeTickLimit: function() {
                return Number.POSITIVE_INFINITY
            },
            handleDirectionalChanges: mi,
            buildTicks: function() {
                var t = this,
                    e = t.options.ticks,
                    i = t.getTickLimit(),
                    n = {
                        maxTicks: i = Math.max(2, i),
                        min: e.min,
                        max: e.max,
                        precision: e.precision,
                        stepSize: ut.valueOrDefault(e.fixedStepSize, e.stepSize)
                    },
                    a = t.ticks = function(t, e) {
                        var i, n, a, o, r = [],
                            s = t.stepSize,
                            l = s || 1,
                            d = t.maxTicks - 1,
                            u = t.min,
                            h = t.max,
                            c = t.precision,
                            f = e.min,
                            g = e.max,
                            p = ut.niceNum((g - f) / d / l) * l;
                        if (p < 1e-14 && vi(u) && vi(h)) return [f, g];
                        (o = Math.ceil(g / p) - Math.floor(f / p)) > d && (p = ut.niceNum(o * p / d / l) * l), s || vi(c) ? i = Math.pow(10, ut._decimalPlaces(p)) : (i = Math.pow(10, c), p = Math.ceil(p * i) / i), n = Math.floor(f / p) * p, a = Math.ceil(g / p) * p, s && (!vi(u) && ut.almostWhole(u / p, p / 1e3) && (n = u), !vi(h) && ut.almostWhole(h / p, p / 1e3) && (a = h)), o = (a - n) / p, o = ut.almostEquals(o, Math.round(o), p / 1e3) ? Math.round(o) : Math.ceil(o), n = Math.round(n * i) / i, a = Math.round(a * i) / i, r.push(vi(u) ? n : u);
                        for (var m = 1; m < o; ++m) r.push(Math.round((n + m * p) * i) / i);
                        return r.push(vi(h) ? a : h), r
                    }(n, t);
                t.handleDirectionalChanges(), t.max = ut.max(a), t.min = ut.min(a), e.reverse ? (a.reverse(), t.start = t.max, t.end = t.min) : (t.start = t.min, t.end = t.max)
            },
            convertTicksToLabels: function() {
                var t = this;
                t.ticksAsNumbers = t.ticks.slice(), t.zeroLineIndex = t.ticks.indexOf(0), fi.prototype.convertTicksToLabels.call(t)
            }
        }),
        xi = {
            position: "left",
            ticks: {
                callback: li.formatters.linear
            }
        },
        yi = bi.extend({
            determineDataLimits: function() {
                var t = this,
                    e = t.options,
                    i = t.chart,
                    n = i.data.datasets,
                    a = t.isHorizontal();

                function o(e) {
                    return a ? e.xAxisID === t.id : e.yAxisID === t.id
                }
                t.min = null, t.max = null;
                var r = e.stacked;
                if (void 0 === r && ut.each(n, function(t, e) {
                        if (!r) {
                            var n = i.getDatasetMeta(e);
                            i.isDatasetVisible(e) && o(n) && void 0 !== n.stack && (r = !0)
                        }
                    }), e.stacked || r) {
                    var s = {};
                    ut.each(n, function(n, a) {
                        var r = i.getDatasetMeta(a),
                            l = [r.type, void 0 === e.stacked && void 0 === r.stack ? a : "", r.stack].join(".");
                        void 0 === s[l] && (s[l] = {
                            positiveValues: [],
                            negativeValues: []
                        });
                        var d = s[l].positiveValues,
                            u = s[l].negativeValues;
                        i.isDatasetVisible(a) && o(r) && ut.each(n.data, function(i, n) {
                            var a = +t.getRightValue(i);
                            isNaN(a) || r.data[n].hidden || (d[n] = d[n] || 0, u[n] = u[n] || 0, e.relativePoints ? d[n] = 100 : a < 0 ? u[n] += a : d[n] += a)
                        })
                    }), ut.each(s, function(e) {
                        var i = e.positiveValues.concat(e.negativeValues),
                            n = ut.min(i),
                            a = ut.max(i);
                        t.min = null === t.min ? n : Math.min(t.min, n), t.max = null === t.max ? a : Math.max(t.max, a)
                    })
                } else ut.each(n, function(e, n) {
                    var a = i.getDatasetMeta(n);
                    i.isDatasetVisible(n) && o(a) && ut.each(e.data, function(e, i) {
                        var n = +t.getRightValue(e);
                        isNaN(n) || a.data[i].hidden || (null === t.min ? t.min = n : n < t.min && (t.min = n), null === t.max ? t.max = n : n > t.max && (t.max = n))
                    })
                });
                t.min = isFinite(t.min) && !isNaN(t.min) ? t.min : 0, t.max = isFinite(t.max) && !isNaN(t.max) ? t.max : 1, this.handleTickRangeOptions()
            },
            _computeTickLimit: function() {
                var t;
                return this.isHorizontal() ? Math.ceil(this.width / 40) : (t = ut.options._parseFont(this.options.ticks), Math.ceil(this.height / t.lineHeight))
            },
            handleDirectionalChanges: function() {
                this.isHorizontal() || this.ticks.reverse()
            },
            getLabelForIndex: function(t, e) {
                return +this.getRightValue(this.chart.data.datasets[e].data[t])
            },
            getPixelForValue: function(t) {
                var e = this,
                    i = e.start,
                    n = +e.getRightValue(t),
                    a = e.end - i;
                return e.isHorizontal() ? e.left + e.width / a * (n - i) : e.bottom - e.height / a * (n - i)
            },
            getValueForPixel: function(t) {
                var e = this,
                    i = e.isHorizontal(),
                    n = i ? e.width : e.height,
                    a = (i ? t - e.left : e.bottom - t) / n;
                return e.start + (e.end - e.start) * a
            },
            getPixelForTick: function(t) {
                return this.getPixelForValue(this.ticksAsNumbers[t])
            }
        }),
        ki = xi;
    yi._defaults = ki;
    var wi = ut.valueOrDefault;
    var Mi = {
        position: "left",
        ticks: {
            callback: li.formatters.logarithmic
        }
    };

    function _i(t, e) {
        return ut.isFinite(t) && t >= 0 ? t : e
    }
    var Ci = fi.extend({
            determineDataLimits: function() {
                var t = this,
                    e = t.options,
                    i = t.chart,
                    n = i.data.datasets,
                    a = t.isHorizontal();

                function o(e) {
                    return a ? e.xAxisID === t.id : e.yAxisID === t.id
                }
                t.min = null, t.max = null, t.minNotZero = null;
                var r = e.stacked;
                if (void 0 === r && ut.each(n, function(t, e) {
                        if (!r) {
                            var n = i.getDatasetMeta(e);
                            i.isDatasetVisible(e) && o(n) && void 0 !== n.stack && (r = !0)
                        }
                    }), e.stacked || r) {
                    var s = {};
                    ut.each(n, function(n, a) {
                        var r = i.getDatasetMeta(a),
                            l = [r.type, void 0 === e.stacked && void 0 === r.stack ? a : "", r.stack].join(".");
                        i.isDatasetVisible(a) && o(r) && (void 0 === s[l] && (s[l] = []), ut.each(n.data, function(e, i) {
                            var n = s[l],
                                a = +t.getRightValue(e);
                            isNaN(a) || r.data[i].hidden || a < 0 || (n[i] = n[i] || 0, n[i] += a)
                        }))
                    }), ut.each(s, function(e) {
                        if (e.length > 0) {
                            var i = ut.min(e),
                                n = ut.max(e);
                            t.min = null === t.min ? i : Math.min(t.min, i), t.max = null === t.max ? n : Math.max(t.max, n)
                        }
                    })
                } else ut.each(n, function(e, n) {
                    var a = i.getDatasetMeta(n);
                    i.isDatasetVisible(n) && o(a) && ut.each(e.data, function(e, i) {
                        var n = +t.getRightValue(e);
                        isNaN(n) || a.data[i].hidden || n < 0 || (null === t.min ? t.min = n : n < t.min && (t.min = n), null === t.max ? t.max = n : n > t.max && (t.max = n), 0 !== n && (null === t.minNotZero || n < t.minNotZero) && (t.minNotZero = n))
                    })
                });
                this.handleTickRangeOptions()
            },
            handleTickRangeOptions: function() {
                var t = this,
                    e = t.options.ticks;
                t.min = _i(e.min, t.min), t.max = _i(e.max, t.max), t.min === t.max && (0 !== t.min && null !== t.min ? (t.min = Math.pow(10, Math.floor(ut.log10(t.min)) - 1), t.max = Math.pow(10, Math.floor(ut.log10(t.max)) + 1)) : (t.min = 1, t.max = 10)), null === t.min && (t.min = Math.pow(10, Math.floor(ut.log10(t.max)) - 1)), null === t.max && (t.max = 0 !== t.min ? Math.pow(10, Math.floor(ut.log10(t.min)) + 1) : 10), null === t.minNotZero && (t.min > 0 ? t.minNotZero = t.min : t.max < 1 ? t.minNotZero = Math.pow(10, Math.floor(ut.log10(t.max))) : t.minNotZero = 1)
            },
            buildTicks: function() {
                var t = this,
                    e = t.options.ticks,
                    i = !t.isHorizontal(),
                    n = {
                        min: _i(e.min),
                        max: _i(e.max)
                    },
                    a = t.ticks = function(t, e) {
                        var i, n, a = [],
                            o = wi(t.min, Math.pow(10, Math.floor(ut.log10(e.min)))),
                            r = Math.floor(ut.log10(e.max)),
                            s = Math.ceil(e.max / Math.pow(10, r));
                        0 === o ? (i = Math.floor(ut.log10(e.minNotZero)), n = Math.floor(e.minNotZero / Math.pow(10, i)), a.push(o), o = n * Math.pow(10, i)) : (i = Math.floor(ut.log10(o)), n = Math.floor(o / Math.pow(10, i)));
                        var l = i < 0 ? Math.pow(10, Math.abs(i)) : 1;
                        do {
                            a.push(o), 10 == ++n && (n = 1, l = ++i >= 0 ? 1 : l), o = Math.round(n * Math.pow(10, i) * l) / l
                        } while (i < r || i === r && n < s);
                        var d = wi(t.max, o);
                        return a.push(d), a
                    }(n, t);
                t.max = ut.max(a), t.min = ut.min(a), e.reverse ? (i = !i, t.start = t.max, t.end = t.min) : (t.start = t.min, t.end = t.max), i && a.reverse()
            },
            convertTicksToLabels: function() {
                this.tickValues = this.ticks.slice(), fi.prototype.convertTicksToLabels.call(this)
            },
            getLabelForIndex: function(t, e) {
                return +this.getRightValue(this.chart.data.datasets[e].data[t])
            },
            getPixelForTick: function(t) {
                return this.getPixelForValue(this.tickValues[t])
            },
            _getFirstTickValue: function(t) {
                var e = Math.floor(ut.log10(t));
                return Math.floor(t / Math.pow(10, e)) * Math.pow(10, e)
            },
            getPixelForValue: function(t) {
                var e, i, n, a, o, r = this,
                    s = r.options.ticks,
                    l = s.reverse,
                    d = ut.log10,
                    u = r._getFirstTickValue(r.minNotZero),
                    h = 0;
                return t = +r.getRightValue(t), l ? (n = r.end, a = r.start, o = -1) : (n = r.start, a = r.end, o = 1), r.isHorizontal() ? (e = r.width, i = l ? r.right : r.left) : (e = r.height, o *= -1, i = l ? r.top : r.bottom), t !== n && (0 === n && (e -= h = wi(s.fontSize, st.global.defaultFontSize), n = u), 0 !== t && (h += e / (d(a) - d(n)) * (d(t) - d(n))), i += o * h), i
            },
            getValueForPixel: function(t) {
                var e, i, n, a, o = this,
                    r = o.options.ticks,
                    s = r.reverse,
                    l = ut.log10,
                    d = o._getFirstTickValue(o.minNotZero);
                if (s ? (i = o.end, n = o.start) : (i = o.start, n = o.end), o.isHorizontal() ? (e = o.width, a = s ? o.right - t : t - o.left) : (e = o.height, a = s ? t - o.top : o.bottom - t), a !== i) {
                    if (0 === i) {
                        var u = wi(r.fontSize, st.global.defaultFontSize);
                        a -= u, e -= u, i = d
                    }
                    a *= l(n) - l(i), a /= e, a = Math.pow(10, l(i) + a)
                }
                return a
            }
        }),
        Si = Mi;
    Ci._defaults = Si;
    var Pi = ut.valueOrDefault,
        Ii = ut.valueAtIndexOrDefault,
        Ai = ut.options.resolve,
        Di = {
            display: !0,
            animate: !0,
            position: "chartArea",
            angleLines: {
                display: !0,
                color: "rgba(0, 0, 0, 0.1)",
                lineWidth: 1,
                borderDash: [],
                borderDashOffset: 0
            },
            gridLines: {
                circular: !1
            },
            ticks: {
                showLabelBackdrop: !0,
                backdropColor: "rgba(255,255,255,0.75)",
                backdropPaddingY: 2,
                backdropPaddingX: 2,
                callback: li.formatters.linear
            },
            pointLabels: {
                display: !0,
                fontSize: 10,
                callback: function(t) {
                    return t
                }
            }
        };

    function Ti(t) {
        var e = t.options;
        return e.angleLines.display || e.pointLabels.display ? t.chart.data.labels.length : 0
    }

    function Fi(t) {
        var e = t.ticks;
        return e.display && t.display ? Pi(e.fontSize, st.global.defaultFontSize) + 2 * e.backdropPaddingY : 0
    }

    function Li(t, e, i, n, a) {
        return t === n || t === a ? {
            start: e - i / 2,
            end: e + i / 2
        } : t < n || t > a ? {
            start: e - i,
            end: e
        } : {
            start: e,
            end: e + i
        }
    }

    function Ri(t) {
        return 0 === t || 180 === t ? "center" : t < 180 ? "left" : "right"
    }

    function Oi(t, e, i, n) {
        var a, o, r = i.y + n / 2;
        if (ut.isArray(e))
            for (a = 0, o = e.length; a < o; ++a) t.fillText(e[a], i.x, r), r += n;
        else t.fillText(e, i.x, r)
    }

    function zi(t, e, i) {
        90 === t || 270 === t ? i.y -= e.h / 2 : (t > 270 || t < 90) && (i.y -= e.h)
    }

    function Bi(t) {
        return ut.isNumber(t) ? t : 0
    }
    var Ni = bi.extend({
            setDimensions: function() {
                var t = this;
                t.width = t.maxWidth, t.height = t.maxHeight, t.paddingTop = Fi(t.options) / 2, t.xCenter = Math.floor(t.width / 2), t.yCenter = Math.floor((t.height - t.paddingTop) / 2), t.drawingArea = Math.min(t.height - t.paddingTop, t.width) / 2
            },
            determineDataLimits: function() {
                var t = this,
                    e = t.chart,
                    i = Number.POSITIVE_INFINITY,
                    n = Number.NEGATIVE_INFINITY;
                ut.each(e.data.datasets, function(a, o) {
                    if (e.isDatasetVisible(o)) {
                        var r = e.getDatasetMeta(o);
                        ut.each(a.data, function(e, a) {
                            var o = +t.getRightValue(e);
                            isNaN(o) || r.data[a].hidden || (i = Math.min(o, i), n = Math.max(o, n))
                        })
                    }
                }), t.min = i === Number.POSITIVE_INFINITY ? 0 : i, t.max = n === Number.NEGATIVE_INFINITY ? 0 : n, t.handleTickRangeOptions()
            },
            _computeTickLimit: function() {
                return Math.ceil(this.drawingArea / Fi(this.options))
            },
            convertTicksToLabels: function() {
                var t = this;
                bi.prototype.convertTicksToLabels.call(t), t.pointLabels = t.chart.data.labels.map(t.options.pointLabels.callback, t)
            },
            getLabelForIndex: function(t, e) {
                return +this.getRightValue(this.chart.data.datasets[e].data[t])
            },
            fit: function() {
                var t = this.options;
                t.display && t.pointLabels.display ? function(t) {
                    var e, i, n, a = ut.options._parseFont(t.options.pointLabels),
                        o = {
                            l: 0,
                            r: t.width,
                            t: 0,
                            b: t.height - t.paddingTop
                        },
                        r = {};
                    t.ctx.font = a.string, t._pointLabelSizes = [];
                    var s, l, d, u = Ti(t);
                    for (e = 0; e < u; e++) {
                        n = t.getPointPosition(e, t.drawingArea + 5), s = t.ctx, l = a.lineHeight, d = t.pointLabels[e] || "", i = ut.isArray(d) ? {
                            w: ut.longestText(s, s.font, d),
                            h: d.length * l
                        } : {
                            w: s.measureText(d).width,
                            h: l
                        }, t._pointLabelSizes[e] = i;
                        var h = t.getIndexAngle(e),
                            c = ut.toDegrees(h) % 360,
                            f = Li(c, n.x, i.w, 0, 180),
                            g = Li(c, n.y, i.h, 90, 270);
                        f.start < o.l && (o.l = f.start, r.l = h), f.end > o.r && (o.r = f.end, r.r = h), g.start < o.t && (o.t = g.start, r.t = h), g.end > o.b && (o.b = g.end, r.b = h)
                    }
                    t.setReductions(t.drawingArea, o, r)
                }(this) : this.setCenterPoint(0, 0, 0, 0)
            },
            setReductions: function(t, e, i) {
                var n = this,
                    a = e.l / Math.sin(i.l),
                    o = Math.max(e.r - n.width, 0) / Math.sin(i.r),
                    r = -e.t / Math.cos(i.t),
                    s = -Math.max(e.b - (n.height - n.paddingTop), 0) / Math.cos(i.b);
                a = Bi(a), o = Bi(o), r = Bi(r), s = Bi(s), n.drawingArea = Math.min(Math.floor(t - (a + o) / 2), Math.floor(t - (r + s) / 2)), n.setCenterPoint(a, o, r, s)
            },
            setCenterPoint: function(t, e, i, n) {
                var a = this,
                    o = a.width - e - a.drawingArea,
                    r = t + a.drawingArea,
                    s = i + a.drawingArea,
                    l = a.height - a.paddingTop - n - a.drawingArea;
                a.xCenter = Math.floor((r + o) / 2 + a.left), a.yCenter = Math.floor((s + l) / 2 + a.top + a.paddingTop)
            },
            getIndexAngle: function(t) {
                return t * (2 * Math.PI / Ti(this)) + (this.chart.options && this.chart.options.startAngle ? this.chart.options.startAngle : 0) * Math.PI * 2 / 360
            },
            getDistanceFromCenterForValue: function(t) {
                var e = this;
                if (null === t) return 0;
                var i = e.drawingArea / (e.max - e.min);
                return e.options.ticks.reverse ? (e.max - t) * i : (t - e.min) * i
            },
            getPointPosition: function(t, e) {
                var i = this.getIndexAngle(t) - Math.PI / 2;
                return {
                    x: Math.cos(i) * e + this.xCenter,
                    y: Math.sin(i) * e + this.yCenter
                }
            },
            getPointPositionForValue: function(t, e) {
                return this.getPointPosition(t, this.getDistanceFromCenterForValue(e))
            },
            getBasePosition: function() {
                var t = this.min,
                    e = this.max;
                return this.getPointPositionForValue(0, this.beginAtZero ? 0 : t < 0 && e < 0 ? e : t > 0 && e > 0 ? t : 0)
            },
            draw: function() {
                var t = this,
                    e = t.options,
                    i = e.gridLines,
                    n = e.ticks;
                if (e.display) {
                    var a = t.ctx,
                        o = this.getIndexAngle(0),
                        r = ut.options._parseFont(n);
                    (e.angleLines.display || e.pointLabels.display) && function(t) {
                        var e = t.ctx,
                            i = t.options,
                            n = i.angleLines,
                            a = i.gridLines,
                            o = i.pointLabels,
                            r = Pi(n.lineWidth, a.lineWidth),
                            s = Pi(n.color, a.color),
                            l = Fi(i);
                        e.save(), e.lineWidth = r, e.strokeStyle = s, e.setLineDash && (e.setLineDash(Ai([n.borderDash, a.borderDash, []])), e.lineDashOffset = Ai([n.borderDashOffset, a.borderDashOffset, 0]));
                        var d = t.getDistanceFromCenterForValue(i.ticks.reverse ? t.min : t.max),
                            u = ut.options._parseFont(o);
                        e.font = u.string, e.textBaseline = "middle";
                        for (var h = Ti(t) - 1; h >= 0; h--) {
                            if (n.display && r && s) {
                                var c = t.getPointPosition(h, d);
                                e.beginPath(), e.moveTo(t.xCenter, t.yCenter), e.lineTo(c.x, c.y), e.stroke()
                            }
                            if (o.display) {
                                var f = 0 === h ? l / 2 : 0,
                                    g = t.getPointPosition(h, d + f + 5),
                                    p = Ii(o.fontColor, h, st.global.defaultFontColor);
                                e.fillStyle = p;
                                var m = t.getIndexAngle(h),
                                    v = ut.toDegrees(m);
                                e.textAlign = Ri(v), zi(v, t._pointLabelSizes[h], g), Oi(e, t.pointLabels[h] || "", g, u.lineHeight)
                            }
                        }
                        e.restore()
                    }(t), ut.each(t.ticks, function(e, s) {
                        if (s > 0 || n.reverse) {
                            var l = t.getDistanceFromCenterForValue(t.ticksAsNumbers[s]);
                            if (i.display && 0 !== s && function(t, e, i, n) {
                                    var a, o = t.ctx,
                                        r = e.circular,
                                        s = Ti(t),
                                        l = Ii(e.color, n - 1),
                                        d = Ii(e.lineWidth, n - 1);
                                    if ((r || s) && l && d) {
                                        if (o.save(), o.strokeStyle = l, o.lineWidth = d, o.setLineDash && (o.setLineDash(e.borderDash || []), o.lineDashOffset = e.borderDashOffset || 0), o.beginPath(), r) o.arc(t.xCenter, t.yCenter, i, 0, 2 * Math.PI);
                                        else {
                                            a = t.getPointPosition(0, i), o.moveTo(a.x, a.y);
                                            for (var u = 1; u < s; u++) a = t.getPointPosition(u, i), o.lineTo(a.x, a.y)
                                        }
                                        o.closePath(), o.stroke(), o.restore()
                                    }
                                }(t, i, l, s), n.display) {
                                var d = Pi(n.fontColor, st.global.defaultFontColor);
                                if (a.font = r.string, a.save(), a.translate(t.xCenter, t.yCenter), a.rotate(o), n.showLabelBackdrop) {
                                    var u = a.measureText(e).width;
                                    a.fillStyle = n.backdropColor, a.fillRect(-u / 2 - n.backdropPaddingX, -l - r.size / 2 - n.backdropPaddingY, u + 2 * n.backdropPaddingX, r.size + 2 * n.backdropPaddingY)
                                }
                                a.textAlign = "center", a.textBaseline = "middle", a.fillStyle = d, a.fillText(e, 0, -l), a.restore()
                            }
                        }
                    })
                }
            }
        }),
        Wi = Di;
    Ni._defaults = Wi;
    var Vi = ut.valueOrDefault,
        Ei = Number.MIN_SAFE_INTEGER || -9007199254740991,
        Hi = Number.MAX_SAFE_INTEGER || 9007199254740991,
        ji = {
            millisecond: {
                common: !0,
                size: 1,
                steps: [1, 2, 5, 10, 20, 50, 100, 250, 500]
            },
            second: {
                common: !0,
                size: 1e3,
                steps: [1, 2, 5, 10, 15, 30]
            },
            minute: {
                common: !0,
                size: 6e4,
                steps: [1, 2, 5, 10, 15, 30]
            },
            hour: {
                common: !0,
                size: 36e5,
                steps: [1, 2, 3, 6, 12]
            },
            day: {
                common: !0,
                size: 864e5,
                steps: [1, 2, 5]
            },
            week: {
                common: !1,
                size: 6048e5,
                steps: [1, 2, 3, 4]
            },
            month: {
                common: !0,
                size: 2628e6,
                steps: [1, 2, 3]
            },
            quarter: {
                common: !1,
                size: 7884e6,
                steps: [1, 2, 3, 4]
            },
            year: {
                common: !0,
                size: 3154e7
            }
        },
        qi = Object.keys(ji);

    function Yi(t, e) {
        return t - e
    }

    function Ui(t) {
        var e, i, n, a = {},
            o = [];
        for (e = 0, i = t.length; e < i; ++e) a[n = t[e]] || (a[n] = !0, o.push(n));
        return o
    }

    function Xi(t, e, i, n) {
        var a = function(t, e, i) {
                for (var n, a, o, r = 0, s = t.length - 1; r >= 0 && r <= s;) {
                    if (a = t[(n = r + s >> 1) - 1] || null, o = t[n], !a) return {
                        lo: null,
                        hi: o
                    };
                    if (o[e] < i) r = n + 1;
                    else {
                        if (!(a[e] > i)) return {
                            lo: a,
                            hi: o
                        };
                        s = n - 1
                    }
                }
                return {
                    lo: o,
                    hi: null
                }
            }(t, e, i),
            o = a.lo ? a.hi ? a.lo : t[t.length - 2] : t[0],
            r = a.lo ? a.hi ? a.hi : t[t.length - 1] : t[1],
            s = r[e] - o[e],
            l = s ? (i - o[e]) / s : 0,
            d = (r[n] - o[n]) * l;
        return o[n] + d
    }

    function Ki(t, e) {
        var i = t._adapter,
            n = t.options.time,
            a = n.parser,
            o = a || n.format,
            r = e;
        return "function" == typeof a && (r = a(r)), ut.isFinite(r) || (r = "string" == typeof o ? i.parse(r, o) : i.parse(r)), null !== r ? +r : (a || "function" != typeof o || (r = o(e), ut.isFinite(r) || (r = i.parse(r))), r)
    }

    function Gi(t, e) {
        if (ut.isNullOrUndef(e)) return null;
        var i = t.options.time,
            n = Ki(t, t.getRightValue(e));
        return null === n ? n : (i.round && (n = +t._adapter.startOf(n, i.round)), n)
    }

    function Zi(t) {
        for (var e = qi.indexOf(t) + 1, i = qi.length; e < i; ++e)
            if (ji[qi[e]].common) return qi[e]
    }

    function $i(t, e, i, n) {
        var a, o = t._adapter,
            r = t.options,
            s = r.time,
            l = s.unit || function(t, e, i, n) {
                var a, o, r, s = qi.length;
                for (a = qi.indexOf(t); a < s - 1; ++a)
                    if (r = (o = ji[qi[a]]).steps ? o.steps[o.steps.length - 1] : Hi, o.common && Math.ceil((i - e) / (r * o.size)) <= n) return qi[a];
                return qi[s - 1]
            }(s.minUnit, e, i, n),
            d = Zi(l),
            u = Vi(s.stepSize, s.unitStepSize),
            h = "week" === l && s.isoWeekday,
            c = r.ticks.major.enabled,
            f = ji[l],
            g = e,
            p = i,
            m = [];
        for (u || (u = function(t, e, i, n) {
                var a, o, r, s = e - t,
                    l = ji[i],
                    d = l.size,
                    u = l.steps;
                if (!u) return Math.ceil(s / (n * d));
                for (a = 0, o = u.length; a < o && (r = u[a], !(Math.ceil(s / (d * r)) <= n)); ++a);
                return r
            }(e, i, l, n)), h && (g = +o.startOf(g, "isoWeek", h), p = +o.startOf(p, "isoWeek", h)), g = +o.startOf(g, h ? "day" : l), (p = +o.startOf(p, h ? "day" : l)) < i && (p = +o.add(p, 1, l)), a = g, c && d && !h && !s.round && (a = +o.startOf(a, d), a = +o.add(a, ~~((g - a) / (f.size * u)) * u, l)); a < p; a = +o.add(a, u, l)) m.push(+a);
        return m.push(+a), m
    }
    var Ji = fi.extend({
            initialize: function() {
                this.mergeTicksOptions(), fi.prototype.initialize.call(this)
            },
            update: function() {
                var t = this.options,
                    e = t.time || (t.time = {}),
                    i = this._adapter = new si._date(t.adapters.date);
                return e.format && console.warn("options.time.format is deprecated and replaced by options.time.parser."), ut.mergeIf(e.displayFormats, i.formats()), fi.prototype.update.apply(this, arguments)
            },
            getRightValue: function(t) {
                return t && void 0 !== t.t && (t = t.t), fi.prototype.getRightValue.call(this, t)
            },
            determineDataLimits: function() {
                var t, e, i, n, a, o, r = this,
                    s = r.chart,
                    l = r._adapter,
                    d = r.options.time,
                    u = d.unit || "day",
                    h = Hi,
                    c = Ei,
                    f = [],
                    g = [],
                    p = [],
                    m = s.data.labels || [];
                for (t = 0, i = m.length; t < i; ++t) p.push(Gi(r, m[t]));
                for (t = 0, i = (s.data.datasets || []).length; t < i; ++t)
                    if (s.isDatasetVisible(t))
                        if (a = s.data.datasets[t].data, ut.isObject(a[0]))
                            for (g[t] = [], e = 0, n = a.length; e < n; ++e) o = Gi(r, a[e]), f.push(o), g[t][e] = o;
                        else {
                            for (e = 0, n = p.length; e < n; ++e) f.push(p[e]);
                            g[t] = p.slice(0)
                        }
                else g[t] = [];
                p.length && (p = Ui(p).sort(Yi), h = Math.min(h, p[0]), c = Math.max(c, p[p.length - 1])), f.length && (f = Ui(f).sort(Yi), h = Math.min(h, f[0]), c = Math.max(c, f[f.length - 1])), h = Gi(r, d.min) || h, c = Gi(r, d.max) || c, h = h === Hi ? +l.startOf(Date.now(), u) : h, c = c === Ei ? +l.endOf(Date.now(), u) + 1 : c, r.min = Math.min(h, c), r.max = Math.max(h + 1, c), r._horizontal = r.isHorizontal(), r._table = [], r._timestamps = {
                    data: f,
                    datasets: g,
                    labels: p
                }
            },
            buildTicks: function() {
                var t, e, i, n = this,
                    a = n.min,
                    o = n.max,
                    r = n.options,
                    s = r.time,
                    l = [],
                    d = [];
                switch (r.ticks.source) {
                    case "data":
                        l = n._timestamps.data;
                        break;
                    case "labels":
                        l = n._timestamps.labels;
                        break;
                    case "auto":
                    default:
                        l = $i(n, a, o, n.getLabelCapacity(a))
                }
                for ("ticks" === r.bounds && l.length && (a = l[0], o = l[l.length - 1]), a = Gi(n, s.min) || a, o = Gi(n, s.max) || o, t = 0, e = l.length; t < e; ++t)(i = l[t]) >= a && i <= o && d.push(i);
                return n.min = a, n.max = o, n._unit = s.unit || function(t, e, i, n, a) {
                        var o, r;
                        for (o = qi.length - 1; o >= qi.indexOf(i); o--)
                            if (r = qi[o], ji[r].common && t._adapter.diff(a, n, r) >= e.length) return r;
                        return qi[i ? qi.indexOf(i) : 0]
                    }(n, d, s.minUnit, n.min, n.max), n._majorUnit = Zi(n._unit), n._table = function(t, e, i, n) {
                        if ("linear" === n || !t.length) return [{
                            time: e,
                            pos: 0
                        }, {
                            time: i,
                            pos: 1
                        }];
                        var a, o, r, s, l, d = [],
                            u = [e];
                        for (a = 0, o = t.length; a < o; ++a)(s = t[a]) > e && s < i && u.push(s);
                        for (u.push(i), a = 0, o = u.length; a < o; ++a) l = u[a + 1], r = u[a - 1], s = u[a], void 0 !== r && void 0 !== l && Math.round((l + r) / 2) === s || d.push({
                            time: s,
                            pos: a / (o - 1)
                        });
                        return d
                    }(n._timestamps.data, a, o, r.distribution), n._offsets = function(t, e, i, n, a) {
                        var o, r, s = 0,
                            l = 0;
                        return a.offset && e.length && (a.time.min || (o = Xi(t, "time", e[0], "pos"), s = 1 === e.length ? 1 - o : (Xi(t, "time", e[1], "pos") - o) / 2), a.time.max || (r = Xi(t, "time", e[e.length - 1], "pos"), l = 1 === e.length ? r : (r - Xi(t, "time", e[e.length - 2], "pos")) / 2)), {
                            start: s,
                            end: l
                        }
                    }(n._table, d, 0, 0, r), r.ticks.reverse && d.reverse(),
                    function(t, e, i) {
                        var n, a, o, r, s = [];
                        for (n = 0, a = e.length; n < a; ++n) o = e[n], r = !!i && o === +t._adapter.startOf(o, i), s.push({
                            value: o,
                            major: r
                        });
                        return s
                    }(n, d, n._majorUnit)
            },
            getLabelForIndex: function(t, e) {
                var i = this,
                    n = i._adapter,
                    a = i.chart.data,
                    o = i.options.time,
                    r = a.labels && t < a.labels.length ? a.labels[t] : "",
                    s = a.datasets[e].data[t];
                return ut.isObject(s) && (r = i.getRightValue(s)), o.tooltipFormat ? n.format(Ki(i, r), o.tooltipFormat) : "string" == typeof r ? r : n.format(Ki(i, r), o.displayFormats.datetime)
            },
            tickFormatFunction: function(t, e, i, n) {
                var a = this._adapter,
                    o = this.options,
                    r = o.time.displayFormats,
                    s = r[this._unit],
                    l = this._majorUnit,
                    d = r[l],
                    u = +a.startOf(t, l),
                    h = o.ticks.major,
                    c = h.enabled && l && d && t === u,
                    f = a.format(t, n || (c ? d : s)),
                    g = c ? h : o.ticks.minor,
                    p = Vi(g.callback, g.userCallback);
                return p ? p(f, e, i) : f
            },
            convertTicksToLabels: function(t) {
                var e, i, n = [];
                for (e = 0, i = t.length; e < i; ++e) n.push(this.tickFormatFunction(t[e].value, e, t));
                return n
            },
            getPixelForOffset: function(t) {
                var e = this,
                    i = e.options.ticks.reverse,
                    n = e._horizontal ? e.width : e.height,
                    a = e._horizontal ? i ? e.right : e.left : i ? e.bottom : e.top,
                    o = Xi(e._table, "time", t, "pos"),
                    r = n * (e._offsets.start + o) / (e._offsets.start + 1 + e._offsets.end);
                return i ? a - r : a + r
            },
            getPixelForValue: function(t, e, i) {
                var n = null;
                if (void 0 !== e && void 0 !== i && (n = this._timestamps.datasets[i][e]), null === n && (n = Gi(this, t)), null !== n) return this.getPixelForOffset(n)
            },
            getPixelForTick: function(t) {
                var e = this.getTicks();
                return t >= 0 && t < e.length ? this.getPixelForOffset(e[t].value) : null
            },
            getValueForPixel: function(t) {
                var e = this,
                    i = e._horizontal ? e.width : e.height,
                    n = e._horizontal ? e.left : e.top,
                    a = (i ? (t - n) / i : 0) * (e._offsets.start + 1 + e._offsets.start) - e._offsets.end,
                    o = Xi(e._table, "pos", a, "time");
                return e._adapter._create(o)
            },
            getLabelWidth: function(t) {
                var e = this.options.ticks,
                    i = this.ctx.measureText(t).width,
                    n = ut.toRadians(e.maxRotation),
                    a = Math.cos(n),
                    o = Math.sin(n);
                return i * a + Vi(e.fontSize, st.global.defaultFontSize) * o
            },
            getLabelCapacity: function(t) {
                var e = this,
                    i = e.options.time.displayFormats.millisecond,
                    n = e.tickFormatFunction(t, 0, [], i),
                    a = e.getLabelWidth(n),
                    o = e.isHorizontal() ? e.width : e.height,
                    r = Math.floor(o / a);
                return r > 0 ? r : 1
            }
        }),
        Qi = {
            position: "bottom",
            distribution: "linear",
            bounds: "data",
            adapters: {},
            time: {
                parser: !1,
                format: !1,
                unit: !1,
                round: !1,
                displayFormat: !1,
                isoWeekday: !1,
                minUnit: "millisecond",
                displayFormats: {}
            },
            ticks: {
                autoSkip: !1,
                source: "auto",
                major: {
                    enabled: !1
                }
            }
        };
    Ji._defaults = Qi;
    var tn = {
            category: gi,
            linear: yi,
            logarithmic: Ci,
            radialLinear: Ni,
            time: Ji
        },
        en = {
            datetime: "MMM D, YYYY, h:mm:ss a",
            millisecond: "h:mm:ss.SSS a",
            second: "h:mm:ss a",
            minute: "h:mm a",
            hour: "hA",
            day: "MMM D",
            week: "ll",
            month: "MMM YYYY",
            quarter: "[Q]Q - YYYY",
            year: "YYYY"
        };
    si._date.override("function" == typeof t ? {
        _id: "moment",
        formats: function() {
            return en
        },
        parse: function(e, i) {
            return "string" == typeof e && "string" == typeof i ? e = t(e, i) : e instanceof t || (e = t(e)), e.isValid() ? e.valueOf() : null
        },
        format: function(e, i) {
            return t(e).format(i)
        },
        add: function(e, i, n) {
            return t(e).add(i, n).valueOf()
        },
        diff: function(e, i, n) {
            return t.duration(t(e).diff(t(i))).as(n)
        },
        startOf: function(e, i, n) {
            return e = t(e), "isoWeek" === i ? e.isoWeekday(n).valueOf() : e.startOf(i).valueOf()
        },
        endOf: function(e, i) {
            return t(e).endOf(i).valueOf()
        },
        _create: function(e) {
            return t(e)
        }
    } : {}), st._set("global", {
        plugins: {
            filler: {
                propagate: !0
            }
        }
    });
    var nn = {
        dataset: function(t) {
            var e = t.fill,
                i = t.chart,
                n = i.getDatasetMeta(e),
                a = n && i.isDatasetVisible(e) && n.dataset._children || [],
                o = a.length || 0;
            return o ? function(t, e) {
                return e < o && a[e]._view || null
            } : null
        },
        boundary: function(t) {
            var e = t.boundary,
                i = e ? e.x : null,
                n = e ? e.y : null;
            return function(t) {
                return {
                    x: null === i ? t.x : i,
                    y: null === n ? t.y : n
                }
            }
        }
    };

    function an(t, e, i) {
        var n, a = t._model || {},
            o = a.fill;
        if (void 0 === o && (o = !!a.backgroundColor), !1 === o || null === o) return !1;
        if (!0 === o) return "origin";
        if (n = parseFloat(o, 10), isFinite(n) && Math.floor(n) === n) return "-" !== o[0] && "+" !== o[0] || (n = e + n), !(n === e || n < 0 || n >= i) && n;
        switch (o) {
            case "bottom":
                return "start";
            case "top":
                return "end";
            case "zero":
                return "origin";
            case "origin":
            case "start":
            case "end":
                return o;
            default:
                return !1
        }
    }

    function on(t) {
        var e, i = t.el._model || {},
            n = t.el._scale || {},
            a = t.fill,
            o = null;
        if (isFinite(a)) return null;
        if ("start" === a ? o = void 0 === i.scaleBottom ? n.bottom : i.scaleBottom : "end" === a ? o = void 0 === i.scaleTop ? n.top : i.scaleTop : void 0 !== i.scaleZero ? o = i.scaleZero : n.getBasePosition ? o = n.getBasePosition() : n.getBasePixel && (o = n.getBasePixel()), null != o) {
            if (void 0 !== o.x && void 0 !== o.y) return o;
            if (ut.isFinite(o)) return {
                x: (e = n.isHorizontal()) ? o : null,
                y: e ? null : o
            }
        }
        return null
    }

    function rn(t, e, i) {
        var n, a = t[e].fill,
            o = [e];
        if (!i) return a;
        for (; !1 !== a && -1 === o.indexOf(a);) {
            if (!isFinite(a)) return a;
            if (!(n = t[a])) return !1;
            if (n.visible) return a;
            o.push(a), a = n.fill
        }
        return !1
    }

    function sn(t) {
        var e = t.fill,
            i = "dataset";
        return !1 === e ? null : (isFinite(e) || (i = "boundary"), nn[i](t))
    }

    function ln(t) {
        return t && !t.skip
    }

    function dn(t, e, i, n, a) {
        var o;
        if (n && a) {
            for (t.moveTo(e[0].x, e[0].y), o = 1; o < n; ++o) ut.canvas.lineTo(t, e[o - 1], e[o]);
            for (t.lineTo(i[a - 1].x, i[a - 1].y), o = a - 1; o > 0; --o) ut.canvas.lineTo(t, i[o], i[o - 1], !0)
        }
    }
    var un = {
            id: "filler",
            afterDatasetsUpdate: function(t, e) {
                var i, n, a, o, r = (t.data.datasets || []).length,
                    s = e.propagate,
                    l = [];
                for (n = 0; n < r; ++n) o = null, (a = (i = t.getDatasetMeta(n)).dataset) && a._model && a instanceof Wt.Line && (o = {
                    visible: t.isDatasetVisible(n),
                    fill: an(a, n, r),
                    chart: t,
                    el: a
                }), i.$filler = o, l.push(o);
                for (n = 0; n < r; ++n)(o = l[n]) && (o.fill = rn(l, n, s), o.boundary = on(o), o.mapper = sn(o))
            },
            beforeDatasetDraw: function(t, e) {
                var i = e.meta.$filler;
                if (i) {
                    var n = t.ctx,
                        a = i.el,
                        o = a._view,
                        r = a._children || [],
                        s = i.mapper,
                        l = o.backgroundColor || st.global.defaultColor;
                    s && l && r.length && (ut.canvas.clipArea(n, t.chartArea), function(t, e, i, n, a, o) {
                        var r, s, l, d, u, h, c, f = e.length,
                            g = n.spanGaps,
                            p = [],
                            m = [],
                            v = 0,
                            b = 0;
                        for (t.beginPath(), r = 0, s = f + !!o; r < s; ++r) u = i(d = e[l = r % f]._view, l, n), h = ln(d), c = ln(u), h && c ? (v = p.push(d), b = m.push(u)) : v && b && (g ? (h && p.push(d), c && m.push(u)) : (dn(t, p, m, v, b), v = b = 0, p = [], m = []));
                        dn(t, p, m, v, b), t.closePath(), t.fillStyle = a, t.fill()
                    }(n, r, s, o, l, a._loop), ut.canvas.unclipArea(n))
                }
            }
        },
        hn = ut.noop,
        cn = ut.valueOrDefault;

    function fn(t, e) {
        return t.usePointStyle && t.boxWidth > e ? e : t.boxWidth
    }
    st._set("global", {
        legend: {
            display: !0,
            position: "top",
            fullWidth: !0,
            reverse: !1,
            weight: 1e3,
            onClick: function(t, e) {
                var i = e.datasetIndex,
                    n = this.chart,
                    a = n.getDatasetMeta(i);
                a.hidden = null === a.hidden ? !n.data.datasets[i].hidden : null, n.update()
            },
            onHover: null,
            onLeave: null,
            labels: {
                boxWidth: 40,
                padding: 10,
                generateLabels: function(t) {
                    var e = t.data;
                    return ut.isArray(e.datasets) ? e.datasets.map(function(e, i) {
                        return {
                            text: e.label,
                            fillStyle: ut.isArray(e.backgroundColor) ? e.backgroundColor[0] : e.backgroundColor,
                            hidden: !t.isDatasetVisible(i),
                            lineCap: e.borderCapStyle,
                            lineDash: e.borderDash,
                            lineDashOffset: e.borderDashOffset,
                            lineJoin: e.borderJoinStyle,
                            lineWidth: e.borderWidth,
                            strokeStyle: e.borderColor,
                            pointStyle: e.pointStyle,
                            datasetIndex: i
                        }
                    }, this) : []
                }
            }
        },
        legendCallback: function(t) {
            var e = [];
            e.push('<ul class="' + t.id + '-legend">');
            for (var i = 0; i < t.data.datasets.length; i++) e.push('<li><span style="background-color:' + t.data.datasets[i].backgroundColor + '"></span>'), t.data.datasets[i].label && e.push(t.data.datasets[i].label), e.push("</li>");
            return e.push("</ul>"), e.join("")
        }
    });
    var gn = pt.extend({
        initialize: function(t) {
            ut.extend(this, t), this.legendHitBoxes = [], this._hoveredItem = null, this.doughnutMode = !1
        },
        beforeUpdate: hn,
        update: function(t, e, i) {
            var n = this;
            return n.beforeUpdate(), n.maxWidth = t, n.maxHeight = e, n.margins = i, n.beforeSetDimensions(), n.setDimensions(), n.afterSetDimensions(), n.beforeBuildLabels(), n.buildLabels(), n.afterBuildLabels(), n.beforeFit(), n.fit(), n.afterFit(), n.afterUpdate(), n.minSize
        },
        afterUpdate: hn,
        beforeSetDimensions: hn,
        setDimensions: function() {
            var t = this;
            t.isHorizontal() ? (t.width = t.maxWidth, t.left = 0, t.right = t.width) : (t.height = t.maxHeight, t.top = 0, t.bottom = t.height), t.paddingLeft = 0, t.paddingTop = 0, t.paddingRight = 0, t.paddingBottom = 0, t.minSize = {
                width: 0,
                height: 0
            }
        },
        afterSetDimensions: hn,
        beforeBuildLabels: hn,
        buildLabels: function() {
            var t = this,
                e = t.options.labels || {},
                i = ut.callback(e.generateLabels, [t.chart], t) || [];
            e.filter && (i = i.filter(function(i) {
                return e.filter(i, t.chart.data)
            })), t.options.reverse && i.reverse(), t.legendItems = i
        },
        afterBuildLabels: hn,
        beforeFit: hn,
        fit: function() {
            var t = this,
                e = t.options,
                i = e.labels,
                n = e.display,
                a = t.ctx,
                o = ut.options._parseFont(i),
                r = o.size,
                s = t.legendHitBoxes = [],
                l = t.minSize,
                d = t.isHorizontal();
            if (d ? (l.width = t.maxWidth, l.height = n ? 10 : 0) : (l.width = n ? 10 : 0, l.height = t.maxHeight), n)
                if (a.font = o.string, d) {
                    var u = t.lineWidths = [0],
                        h = 0;
                    a.textAlign = "left", a.textBaseline = "top", ut.each(t.legendItems, function(t, e) {
                        var n = fn(i, r) + r / 2 + a.measureText(t.text).width;
                        (0 === e || u[u.length - 1] + n + i.padding > l.width) && (h += r + i.padding, u[u.length - (e > 0 ? 0 : 1)] = i.padding), s[e] = {
                            left: 0,
                            top: 0,
                            width: n,
                            height: r
                        }, u[u.length - 1] += n + i.padding
                    }), l.height += h
                } else {
                    var c = i.padding,
                        f = t.columnWidths = [],
                        g = i.padding,
                        p = 0,
                        m = 0,
                        v = r + c;
                    ut.each(t.legendItems, function(t, e) {
                        var n = fn(i, r) + r / 2 + a.measureText(t.text).width;
                        e > 0 && m + v > l.height - c && (g += p + i.padding, f.push(p), p = 0, m = 0), p = Math.max(p, n), m += v, s[e] = {
                            left: 0,
                            top: 0,
                            width: n,
                            height: r
                        }
                    }), g += p, f.push(p), l.width += g
                } t.width = l.width, t.height = l.height
        },
        afterFit: hn,
        isHorizontal: function() {
            return "top" === this.options.position || "bottom" === this.options.position
        },
        draw: function() {
            var t = this,
                e = t.options,
                i = e.labels,
                n = st.global,
                a = n.defaultColor,
                o = n.elements.line,
                r = t.width,
                s = t.lineWidths;
            if (e.display) {
                var l, d = t.ctx,
                    u = cn(i.fontColor, n.defaultFontColor),
                    h = ut.options._parseFont(i),
                    c = h.size;
                d.textAlign = "left", d.textBaseline = "middle", d.lineWidth = .5, d.strokeStyle = u, d.fillStyle = u, d.font = h.string;
                var f = fn(i, c),
                    g = t.legendHitBoxes,
                    p = t.isHorizontal();
                l = p ? {
                    x: t.left + (r - s[0]) / 2 + i.padding,
                    y: t.top + i.padding,
                    line: 0
                } : {
                    x: t.left + i.padding,
                    y: t.top + i.padding,
                    line: 0
                };
                var m = c + i.padding;
                ut.each(t.legendItems, function(n, u) {
                    var h = d.measureText(n.text).width,
                        v = f + c / 2 + h,
                        b = l.x,
                        x = l.y;
                    p ? u > 0 && b + v + i.padding > t.left + t.minSize.width && (x = l.y += m, l.line++, b = l.x = t.left + (r - s[l.line]) / 2 + i.padding) : u > 0 && x + m > t.top + t.minSize.height && (b = l.x = b + t.columnWidths[l.line] + i.padding, x = l.y = t.top + i.padding, l.line++),
                        function(t, i, n) {
                            if (!(isNaN(f) || f <= 0)) {
                                d.save();
                                var r = cn(n.lineWidth, o.borderWidth);
                                if (d.fillStyle = cn(n.fillStyle, a), d.lineCap = cn(n.lineCap, o.borderCapStyle), d.lineDashOffset = cn(n.lineDashOffset, o.borderDashOffset), d.lineJoin = cn(n.lineJoin, o.borderJoinStyle), d.lineWidth = r, d.strokeStyle = cn(n.strokeStyle, a), d.setLineDash && d.setLineDash(cn(n.lineDash, o.borderDash)), e.labels && e.labels.usePointStyle) {
                                    var s = f * Math.SQRT2 / 2,
                                        l = t + f / 2,
                                        u = i + c / 2;
                                    ut.canvas.drawPoint(d, n.pointStyle, s, l, u)
                                } else 0 !== r && d.strokeRect(t, i, f, c), d.fillRect(t, i, f, c);
                                d.restore()
                            }
                        }(b, x, n), g[u].left = b, g[u].top = x,
                        function(t, e, i, n) {
                            var a = c / 2,
                                o = f + a + t,
                                r = e + a;
                            d.fillText(i.text, o, r), i.hidden && (d.beginPath(), d.lineWidth = 2, d.moveTo(o, r), d.lineTo(o + n, r), d.stroke())
                        }(b, x, n, h), p ? l.x += v + i.padding : l.y += m
                })
            }
        },
        _getLegendItemAt: function(t, e) {
            var i, n, a, o = this;
            if (t >= o.left && t <= o.right && e >= o.top && e <= o.bottom)
                for (a = o.legendHitBoxes, i = 0; i < a.length; ++i)
                    if (t >= (n = a[i]).left && t <= n.left + n.width && e >= n.top && e <= n.top + n.height) return o.legendItems[i];
            return null
        },
        handleEvent: function(t) {
            var e, i = this,
                n = i.options,
                a = "mouseup" === t.type ? "click" : t.type;
            if ("mousemove" === a) {
                if (!n.onHover && !n.onLeave) return
            } else {
                if ("click" !== a) return;
                if (!n.onClick) return
            }
            e = i._getLegendItemAt(t.x, t.y), "click" === a ? e && n.onClick && n.onClick.call(i, t.native, e) : (n.onLeave && e !== i._hoveredItem && (i._hoveredItem && n.onLeave.call(i, t.native, i._hoveredItem), i._hoveredItem = e), n.onHover && e && n.onHover.call(i, t.native, e))
        }
    });

    function pn(t, e) {
        var i = new gn({
            ctx: t.ctx,
            options: e,
            chart: t
        });
        ke.configure(t, i, e), ke.addBox(t, i), t.legend = i
    }
    var mn = {
            id: "legend",
            _element: gn,
            beforeInit: function(t) {
                var e = t.options.legend;
                e && pn(t, e)
            },
            beforeUpdate: function(t) {
                var e = t.options.legend,
                    i = t.legend;
                e ? (ut.mergeIf(e, st.global.legend), i ? (ke.configure(t, i, e), i.options = e) : pn(t, e)) : i && (ke.removeBox(t, i), delete t.legend)
            },
            afterEvent: function(t, e) {
                var i = t.legend;
                i && i.handleEvent(e)
            }
        },
        vn = ut.noop;
    st._set("global", {
        title: {
            display: !1,
            fontStyle: "bold",
            fullWidth: !0,
            padding: 10,
            position: "top",
            text: "",
            weight: 2e3
        }
    });
    var bn = pt.extend({
        initialize: function(t) {
            ut.extend(this, t), this.legendHitBoxes = []
        },
        beforeUpdate: vn,
        update: function(t, e, i) {
            var n = this;
            return n.beforeUpdate(), n.maxWidth = t, n.maxHeight = e, n.margins = i, n.beforeSetDimensions(), n.setDimensions(), n.afterSetDimensions(), n.beforeBuildLabels(), n.buildLabels(), n.afterBuildLabels(), n.beforeFit(), n.fit(), n.afterFit(), n.afterUpdate(), n.minSize
        },
        afterUpdate: vn,
        beforeSetDimensions: vn,
        setDimensions: function() {
            var t = this;
            t.isHorizontal() ? (t.width = t.maxWidth, t.left = 0, t.right = t.width) : (t.height = t.maxHeight, t.top = 0, t.bottom = t.height), t.paddingLeft = 0, t.paddingTop = 0, t.paddingRight = 0, t.paddingBottom = 0, t.minSize = {
                width: 0,
                height: 0
            }
        },
        afterSetDimensions: vn,
        beforeBuildLabels: vn,
        buildLabels: vn,
        afterBuildLabels: vn,
        beforeFit: vn,
        fit: function() {
            var t = this,
                e = t.options,
                i = e.display,
                n = t.minSize,
                a = ut.isArray(e.text) ? e.text.length : 1,
                o = ut.options._parseFont(e),
                r = i ? a * o.lineHeight + 2 * e.padding : 0;
            t.isHorizontal() ? (n.width = t.maxWidth, n.height = r) : (n.width = r, n.height = t.maxHeight), t.width = n.width, t.height = n.height
        },
        afterFit: vn,
        isHorizontal: function() {
            var t = this.options.position;
            return "top" === t || "bottom" === t
        },
        draw: function() {
            var t = this,
                e = t.ctx,
                i = t.options;
            if (i.display) {
                var n, a, o, r = ut.options._parseFont(i),
                    s = r.lineHeight,
                    l = s / 2 + i.padding,
                    d = 0,
                    u = t.top,
                    h = t.left,
                    c = t.bottom,
                    f = t.right;
                e.fillStyle = ut.valueOrDefault(i.fontColor, st.global.defaultFontColor), e.font = r.string, t.isHorizontal() ? (a = h + (f - h) / 2, o = u + l, n = f - h) : (a = "left" === i.position ? h + l : f - l, o = u + (c - u) / 2, n = c - u, d = Math.PI * ("left" === i.position ? -.5 : .5)), e.save(), e.translate(a, o), e.rotate(d), e.textAlign = "center", e.textBaseline = "middle";
                var g = i.text;
                if (ut.isArray(g))
                    for (var p = 0, m = 0; m < g.length; ++m) e.fillText(g[m], 0, p, n), p += s;
                else e.fillText(g, 0, 0, n);
                e.restore()
            }
        }
    });

    function xn(t, e) {
        var i = new bn({
            ctx: t.ctx,
            options: e,
            chart: t
        });
        ke.configure(t, i, e), ke.addBox(t, i), t.titleBlock = i
    }
    var yn = {},
        kn = un,
        wn = mn,
        Mn = {
            id: "title",
            _element: bn,
            beforeInit: function(t) {
                var e = t.options.title;
                e && xn(t, e)
            },
            beforeUpdate: function(t) {
                var e = t.options.title,
                    i = t.titleBlock;
                e ? (ut.mergeIf(e, st.global.title), i ? (ke.configure(t, i, e), i.options = e) : xn(t, e)) : i && (ke.removeBox(t, i), delete t.titleBlock)
            }
        };
    for (var _n in yn.filler = kn, yn.legend = wn, yn.title = Mn, ai.helpers = ut,
            function() {
                function t(t, e, i) {
                    var n;
                    return "string" == typeof t ? (n = parseInt(t, 10), -1 !== t.indexOf("%") && (n = n / 100 * e.parentNode[i])) : n = t, n
                }

                function e(t) {
                    return null != t && "none" !== t
                }

                function i(i, n, a) {
                    var o = document.defaultView,
                        r = ut._getParentNode(i),
                        s = o.getComputedStyle(i)[n],
                        l = o.getComputedStyle(r)[n],
                        d = e(s),
                        u = e(l),
                        h = Number.POSITIVE_INFINITY;
                    return d || u ? Math.min(d ? t(s, i, a) : h, u ? t(l, r, a) : h) : "none"
                }
                ut.where = function(t, e) {
                    if (ut.isArray(t) && Array.prototype.filter) return t.filter(e);
                    var i = [];
                    return ut.each(t, function(t) {
                        e(t) && i.push(t)
                    }), i
                }, ut.findIndex = Array.prototype.findIndex ? function(t, e, i) {
                    return t.findIndex(e, i)
                } : function(t, e, i) {
                    i = void 0 === i ? t : i;
                    for (var n = 0, a = t.length; n < a; ++n)
                        if (e.call(i, t[n], n, t)) return n;
                    return -1
                }, ut.findNextWhere = function(t, e, i) {
                    ut.isNullOrUndef(i) && (i = -1);
                    for (var n = i + 1; n < t.length; n++) {
                        var a = t[n];
                        if (e(a)) return a
                    }
                }, ut.findPreviousWhere = function(t, e, i) {
                    ut.isNullOrUndef(i) && (i = t.length);
                    for (var n = i - 1; n >= 0; n--) {
                        var a = t[n];
                        if (e(a)) return a
                    }
                }, ut.isNumber = function(t) {
                    return !isNaN(parseFloat(t)) && isFinite(t)
                }, ut.almostEquals = function(t, e, i) {
                    return Math.abs(t - e) < i
                }, ut.almostWhole = function(t, e) {
                    var i = Math.round(t);
                    return i - e < t && i + e > t
                }, ut.max = function(t) {
                    return t.reduce(function(t, e) {
                        return isNaN(e) ? t : Math.max(t, e)
                    }, Number.NEGATIVE_INFINITY)
                }, ut.min = function(t) {
                    return t.reduce(function(t, e) {
                        return isNaN(e) ? t : Math.min(t, e)
                    }, Number.POSITIVE_INFINITY)
                }, ut.sign = Math.sign ? function(t) {
                    return Math.sign(t)
                } : function(t) {
                    return 0 == (t = +t) || isNaN(t) ? t : t > 0 ? 1 : -1
                }, ut.log10 = Math.log10 ? function(t) {
                    return Math.log10(t)
                } : function(t) {
                    var e = Math.log(t) * Math.LOG10E,
                        i = Math.round(e);
                    return t === Math.pow(10, i) ? i : e
                }, ut.toRadians = function(t) {
                    return t * (Math.PI / 180)
                }, ut.toDegrees = function(t) {
                    return t * (180 / Math.PI)
                }, ut._decimalPlaces = function(t) {
                    if (ut.isFinite(t)) {
                        for (var e = 1, i = 0; Math.round(t * e) / e !== t;) e *= 10, i++;
                        return i
                    }
                }, ut.getAngleFromPoint = function(t, e) {
                    var i = e.x - t.x,
                        n = e.y - t.y,
                        a = Math.sqrt(i * i + n * n),
                        o = Math.atan2(n, i);
                    return o < -.5 * Math.PI && (o += 2 * Math.PI), {
                        angle: o,
                        distance: a
                    }
                }, ut.distanceBetweenPoints = function(t, e) {
                    return Math.sqrt(Math.pow(e.x - t.x, 2) + Math.pow(e.y - t.y, 2))
                }, ut.aliasPixel = function(t) {
                    return t % 2 == 0 ? 0 : .5
                }, ut._alignPixel = function(t, e, i) {
                    var n = t.currentDevicePixelRatio,
                        a = i / 2;
                    return Math.round((e - a) * n) / n + a
                }, ut.splineCurve = function(t, e, i, n) {
                    var a = t.skip ? e : t,
                        o = e,
                        r = i.skip ? e : i,
                        s = Math.sqrt(Math.pow(o.x - a.x, 2) + Math.pow(o.y - a.y, 2)),
                        l = Math.sqrt(Math.pow(r.x - o.x, 2) + Math.pow(r.y - o.y, 2)),
                        d = s / (s + l),
                        u = l / (s + l),
                        h = n * (d = isNaN(d) ? 0 : d),
                        c = n * (u = isNaN(u) ? 0 : u);
                    return {
                        previous: {
                            x: o.x - h * (r.x - a.x),
                            y: o.y - h * (r.y - a.y)
                        },
                        next: {
                            x: o.x + c * (r.x - a.x),
                            y: o.y + c * (r.y - a.y)
                        }
                    }
                }, ut.EPSILON = Number.EPSILON || 1e-14, ut.splineCurveMonotone = function(t) {
                    var e, i, n, a, o, r, s, l, d, u = (t || []).map(function(t) {
                            return {
                                model: t._model,
                                deltaK: 0,
                                mK: 0
                            }
                        }),
                        h = u.length;
                    for (e = 0; e < h; ++e)
                        if (!(n = u[e]).model.skip) {
                            if (i = e > 0 ? u[e - 1] : null, (a = e < h - 1 ? u[e + 1] : null) && !a.model.skip) {
                                var c = a.model.x - n.model.x;
                                n.deltaK = 0 !== c ? (a.model.y - n.model.y) / c : 0
                            }!i || i.model.skip ? n.mK = n.deltaK : !a || a.model.skip ? n.mK = i.deltaK : this.sign(i.deltaK) !== this.sign(n.deltaK) ? n.mK = 0 : n.mK = (i.deltaK + n.deltaK) / 2
                        } for (e = 0; e < h - 1; ++e) n = u[e], a = u[e + 1], n.model.skip || a.model.skip || (ut.almostEquals(n.deltaK, 0, this.EPSILON) ? n.mK = a.mK = 0 : (o = n.mK / n.deltaK, r = a.mK / n.deltaK, (l = Math.pow(o, 2) + Math.pow(r, 2)) <= 9 || (s = 3 / Math.sqrt(l), n.mK = o * s * n.deltaK, a.mK = r * s * n.deltaK)));
                    for (e = 0; e < h; ++e)(n = u[e]).model.skip || (i = e > 0 ? u[e - 1] : null, a = e < h - 1 ? u[e + 1] : null, i && !i.model.skip && (d = (n.model.x - i.model.x) / 3, n.model.controlPointPreviousX = n.model.x - d, n.model.controlPointPreviousY = n.model.y - d * n.mK), a && !a.model.skip && (d = (a.model.x - n.model.x) / 3, n.model.controlPointNextX = n.model.x + d, n.model.controlPointNextY = n.model.y + d * n.mK))
                }, ut.nextItem = function(t, e, i) {
                    return i ? e >= t.length - 1 ? t[0] : t[e + 1] : e >= t.length - 1 ? t[t.length - 1] : t[e + 1]
                }, ut.previousItem = function(t, e, i) {
                    return i ? e <= 0 ? t[t.length - 1] : t[e - 1] : e <= 0 ? t[0] : t[e - 1]
                }, ut.niceNum = function(t, e) {
                    var i = Math.floor(ut.log10(t)),
                        n = t / Math.pow(10, i);
                    return (e ? n < 1.5 ? 1 : n < 3 ? 2 : n < 7 ? 5 : 10 : n <= 1 ? 1 : n <= 2 ? 2 : n <= 5 ? 5 : 10) * Math.pow(10, i)
                }, ut.requestAnimFrame = "undefined" == typeof window ? function(t) {
                    t()
                } : window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(t) {
                    return window.setTimeout(t, 1e3 / 60)
                }, ut.getRelativePosition = function(t, e) {
                    var i, n, a = t.originalEvent || t,
                        o = t.target || t.srcElement,
                        r = o.getBoundingClientRect(),
                        s = a.touches;
                    s && s.length > 0 ? (i = s[0].clientX, n = s[0].clientY) : (i = a.clientX, n = a.clientY);
                    var l = parseFloat(ut.getStyle(o, "padding-left")),
                        d = parseFloat(ut.getStyle(o, "padding-top")),
                        u = parseFloat(ut.getStyle(o, "padding-right")),
                        h = parseFloat(ut.getStyle(o, "padding-bottom")),
                        c = r.right - r.left - l - u,
                        f = r.bottom - r.top - d - h;
                    return {
                        x: i = Math.round((i - r.left - l) / c * o.width / e.currentDevicePixelRatio),
                        y: n = Math.round((n - r.top - d) / f * o.height / e.currentDevicePixelRatio)
                    }
                }, ut.getConstraintWidth = function(t) {
                    return i(t, "max-width", "clientWidth")
                }, ut.getConstraintHeight = function(t) {
                    return i(t, "max-height", "clientHeight")
                }, ut._calculatePadding = function(t, e, i) {
                    return (e = ut.getStyle(t, e)).indexOf("%") > -1 ? i * parseInt(e, 10) / 100 : parseInt(e, 10)
                }, ut._getParentNode = function(t) {
                    var e = t.parentNode;
                    return e && "[object ShadowRoot]" === e.toString() && (e = e.host), e
                }, ut.getMaximumWidth = function(t) {
                    var e = ut._getParentNode(t);
                    if (!e) return t.clientWidth;
                    var i = e.clientWidth,
                        n = i - ut._calculatePadding(e, "padding-left", i) - ut._calculatePadding(e, "padding-right", i),
                        a = ut.getConstraintWidth(t);
                    return isNaN(a) ? n : Math.min(n, a)
                }, ut.getMaximumHeight = function(t) {
                    var e = ut._getParentNode(t);
                    if (!e) return t.clientHeight;
                    var i = e.clientHeight,
                        n = i - ut._calculatePadding(e, "padding-top", i) - ut._calculatePadding(e, "padding-bottom", i),
                        a = ut.getConstraintHeight(t);
                    return isNaN(a) ? n : Math.min(n, a)
                }, ut.getStyle = function(t, e) {
                    return t.currentStyle ? t.currentStyle[e] : document.defaultView.getComputedStyle(t, null).getPropertyValue(e)
                }, ut.retinaScale = function(t, e) {
                    var i = t.currentDevicePixelRatio = e || "undefined" != typeof window && window.devicePixelRatio || 1;
                    if (1 !== i) {
                        var n = t.canvas,
                            a = t.height,
                            o = t.width;
                        n.height = a * i, n.width = o * i, t.ctx.scale(i, i), n.style.height || n.style.width || (n.style.height = a + "px", n.style.width = o + "px")
                    }
                }, ut.fontString = function(t, e, i) {
                    return e + " " + t + "px " + i
                }, ut.longestText = function(t, e, i, n) {
                    var a = (n = n || {}).data = n.data || {},
                        o = n.garbageCollect = n.garbageCollect || [];
                    n.font !== e && (a = n.data = {}, o = n.garbageCollect = [], n.font = e), t.font = e;
                    var r = 0;
                    ut.each(i, function(e) {
                        null != e && !0 !== ut.isArray(e) ? r = ut.measureText(t, a, o, r, e) : ut.isArray(e) && ut.each(e, function(e) {
                            null == e || ut.isArray(e) || (r = ut.measureText(t, a, o, r, e))
                        })
                    });
                    var s = o.length / 2;
                    if (s > i.length) {
                        for (var l = 0; l < s; l++) delete a[o[l]];
                        o.splice(0, s)
                    }
                    return r
                }, ut.measureText = function(t, e, i, n, a) {
                    var o = e[a];
                    return o || (o = e[a] = t.measureText(a).width, i.push(a)), o > n && (n = o), n
                }, ut.numberOfLabelLines = function(t) {
                    var e = 1;
                    return ut.each(t, function(t) {
                        ut.isArray(t) && t.length > e && (e = t.length)
                    }), e
                }, ut.color = X ? function(t) {
                    return t instanceof CanvasGradient && (t = st.global.defaultColor), X(t)
                } : function(t) {
                    return console.error("Color.js not found!"), t
                }, ut.getHoverColor = function(t) {
                    return t instanceof CanvasPattern || t instanceof CanvasGradient ? t : ut.color(t).saturate(.5).darken(.1).rgbString()
                }
            }(), ai._adapters = si, ai.Animation = vt, ai.animationService = bt, ai.controllers = ue, ai.DatasetController = Mt, ai.defaults = st, ai.Element = pt, ai.elements = Wt, ai.Interaction = ve, ai.layouts = ke, ai.platform = Ve, ai.plugins = Ee, ai.Scale = fi, ai.scaleService = He, ai.Ticks = li, ai.Tooltip = Je, ai.helpers.each(tn, function(t, e) {
                ai.scaleService.registerScaleType(e, t, t._defaults)
            }), yn) yn.hasOwnProperty(_n) && ai.plugins.register(yn[_n]);
    ai.platform.initialize();
    var Cn = ai;
    return "undefined" != typeof window && (window.Chart = ai), ai.Chart = ai, ai.Legend = yn.legend._element, ai.Title = yn.title._element, ai.pluginService = ai.plugins, ai.PluginBase = ai.Element.extend({}), ai.canvasHelpers = ai.helpers.canvas, ai.layoutService = ai.layouts, ai.LinearScaleBase = bi, ai.helpers.each(["Bar", "Bubble", "Doughnut", "Line", "PolarArea", "Radar", "Scatter"], function(t) {
        ai[t] = function(e, i) {
            return new ai(e, ai.helpers.merge(i || {}, {
                type: t.charAt(0).toLowerCase() + t.slice(1)
            }))
        }
    }), Cn
});