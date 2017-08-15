/*
	Translucent - Responsive Banner Rotator / Slider
 	Copyright (c) 2011-12 Ramesh Kumar
	http://codecanyon.net/user/VF
	
	Version: 1.4.1 
	Created: 15 NOV 2011
	Updated: 22 MAY 2012
	
	Built using:
	jQuery				version: 1.7.1	http://jquery.com/
	jQuery Easing 		version: 1.3	http://gsgd.co.uk/sandbox/jquery/easing/
	StackBoxBlur		version: 0.3	http://www.quasimondo.com/BoxBlurForCanvas
	getImageData 		version: 0.3	http://www.maxnov.com/getimagedata
		
*/

(function($, window, document) {
	
	/*=============================================================================
		Default settings:
		For detailed description of individual parameters, see the help document
	===============================================================================*/
	var defaults = {
		slide_autoplay				: true,
		slide_delaytime				: 5,
		slide_transition			: 1,
		slide_transition_period		: 800,
		slide_preload_images		: 1,
		slide_random_order			: false,
		
		image_align_center			: true,
		image_resize				: true,
		image_resize_to_fit			: false,
		
		navigation_type				: 1,
		
		button_size					: 20,
		button_size_touch_device	: 28,
		button_margin				: 4,
		button_opacity				: .7,
		button_space				: 2,
		button_color				: '#FFFFFF',
		
		button_show_next			: true,
		button_show_back			: false,
		button_show_timer			: true,
		button_show_numbers			: true,			
		button_numbers_autohide		: true,
		button_numbers_horizontal	: false,	
		
		dot_button_size				: 14,
		dot_button_space			: 6,
		dot_button_margin			: 10,
		dot_button_dark				: false,
		dot_button_bg_blur			: true,
		dot_button_bg_padding		: 8,
			
		caption_float_mode			: false,
		caption_bg_blur				: 12,
		caption_padding_x			: 24,
		caption_padding_y			: 12,
		caption_margin_x			: 0,
		caption_margin_y			: 0,
			
		caption_position_x			: 50,
		caption_position_y			: 100,
		caption_width				: 300,
		caption_height				: '',
		caption_bg_color			: '#FFFFFF',
		caption_bg_opacity			: .08,
		caption_bg_radius			: 6,
		caption_bg_shadow			: .1,			
		caption_border				: 1,
		caption_border_color		: '#FFFFFF',
		caption_border_opacity		: .35,
		caption_allow_selection		: false,
		
		mouse_drag					: true,		
		touch_swipe					: true,		
		touch_dragdrop_factor		: 60,
		touch_throw_factor			: 5,
			
		responsive						: true,		
		responsive_limit_autoplay		: '',
		responsive_limit_caption		: 480,
		responsive_limit_navigation		: 480,
		responsive_limit_navigation_type: 2,
		responsive_screen_based_limits	: false
	}
	
	function TBMain (container, options, instanceID){
		
		var self = this;
		var s = this.sett = $.extend({}, defaults, options);
		this.instanceID = instanceID;
		
		//Get Slides
		this.$cont = container;
		this.$children = this.$cont.find('.Slide');	
		
		//Randomize slides if opted
		if (s.slide_random_order) {
			this.shuffle (this.$children);
		}

		//Check if max-width set
		this.maxW = this.$cont.css('max-width');
		if (this.maxW.indexOf ('%')<0) {
			this.maxW = parseInt(this.maxW);
		} else {
			this.maxW = false;
		}
		
		//Measure width and height of banner
		this.bW = this.$cont.width();
		this.oH = parseInt(this.$cont.css('height'));
		this.ratio = (this.maxW || this.bW)/this.oH; 
		this.bH = this.getHeight();	
		
		//Get browser and feature support details
		this.FF2 = $.browser.mozilla && parseFloat($.browser.version, 10) < 1.9 ? true : false;
		this.IE8 = $.browser.msie && parseInt($.browser.version, 10) <= 8 ? true : false;
		this.canvasSupport = !!document.createElement('canvas').getContext;
		this.touchDevice = 'ontouchstart' in window;
		
		//Initiate variables for inner operation
		this.slides = [];
		this.slide_tot = this.$children.length;
		this.slide_dir = -1;
		this.slide_sel = 0;
		this.slide_pr1 = '';
		this.slide_pr2 = '';
		this.slide_fin = false;
		this.slide_drg = false;	
		this.slide_sta = true;
		
		this.clockDraw;		
		this.clockContext;
		this.clockStart;
		this.clockDiff = 0;
		this.clockTimer = s.button_show_timer;
		this.clockPlaying = false;
		
		this.buttonNext = s.button_show_next;
		this.buttonBack = s.button_show_back;
		this.buttonNumber = s.button_show_numbers;

		this.buttonIE = this.IE8? 1 : 0;	
		this.buttonLeaveTimer;
		this.navHolder;
		
		this.draggable = ((this.touchDevice && s.touch_swipe) || (!this.touchDevice && s.mouse_drag))? true : false;
		this.dragged = false;
		this.numShow = false;
		this.moved = 0;
		
		this.timerob = $('<div style="position: absolute;"></div>');
		this.regxHost = new RegExp('^(?:f|ht)tp(?:s)?\://([^/]+)', 'im');
		
		if (this.touchDevice){
			this.downEvent 	= 'touchstart';
			this.upEvent 	= 'touchend';
			this.moveEvent 	= 'touchmove';
		} else {
			this.downEvent 	= 'mousedown';
			this.upEvent 	= 'mouseup';
			this.moveEvent 	= 'mousemove';
		}		
		this.dotButtonBlurBG = false;
		
		//Verify and format transition type value
		var transitions = ['move', 'fade', 'slideIn', 'slideOut'];
		if (s.slide_transition < 1 || isNaN(s.slide_transition)) {
			s.slide_transition = 1;
			
		} else if (s.slide_transition > transitions.length){
			 s.slide_transition = transitions.length;
		}
		s.slide_transition = transitions[s.slide_transition-1];
		
		//Make sure some logics / limits maintained on settings
		if (s.caption_margin_y == 0 && !s.caption_float_mode) {
			s.caption_bg_radius = 0;
		}
		if (s.button_show_numbers && !s.button_show_next) {
			s.button_numbers_autohide = false;
		}
		if (s.navigation_type <1) {
			s.navigation_type = 1;
		} else if (s.navigation_type >3) {
			s.navigation_type = 3;
		}
		if (s.responsive_limit_navigation_type <1) {
			s.responsive_limit_navigation_type = 1;
		} else if (s.responsive_limit_navigation_type >3) {
			s.responsive_limit_navigation_type = 3;
		}
		if (s.responsive_limit_navigation_type == '' || (s.navigation_type >1 && s.responsive_limit_navigation_type === 1)) {
			s.responsive_limit_navigation_type = s.navigation_type;
		}	
		if (this.touchDevice) {
			s.button_size = Math.max(s.button_size, s.button_size_touch_device);
		}
		
		//Icon sprite dimenions (note: if somewhere this.icOff gets multiplied with .5 that means icon aligned center)
		this.icSize = 60;
		this.icOff = s.button_size >26? this.icSize*4 : 0;
		if (s.dot_button_dark) {
			this.icDotOff = -this.icSize*(11 + .5) + ((s.dot_button_size+s.dot_button_space)/2);
		} else {
			this.icDotOff = -this.icSize*(8 + .5) + ((s.dot_button_size+s.dot_button_space)/2);	
		}			
		
		//Shadow style with vendor prefix
		if ($.browser.webkit) {
			this.shProp = '-webkit-box-shadow';
		} else if ($.browser.mozilla && this.$cont.css('box-shadow') != 'none') {
			this.shProp = '-moz-box-shadow';
		} else {	
			this.shProp = 'box-shadow';
		}			
		
		//Device specific optimisation
		this.blurIteration = this.touchDevice ? 1 : 2;		
		this.enableCaption	= (s.responsive && this.checkLimit(s.responsive_limit_caption, false)) ? false : true;		
		this.currentNav		= (s.responsive && this.checkLimit(s.responsive_limit_navigation, false)) ? s.responsive_limit_navigation_type : s.navigation_type;
		this.autoPlaying	= (s.responsive && this.checkLimit(s.responsive_limit_autoplay, false)) ? false : s.slide_autoplay;
		
		//Collect main & icon image paths to begin preload
		var regx=/url\(["']?([^'")]+)['"]?\)/;
		var temp = $('<div class="icon"></div>').appendTo(this.$cont);	
		this.icons = $('.icon').css("background-image").replace(regx,'$1');
		this.imgList = [
			{src: this.icons, loaded: false}, //Icon image
			{src: this.$children.eq(0).find('img').attr('src'), loaded: false} // 1st Slide's image
		];
		for (var i=1; i< Math.min(s.slide_preload_images, this.slide_tot); i++){				
			this.imgList.push({src:this.$children.eq(i).find('img').attr('src'), loaded: false});
		}
		this.timer_sprite = this.canvasSupport || temp.addClass('timer_sprite').css("background-image").replace(regx,'$1');
		temp.remove();
						
		//Check load status of 1st image and Navigation icons. After preloading, the banner initiated.
		$.each(this.imgList, function (i){
			var _img = new Image();	
			$(_img)
			.bind('load', {id:i, self: self}, self.loadComplete)
			.bind('error', {id:i, self: self}, self.loadComplete);
			_img.src = self.imgList[i].src;	
		});
		
	}

	TBMain.prototype = {
		
		/*On each image load complete with preload process
		=====================================================================================================================*/	
		loadComplete: function (e) {
			var self = e.data.self,
			complete = true;
			
			self.imgList[e.data.id].loaded = true;					
			for (var j=0; j<self.imgList.length; j++){				
				if (!self.imgList[j].loaded) {
					 complete = false;
				}
			}
			if (complete) {
				self.init();
			}
		},	
		
		
		/*Initialise Slideshow / gather data
		=====================================================================================================================*/	
		init: function (){		
			var self = this,
				s = self.sett,				
				shadowVal = '0px 0px 6px '+($.browser.webkit && parseInt($.browser.version, 10) < 533 ? '' : '0px ')+'rgba(0, 0, 0, ',
				caption = self.$children.find('div')[0],
				canvas, div, img, txt, capCont, txtCont, capBGSh, bordRadius, capBG, capBGOp, color, border;
			
			self.blurIE = Math.max((s.caption_bg_blur/3), 3);
			
			//Find navigation width
			var buttonSeries = 0;
			if (s.button_show_next) buttonSeries++;
			if (s.button_show_back) buttonSeries++;
			if (s.button_show_timer) buttonSeries++;
			if (s.button_numbers_horizontal && !s.button_numbers_autohide) buttonSeries += self.slide_tot;			
			self.navWidth = buttonSeries*(s.button_size+s.button_space);

			//Generate each slide with caption elements
			for (var i=0; i<self.slide_tot; i++){				
				div = self.$children.eq(i).css({
						'z-index':self.slide_tot-i,
						'visibility': 'visible'
					});
						
				img = div.find('img')
					.attr('galleryimg', 'no')
					.addClass('noSelect');				
				
				if (!caption && s.navigation_type == 2 && s.dot_button_bg_blur  && s.dot_button_margin>-1)	{
					self.dotButtonBlurBG = true;
					self.sett.caption_float_mode = true;
					self.updateFloatSettings();					
					txt = $('<div>');
					div.append(txt);
				} else {
					txt = div.find('div');	
				}
				
				//Store each slide's data
				self.slides.push({
					src: img.attr('src'),
					scale: 1, 
					ox: "",
					oy: "", 
					con: div, 
					img: img, 
					txt: txt[0] ? txt : false, 
					loaded: false, 
					butt: "",
					z: self.slide_tot-i, 
					delay: (div.data('delay') || s.slide_delaytime)*1000,
					pd: div.data('position'),
					wd: div.data('width'),
					hd: div.data('height')					
				});	
				
				//If Caption exists for slide										
				if (txt[0]){					
					txt.css({
						left: s.caption_padding_x,
						top: s.caption_padding_y,
						'display': 'none'
					})
					.wrapInner($('<span></span>')
					.css('opacity', .99));
						
					if (s.caption_allow_selection){
						txt.bind('mousedown', function (e){
							e.stopImmediatePropagation();					
						});													
					} else {
						txt.addClass('noSelect')
							.attr('unselectable', 'on');
					}
											
					capCont = $('<div style="z-index: 3; position: absolute; bottom: '+s.caption_margin_y+'px; '+(self.dotButtonBlurBG ? '' : 'display: none')+';">\
									<div class="txtCont"></div>\
								</div>');
												
					$.extend(self.slides[i], {
						cap: capCont, 
						txtCont: capCont.find('.txtCont')	
					});	
					
					capBGSh = div.data('caption_bg_shadow') || s.caption_bg_shadow;
					bordRadius = '-moz-border-radius: '+s.caption_bg_radius+'px; -webkit-border-radius: '+s.caption_bg_radius+'px; border-radius: '+s.caption_bg_radius+'px; -khtml-border-radius: '+s.caption_bg_radius+'px;';
					
					//Text BG blur effect
					if (s.caption_bg_blur > 0){
						if (self.IE8){	
							canvas = $(	'<div class="captionCanvas" style="z-index:1; overflow:hidden;">\
											<div style="position:absolute; z-index:2; top:'+(-(s.caption_bg_blur)*2)+'px; left:'+(-(s.caption_bg_blur*2))+'px; -ms-filter: progid:DXImageTransform.Microsoft.blur(pixelradius='+s.caption_bg_blur+'); filter: progid:DXImageTransform.Microsoft.blur(pixelradius='+s.caption_bg_blur+');">\
												<img src="'+img.attr('src')+'" style="position:absolute;" />\
											</div>\
										</div>');
														
							if (s.caption_margin_y <= s.caption_bg_blur/2 && !s.caption_float_mode) {
								canvas.append(	'<div class=".TBinner" style="z-index:1; position:absolute; top:'+(-(self.blurIE)*2)+'px; left:'+(-(self.blurIE*2))+'px; -ms-filter: progid:DXImageTransform.Microsoft.blur(pixelradius='+self.blurIE+'); filter: progid:DXImageTransform.Microsoft.blur(pixelradius='+self.blurIE+');">\
													<img src="'+img.attr('src')+'" style="position:absolute;" />\
												</div>');
							}
						} else {
							if (!self.FF2) {
								canvas = $('<canvas class="captionCanvas" style="'+bordRadius+'"></canvas>' );
							}
						}
					}  else {
						if (capBGSh>0 && !self.FF2) {
							canvas = $('<div class="captionCanvas" style="'+bordRadius+'"></div>' );
						}
					}
					
					//Text BG color with transparency
					capBG = div.data('caption_bg_color') || s.caption_bg_color;
					capBGOp = div.data('caption_bg_opacity') || s.caption_bg_opacity;
					
					color = $('<div class="captionCanvas" style="z-index:2; background-color:'+capBG+';'+bordRadius+'"></div>')
					.css('opacity', capBGOp);
					
					//Text BG Border
					if (s.caption_border) {
						border = $('<div class="captionCanvas" style="z-index:3; border:'+s.caption_border+'px solid '+s.caption_border_color+';'+bordRadius+'"></div>')
						.css('opacity', s.caption_border_opacity);
					}
					
					//Text BG Shadow			
					if (capBGSh>0 && !self.FF2) {
						canvas.css(self.shProp, (shadowVal+capBGSh+')'));	
					}
					
					capCont
					.append(canvas)
					.append(color)
					.append(border);
					
					self.slides[i].txtCont.append(txt);
					div.append(capCont);	
									
					self.slides[i].bord = border;
					self.slides[i].col = color;	
					self.slides[i].can = canvas;
				}				
				div.hide().bind(self.downEvent, {id:i, self: self}, self.startDrag);
			}				
			
			//First image already loaded, so prepare the blurred version and display it
			self.imageLoad(0);
			
			//Check load status of remaining images
			for (var i=1; i<self.slide_tot; i++){
				var _img = new Image();
				self.slides[i].img.hide();
				$(_img).bind('load', {id:i, self: self}, self.imageLoad);
				_img.src = self.slides[i].src;	
			}	

			//Manage Links when slide dragged
			if (self.draggable) {
				var aHrefs = self.$cont.find('a');
				
				aHrefs.each(function() {
					var a = $(this);				
					a.bind('click', {l:a.attr('href'), t:a.attr('target')}, function (e){
						e.stopImmediatePropagation();	
						e.preventDefault();				
						if (!self.slide_drg) {
							$(document).unbind('.TransBannerDrag_'+self.instanceID);
							window.open(e.data.l, e.data.t? e.data.t.toLowerCase() : "_self");										
						} else {
							self.slide_drg = false;
						}
						return false;
						
					});
					if (a.find('img').length <1) {
						a.bind('mousedown', function (e){	
							e.preventDefault();
							return false;						
						});
					}							
				});	
			}
			
			if (s.responsive) {
				$(window).bind('resize', function (e){
					self.blurIteration = 1;
					self.resizeBanner({internal: true});
				});
			}
		},
		
		
		/*On each image load completion (main slide image)
		=====================================================================================================================*/
		imageLoad: function (e){
			var self, id;
			
			if (e.data) {
				self = e.data.self;
				id = e.data.id;			
			} else {
				self = this;
				id = e;	
			}		
			
			//Store original image dimensions
			self.slides[id].imgW = self.slides[id].img[0].width;
			self.slides[id].imgH = self.slides[id].img[0].height;
			
			self.resizeImage (id);
			
			if (self.slides[id].txt){
				 self.updateText (id);	
			}
			
			if (!self.IE8 && !self.FF2 && self.sett.caption_bg_blur>0 && self.slides[id].txt) {			
   				self.createBlur (id, true);
			} else {
				self.showSlide (id);
			}
		},
		
		
		/*Resize the image. Called for each slide/image when browser resized or external 'resizeBanner' method called
		=====================================================================================================================*/
		resizeImage: function (id){
			var self = this,
				s = self.sett,
				sl = self.slides,
				w,h;
				
			if (s.image_resize){										
				sl[id].scale = self.bW/sl[id].imgW;					
				if ((sl[id].scale*sl[id].imgH<=self.bH && !s.image_resize_to_fit) || (sl[id].scale*sl[id].imgH>=self.bH && s.image_resize_to_fit)){												
					sl[id].scale = self.bH/sl[id].imgH;				
					sl[id].img.height(self.bH);	
					sl[id].img.width(sl[id].imgW*sl[id].scale);				
					w = sl[id].imgW*sl[id].scale;
					h = self.bH	;					
													
				} else {
					sl[id].img.width(self.bW);	
					sl[id].img.height(sl[id].imgH*sl[id].scale);					
					w = self.bW;
					h = sl[id].imgH*sl[id].scale;								
				}
				if (s.image_align_center) self.alignCenter(id);
				if (self.IE8) $(sl[id].can).find('img').each(function (){
					this.width = w;
					this.height = h;							
				});
			} else if(s.image_align_center) {
				self.alignCenter(id);
			}
		},		
		

		/*Relocate the image to center it horizontally and vertically
		=====================================================================================================================*/		
		alignCenter: function (id){	
			this.slides[id].ox = (this.bW-(this.slides[id].imgW*this.slides[id].scale))/2;
			this.slides[id].oy = (this.bH-(this.slides[id].imgH*this.slides[id].scale))/2;
			this.slides[id].img.css({
				'left': this.slides[id].ox,
				'top': this.slides[id].oy
			});	
		},
		
		
		/*Decide which way the blur effect needs to be added (use getImageData plugin if the image located outside domain)
		=====================================================================================================================*/		
		createBlur: function (id, show){
			var self = this,
				sl = self.slides[id],
				host = self.getHostName(sl.src);	
						
			if (host && host !== document.domain){
				$.getImageData({
					url: sl.src,
					success: function (image){						
						stackBoxBlurImage(image, sl.cx, sl.cy, sl.cw, sl.ch, sl.scale, sl.ox, sl.oy, sl.can[0], self.sett.caption_bg_blur, false, self.blurIteration);
						if (show) {
							self.showSlide (id);
						}
					},
					error: function(xhr, text_status){
						if (show) {
							self.showSlide (id);
						}			
					}
				});
				
			} else {
				stackBoxBlurImage(sl.img[0], sl.cx, sl.cy, sl.cw, sl.ch, sl.scale, sl.ox, sl.oy, sl.can[0], self.sett.caption_bg_blur, false, self.blurIteration);
				if (show) {
					self.showSlide (id);
				}			
			}
		},		


		/*Start showing the slide (image+caption) after image load and/or blur effect added
		=====================================================================================================================*/	
		showSlide: function (id){		
			this.slides[id].con.css('background-image','none');
			this.slides[id].loaded = true;
						
			//Show the slide if this is currently selected slide
			if (id == this.slide_sel){
				this.slides[id].img.fadeIn(400);						
			} else {
				this.slides[id].img.show();
			}
			
			//If it is 1st slide, start transition and add navigation
			if (id == 0){				
				this[this.sett.slide_transition] ();
				if (this.sett.button_show_next || this.sett.button_show_back || this.sett.button_show_timer || this.sett.button_show_numbers) {
					this.setNavigation ();
				}				
			}
		},
		
		
		/*Get current document's domain name
		=====================================================================================================================*/
		getHostName: function (url){			
			var op = url.match(this.regxHost);
			if (op !== null ){
				return op[1].toString();	
			} else {
				return false;
			}
		},
		
		
		/*For Dot navigation - Adjusts background blur settings so that it covers all buttons
		=====================================================================================================================*/
		updateFloatSettings : function (){
			this.sett.caption_position_x = ((this.bW-((this.sett.dot_button_size + this.sett.dot_button_space)*this.slide_tot)+ this.sett.dot_button_space)/2)- this.sett.dot_button_bg_padding;
			this.sett.caption_position_y = this.bH-this.sett.dot_button_margin-(this.sett.dot_button_bg_padding*2)-this.sett.dot_button_size;
			this.sett.caption_width = ((this.sett.dot_button_size + this.sett.dot_button_space)*this.slide_tot)-this.sett.dot_button_space+(this.sett.dot_button_bg_padding*2);
			this.sett.caption_height = this.sett.dot_button_size + this.sett.dot_button_bg_padding*2;
			this.sett.caption_bg_radius = this.sett.caption_height;							
		},
		

		/*Measure and return the height of banner container
		=====================================================================================================================*/	
		getHeight: function (){
			var self = this, bH;
			
			if (!self.sett.responsive) {
				return self.$cont.height();	
			}
			
			if (self.maxW) {
				if (self.bW<self.maxW) {
					bH = self.bW/self.ratio;
				} else {
					bH = self.oH;
				}					
				self.$cont.height(bH);				
			} else {
				if (self.$cont.css('max-width').indexOf ('%')<0) {
					bH =  self.bW/self.ratio;		
					self.$cont.height(bH);
				} else {						
					bH = self.$cont.height();
				}								
			}			
			return Math.max(20, bH);	
		},	
		
		
		/*Verify if given size exceeds certain dimension (screen size or element width)
		=====================================================================================================================*/	
		checkLimit: function (val, forceScreen){
			var varifyWith;
			
			if (val) {
				varifyWith = (this.sett.responsive_screen_based_limits || forceScreen)? Math.max(screen.width, screen.height) : this.bW;
				return (varifyWith <=parseInt(val)? true : false);
			} else {
				return false;
			}
		},	
		

		/*Caption text's width & height needs to be monitored / updated according to banner size
		=====================================================================================================================*/			
		updateText: function(id){		
			
			var self = this,
				s = self.sett,	
				sl = self.slides,	
				div = self.slides[id].con, 
				img = self.slides[id].img, 
				txt = self.slides[id].txt, 
				capCont = self.slides[id].cap, 
				txtCont = self.slides[id].txtCont,
				border = self.slides[id].bord, 
				color = self.slides[id].col, 
				canvas = self.slides[id].can,
				capX, capY, capW, capH,
				pd = self.slides[id].pd,
				wd = self.slides[id].wd,
				hd = self.slides[id].hd,
				descH;				
				
			//If the text should float over the image, find location and size		
			if (s.caption_float_mode){	
				
				//Dot button set's blur bg
				if (self.dotButtonBlurBG) {
					self.updateFloatSettings ();
				}
				
				//Get position from data
				if (pd && !self.dotButtonBlurBG) {
					capX = parseInt(pd.split(',')[0], 10);
					capY = parseInt(pd.split(',')[1], 10);					
				} else {
					capX = s.caption_position_x;
					capY = s.caption_position_y;								
				}				
				
				//Get width
				if (wd && !self.dotButtonBlurBG) {
					capW = parseInt(wd, 10);					
				} else {
					capW = s.caption_width;									
				}
				
				//Adjust position according to width variation
				if (capX == self.maxW-capW) {
					capX = self.bW-capW;
					
				} else if (self.maxW && !self.dotButtonBlurBG) {
					capX *= self.bW/self.maxW;
					capY *= self.bW/self.maxW;				
				}
				
				if (capX+capW+s.caption_margin_x > self.bW) {
					capW = self.bW-capX-s.caption_margin_x;
				}
				
				//Set text element's width (need to set this before height measurement)
				txt.width((capW-(s.caption_padding_x*2)));
				
				//Get height
				if (hd && !self.dotButtonBlurBG) {
					capH = parseInt(hd, 10);					
				} else {
					if (s.caption_height == '') {
						capH = self.getHiddenTextHeight(div,capCont,txt)+(s.caption_padding_y*2);
					} else {
						capH = s.caption_height;
					}							
				}		
				
				if (capY+capH+s.caption_margin_y > self.bH) {
					capH = self.bH-capY-s.caption_margin_y;
				}
				
				//Set height
				txt.height(s.caption_height == '' ? 'auto' : capH);	
					
				capCont.css({
					'left': capX,
					'top': capY,
					'width': capW,
					'height': capH
				});

			} else {			
				capCont.css({
					'left': s.caption_padding_x,
					'width': self.bW-((s.caption_padding_x+s.caption_margin_x)*2)-(self.currentNav >1? 0 : self.navWidth)
				});
				
				txt.width(self.bW-((s.caption_padding_x+s.caption_margin_x)*2)-(self.currentNav >1? 0 : self.navWidth));
				
				descH = Math.min(self.getHiddenTextHeight(div,capCont,txt)+(s.caption_padding_y*2), self.bH-(s.caption_margin_y*2));
				
				capX = s.caption_margin_x;
				capY = self.bH-descH-s.caption_margin_y;
				capW = self.bW-(s.caption_margin_x*2);
				capH = descH;
				txt.width(capW-(self.currentNav >1? 0 : self.navWidth)-(s.caption_padding_x*2));					
				capCont.css({
					'left': capX,
					'width': capW,
					'height': capH
				});				
			}
			
			txtCont.css({
				'width': capW,
				'height': capH
			});			
			var capBGSh = div.data('caption_bg_shadow') || s.caption_bg_shadow;
			
			//Text BG blur effect
			if (s.caption_bg_blur > 0){
				if (self.IE8){	
					canvas.css({
						'width': capW-1,
						'height': capH-1
					});
					canvas.find('div').css({
						'width': capW+(s.caption_bg_blur*2),
						'height': capH+(s.caption_bg_blur*2)
					});					
						
					$(sl[id].can).find('img').each(function (){									
						$(this).css({
							'left': sl[id].ox-capX+(s.caption_bg_blur),
							'top': sl[id].oy-capY+(s.caption_bg_blur/2)
						});	
					});	
					
					if (s.caption_margin_y <= s.caption_bg_blur/2 && !s.caption_float_mode) {
						canvas.find('.TBinner').css({
							'width': capW+(self.blurIE*2),
							'height': capH+(self.blurIE*2)
						})
						.find('img').css({
							'left': -capX+(self.blurIE),
							'top': -capY+(self.blurIE)
						});
					}
				} else {								
					self.createBlur (id, false);
				}
			}  else {
				if (capBGSh>0 && !self.FF2) {
					canvas.css({
						'width': capW,
						'height': capH
					});
				}
			}
			
			//Text BG color with transaprency
			color.css({
				'width': capW,
				'height':capH
			});
			
			//Text BG Border
			if (s.caption_border) {
				border.css({
					'width': capW-(s.caption_border*2),
					'height': capH-(s.caption_border*2)
				});
			}				
			
			$.extend(self.slides[id], {
				cx: capX,
				cy: capY,
				cw: capW,
				ch: capH,
				tx: s.caption_padding_x+capX,
				ty: s.caption_padding_y+capY,
				tw: txt.width()
			});			
		},		
		

		/*If the element hidden, make it visible, measure dimension and then set back to hidden
		=====================================================================================================================*/
		getHiddenTextHeight: function (div,capCont,txt){
			var dispList = [];
			if (div.css('display') == 'none') dispList.push(div.css('display', 'block'));
			if (capCont.css('display') == 'none') dispList.push(capCont.css('display', 'block'));
			if (txt.css('display') == 'none') dispList.push(txt.css('display', 'block'));
			var ht = txt.height();				
			for (var i = 0; i<dispList.length; i++){
				dispList[i].css('display', 'none');
			}
			return ht;
		},
		

		/*Randomize slide order
		=====================================================================================================================*/	
		shuffle: function(ar){
			var rn, tp;
			for (var i = 0; i<ar.length; i++) {
				rn = Math.floor(Math.random()*ar.length);
				tp = ar[i];
				ar[i] = ar[rn];
				ar[rn] = tp;
			}
		},	
		

		/*Slide just started drag/swipe (mousedown / touchstart event) 
		=====================================================================================================================*/			
		startDrag: function (e) {			
			var self = e.data.self,
				id = e.data.id,
				sx = e.pageX || e.originalEvent.changedTouches[0].pageX,
				sy = e.pageY || e.originalEvent.changedTouches[0].pageY;
									
			self.ch = 0,
			self.p = 0;
				
			if (self.currentNav <3 && self.sett.button_numbers_autohide){
				 self.checkDropDown(false, false);
			}
			if (self.buttonNext[0]){
				 self.buttonNext.trigger('mouseout', {self: self, num: 'next', butt: self.buttonNext});
			}
			if (e.type == 'mousedown') {
				e.preventDefault();	
			}			
			if (!self.draggable || self.slide_drg || !self.slide_fin) {
				return;
			}			
			if (self.sett.slide_transition !== 'move'){
				self.slides[id].con.css(self.shProp, '0px 0px 45px 0px #000000');
			}			
			self.slide_drg = false;
			
			$(document).unbind('.TransBannerDrag_'+self.instanceID)
			.bind(self.moveEvent+'.TransBannerDrag_'+self.instanceID, {self: self, id: e.data.id, sx: sx, sy: sy}, self.onDragMove)
			.bind(self.upEvent+'.TransBannerDrag_'+self.instanceID, {self: self, id: e.data.id, sx: sx, sy: sy}, self.onDragUp);
		},
		

		/*Slide drag/swipe completed and now animate the caption
		=====================================================================================================================*/
		dragTransComplete: function (self) {
			self.slide_fin = true;
			self.slide_drg = false;				
			if (self.sett.button_show_numbers && this.currentNav < 3){			
				self.toggleButton (true);
			} else {
				self.timerReset (true);	
			}
			if (self.slides[self.n].txt) {
				if (!self.dotButtonBlurBG) {
					self.slides[self.n].cap.hide();
				}
				if (self.sett.caption_float_mode) {				
					self.slides[self.n].cap.css('left', (self.IE8 || self.dotButtonBlurBG) ? self.slides[self.n].cx : self.slides[self.n].cx+(100*-self.slide_dir));	
				}
			}
			if (self.slides[self.n].txt && self.enableCaption) {				
				self.animateCaption ();						
			}
			if (self.autoPlaying){							
				self.startDelayTimer();
			}			
		},
		
		
		/*Slide drag/swipe on movement (mousemove / touchmove event) 
		=====================================================================================================================*/
		onDragMove: function (e){	
			var self = e.data.self,
			s = self.sett,
			id = e.data.id,
			sx = e.data.sx,
			sy = e.data.sy,
			mouseX;	
			
			//If touch device
			if (self.touchDevice) {
				mouseX = e.originalEvent.changedTouches[0].pageX;
				
				//If multi touch swipe happens instead of single finger, stop dragging or
				//If swipe happens vertically, stop dragging
				if ((e.originalEvent.touches.length>1 || Math.abs(mouseX-sx) < Math.abs(e.originalEvent.changedTouches[0].pageY-sy)/2 ) && !self.slide_drg){
					self.slide_drg = false;
					$(document).unbind('.TransBannerDrag_'+self.instanceID);
					return;			
				}

			} else {
				mouseX = e.pageX;
			}
										
			self.ch = mouseX-self.p;
			self.p = mouseX;			
			self.pos = mouseX-sx;			
			
			if(self.pos>self.bW) {
				self.pos = self.bW;
			}
			if(self.pos<-self.bW) {
				self.pos = -self.bW;
			}
			if (!self.slide_drg) {				
				self.dragFir = self.pos;				
			} else {
				if ((self.dragFir>0 &&  self.pos<0) || (self.dragFir<0 &&  self.pos>0)){
					self.pos = self.dragFir = 0;
					self.slide_drg = false;
				}
			}
			self.n = self.slide_sel+(self.pos>0 ? -1 : 1);				
			if (self.n < 0) {
				self.n = self.slide_tot-1;
			} else if (self.n > self.slide_tot-1) {
				self.n = 0;
			}				
			if (self.slides[self.n].txt && !self.dotButtonBlurBG){
				self.slides[self.n].cap.hide();	
			}
							
			self.slide_pr1 = self.n;
			self.zSort(2,1);				
			if (self.clockPlaying) {
				self.clockPlaying = false;
				self.timerob.stop();
				self.timerReset(true);	
			}						
			if (self.slide_drg && self.pos == 0){
				self.slide_drg = false;
				self.slides[id].con.css('left', 0);
				self.slides[self.n].con.css('left', 0);				
			} else {
				self.slide_drg = true;
				self.slides[id].con.css('left',self.pos);

				self.slides[self.n].con.css('left', (s.slide_transition == 'move' ? self.pos+(self.pos>0?-self.bW : self.bW) : 0));
				self.slides[self.n].con.show();
			}
			e.preventDefault();
			return false;			
		},		
		
		
		/*Slide drag/swipe complete (mouseup / touchend event) 
		=====================================================================================================================*/	
		onDragUp: function (e){
			var self = e.data.self,
				s = self.sett,
				id = e.data.id,
				sx = e.data.sx,
				move = s.slide_transition == 'move';
						
			$(document).unbind('.TransBannerDrag_'+self.instanceID);
			if (self.slide_drg) {
				var dir = 0;
				var cp = self.slides[id].con.position().left;				
				if (cp>  s.touch_dragdrop_factor) {
					dir = 1;
				} else if (cp< -s.touch_dragdrop_factor) {
					dir = -1;
				}
				if (!self.IE8){
					if (self.ch>s.touch_throw_factor) {					
						dir = cp<  0 ? 0 : 1;
					} else if (self.ch<-s.touch_throw_factor) {
						dir = cp> 0 ? 0 : -1;
					}
				}	
				if (dir !== 0) {
					self.dragged = true;
					self.slide_dir =  dir;
					self.slide_fin = false;
					self.slide_sel = self.n;
				}				
				self.slides[id].con.stop()
					.animate({
						'left': (self.bW+(move? 0 : 30))*dir
					},{
						duration: dir == 0 ? 400 : Math.max((self.bW-(self.slides[id].con.position().left*dir))/(move? 1.5 : .75), move? 400 : 600),
						easing: (move || dir == 0)? 'easeOutQuad' : 'easeOutQuart', 
						step: function (now){
							if (move){
								self.slides[self.n].con.css('left', now+(self.pos>0?-self.bW : self.bW));
							}							
					},
					complete: function(){
						if (!move){
							self.slides[id].con.css(self.shProp, 'none');
						}						
						if (dir == 0) {							
							self.slide_drg = false;
							!self.autoPlaying || self.startDelayTimer();
						} else {							
							self.dragTransComplete(self);	
						}
					}
				});							
			}				
			return false;	
		},	
		
		
		/*Find the selected slide before making transition
		=====================================================================================================================*/
		changeSlide: function (n){
			this.slide_pr2 = this.slide_pr1;
			this.slide_pr1 = this.slide_sel;
			this.dragged = false;
						
			//Check if Next or Back or Number button clicked			
			if (n == 'next'){
				this.slide_sel = this.slide_sel+1 > this.slide_tot-1?  0 : this.slide_sel+1;	
			} else if (n == 'back'){
				this.slide_sel = this.slide_sel-1 < 0?  this.slide_tot-1 : this.slide_sel-1;
			} else {
				this.slide_sel = n;
			}
						
			this[this.sett.slide_transition] ();
		},		
		
		
		/*Change the stack order (z-index) of slides
		=====================================================================================================================*/
		zSort: function (current, previous){
			var z = 1;
			for ( var i=0; i<this.slide_tot; i++) {	
				if (i !== this.slide_sel && i !== this.slide_pr1) {
					if (this.slides[i]) {
						this.slides[i].con.css('z-index', z);
						if (this.IE8) {
							this.slides[i].con.hide();
						}
					}
					z++;
				}				
			}
			if (this.slides[this.slide_pr1]) {
				this.slides[this.slide_pr1].con.css('z-index', this.slide_tot+previous);
			}
			if (this.slides[this.slide_sel]) {
				this.slides[this.slide_sel].con.css('z-index', this.slide_tot+current);
			}
		},		
		
		
		/*Transition out the previous slides caption
		=====================================================================================================================*/
		textOut: function (){
			var self = this;			
			if (this.slides[this.slide_pr1] && this.sett.slide_transition == 'fade') {				
				this.slides[this.slide_pr1].txt.stop(true)
				.animate({
					'left': -self.slides[self.slide_pr1].cw/2}, {
					duration: 150, 
					easing:'easeOutQuad',					
					queue: false,
					complete: function (){						
						$(this).hide();
					}
				});
			} 
		},
		
		
		/*Animate the selected slide's caption
		=====================================================================================================================*/
		textIn: function (){
			var self = this,
				txtDir = -self.slide_dir,
				prop = self.IE8? 'filter' : 'opacity',
				val = self.IE8? 'none' : 1;
							
			if (self.sett.slide_transition == 'fade' && !self.dragged) {
				txtDir = 1;	
			}
				
			if (self.slides[self.slide_sel].txt) {
				self.slides[self.slide_sel].txt
					.css({
						'left': self.sett.caption_padding_x+(100*txtDir),
						 prop: val
					 })
					.hide()
					.fadeIn(600, function(){
						if (self.IE8) {
							$(this)
							.removeAttr("filter")
							.removeAttr("-ms-filter");
						}
					})
					.animate({
						'left': self.sett.caption_padding_x}, {
						duration: 800,
						easing:'easeOutQuart',
						queue:false
					});
			}
		},
		
		
		/*Entire Caption holder animates
		=====================================================================================================================*/
		animateCaption: function () {
			var self = this,
				id = this.slide_sel;	
					
			this.slides[this.slide_sel].txt.hide();	
			
			if (this.sett.caption_float_mode) {
				if (this.IE8 || this.dotButtonBlurBG) {
					if (!self.dotButtonBlurBG) {
						this.slides[id].cap
						.hide()
						.fadeIn({ duration: 300});
					}
				} else {
					this.slides[id].cap
					.hide()
					.fadeIn({
						duration: 800,
						queue:false
					})
					.animate({
						'left': this.slides[id].cx },{
						duration:600
					});
				}
				this.textIn ();
				
			} else {
				if (this.IE8) {
					this.slides[id].cap
					.hide()
					.fadeIn({
						duration: 600, 
						complete: function () {
							self.textIn();
						},
						queue:false
					});
					
				} else {
					this.slides[id].cap
					.hide()
					.fadeIn({
						duration: 600,
						queue:false
					})
					.animate({
						'_': 100 },{
						duration: 400,
						complete: function () {
							self.textIn();
						}
					});
				}				
			}	
		},	
		
		
		/*Add Navigation
		=====================================================================================================================*/
		setNavigation: function (){	
			var self = this;			
			
			for (var i=1; i<=3; i++) {
				if (((!self.sett.responsive || self.sett.responsive_limit_navigation == '' || !self.checkLimit(self.sett.responsive_limit_navigation, true)) && self.sett.navigation_type === i) || (self.sett.responsive && self.sett.responsive_limit_navigation !== '' && self.sett.responsive_limit_navigation_type === i)) {
					if (i == 1) {
						self.navHolder = self.navigation();
						self.$cont.prepend(self.navHolder);
						
					} else if (i == 2) {
						self.navHolderD = self.dotNavigation();
						self.$cont.prepend(self.navHolderD);						
						
					} else if (i == 3) {
						self.navHolderA = self.arrowNavigation();
						self.$cont.prepend(self.navHolderA);
					}
				}
			}

			self.swapNavigation (false);	
			//Expand Number button in case opted to show always
			if (!self.sett.button_numbers_autohide && self.sett.button_show_numbers && self.navHolder){
				for (var i=0; i<self.slide_tot; i++) {
					self.showHideButton(i, true);
				}
			}
		},		
		
		
		/*Set simple version of navigation (only Next and Bakc butttons) for mobile device or low res versions
		====================================================================================================================*/
		arrowNavigation: function (){
			var self = this,
				s = self.sett,
				size = s.button_size,
				space = s.button_space,
				holder = $('<div class="navHolder" style="z-index:'+(self.slide_tot+70)+'; left: 0px; top: 0px;"></div>');
			
			self.buttonNextA = self.addButton (self, holder, 4, true, false, "next")
				.css({
					'left': self.bW-size-s.button_margin,
					'top': (self.bH-size)/2
				});		

			
			self.buttonBackA = self.addButton (self, holder, 5, true, false, "back")
				.css({
					'left': s.button_margin,
					'top': (self.bH-size)/2
				});	

			return holder;
		},		
		
		
		dotNavigation: function (){			
			var self = this,
				s = self.sett,
				size = s.dot_button_size+s.dot_button_space,
				space = 0,
				nw = (((size+space)*self.slide_tot)-space)/2,
				holder = $('<div class="navHolder" style="z-index:'+(self.slide_tot+60)+'; left: '+parseInt(self.bW/2/1)+'px; bottom: 0px;"></div>');
			
			for (var i=0; i< self.slide_tot; i++) {
				self.slides[i].buttS = self.addButton (self, holder, 4, false, true, i)
					.css({
						'left': ((size+space)*i)-nw,
						'top': -(s.dot_button_margin>-1? size-(s.dot_button_space/2)+s.dot_button_margin+ (self.dotButtonBlurBG? s.dot_button_bg_padding : 0) : s.dot_button_margin+(s.dot_button_space/2))
					});			
			}
			
			return holder;
		},		
		

		/*Set up entire navigation here
		=====================================================================================================================*/
		navigation: function () {
			var self = this,
				s = self.sett,
				sl = self.slides,
				bN = self.buttonNext,
				bB = self.buttonBack,
				bP = self.buttonPause,
				bIE = self.buttonIE,
				size = s.button_size,
				space = s.button_space
				nav = self.nav = self;
				
			self.currentDown = -1;
			
			//Add Navigation Holder
			var $navHolder = $('<div class="navHolder" style="z-index:'+(self.slide_tot+50)+';"></div>');
			
			if (bN || self.buttonNumber){
				var $numSet = $('<div style="z-index:4; position: absolute; left: '+(-size)+'px; top: '+ (-(size+space)*(self.slide_tot+(bN? 1 : 0))+space) +'px; width: '+size+'px; height: '+((size+space)*(self.slide_tot+1)-space)+'px;"></div>');
				
				if (s.button_numbers_horizontal) {		
					$numSet.css({
						'z-index':4,
						'position': 'absolute',
						'left': -(size+space)*(self.slide_tot+ (bN? 1 : 0))+space,
						'top': -size,
						'width': (size+space)*(self.slide_tot+ (bN? 1 : 0))-space,
						'height': size
					});				
				} 
				$navHolder.append($numSet);				
			}
			
			//Next Button
			if (bN) {
				bN = self.buttonNext = self.addButton (nav, $numSet, 4, true, false, "next")
					.css({
						'left': (s.button_numbers_horizontal? ((size+space)*self.slide_tot) : 0)-bIE,
						'top': (s.button_numbers_horizontal? 0 :((size+space)*self.slide_tot))-bIE
					})
			
				if (s.button_numbers_autohide && self.buttonNumber){
					if (!self.touchDevice) {					
						bN.bind('mouseenter', {self: self, up: true}, self.checkDropDown);
						$numSet.bind('mouseleave', {self: self, up: false}, self.checkDropDown)					
						.bind('mouseenter', function (e){	
							if (self.numShow) {
								clearTimeout(self.buttonLeaveTimer);
							};			
						});
					}
				}
			}
			
			//Timer Clock
			if (self.clockTimer) {
				var ctX, ctY;
				if (self.canvasSupport){
					self.clockTimer = $('<canvas id="clockTimer" width="'+size+'" height="'+size+'" style="position:absolute; z-index:2;"></canvas>');
					var ctx = self.clockContext = self.clockTimer[0].getContext('2d');
					ctx.shadowColor = 'rgba(0, 0, 0, 0.5)';
					ctx.shadowBlur = 3;
					ctx.shadowOffsetX = 0;
					ctx.shadowOffsetY = 0;
					ctx.lineWidth = size/10;
					ctx.lineCap = 'round';				
				} else {			
					self.clockTimer = $(
						'<div style="position:absolute; z-index:2; width:'+size+'px; height:'+size+'px; overflow:hidden">\
							<div style="position:absolute; left: -2px; top:-2px; width:'+(size !== 20 ? (960*(size/20/1)) : 960)+'px; height:'+(size+2)+'px; filter : progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+self.timer_sprite+', sizingMethod='+(size !== 20 ? 'scale' : 'noscale')+') alpha(opacity=100);">\
							</div>\
						</div>');
				}
				
				if (s.button_numbers_horizontal && bN) {
					$numSet.append(self.clockTimer);
				} else {
					$navHolder.append(self.clockTimer);
				}				
				
				if (s.button_numbers_horizontal) {
					if (bN) {
						if (self.buttonNumber && !s.button_numbers_autohide){
							ctX = -(size+space);
							ctY = 0;													
						} else {
							ctX = (size+space)*(self.slide_tot-1);
							ctY = 0;							
						}
					} else {
						if (self.buttonNumber && !s.button_numbers_autohide){
							ctX = -((size+space)*(self.slide_tot+1))+space;
							ctY = -size;							
						} else {
							ctX = -size;
							ctY = -size-bIE;												
						}
					}
				} else {
					ctX = -((size*(bN || self.buttonNumber? 2 : 1))+(bN || self.buttonNumber? space : 0));
					ctY = -size;
				}
				self.clockTimer.css({
					'left': ctX,
					'top': ctY
				});	
				
				bP = self.buttonPause = self.addButton (nav, s.button_numbers_horizontal && bN? $numSet : $navHolder, 3, true, false, 'pause')
					.css({
						'left': ctX-bIE,
						'top': ctY-bIE
					});
				
				if (self.autoPlaying){
					bP.css('opacity', 0);
				} else {
					self.clockTimer.css('opacity', 0);
				}
				
				if (!self.touchDevice) {
					bP.bind('mouseenter', function (e){
						bP.stop().animate({
							opacity: 1 },{
							duration: 400,
							easing: 'easeOutQuad'
						
						});					
												
					}).bind('mouseleave', function (e){
						if (self.autoPlaying){
							bP.stop().animate({
								opacity: 0 },{
								duration: 400,
								easing: 'easeOutQuart'						
							});	
						}
												
					});	
				}
			}
				
			//Back Button
			if (bB) {
				var btX, btY;
				bB = self.buttonBack = self.addButton (nav, s.button_numbers_horizontal && bN? $numSet : $navHolder, 1, true, false, "back");	
				if (s.button_numbers_horizontal) {	
					if (bN){						
						btX = (size+space)*(self.slide_tot-(self.clockTimer? 2 : 1));
						btY = 0;
					} else {	
						if (self.clockTimer){
							btX = parseInt(self.clockTimer.css('left'),10)-size-space;
							btY = parseInt(self.clockTimer.css('top'), 10);
						} else{
							btX = -size+bIE;
							btY = -size;						
						}
					}					
				} else {
					if (self.clockTimer){
						btX = (-(size+space)*(bN? 3 : 2))+space;						
					} else {
						btX = -((size*(bN || self.buttonNumber? 2 : 1))+(bN || self.buttonNumber? space : 0));						
					}
					btY = -size;
				}
				
				bB.css({
					'left': btX-bIE,
					'top': btY-bIE
				});
			}
			
			//Number Buttons
			if (self.buttonNumber) {
				for (var i=0; i<self.slide_tot; i++){					
					sl[i].butt =  self.addButton (nav, $numSet, self.slide_tot-i+5, false, false, i);
					
					if (s.button_numbers_horizontal) {
						sl[i].butt.css({
							'top': -bIE,
							'left': ((size+space)*i)-bIE
						});
					} else {
						sl[i].butt.css({
							'left': -bIE,
							'top': ((size+space)*i)-bIE
						});
					}						
					if (i == self.slide_sel) {
						sl[i].butt.bg.css('opacity', 1);
					}
					sl[i].butt.hide();
				}			
			}
			
			$navHolder.css({
				'right': s.button_margin-(s.caption_float_mode? 0 : -s.caption_margin_x),
				'bottom': s.button_margin-(s.caption_float_mode? 0 : -s.caption_margin_y)
			});	
				
			return $navHolder;
		},
		
		
		/*Switch between Full navigation and Simple version 
		=====================================================================================================================*/
		swapNavigation: function (timer){
			
			$(document).unbind('.TransBannerButtonUp_'+this.instanceID);
			if (this.currentNav === 1) {
				if (this.navHolder) this.navHolder.show();	
				if (this.navHolderD) this.navHolderD.hide();
				if (this.navHolderA) this.navHolderA.hide();
		
			} else if (this.currentNav === 2) {
				if (this.navHolder) this.navHolder.hide();
				if (this.navHolderD) this.navHolderD.show();
				if (this.navHolderA) this.navHolderA.hide();				
							
			} else if (this.currentNav === 3) {
				if (this.navHolder) this.navHolder.hide();
				if (this.navHolderD) this.navHolderD.hide();
				if (this.navHolderA) this.navHolderA.show();								
			}
			
			//Mouse Up event for all the buttons: Next, Back, Pause and Number buttons
			$(document).bind(this.upEvent+'.TransBannerButtonUp_'+this.instanceID, {self: this}, this.releaseButton);
			
			if (this.currentNav <3) {
				this.toggleButton(true);
			}
			this.timerReset(true);			
			if (this.autoPlaying && timer) {
				this.startDelayTimer();
			}
		},	
		

		/*Insert navigation Button
		=====================================================================================================================*/
		addButton: function (nav, holder, zindex, icon, dot, num){
			var self = this,
				size = dot ? self.sett.dot_button_size+self.sett.dot_button_space : self.sett.button_size,
				sh, ih, bText,
				button = $(
					'<div class="noSelect" style="z-index:'+zindex+'; position: absolute; width:'+(size+(self.buttonIE*2))+'px; height:'+(size+(self.buttonIE*2))+'px; cursor: pointer;">\
						<div class="defaultButton rounded '+(!self.IE8 && (icon || dot)? 'icon' : '')+'" style="position: absolute; overflow: hidden; z-index:2; left: '+self.buttonIE+'px; top: '+self.buttonIE+'px; right:'+self.buttonIE+'px; bottom:'+self.buttonIE+'px; width:'+size+'px; height:'+ size+'px; '+(self.IE8 || dot? '' : 'background-color:'+self.sett.button_color)+'">'+(self.IE8 && !dot? '\
							<div class="buttonAlpha" style="background-color:'+self.sett.button_color+'"></div>\
							<div class="buttonTopBot" style="background-color:'+self.sett.button_color+'"></div>\
							<div class="buttonCent iconHolder '+(icon? 'icon' : '')+'" unselectable="on" style="height: '+(size-2)+'px; background-color:'+self.sett.button_color+'" align="center">'+(icon? '' : '\
								<span unselectable="on" class="buttonText '+(self.icOff>0? 'buttonTextSizeTouch' : ' buttonTextSizeNormal')+'" style="position:relative; text-align: center; line-height:'+ (size-1)+'px; left:'+ (String(num+1).length <=1 ? 1 : 0)+'px; top:-1px;"  align="center">'+(num+1)+'</span>')+'\
							</div>' : '')+'\
						</div>\
						'+(dot || !self.IE8 ? '' : '<div class="buttonShadow"></div>')+'\
					</div>'
				),
								
				bg = button.find('.defaultButton');

			if (self.IE8) {
				sh = button.find('.buttonShadow');				
				ih = bg.find('.iconHolder');
				if (icon){
					ih.css('background-position', (dot ? self.icDotOff : (num == "next"? ((size-self.icSize)/2)-self.icSize : num == "pause"? ((size-self.icSize)/2)-(self.autoPlaying? self.icSize*2 : self.icSize*3) : (size-self.icSize)/2) - self.icOff) + 'px center');
					
				} else if (dot){
					bg.append(dot = $('<div style="position: absolute; width:'+size+'px; height:'+ size+'px; left:'+self.icDotOff+'px; top:'+(-(self.icSize/2)+(size/2))+'px; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+self.icons+', sizingMethod=image) alpha(opacity=100);"></div>'))
					
				} else {
					var ih_number = ih.find('.buttonText');
				}
				button.append(bg, sh);
				
			} else {		
				if (icon || dot){
					bg.css('background-position', (dot ? self.icDotOff : (num == "next"? ((size-self.icSize)/2)-self.icSize : num == "pause"? ((size-self.icSize)/2)-(self.autoPlaying? self.icSize*2 : self.icSize*3) : (size-self.icSize)/2)- self.icOff) + 'px center');
					
				} else {	
					bText = $('<div align="center" class="buttonText '+(self.icOff>0? 'buttonTextSizeTouch' : ' buttonTextSizeNormal')+'" style="z-index:2; position: absolute; left: 0px; top: 0px; width: 100%; height:100%; line-height:'+ size+'px; text-align: center; cursor:hand;">'+(num+1)+'</div>');
				}	

				if (!dot) {
					bg.css(self.shProp, '0px 0px 2px '+($.browser.webkit && parseInt($.browser.version, 10) < 533 ? '' : '0px ')+'rgba(0, 0, 0, .7)');	
				}
				button.append(bg, bText);
			}
			
			if (!dot) {
				bg.css('opacity', self.sett.button_opacity);	
			}
			
			button.bg = bg;
			button.sh = sh;
			button.ih = ih;
			button.bt = ih_number;
			button.dot = dot;
			holder.append(button);
			
			//Button Events; only for over, out and down states
			button.bind('mouseenter mouseleave '+ self.downEvent, {self: self, num: num, dot: dot, btn: button}, self.hoverButton);
			

			return button;
		},	
		

		/*All buttons hover state
		=====================================================================================================================*/
		hoverButton: function (e) {	
			var self = e.data.self,
				num = e.data.num,
				dot = e.data.dot,
				btn = e.data.btn,
				size = dot ? self.sett.dot_button_size+self.sett.dot_button_space : self.sett.button_size,
				bgPos;	
			
			if (e.type == 'mouseenter'){
				if (dot){
					if (self.IE8) {
						btn.dot.css('left', self.icDotOff-self.icSize);
					} else {
						btn.bg.css('background-position', self.icDotOff-self.icSize+'px center');					
					}
				} else {
					btn.bg.css({'opacity': 1});
				}
				
			} else if (e.type == 'mouseleave') {
				if (num != self.slide_sel) {
					if (dot){
						if (self.IE8) {
							btn.dot.css('left', self.icDotOff);
						} else {
							btn.bg.css('background-position', self.icDotOff+'px center');					
						}						
					} else {
						btn.bg.css('opacity', self.sett.button_opacity);
					}
				}
					
			} else {				
				e.stopImmediatePropagation();
				if (num !== self.slide_sel) {
					if (dot) {
						if (self.IE8) {
							btn.dot.css('left', self.icDotOff-(self.icSize*2));
						} else {
							btn.bg.css('background-position', (self.icDotOff-(self.icSize*2))+'px center');					
						}						
					} else {
						
						bgPos = ((size-self.icSize)/2)-self.icOff-1;
						if (num == "next") {
							bgPos -= self.icSize;
							
						} else if (num == "pause" && self.autoPlaying) {
							bgPos -= self.icSize * 2;	
							
						} else if (num == "pause" && !self.autoPlaying){
							bgPos -= self.icSize * 3;
						}
						
						self.resizeButton(btn, self.buttonIE+(dot? 0: 1), 1, size - 2, bgPos, num == 'next' && !self.numShow && self.touchDevice ? self.sett.button_opacity : 1);		
						if (btn.bt) {
							btn.bt.css('top', -2);
						}
					}
					self.currentDown = num;	
				}				
				if (self.touchDevice && self.currentNav <3) {
					if (num == 'next' && !self.numShow) {
						self.checkDropDown(false, true);
					} else if (num == 'back' || num == 'pause' && self.numShow) {
						self.checkDropDown(false, false);
					}										
				}				
			}
		},		


		/*All buttons after click activities
		=====================================================================================================================*/
		releaseButton: function (e){
			var self = e.data.self,
				size = (self.currentNav == 2) ? self.sett.dot_button_size+self.sett.dot_button_space : self.sett.button_size,			
				ready = self.checkTransitionStatus (),
				sameNum = (self.currentDown <0 || self.slide_sel === self.currentDown) ? true : false;		
				
			if (self.currentDown == "next"){								
				if (ready) {
					self.slide_dir = -1;
					self.changeSlide ("next");				
				}			
				self.resizeButton (self.currentNav == 3? self.buttonNextA : self.buttonNext, self.buttonIE, 0, size, (((size-self.icSize)/2)-self.icSize)-self.icOff, 1);
					
										
			} else if (self.currentDown == "back"){
				if (ready) {
					self.slide_dir = 1;
					self.changeSlide ("back");				
				}								
				self.resizeButton (self.currentNav == 3? self.buttonBackA : self.buttonBack, self.buttonIE, 0, size, ((size-self.icSize)/2)-self.icOff, self.touchDevice? self.sett.button_opacity : 1);
						
			} else if (self.currentDown == "pause"){
				if (self.autoPlaying){
					self.autoPlaying = false;
					self.buttonPause.css('opacity', 1);
					self.clockTimer.css('opacity', 0);
					self.timerReset(true);
				} else {
					self.autoPlaying = true;
					self.buttonPause.stop()
					.animate({
						opacity: 0 },{
						duration: 400,
						easing: 'easeOutQuart'					
					});	
					self.clockTimer.css('opacity', 1);
					self.timerReset(true);
					self.startDelayTimer();
				}	
				self.resizeButton (self.buttonPause, self.buttonIE, 0, size, (((size-self.icSize)/2)-(self.autoPlaying? self.icSize*2 : self.icSize*3))-self.icOff, self.touchDevice? self.sett.button_opacity : 1);						
		
			} else if (self.currentDown > -1){
				if (ready && self.slide_sel !== self.currentDown){
					if (self.currentDown > self.slide_sel) {
						self.slide_dir = -1;
					} else if (self.currentDown < self.slide_sel){
						self.slide_dir = 1;
					}							
					self.changeSlide (self.currentDown);					
				}	
				
				if (self.currentNav !== 2) {
					var btn = self.currentNav === 1 ? self.slides[self.slide_sel].butt :  self.slides[self.slide_sel].buttS;
					if (btn.ih) btn.ih.height(size-2);				
					if (btn.bt) btn.bt.css('top', -1);
				}				
				
			}
			
			if (self.currentDown !== "pause" && !sameNum) {
				if (self.sett.button_show_numbers && self.currentNav < 3){
					self.toggleButton (false);
				} else {
					self.timerReset(false);
				}			
			}
			self.currentDown = -1;
		},		
		
		
		/*Button resize on Up and Down states
		=====================================================================================================================*/
		resizeButton: function (btn, pos1, pos2, size, bgPos, opacity, bs2){					
			btn.bg.css({
				'opacity': opacity,
				'left': pos1,
				'top': pos1,
				'width': size,
				'height': size,
				'background-position': bgPos + 'px center'
			});	
					
			if (btn.sh) {
				btn.sh.css({
					'left': pos2,
					'top': pos2,
					'width': size+2,
					'height': size+2
				});
			}
			if (btn.ih) {
				btn.ih.css({
					'height': size-2,
					'background-position': bgPos + 'px center'
				});	
			}
		},	
		
		
		/*Change Number button selection
		=====================================================================================================================*/
		toggleButton: function (immediate){			
			var size = (this.currentNav == 2 ? this.sett.dot_button_size+this.sett.dot_button_space : this.sett.button_size);
				
			for (var i=0, btn; i<this.slide_tot; i++){	
				btn = this.currentNav >1 ? this.slides[i].buttS : this.slides[i].butt;
				if (btn) {
					btn.bg.css({
						'opacity': (i == this.slide_sel || this.currentNav == 2) ? 1 : this.sett.button_opacity,
						'left': this.buttonIE,
						'top': this.buttonIE,
						'width': size,
						'height': size
					});	
				}
				if (this.currentNav == 2) {
					if (this.IE8) {
						btn.dot.css('left', this.icDotOff - (i == this.slide_sel? this.icSize : 0));
					} else {
						btn.bg.css('background-position', (this.icDotOff - (i == this.slide_sel? this.icSize : 0))+'px center');						
					}
				}
			}
			this.timerReset(immediate);
			btn = this.currentNav > 1? this.slides[this.slide_sel].buttS : this.slides[this.slide_sel].butt;
			
			if (this.buttonIE >0 && btn.sh) btn.sh.css({
				'left': 0,
				'top': 0,
				'width': this.sett.button_size+2,
				'height': this.sett.button_size+2
			});			
		},		
		
		
		/*Verify the current state of Number buttons and decide whether it needs show or hide
		=====================================================================================================================*/
		checkDropDown: function (e,up){
			var self = e ? e.data.self : this;
			var up = e ? e.data.up : up;
			
			if (up && !self.numShow){
				for (var i=0; i<self.slide_tot; i++) {
					clearTimeout(self.buttonLeaveTimer);
					clearTimeout(self.slides[i].timer);									
					self.showHideButton(i, true);					
				}	
			} else if (!up && self.numShow){										
				self.buttonLeaveTimer = setTimeout(function (){	
					self.numShow = false;		
					for (var i=0; i<self.slide_tot; i++) {
						self.showHideButton(i, false);
					}			
				}, e? 300 : 0);
			}		
		},
		
		
		/*Number Buttons - Animated Chain display that show/hides
		=====================================================================================================================*/
		showHideButton: function (i, up){			
			var self = this;
			var delay, dur, tar_op, sc, ob;
			ob = self.slides[i].butt;						
			clearTimeout(self.buttonLeaveTimer);
			clearTimeout(self.slides[i].timer);	
			ob.stop();
			if (up) {			
				self.numShow = true;
				self.slides[i].butt.show();
				if (ob.css('opacity') == 1) {
					ob.css('opacity', 0);
				}
				delay = (self.slide_tot-i)*(100/self.slide_tot);
				dur = 20+((self.slide_tot-i)*(300/self.slide_tot));			
				tar_op = 1;
				sc = 3;
			} else {
				self.numShow = false;			
				delay = i*(150/self.slide_tot);
				dur = 20+(i*(150/self.slide_tot));
				tar_op = 0;
				sc = 8			
			}
			self.slides[i].timer = setTimeout(function (){			
				ob.animate({
					'opacity': tar_op },{
					duration: dur,
					step: function(now) {
						 self.showHideStep (now, sc, ob, up, i);
					},
					complete: function() {
						if (!up) {
						 self.slides[i].butt.hide();
						}
					}
				});		
			}, delay);
		},
		
		
		/*Number Buttons - Animated Chain display steps
		=====================================================================================================================*/
		showHideStep: function(now, sc, ob, up, i) {
			var self = this,
				size = self.currentNav == 2 ? self.sett.dot_button_size : self.sett.button_size,
				space = self.currentNav == 2 ? self.sett.dot_button_space : self.sett.button_space,						
				p = parseInt((size/sc)-(size/sc*now), 10),
				s = size-(p*2);	
			
			ob.bg.css({
				'left': p+self.buttonIE,
				'top': p+self.buttonIE,
				'width': s,
				'height': s				
			});
			
			if (self.buttonIE >0) {
				ob.sh.css({
					'left': p,
					'top': p,
					'width': s+2,
					'height': s+2					
				});	
			}
			
			if (ob.ih) {
				ob.bt.css('top', -p-1);
				ob.ih.height(s-2);			
			}
			if (self.sett.button_numbers_horizontal && i==self.slide_tot-1) {
				if (self.clockTimer && self.navHolder){
					if (self.buttonNext){
						self.clockTimer.css('left', up ? -(size+space)*now : ((size+space)*(self.slide_tot-1)*(1-now))+(size+space)*now);
					}
					if (self.buttonBack){
						self.buttonBack.css('left', parseInt(self.clockTimer.css('left'))-size-space-self.buttonIE);						
					}
					self.buttonPause.css({
						'left': parseInt(self.clockTimer.css('left'), 10)-self.buttonIE,
						'top': parseInt(self.clockTimer.css('top'), 10)-self.buttonIE
					});
				} else {
					if (self.buttonBack && self.buttonNext) {
						self.buttonBack.css('left', (up ? -now*(size+space) : ((size+space)*(self.slide_tot-1)*(1-now))+(size+space)*now)-self.buttonIE);		
					}
				}							
			}			
		},	
		
		
		/*Check everything completed animation. To make sure to progress next activities such as switching to next slide
		=====================================================================================================================*/
		checkTransitionStatus: function (){
			if (this.sett.slide_transition == 'fade'){
				if (this.slide_fin) {
					return true;
				} else {
					return false;
				} 
			} else {
				if (this.slide_dir <0 && this.slides[this.slide_sel].con.position().left < this.bW/2) {
					 return true;
				} else if (this.slide_dir >0 && this.slides[this.slide_sel].con.position().left > -this.bW/2){
					 return true;
				} else {
					return false;
				}
			}	
		},


		/*The timer clock initiated
		=====================================================================================================================*/
		startDelayTimer: function(){
			var self = this;
			
			if (self.clockTimer && self.currentNav == 1){
				 self.clockTimer.stop();
			}			
			self.clockPlaying = true;
			
			self.timerob.stop()
				.css('left', 0)
				.animate({
					'left': 720 },{
					easing: 'linear',
					duration: self.slides[self.slide_sel].delay,
					queue: false,
					step: function (now){					
						if (self.sett.button_show_timer && self.currentNav == 1) {
							if (self.canvasSupport){
								var ctx = self.drawTimer(self);				
								ctx.strokeStyle = self.sett.button_color;
								ctx.beginPath();	
								ctx.arc(self.sett.button_size/2, self.sett.button_size/2, (self.sett.button_size/2)-(self.sett.button_size/10), (Math.PI*2*(now/720))-(Math.PI/2), -Math.PI/2, true);							
								ctx.stroke();
								ctx.closePath();						
							} else {
								var pos = (parseInt(now/720*39, 10)*-(24*self.sett.button_size/20))-2;			
								pos< -(39*(24*self.sett.button_size/20))-2? pos = -2 : "";
								self.clockTimer.children().eq(0).css('left', pos);		
							}	
						}
					}, 
					complete: function (){	
						self.clockPlaying = false;														
						if (!self.slide_drg) {
							self.slide_dir = -1;						
							self.changeSlide ("next");
							if (self.sett.button_show_numbers && self.currentNav < 3){
								self.toggleButton (false);
							} else {
								self.timerReset(false);	
							}
						}					
					}
				});		
		},		
		

		/*Stop timer clock and initiate new
		=====================================================================================================================*/
		timerReset: function (immediate){
			var self = this;					
			if (self.clockPlaying) {
				self.timerob.stop();
			}
			if (self.autoPlaying){
				if (self.clockTimer && self.currentNav == 1) {
					if (immediate) {
						self.timerHalt ();
					} else {
						self.clockTimer.stop()
						.fadeTo( 300, .4, 
							function (e){
								self.timerHalt();
							});	
					}
				}
			}
		},
		
		
		timerHalt: function(){
			var self = this;			
			if (self.canvasSupport) {
				self.drawTimer(self);
			} else {							
				self.clockTimer
				.css('filter', 'none')
				.children().eq(0).css('left', -2);
			}
		},		


		/*Draws timer circle (if canvas supported)
		=====================================================================================================================*/
		drawTimer: function (self){
			var ctx = self.clockContext;							
			ctx.clearRect(0, 0, self.sett.button_size, self.sett.button_size);	
			ctx.strokeStyle = "rgba(255, 255, 255, .4)";
			ctx.beginPath();		
			ctx.arc(self.sett.button_size/2, self.sett.button_size/2, (self.sett.button_size/2)-(self.sett.button_size/10), 0, Math.PI*2, true);
			ctx.stroke();
			ctx.closePath();
			self.clockTimer.css('opacity', 1);
			return ctx;	
		},	
		
		
		/*Preparing necessary visibility states before slide transition
		=====================================================================================================================*/
		transPrepare: function (lev1,lev2, id, st){
			var self = this;			
			self.zSort (lev1,lev2);
			if (self.slides[id].txt) {
				if (!self.dotButtonBlurBG) {
					self.slides[id].cap.hide();
				} 
				if (self.sett.caption_float_mode) {
					self.slides[id].cap.css('left', self.slides[id].cx +(self.IE8 || self.dotButtonBlurBG ? 0 : (100*-self.slide_dir)));	
				}
				if (st && self.IE8){
					self.slides[id].txt.stop(true);
					self.slides[id].cap.stop(true);				
				}
			}
			if (self.slide_pr1 !== ''){
				if (self.slides[self.slide_pr1].txt) {
					self.textOut();
				}
			}		
			self.slide_drg = false;
			self.slide_fin = false;
			self.slide_playing = true;			
		}, 
		
		
		/*Affter slide transition, initiate caption animation and delay timer
		=====================================================================================================================*/
		transComplete: function (self, id){			
			self.slide_fin = true;	
			if (self.slide_sta)	{
				self.slide_sta = false;
				self.$cont.css('background-image', 'none');
			}	

			if (self.slide_sel == self.slide_sel && self.slides[id].txt && self.enableCaption && self.slide_sel == id) {
				self.animateCaption ();
			}
			if (self.autoPlaying){	
				if (self.currentNav == 3) {
					self.toggleButton(true);
				}
				self.startDelayTimer();
			}
		},
		
		
		/*Transition 1: Move
		=====================================================================================================================*/
		move: function (){
			var self = this,
			id = self.slide_sel;
			self.transPrepare(2, 1, id, false);				
			self.slides[id].con.stop()
				.css({
					'left': (self.slide_pr1 !== '' ? self.slides[self.slide_pr1].con.position().left+(-self.bW*self.slide_dir) : -self.bW*self.slide_dir),
					display: 'block'
					
				}).animate({
					'left': 0 },{
					duration: self.sett.slide_transition_period+100,
					easing:'easeInOutQuart',
					step: function (now){
						if (self.slide_pr1 !== '' && self.slide_pr1 !== id) {
							self.slides[self.slide_pr1].con.stop()
							.css('left', now+(self.bW*self.slide_dir));		
						}
						if (self.slide_pr2 !== '' && self.slide_pr2 !== id && self.slide_pr2 !== self.slide_pr1) {
							self.slides[self.slide_pr2].con.stop()
							.css('left', now+(self.bW*2*self.slide_dir));
						}
				},
				complete: function (){
					self.transComplete (self, id);
				}						
			});				
		},			
					

		/*Transition 2: Fade In
		=====================================================================================================================*/
		fade : function (){
			var self = this,
			id = self.slide_sel;				
			self.transPrepare(2, 1, id, false);	
			self.slides[id].con.stop()
				.css({
					'left': 0,
					display: 'none'
				})				
				.fadeIn({
					duration: self.sett.slide_transition_period+100,
					easing: 'easeInOutQuart',
					complete: function (){
						self.transComplete (self, id);	
					}					
				});		
		},		
		
		
		/*Transition 3: Slide In
		=====================================================================================================================*/
		slideIn : function (){
			var self = this,
			id = this.slide_sel,
			sh = self.shProp;			
			self.transPrepare(2, 1, id, true);			
			self.slides[id].con.stop(true)
				.css({
					'left': (self.bW+30)*-self.slide_dir,
					sh : '0px 0px 45px 0px #000000',
					display: 'block'
				})
				.animate({
					'left': 0 },{
					duration: self.sett.slide_transition_period+100,	
					easing: 'easeInOutQuart',
					complete: function (){
						self.transComplete (self, id);
						self.slides[id].con.css(self.shProp, 'none');		
					}					
				});			
		},		
		
		
		/*Transition 4: Slide Out
		=====================================================================================================================*/
		slideOut : function (){
			var self = this,
			id = this.slide_sel,
			sh = self.shProp;				
			self.transPrepare(1, 2, id, false);				
			if (self.slide_pr1 !== '') {				
				self.slides[id].con.stop(true)
					.css({
						'left': 0,
						sh : '0px 0px 45px 0px #000000',
						display: 'block'
					});
					
				if (self.IE8 && self.slides[id].txt){
					self.slides[self.slide_pr1].txt.stop(true);
					self.slides[self.slide_pr1].cap.stop(true);					
				}
				
				self.slides[self.slide_pr1].con.stop(true)
				.animate({
					'left': self.slide_dir*(self.bW+30) },{
					duration: self.sett.slide_transition_period,				
					easing: 'easeInOutQuart',
					complete: function (){
						self.transComplete (self, id);
						self.slides[id].con.css(self.shProp, 'none');		
					}						
				});	
			} else {	
				self.slides[id].con.stop(true)
				.css({
					'left': self.bW,
					display: 'block'
					
				}).animate({
					'left': 0 },{ 
					duration: self.sett.slide_transition_period,				
					easing:'easeInOutQuart',
					complete: function (){					
						self.slide_fin = true;
						if (id == self.slide_sel && self.slides[id].txt && self.enableCaption) {
							self.animateCaption ();
						}
						if (self.autoPlaying){			
							self.startDelayTimer();
						}
					}					
				});					
			}
		},
		
		
		/*On Browser resize or external 'resizeBanner' callback
		=====================================================================================================================*/			
		resizeBanner: function (params){
			var self = this,
				nW = self.bW;
			
			if (params.internal) {
				self.bW = self.$cont.width();
				self.bH = self.getHeight();	
					
			} else {				
				if (params.width) {
					self.bW = nW = params.width;
					self.$cont.width(self.bW);
					
				} else if (params.maxWidth) {
					self.bW = nW = self.maxW = params.maxWidth;
					self.$cont.css('max-width', self.maxW+'px');
					self.bW = self.$cont.width();
				}
				
				if (params.height) {
					self.bH = self.oH = params.height;
					self.ratio = nW/self.oH;
					
				} else {							
					self.oH = nW/self.ratio;
				}	
				
				self.bH = self.getHeight();							
			}
			
			//If responsive feature enabled, check and change caption visibility and navigation type
			if (self.sett.responsive) {		
				self.enableCaption = !self.checkLimit(self.sett.responsive_limit_caption, false);							
				if (self.sett.responsive_limit_navigation !== '') {						
					if (self.checkLimit(self.sett.responsive_limit_navigation, false)){										
						 if (self.currentNav !== self.sett.responsive_limit_navigation_type) {
							self.currentNav = self.sett.responsive_limit_navigation_type;
							self.swapNavigation (true);														 
						 }						 		
					} else {
						if (self.currentNav !== self.sett.navigation_type) {
							self.currentNav = self.sett.navigation_type;
							self.swapNavigation (true);												
						}
					}
				}
			}
			
			if (self.currentNav == 2) {	
				self.navHolderD.css('left', self.bW/2);
				
			} else if (self.currentNav == 3) {
				self.buttonNextA.css({
					'left': self.bW-self.sett.button_size-self.sett.button_margin,
					'top': (self.bH-self.sett.button_size)/2
				});
																				
				self.buttonBackA.css({
					'left': self.sett.button_margin,
					'top': (self.bH-self.sett.button_size)/2
				});				
			}
							
			for (var i=self.slide_sel, first = true; i<self.slide_tot; i++){				
				if (first || i !== self.slide_sel) {
					self.resizeImage (i);				
					if (self.slides[i].txt) {
						self.updateText (i);
						if (!self.enableCaption && !self.dotButtonBlurBG) {
							self.slides[i].cap.hide();
						} else {
							self.slides[i].cap.show();
							self.slides[i].txt.show();
						}
					}
					if (first) {
						i = (self.slide_sel == 0) ? 0 : -1;
						first = false;
					} else {
						self.slides[i].con.stop()
						.css('left', self.bW*self.slide_dir);
					}
				}			
			}				
		}
		
	} //End - TBMain.prototype	


    $.fn.TransBanner = function(params) {
		var arg = arguments;
        return this.each(function(i) {
			var banner = $(this);
			var instance = banner.data('TransBanner');
			if (!instance) {
				banner.data('TransBanner',  new TBMain(banner, params, i));				
			} else {
				if (instance[arg[0]]) {
					instance[params].apply(instance, Array.prototype.slice.call(arg, 1));					
				}
			}
        });
    };	
	
	
	//Below is slightly customized version of StackBoxBlur to fit TransBanner
	
	/*

	StackBoxBlur - a fast almost Box Blur For Canvas
	
	Version: 	0.3
	Author:		Mario Klingemann
	Contact: 	mario@quasimondo.com
	Website:	http://www.quasimondo.com/
	Twitter:	@quasimondo
	
	In case you find this class useful - especially in commercial projects -
	I am not totally unhappy for a small donation to my PayPal account
	mario@quasimondo.de
	
	Copyright (c) 2010 Mario Klingemann
	
	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:
	
	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
	*/
	
	var mul_table=[1,171,205,293,57,373,79,137,241,27,391,357,41,19,283,265,497,469,443,421,25,191,365,349,335,161,155,149,9,278,269,261,505,245,475,231,449,437,213,415,405,395,193,377,369,361,353,345,169,331,325,319,313,307,301,37,145,285,281,69,271,267,263,259,509,501,493,243,479,118,465,459,113,446,55,435,429,423,209,413,51,403,199,393,97,3,379,375,371,367,363,359,355,351,347,43,85,337,333,165,327,323,5,317,157,311,77,305,303,75,297,294,73,289,287,71,141,279,277,275,68,135,67,133,33,262,260,129,511,507,503,499,495,491,61,121,481,477,237,235,467,232,115,457,227,451,7,445,221,439,218,433,215,427,425,211,419,417,207,411,409,203,202,401,399,396,197,49,389,387,385,383,95,189,47,187,93,185,23,183,91,181,45,179,89,177,11,175,87,173,345,343,341,339,337,21,167,83,331,329,327,163,81,323,321,319,159,79,315,313,39,155,309,307,153,305,303,151,75,299,149,37,295,147,73,291,145,289,287,143,285,71,141,281,35,279,139,69,275,137,273,17,271,135,269,267,133,265,33,263,131,261,130,259,129,257,1];var shg_table=[0,9,10,11,9,12,10,11,12,9,13,13,10,9,13,13,14,14,14,14,10,13,14,14,14,13,13,13,9,14,14,14,15,14,15,14,15,15,14,15,15,15,14,15,15,15,15,15,14,15,15,15,15,15,15,12,14,15,15,13,15,15,15,15,16,16,16,15,16,14,16,16,14,16,13,16,16,16,15,16,13,16,15,16,14,9,16,16,16,16,16,16,16,16,16,13,14,16,16,15,16,16,10,16,15,16,14,16,16,14,16,16,14,16,16,14,15,16,16,16,14,15,14,15,13,16,16,15,17,17,17,17,17,17,14,15,17,17,16,16,17,16,15,17,16,17,11,17,16,17,16,17,16,17,17,16,17,17,16,17,17,16,16,17,17,17,16,14,17,17,17,17,15,16,14,16,15,16,13,16,15,16,14,16,15,16,12,16,15,16,17,17,17,17,17,13,16,15,17,17,17,16,15,17,17,17,16,15,17,17,14,16,17,17,16,17,17,16,15,17,16,14,17,16,15,17,16,17,17,16,17,15,16,17,14,17,16,15,17,16,17,13,17,16,17,17,16,17,14,17,16,17,16,17,16,17,9];function stackBoxBlurImage(k,g,o,n,j,i,e,c,d,m,a,f){var p=n;var l=j;d.style.width=p+"px";d.style.height=l+"px";d.width=p;d.height=l;var b=d.getContext("2d");b.clearRect(0,0,p,l);b.scale(i,i);b.drawImage(k,(-g+(e!==""?e:0))/i,(-o+(c!==""?c:0))/i);if(isNaN(m)||m<1){return}stackBoxBlurCanvasRGB(d,0,0,p,l,m,f);b.restore()}function stackBoxBlurCanvasRGB(h,D,B,a,b,L,P){if(isNaN(L)||L<1){return}L|=0;if(isNaN(P)){P=1}P|=0;if(P>3){P=3}if(P<1){P=1}var U=h.getContext("2d");var O;try{try{O=U.getImageData(D,B,a,b)}catch(T){try{netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");O=U.getImageData(D,B,a,b)}catch(T){return}}}catch(T){}var g=O.data;var J,I,R,N,q,t,m,d,f,A,n,C,w,G,K,r,l,s,u,F;var S=L+L+1;var H=a<<2;var o=a-1;var M=b-1;var k=L+1;var E=new BlurStack();var z=E;for(R=1;R<S;R++){z=z.next=new BlurStack();if(R==k){var j=z}}z.next=E;var Q=null;var v=mul_table[L];var c=shg_table[L];while(P-->0){m=t=0;for(I=b;--I>-1;){d=k*(l=g[t]);f=k*(s=g[t+1]);A=k*(u=g[t+2]);z=E;for(R=k;--R>-1;){z.r=l;z.g=s;z.b=u;z=z.next}for(R=1;R<k;R++){N=t+((o<R?o:R)<<2);d+=(z.r=g[N++]);f+=(z.g=g[N++]);A+=(z.b=g[N]);z=z.next}Q=E;for(J=0;J<a;J++){g[t++]=(d*v)>>>c;g[t++]=(f*v)>>>c;g[t++]=(A*v)>>>c;t++;N=(m+((N=J+L+1)<o?N:o))<<2;d-=Q.r-(Q.r=g[N++]);f-=Q.g-(Q.g=g[N++]);A-=Q.b-(Q.b=g[N]);Q=Q.next}m+=a}for(J=0;J<a;J++){t=J<<2;d=k*(l=g[t++]);f=k*(s=g[t++]);A=k*(u=g[t]);z=E;for(R=0;R<k;R++){z.r=l;z.g=s;z.b=u;z=z.next}q=a;for(R=1;R<=L;R++){t=(q+J)<<2;d+=(z.r=g[t++]);f+=(z.g=g[t++]);A+=(z.b=g[t]);z=z.next;if(R<M){q+=a}}t=J;Q=E;for(I=0;I<b;I++){N=t<<2;g[N]=(d*v)>>>c;g[N+1]=(f*v)>>>c;g[N+2]=(A*v)>>>c;N=(J+(((N=I+k)<M?N:M)*a))<<2;d-=Q.r-(Q.r=g[N]);f-=Q.g-(Q.g=g[N+1]);A-=Q.b-(Q.b=g[N+2]);Q=Q.next;t+=a}}}U.putImageData(O,D,B)}function BlurStack(){this.r=0;this.g=0;this.b=0;this.a=0;this.next=null};
	
}) (jQuery, window, document);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 *
 *  jQuery $.getImageData Plugin 0.3
 *  http://www.maxnov.com/getimagedata
 *  
 *  Written by Max Novakovic (http://www.maxnov.com/)
 *  Date: Thu Jan 13 2011
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  
 *  Includes jQuery JSONP Core Plugin 2.1.4
 *  http://code.google.com/p/jquery-jsonp/
 *  Copyright 2010, Julian Aubourg
 *  Released under the MIT License.
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  
 *  Copyright 2011, Max Novakovic
 *  Dual licensed under the MIT or GPL Version 2 licenses.
 *  http://www.maxnov.com/getimagedata/#license
 * 
 */
(function(c,g){function n(){}function o(a){s=[a]}function e(a,j,k){return a&&a.apply(j.context||j,k)}function h(a){function j(b){!l++&&g(function(){p();q&&(t[d]={s:[b]});z&&(b=z.apply(a,[b]));e(a.success,a,[b,A]);e(B,a,[a,A])},0)}function k(b){!l++&&g(function(){p();q&&b!=C&&(t[d]=b);e(a.error,a,[a,b]);e(B,a,[a,b])},0)}a=c.extend({},D,a);var B=a.complete,z=a.dataFilter,E=a.callbackParameter,F=a.callback,R=a.cache,q=a.pageCache,G=a.charset,d=a.url,f=a.data,H=a.timeout,r,l=0,p=n;a.abort=function(){!l++&&
p()};if(e(a.beforeSend,a,[a])===false||l)return a;d=d||u;f=f?typeof f=="string"?f:c.param(f,a.traditional):u;d+=f?(/\?/.test(d)?"&":"?")+f:u;E&&(d+=(/\?/.test(d)?"&":"?")+encodeURIComponent(E)+"=?");!R&&!q&&(d+=(/\?/.test(d)?"&":"?")+"_"+(new Date).getTime()+"=");d=d.replace(/=\?(&|$)/,"="+F+"$1");q&&(r=t[d])?r.s?j(r.s[0]):k(r):g(function(b,m,v){if(!l){v=H>0&&g(function(){k(C)},H);p=function(){v&&clearTimeout(v);b[I]=b[w]=b[J]=b[x]=null;i[K](b);m&&i[K](m)};window[F]=o;b=c(L)[0];b.id=M+S++;if(G)b[T]=
G;var O=function(y){(b[w]||n)();y=s;s=undefined;y?j(y[0]):k(N)};if(P.msie){b.event=w;b.htmlFor=b.id;b[I]=function(){/loaded|complete/.test(b.readyState)&&O()}}else{b[x]=b[J]=O;P.opera?(m=c(L)[0]).text="jQuery('#"+b.id+"')[0]."+x+"()":b[Q]=Q}b.src=d;i.insertBefore(b,i.firstChild);m&&i.insertBefore(m,i.firstChild)}},0);return a}var Q="async",T="charset",u="",N="error",M="_jqjsp",w="onclick",x="on"+N,J="onload",I="onreadystatechange",K="removeChild",L="<script/>",A="success",C="timeout",P=c.browser,
i=c("head")[0]||document.documentElement,t={},S=0,s,D={callback:M,url:location.href};h.setup=function(a){c.extend(D,a)};c.jsonp=h})(jQuery,setTimeout);
(function(c){c.getImageData=function(a){var f=/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;if(a.url){var g=location.protocol==="https:",e="";e=a.server&&f.test(a.server)&&a.server.indexOf("https:")&&(g||a.url.indexOf("https:"))?a.server:"//img-to-json.appspot.com/?callback=?";c.jsonp({url:e,data:{url:escape(a.url)},dataType:"jsonp",timeout:1E4,success:function(b){var d=new Image;c(d).load(function(){this.width=b.width;this.height=b.height;typeof a.success==typeof Function&& a.success(this)}).attr("src",b.data)},error:function(b,d){typeof a.error==typeof Function&&a.error(b,d)}})}else typeof a.error==typeof Function&&a.error(null,"no_url")}})(jQuery);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
