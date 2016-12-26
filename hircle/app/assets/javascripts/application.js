// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require fullcalendar
//= require fullcalendar.min
//= require calendar.js
//= require user_settings
//= require dashboard
//= require landing-page-forms.js
//= require bootstrap.js
//= require bootstrap-affix.js
//= require bootstrap-transition.js
//= require bootstrap-button.js
//= require bootstrap-carousel.js
//= require bootstrap-custom.js
//= require bootstrap-dropdown.js
//= require bootstrap-modal.js
//= require bootstrap-popover.js
//= require bootstrap-scrollspy.js
//= require bootstrap-tab.js
//= require bootstrap-typeahead.js
//= require bootstrap-datepicker.js
//= require select.js
//= require prettify.js
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/hircle

//= require_tree .



// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
// IT'S ALL JUST JUNK FOR OUR DOCS!
// ++++++++++++++++++++++++++++++++++++++++++

!function ($) {

  $(function(){

    var $window = $(window)

    // Disable certain links in docs
    $('section [href^=#]').click(function (e) {
      e.preventDefault()
    })

    // side bar
    setTimeout(function () {
      $('.bs-docs-sidenav').affix({
        offset: {
          top: function () { return $window.width() <= 980 ? 290 : 210 }
        , bottom: 270
        }
      })
    }, 100)

    // make code pretty
    window.prettyPrint && prettyPrint()

    // add-ons
    $('.add-on :checkbox').on('click', function () {
      var $this = $(this)
        , method = $this.attr('checked') ? 'addClass' : 'removeClass'
      $(this).parents('.add-on')[method]('active')
    })

    // add tipsies to grid for scaffolding
    if ($('#gridSystem').length) {
      $('#gridSystem').tooltip({
          selector: '.show-grid > [class*="span"]'
        , title: function () { return $(this).width() + 'px' }
      })
    }

    // tooltip demo
    $('.tooltip-demo').tooltip({
      selector: "a[data-toggle=tooltip]"
    })

    $('.tooltip-test').tooltip()
    $('.popover-test').popover()

    // popover demo
    $("a[data-toggle=popover]")
      .popover()
      .click(function(e) {
        e.preventDefault()
      })

    // button state demo
    $('#fat-btn')
      .click(function () {
        var btn = $(this)
        btn.button('loading')
        setTimeout(function () {
          btn.button('reset')
        }, 3000)
      })

    // carousel demo
    $('#myCarousel').carousel()

    // javascript build logic
    var inputsComponent = $("#components.download input")
      , inputsPlugin = $("#plugins.download input")
      , inputsVariables = $("#variables.download input")

    // toggle all plugin checkboxes
    $('#components.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsComponent.attr('checked', !inputsComponent.is(':checked'))
    })

    $('#plugins.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsPlugin.attr('checked', !inputsPlugin.is(':checked'))
    })

    $('#variables.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsVariables.val('')
    })

    // request built javascript
    $('.download-btn .btn').on('click', function () {

      var css = $("#components.download input:checked")
            .map(function () { return this.value })
            .toArray()
        , js = $("#plugins.download input:checked")
            .map(function () { return this.value })
            .toArray()
        , vars = {}
        , img = ['glyphicons-halflings.png', 'glyphicons-halflings-white.png']

    $("#variables.download input")
      .each(function () {
        $(this).val() && (vars[ $(this).prev().text() ] = $(this).val())
      })

      $.ajax({
        type: 'POST'
      , url: /\?dev/.test(window.location) ? 'http://localhost:3000' : 'http://bootstrap.herokuapp.com'
      , dataType: 'jsonpi'
      , params: {
          js: js
        , css: css
        , vars: vars
        , img: img
      }
      })
    })
  })

