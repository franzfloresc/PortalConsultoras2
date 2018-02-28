/* ---------------------------------------------------------------------- */
/*	Load Google Fonts
/* ---------------------------------------------------------------------- */

/* end Google Fonts */

/************************************************************************/
/* DOM READY --> Begin													*/
/************************************************************************/

jQuery(document).ready(function ($) {
    /* ---------------------------------------------------------------------- */
    /*	Top Toggle Panel
	/* ---------------------------------------------------------------------- */

    (function () {

        var $html = $('.panel-entry').animate({ opacity: "0" }, 200);

        $('.toggle').click(function (e) {
            var $target = $(e.target);
            $html.animate({ opacity: "0" }, 0);
            $('.panel').slideToggle('1000', "linear", function () {
                $html.animate({ opacity: "1" }, 200);
                $('.toggle').toggleClass('hide');
            }
			);
            return false;
        });

    })();
    /* end top toggle panel */

    /* ---------------------------------------------------------------------- */
    /*	For Touch device
	/* ---------------------------------------------------------------------- */

    (function () {

        if (Modernizr.touchevents)
            $('body').addClass('touch-device');

    })();
    /* end Detect touch device */

    /* ---------------------------------------------------------------------- */
    /*	Main Navigation
	/* ---------------------------------------------------------------------- */

    (function () {

        var arrowimages = {
            down: 'downarrowclass',
            right: 'rightarrowclass'
        };

        var $mainNav = $('#navigation').children('ul'),
			optionsList = '<option value="" selected>Navegar</option>';

        var $submenu = $mainNav.find("ul").parent();
        $submenu.each(function (i) {
            var $curobj = $(this);
            this.istopheader = $curobj.parents("ul").length == 1 ? true : false;
            $curobj.children("a").append('<span class="' + (this.istopheader ? arrowimages.down : arrowimages.right) + '"></span>');
        });

        $mainNav.on('mouseenter', 'li', function () {
            var $this = $(this),
				$subMenu = $this.children('ul');
            if ($subMenu.length) $this.addClass('hover');
            $subMenu.hide().stop(true, true).fadeIn(200);
        }).on('mouseleave', 'li', function () {
            $(this).removeClass('hover').children('ul').stop(true, true).fadeOut(50);
        });

        if (navigator.platform == "iPad" || navigator.platform == 'iPhone') {

            $('#navigation a').each(function () {

                var clicked = false;

                $(this).bind('click', function () {

                    if (!clicked) return !(clicked = true);
                });
            });
        }

        // Navigation Responsive

        $mainNav.find('li').each(function () {
            var $this = $(this),
				$anchor = $this.children('a'),
				depth = $this.parents('ul').length - 1,
				dash = '';

            if (depth) {
                while (depth > 0) {
                    dash += '--';
                    depth--;
                }
            }

            optionsList += '<option value="' + $anchor.attr('href') + '">' + dash + ' ' + $anchor.text() + '</option>';

        }).end()
			.after('<select class="nav-responsive">' + optionsList + '</select>');

        $('.nav-responsive').on('change', function () {
            window.location = $(this).val();
        });

    })();
    /* end Main Navigation */

    /* ---------------------------------------------------------------------- */
    /*	TransBanner - Armar el Slide dinamicamente
	/* ---------------------------------------------------------------------- */

    (function () {
    })();
    /* end TransBanner */

    /* ---------------------------------------------------------------------- */
    /*	Flex Slider
	/* ---------------------------------------------------------------------- */

    (function () {

        if ($('#slider').length) {
            $(window).load(function () {
                $('#slider').flexslider({
                    directionNav: false
                });
            });
        }

    })();
    /* end Flex Slider */


    /* ---------------------------------------------------- */
    /*	Min. Height
	/* ---------------------------------------------------- */

    (function () {

        $('section.container')
			.css('min-height', $(window).outerHeight(true)
				- $('#header').outerHeight(true)
				- $('.page-title').outerHeight(true)
				- $('.page-header').outerHeight(true)
				- $('#footer').outerHeight(true));

    })();

    /* end Min. Height */
    
    /* ---------------------------------------------------- */
    /*	Content Toggle
	/* ---------------------------------------------------- */

    (function () {

        if ($('.toggle-container').length) {
            $(".toggle-container").hide();
            //Hide (Collapse) the toggle containers on load
            //Switch the "Open" and "Close" state per click then slide up/down (depending on open/close state)
            $(".trigger").click(function () {
                $(this).toggleClass("active").next().slideToggle("slow");
                return false; //Prevent the browser jump to the link anchor
            });
        }

    })();

    /* end Content Toggle */

    /* ---------------------------------------------------------------------- */
    /*	Accordion Content
	/* ---------------------------------------------------------------------- */

    (function () {

        if ($('.acc-container').length) {

            var $container = $('.acc-container'),
				$trigger = $('.acc-trigger');

            $container.hide();
            $trigger.first().addClass('active').next().show();

            var fullWidth = $container.outerWidth(true);
            $trigger.css('width', fullWidth);
            $container.css('width', fullWidth + 2);

            $trigger.on('click', function (e) {
                if ($(this).next().is(':hidden')) {
                    $trigger.removeClass('active').next().slideUp(300);
                    $(this).toggleClass('active').next().slideDown(300);
                }
                e.preventDefault();
            });
            
            $(window).on('resize', function () {
                fullWidth = $container.outerWidth(true)
                $trigger.css('width', $trigger.parent().width());
                $container.css('width', $container.parent().width() + 2);
            });
        }

    })();

    /* end Accordion Content */

    /* ---------------------------------------------------- */
    /*	Back to Top
	/* ---------------------------------------------------- */

    (function () {

        var extend = {
            button: '#back-top',
            bt: '.divider-top a',
            text: 'Back to Top',
            min: 200,
            fadeIn: 400,
            fadeOut: 400,
            speed: 800,
            easing: 'easeOutQuint'
        }
			,
			oldiOS = false,
			oldAndroid = false;

        // Detect if older iOS device, which doesn't support fixed position
        if (/(iPhone|iPod|iPad)\sOS\s[0-4][_\d]+/i.test(navigator.userAgent))
            oldiOS = true;

        // Detect if older Android device, which doesn't support fixed position
        if (/Android\s+([0-2][\.\d]+)/i.test(navigator.userAgent))
            oldAndroid = true;

        $('body').append('<a href="#" id="' + extend.button.substring(1) + '" title="' + extend.text + '">' + extend.text + '</a>');

        $(window).scroll(function () {
            var pos = $(window).scrollTop();

            if (oldiOS || oldAndroid) {
                $(settings.button).css({
                    'position': 'absolute',
                    'top': pos + $(window).height()
                });
            }

            if (pos > extend.min)
                $(extend.button).fadeIn(extend.fadeIn);
            else
                $(extend.button).fadeOut(extend.fadeOut);
        });

        $(extend.button).add(extend.bt).click(function (e) {
            $('html, body').animate({ scrollTop: 0 }, extend.speed, extend.easing);
            e.preventDefault();
        });

    })();

    /* end Back to Top */

    /************************************************************************/
});/* DOM READY --> End													*/
/************************************************************************/
