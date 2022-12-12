// Copyright 2013 Google Inc. All Rights Reserved.

/**
 * @fileoverview JSCIN for Chrome Extension, background start entry.
 * @author hungte@google.com (Hung-Te Lin)
 */

document.addEventListener( 'readystatechange', function() {
  if (document.readyState === 'complete') {
    croscin.instance = new croscin.IME;

    // TODO Sync with content.js behavior.
    if (croscin.instance.ime_api.isEmulation) {
      var impl = new ChromeInputImeImplChromeExtension('background');
      impl.init();
    }
  }
});