// Modified from the original jsonpi https://github.com/benvinegar/jquery-jsonpi
$.ajaxTransport('jsonpi', function(opts, originalOptions, jqXHR) {
  var url = opts.url;

  return {
    send: function(_, completeCallback) {
      var name = 'jQuery_iframe_' + jQuery.now()
        , iframe, form

      iframe = $('<iframe>')
        .attr('name', name)
        .appendTo('head')

      form = $('<form>')
        .attr('method', opts.type) // GET or POST
        .attr('action', url)
        .attr('target', name)

      $.each(opts.params, function(k, v) {

        $('<input>')
          .attr('type', 'hidden')
          .attr('name', k)
          .attr('value', typeof v == 'string' ? v : JSON.stringify(v))
          .appendTo(form)
      })

      form.appendTo('body').submit()
    }
  }
})

}(window.jQuery)
$(document).ready(function() {
  $('#user_password_confirmation').attr('disabled', 'disabled');

  $('#user_password').on('keyup',function() {
    $('#user_password_confirmation').removeAttr('disabled');
  })

  
  // Himanshu Saxena - My code starts here
  //-------------------------------------
  
  //user_settings() // function defined in user_settings.js
  
  // Himanshu Saxena - My code ends here
  //------------------------------------

  });

$(function() {
  // var faye = new Faye.Client('http://localhost:9292/faye');
  // faye.subscribe('/messages/new', function (data) {
  // var chatWindow = $('#chat_window').text();
  //   $('#chat_window').text(chatWindow + data.text);
  //   });

  // $('#chat_send').click(function(){
  //   var chatText = $('#chat_text').find('input[type="text"]').val();
  //   var chatWindow = $('#chat_window').text();
  //   var publication = faye.publish('/messages/new', {text: chatText})

  //   publication.callback(function() {
  //     $('#chat_window').text(chatWindow + chatText );
  //   });
  // });
});


oFReader = new FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
 
oFReader.onload = function (oFREvent) {
    document.getElementById("uploadPreview").src = oFREvent.target.result;
};
 
function loadImageFile() {
  console.log("OK?");
  if (document.getElementById("logo").files.length === 0) { return; }
  var oFile = document.getElementById("logo").files[0];
  if (!rFilter.test(oFile.type)) { alert("You must select a valid image file!"); return; }
  oFReader.readAsDataURL(oFile);
}


$(function(){
  $('.messageTextarea').keydown(function(event) {
    if (event.keyCode == 13) {
        $(this.form).submit()
        return false;
     }
  }).focus(function(){
    if(this.value == "Write your comment here..."){
      this.value = "";
    }

  }).blur(function(){
    if(this.value==""){
      this.value = "Write your comment here...";
    }
  }); 


   // bind form using ajaxForm
  $('.new-message').submit(function(e) {
    console.log("submit");
    e.preventDefault();
    $('input[name=\"submit\"]').attr("disabled", 'true');   
    var empty = $(this).find('input[type=\"text\"]').val().trim() == ''; 

    if (empty)
      return false; 
    var  ref = $(this); 
    $.ajax({
      type: "post",
      url: $(this).attr('action'), 
      data: $(this).serialize(),
      // dataType identifies the expected content type of the server response
      dataType:  'json',
      beforeSend: function() {
        console.debug('-1111');
        ref.find('.messageTextarea:first').attr('disabled', true); 

      }, 
      // success identifies the function to invoke when the server response
      // has been received
      success: function(data) {

        ref.disabled = false; 
        //check widget presence
        // var widget = $('body').find('#widget_' + data.message.recipient_id);
         
    

        // var activity = $('#chat-widget ul.activity-stream .activity:first').clone().show();
        // activity.find('.screen-name:first').text(data.message.email);
        // activity.find('.text:first').text(data.message.body);
        // activity.find('.timestamp span:first').text(data.message.created_at); 

 
        // widget.find(".activity-stream:first").append(activity);   
    
      }
    }); 
  });

  $('.pusher-chat-widget-header').click(function(e) {
    e.preventDefault();
    $(this).find('.pusher-chat-widget-messages:first').toggle();
    $(this).find('.pusher-chat-widget-input:first').toggle(); 
  });
});