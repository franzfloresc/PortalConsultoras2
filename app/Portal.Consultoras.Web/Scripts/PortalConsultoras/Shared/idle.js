var store = (function () {
    function _serialize(obj) {
        return JSON.stringify(obj);
    }

    function _deserialize(strVal, defaultVal) {
        if (!strVal) { return defaultVal }
        var val = ''
        try { val = JSON.parse(strVal) }
        catch(e) { val = strVal }

        return (val !== undefined ? val : defaultVal);
    }

    function remove(key) {
        window.localStorage.removeItem(key);
    }
    return {
        enabled: true,
        set: function(key, value) {
            if (value === undefined) {
                return remove(key);
            }

            window.localStorage.setItem(key, _serialize(value));
        },
        get: function (key) {

            var val = window.localStorage.getItem(key);

            return _deserialize(val);
        }
    }
})();
(function ($) {

    $.fn.idleTimeout = function (userRuntimeConfig) {
  
      //##############################
      //## Public Configuration Variables
      //##############################
      var defaultConfig = {
        redirectUrl: '/logout',      // redirect to this url on logout. Set to "redirectUrl: false" to disable redirect
  
        // idle settings
        idleTimeLimit: 1200,         // 'No activity' time limit in seconds. 1200 = 20 Minutes
        idleCheckHeartbeat: 2,       // Frequency to check for idle timeouts in seconds
        customCallback: false,       // set to false for no customCallback

        // configure which activity events to detect
        // http://www.quirksmode.org/dom/events/
        // https://developer.mozilla.org/en-US/docs/Web/Reference/Events
        activityEvents: 'click keypress scroll wheel mousewheel mousemove', // separate each event with a space
  
        // warning dialog box configuration
        enableDialog: true,           // set to false for logout without warning dialog
        dialogDisplayLimit: 180,       // Time to display the warning dialog before logout (and optional callback) in seconds. 180 = 3 Minutes
        dialogTitle: 'Session Expiration Warning', // also displays on browser title bar
        dialogText: 'Because you have been inactive, your session is about to expire.',
        dialogTimeRemaining: 'Time remaining',
        dialogStayLoggedInButton: 'Stay Logged In',
        dialogLogOutNowButton: 'Log Out Now',
  
        // error message if https://github.com/marcuswestin/store.js not enabled
        errorAlertMessage: 'Please disable "Private Mode", or upgrade to a modern browser. Or perhaps a dependent file missing. Please see: https://github.com/marcuswestin/store.js',
  
        // server-side session keep-alive timer
        sessionKeepAliveTimer: 600,   // ping the server at this interval in seconds. 600 = 10 Minutes. Set to false to disable pings
        sessionKeepAliveUrl: window.location.href // set URL to ping - does not apply if sessionKeepAliveTimer: false
      },
  
      //##############################
      //## Private Variables
      //##############################
        currentConfig = $.extend(defaultConfig, userRuntimeConfig), // merge default and user runtime configuration
        origTitle = document.title, // save original browser title
        activityDetector,
        startKeepSessionAlive, stopKeepSessionAlive, keepSession, keepAlivePing, // session keep alive
        idleTimer, remainingTimer, checkIdleTimeout, checkIdleTimeoutLoop, startIdleTimer, stopIdleTimer, // idle timer
        openWarningDialog, dialogTimer, checkDialogTimeout, startDialogTimer, stopDialogTimer, isDialogOpen, destroyWarningDialog, countdownDisplay, // warning dialog
        logoutUser, keepAlive;
  
      //##############################
      //## Public Functions
      //##############################
      // trigger a manual user logout
      // use this code snippet on your site's Logout button: $.fn.idleTimeout().logout();
      this.logout = function () {
          store.set('idleTimerLoggedOut', true);
      };

        this.reset = function() {
            destroyWarningDialog();
            stopDialogTimer();
            startIdleTimer();
        };

        this.restarTimer = function() {
            startIdleTimer();
        };
      //##############################
      //## Private Functions
      //##############################
  
      //----------- KEEP SESSION ALIVE FUNCTIONS --------------//
      startKeepSessionAlive = function () {
  
        keepSession = function () {
          $.get(currentConfig.sessionKeepAliveUrl);
          startKeepSessionAlive();
        };
  
        keepAlivePing = setTimeout(keepSession, (currentConfig.sessionKeepAliveTimer * 1000));
      };
  
      stopKeepSessionAlive = function () {
        clearTimeout(keepAlivePing);
      };
  
      //----------- ACTIVITY DETECTION FUNCTION --------------//
      activityDetector = function () {
  
        //$('body').on(currentConfig.activityEvents, function () {
  
        //  if (!currentConfig.enableDialog || (currentConfig.enableDialog && isDialogOpen() !== true)) {
        //    startIdleTimer();
        //  }
        //});
      };
  
      //----------- IDLE TIMER FUNCTIONS --------------//
      checkIdleTimeout = function () {
  
        var timeIdleTimeout = (store.get('idleTimerLastActivity') + (currentConfig.idleTimeLimit * 1000));
  
        if ($.now() > timeIdleTimeout) {
  
          if (!currentConfig.enableDialog) { // warning dialog is disabled
            logoutUser(); // immediately log out user when user is idle for idleTimeLimit
          } else if (currentConfig.enableDialog && isDialogOpen() !== true) {
            openWarningDialog();
            startDialogTimer(); // start timing the warning dialog
          }
        }
      };
  
      startIdleTimer = function () {
        stopIdleTimer();
        store.set('idleTimerLastActivity', $.now());
        checkIdleTimeoutLoop();
      };
  
      checkIdleTimeoutLoop = function () {
          if (idleTimer) {
              clearTimeout(idleTimer);
          }
        checkIdleTimeout();
        idleTimer = setTimeout(checkIdleTimeoutLoop, (currentConfig.idleCheckHeartbeat * 1000));
      };
  
      stopIdleTimer = function () {
        clearTimeout(idleTimer);
      };
  
      //----------- WARNING DIALOG FUNCTIONS --------------//
      openWarningDialog = function () {
  
          if (noPedidoReservado()) {
              showPopupCierreSesion(3);
          } else {
              showPopupCierreSesion(2);
          }
        // $(dialogContent).dialog({
        //   buttons: [{
        //     text: currentConfig.dialogStayLoggedInButton,
        //     click: function () {
        //       destroyWarningDialog();
        //       stopDialogTimer();
        //       startIdleTimer();
        //     }
        //   },
        //     {
        //       text: currentConfig.dialogLogOutNowButton,
        //       click: function () {
        //         logoutUser();
        //       }
        //     }
        //     ],
        //   closeOnEscape: false,
        //   modal: true,
        //   title: currentConfig.dialogTitle,
        //   open: function () {
        //     $(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').hide();
        //   }
        // });
  
        countdownDisplay();
  
        //document.title = currentConfig.dialogTitle;
  
        if (currentConfig.sessionKeepAliveTimer) {
          stopKeepSessionAlive();
        }
      };
  
      checkDialogTimeout = function () {
        var timeDialogTimeout = (store.get('idleTimerLastActivity') + (currentConfig.idleTimeLimit * 1000) + (currentConfig.dialogDisplayLimit * 1000));
  
        if (($.now() > timeDialogTimeout) || (store.get('idleTimerLoggedOut') === true)) {
          logoutUser();
        }
      };
  
      startDialogTimer = function () {
        dialogTimer = setInterval(checkDialogTimeout, (currentConfig.idleCheckHeartbeat * 1000));
      };
  
      stopDialogTimer = function () {
        clearInterval(dialogTimer);
        clearInterval(remainingTimer);
      };
  
      isDialogOpen = function () {
          var popup = getPopupCierreSession();
          var dialogOpen = popup.is(":visible");
          var tipo = popup.data('tipo');

          return dialogOpen && (tipo == 2 || tipo == 3 || tipo == 4);
      };
  
      destroyWarningDialog = function () {
        getPopupCierreSession().fadeOut(100);
        //$("#idletimer_warning_dialog").dialog('destroy').remove();
        document.title = origTitle;
  
        if (currentConfig.sessionKeepAliveTimer) {
          startKeepSessionAlive();
        }
      };

        var showSeconds = function(secs) {
            if (secs < 10) {
                secs = '0' + secs;
            }
            $('#countdownDisplay').html(secs + ' segundos');
        };

      countdownDisplay = function () {
       //if (remainingTimer) {
       //   clearInterval(remainingTimer);
       //}
        clearInterval(remainingTimer);
        var dialogDisplaySeconds = currentConfig.dialogDisplayLimit;
        showSeconds(dialogDisplaySeconds);
        dialogDisplaySeconds -= 1;

        remainingTimer = setInterval(function () {
          showSeconds(dialogDisplaySeconds);
          dialogDisplaySeconds -= 1;
        }, 1000);
      };
  
      //----------- LOGOUT USER FUNCTION --------------//
      logoutUser = function () {
        store.set('idleTimerLoggedOut', true);

          if (currentConfig.sessionKeepAliveTimer) {
              stopKeepSessionAlive();
          }
  
          if (currentConfig.customCallback) {
              currentConfig.customCallback();
          }

          clearTimeout();
          stopDialogTimer();

          showPopupFinSesion();
      };

      //###############################
      // Build & Return the instance of the item as a plugin
      // This is your construct.
      //###############################
      return this.each(function () {
  
        if (store.enabled) {
  
          store.set('idleTimerLastActivity', $.now());
          store.set('idleTimerLoggedOut', false);
  
          activityDetector();
  
          if (currentConfig.sessionKeepAliveTimer) {
            startKeepSessionAlive();
          }
  
          startIdleTimer();

        } else {
          alert(currentConfig.errorAlertMessage);
        }
  
      });
    };
  }(jQuery));