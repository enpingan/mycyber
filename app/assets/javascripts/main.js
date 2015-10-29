$.ajaxSetup({
  'beforeSned': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

// $.fn.ajaxPagination = function() {
//   this.on("click", function() {
//     $.get(this.href, null, null, "script");
//     return false;
//   });
// }

$(document).ready( function () {

  $('#btn_login').fadeTo(1,0.2);
  // $('#btn_login').attr('disabled', 'disabled');
  
  $('#user_username').on('input', function() {
    tmp = $(this).val();
    t2 = $('#user_password').val();

    if (tmp != '' && t2 != '') {
      $('#btn_login').fadeTo(1,1);
      $('#btn_login').removeAttr('disabled').css('cursor','pointer');
    } else {
      $('#btn_login').fadeTo(1,0.2);
      $('#btn_login').attr('disabled', 'disabled').css('cursor', 'no-drop');
    }
  });

  $('#user_password').on('input', function() {
    tmp = $(this).val();
    t2 = $('#user_username').val();

    if (tmp != '' && t2 != '') {
      $('#btn_login').fadeTo(1,1);
      $('#btn_login').removeAttr('disabled').css('cursor','pointer');
    } else {
      $('#btn_login').fadeTo(1,0.2);
      $('#btn_login').attr('disabled', 'disabled').css('cursor', 'no-drop');
    }
  });

  $('#btn_login').on('click', function() {
    var tmp = $('#user_username').val(),
        t2 = $('#user_password').val();

    if (tmp == '' || t2 == '') {
      return false;
    }
  });

  function toggleNavbarMethod() {
    if ($(window).width() > 768) {
      $('.navbar-nav .dropdown').on('mouseover', function(){
        $('.dropdown-toggle', this).trigger('click');
        // console.log('in');
      }).on('mouseout', function(){
        $('.dropdown-toggle', this).trigger('click').blur();
        // console.log('out');
      });
    }
    else {
      $('.navbar-nav .dropdown').off('mouseover').off('mouseout');
    }
  }

  // toggle navbar hover
  toggleNavbarMethod();
  // bind resize event
  $(window).resize(toggleNavbarMethod);

  $(document).on('change', '#select_ticket_rows', function(e) {
    $('#ticket_rows').val($("#select_ticket_rows option:selected").val());

    $.get('/tickets.js',
    {
      'ticket_rows' : $("#select_ticket_rows option:selected").val()
    });
    // $('#form_ticket_rows').submit();
  });

  $(document).on('change', '#select_device_rows', function(e) {
    $('#device_rows').val($("#select_device_rows option:selected").val());

    $.get('/devices.js',
    {
      'device_rows' : $("#select_device_rows option:selected").val()
    });
    // $('#form_device_rows').submit();
  });  

  $(document).on('change', '#select_security_rows', function(e) {
    $('#security_rows').val($("#form_security_rows option:selected").val());

    $.get('/devices/security.js',
    {
      'security_rows' : $("#form_security_rows option:selected").val(),
      'device_name' : $('#device_name').val()
    });
    // $('#form_ticket_rows').submit();
  });

  $(document).on('click', '#security .pagination a', function(e) {
    $('#security_rows').val($("#form_security_rows option:selected").val());

    $.get('/devices/security.js',
    {
      'page' : $(this).text(),
      'security_rows' : $("#form_security_rows option:selected").val(),
      'device_name' : $('#device_name').val()
    });
  });

  $(document).on('change', '#_qselect_ticket_subject', function(e) {
    // $('#_tickets_quickadd_subject').val($("#_qselect_ticket_subject option:selected").val());
    $('#quickadd_subject').val($("#_qselect_ticket_subject option:selected").val());
  });

  $(document).on('change', '#_qselect_ticket_last_replied', function(e) {
    // $('#_tickets_quickadd_last_replied').val($("#_qselect_ticket_last_replied option:selected").val());
    $('#quickadd_owner').val($("#_qselect_ticket_last_replied option:selected").val());
  });

  $(document).on('change', '#_qselect_ticket_owner', function(e) {
    // $('#_tickets_quickadd_owner').val($("#_qselect_ticket_owner option:selected").val());
    $('#quickadd_last_replied').val($("#_qselect_ticket_owner option:selected").val());
  });

  $(document).on('change', '#_qselect_ticket_device', function(e) {
    // $('#_tickets_quickadd_device').val($("#_qselect_ticket_device option:selected").val());
    $('#quickadd_device').val($("#_qselect_ticket_device option:selected").val());
  });

  $(document).on('change', '#select_ticket_subject', function(e) {
    $('#ticket_subject').val($("#select_ticket_subject option:selected").val());
  });

  $(document).on('change', '#select_ticket_last_replied', function(e) {
    $('#ticket_last_replied').val($("#select_ticket_last_replied option:selected").val());
  });

  $(document).on('change', '#select_ticket_owner', function(e) {
    $('#ticket_owner').val($("#select_ticket_owner option:selected").val());
  });

  $(document).on('change', '#select_ticket_device', function(e) {
    $('#ticket_device').val($("#select_ticket_device option:selected").val());
  });

  $(document).on('change', '#combo_device_rows', function(e) {
    $('#form_device_rows').submit();
  });

  // $(document).on('change', '#combo_ticket_rows', function(e) {
  //   $('#form_ticket_rows').submit();
  // });

  $(document).on('click', '.btn-reply', function(e) {
    // var c_info = [];
    // var text_id = $(this).attr('id');
    // var tmp = text_id.substring(12, text_id.length);
    // text_id = "#text_comment_"+tmp;

    // c_info['user_id'] = "1";
    // c_info['user_email'] = "user@mail.com";
    // c_info['ticket_id'] = "1";
    // c_info['ticket_name'] = "ticket";
    // c_info['content'] = $(text_id).val();

    // $.post( "/tickets/add_comments", { 
    //         'comment_info[user_id]': c_info['user_id'], 'comment_info[user_email]': c_info['user_email'], 
    //         'comment_info[ticket_id]': c_info['ticket_id'], 'comment_info[ticket_name]': c_info['ticket_name'],
    //         'comment_info[content]': c_info['content']
    //      } );
    // $.ajax({
    //   type: 'POST',
    //   url: '/tickets/add_comments',
    //   data: { rows: $("#combo_rows").val() },
    //   success:function(data){
    //     console.log("rows changed")
    //   },
    //   error:function(){
    //     console.log("An error occur in changing rows")
    //   }
    // });
  });

  $(document).on('click', '#btn_dtickets', function(e) {
    $('#form_device_tickets').submit();
    return false;
  });

  $(document).on('click', '#btn_dusage', function(e) {
    // $('#form_device_usage').submit();
    return false;
  });

  $(document).on('click', '.btn_dpassword', function(e) {
    var tmp = $(this).attr('id');
    if ( tmp.length > 0 ) {
      tmp = tmp.substring( 14, tmp.length );
      tmp = '#form_device_password_' + tmp;
      $(tmp).submit();
    }

    return false;
  });

  $(document).on('click', '.btn_dsecurity', function(e) {
    var tmp = $(this).attr('id');
    if ( tmp.length > 0 ) {
      tmp = tmp.substring( 14, tmp.length );
      tmp = '#form_device_security_' + tmp;
      $(tmp).submit();
    }

    return false;
  });

  $(document).on('click', '#table_tickets th', function(e) { 
    var tmp = $(this).html()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim($(this).text())
        , direction = "";


    if ( tmp != '&nbsp;&nbsp;' ) {
      if (s_end == "▼") {
        s_end = "&#9650";
        tmp = $(this).html();
        tmp = tmp.substring(0,tmp.length-1);

        tmp = tmp + s_end;
        direction = "asc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);
      } else if (s_end == "▲") {
        s_end = "&#9660";
        tmp = $(this).html();
        tmp = tmp.substring(0,tmp.length-1);

        tmp = tmp + s_end;
        direction = "desc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);
      } else {
        $(this).html($(this).html()+"&#9650");
        direction = "asc";
      }
    }

    $.get('/tickets.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'ticket_rows' : $("#select_ticket_rows option:selected").val()
    });
  });

  $(document).on('click', '#table_devices th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp != "  " && tmp != "Action") {
      if (s_end == "▼") {
        s_end = "&#9650";
        tmp = $(this).html();

        tmp = tmp.substring(0,tmp.length-1);
        tmp = tmp + s_end;
        direction = "asc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);

      } else if (s_end == "▲") {
        s_end = "&#9660";
        tmp = $(this).html();

        tmp = tmp.substring(0,tmp.length-1);
        tmp = tmp + s_end;
        direction = "desc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);
      } else {
        $(this).html($(this).html()+"&#9650");
        direction = "asc";
      }
    }

    $.get('/devices.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'device_rows' : $("#select_device_rows option:selected").val()
    });
  });
  
  $(document).on('click', '#btn_submit_quickadd', function(e) { 
    $('#form_quickadd_ticket').submit();
  });  

  $(document).on('click', '#btn_refresh_tickets', function(e) { 
    location.reload();
  });

  $(document).on('click', '#btn_refresh_device', function(e) { 
    location.reload();
  });  

  $(document).on('click', '#btn_filter_tickets', function(e) { 
    $('.filter-div').fadeIn(150);
  });

  $(document).on('click', '#btn_filter_devices', function(e) { 
    $('.filter-div').fadeIn(150);
  });

  $(document).on('click', '#btn_quickadd_tickets', function(e) { 
    $('.quickadd-div').fadeIn(150);
  });

  $(document).on('click', '#btn_cancel_filter', function(e) { 
    $('.filter-div').fadeOut(150);
  });

  function redirecting_some () {
    location.reload();
  }

  $(document).on('click', '#admin_table_devices', function(e) { 
    location.href = "/devices";
  });

  $(document).on('click', '#admin_table_tickets', function(e) { 
    location.href = "/tickets";
  });

  $(document).on('click', '.span-note', function(e) { 
    var pathname = window.location.pathname;

    tmp = $(this).attr('note');
    if (tmp == 'devices') {
      location.href = "/devices/security";  
    } else {
      location.href = "/tickets";  
    }
  });

  $(document).on('click', '.span-close', function(e) { 
    // $('.div-notice').fadeOut(150);
    tmp = window.location.href;
    tmp = tmp.substring(tmp.length - 5);

    $('.div-notice').css('display', 'none');
    if (tmp != "admin") {
      $('.content-div').css("margin-top","15%");
    }
  });

  $(document).on('click', '.tr-dropdown-ticket', function(e) { 
    var con = $(this).find('td').eq(0);
    var tmp = $(this).find('td').eq(1).text();
    tmp = tmp.substring(2, tmp.length);
    var tr_id = "#comments_" + tmp;   

    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(150);
    } else {
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(150);
    }

    tmp = $(this).find('td').eq(1).text();
    tmp = tmp.substring(2, tmp.length);
    var icon_id = "#icon_mail_" + tmp;
    $(icon_id).css("color", "white");

    var span_id = "#span_mail_" + tmp;
    $(span_id).css("color", "white");
    span_id = span_id + "_2";
    $(span_id).css("color", "white");

    $.post('/tickets/check_comment',
      { 'ticket_id': tmp });
    // $('#form_check_comment').submit();
  });  

  $(document).on('click', '#table_devices tr .clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(1).text();// + "_" + $(this).parent().find('td').eq(4).text() + "_" + $(this).parent().find('td').eq(5).text();

    var tr_id = "#servers_" + tmp;

    // if ( con.text() != "" ) {
      tmp = $(tr_id).css("display");
      if ( tmp == "none" ) {
        con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
        console.log(tr_id);
        $(tr_id).fadeIn(150);
      } else {
        con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
        console.log(tr_id);
        $(tr_id).fadeOut(150);
      }
    // }
  });

  $(document).on('click', '#table_password tr .clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0).text();
    var tmp = $(this).parent().find('td').eq(1).text();

    var tr_id = "#tr_crpwd_" + con;

    if ( con != "" ) {
      tmp = $(tr_id).css("display");
      if ( tmp == "none" ) {
        $(tr_id).fadeIn(150);
      } else {
        $(tr_id).fadeOut(150);
      }
    }
  });

  $(document).on('click', '.btn-cduser', function() {
    var tmp = $(this).attr('id');
    // btn_rduser_
    tmp = tmp.substring(11, tmp.length);
    var tid = '#tr_crpwd_' + tmp;
    $(tid).fadeOut(150);
  });

  $('#table_tickets').find('tr').click( function(){
    // alert('You clicked row '+ ($(this).index()+1) );    
  });

  $(document).on('click', '#btn_ticket_quickadd_close', function(e) { 
    $('.quickadd-div').fadeOut(150);
    return false;
  });
  
  $(document).on('click', '#btn_cancel_ticket_filter', function(e) { 
    $('.filter-div').fadeOut(150);
    return false;
  });

  $(document).on('click', '#btn_cancel_device_filter', function(e) { 
    $('#div_device_filter').fadeOut(150);
    return false;
  });

  $(document).on('change', '#select_device_action', function(e) {
    tmp = $("#select_device_action option:selected").val();
    
    $('#request_order').val(tmp);
    $('#form_send_actions').submit();
  });

  $(document).on('change', '.sda2', function(e) {
    tmp = $.trim($(this).find('select option:selected').val());
    var tr_val = $(this).parent().parent();

    dname = tr_val.find('td').eq(1).text();
    $('#request_order').val(tmp);

    $.get('/devices.js', 
    {
      'device_name' : dname,
      'request' : tmp
    });
    // $('#form_send_actions2').submit();
  });

  $(document).on('click', '.btn-dshowpwd', function(e) {
    tmp = $(this).attr('id');
    tmp = tmp.substring(18, tmp.length);

    var tid = '#pwd_device_' + tmp;

    if ($(tid).get(0).type == 'password') {
      $(tid)[0].type = 'text';
    } else {
      $(tid)[0].type = 'password';  
    }
  });

});
