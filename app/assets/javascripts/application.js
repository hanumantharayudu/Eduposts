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
//= require autocomplete-rails
//= require jquery_ujs



// autoScroll
$(document).ready(function() {
    $('#scroller').simplyScroll({
        orientation: 'vertical',
        customClass: 'vert'
    });
});

//add fields
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".faq_box").hide();
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}

function get_username(ht) {
    $.ajax({
        url: "/students/username",
        data: {
            username: $(ht).val()
        },
        type: "PUT",
        success: function(data) {
            if (data == "Error") {
                alert("Error. Please try again");
            } else {
            }
        }
    });
}

//popups

function conversation(school, user) {
    $.ajax({
        url: '/' + school + '/profiles/' + user + '/conversation',
        success: function(data) {
            $("body").css({
                'overflow': "hidden",
                'margin-right': "14px"
            })
            $("#popup_body").html(data);
            $("#overlay").show();
            $("#popup_box").show();
        }
    });
}

function faq(school, user) {
    $.ajax({
        url: '/' + school + '/classes/' + user + '/faqs/faqs',
        success: function(data) {
            $("#popup_body1").html(data);
            $("#overlay").show();
            $("#popup_box1").show();
        }
    });
}

function reading(school, user) {
    $.ajax({
        url: '/' + school + '/classes/' + user + '/readings/readings',
        success: function(data) {
            $("#popup_body1").html(data);
            $("#overlay").show();
            $("#popup_box1").show();
        }
    });
}

function link(school, user) {
    $.ajax({
        url: '/' + school + '/classes/' + user + '/importent_links/links',
        success: function(data) {
            $("#popup_body1").html(data);
            $("#overlay").show();
            $("#popup_box1").show();
        }
    });
}

function reply(user_id, post_id) {
    $.ajax({
        url: '/users/' + user_id + '/posts/' + post_id + '/reply',
        success: function(data) {
            $("body").css({
                'overflow': "hidden",
                'margin-right': "14px"
            })
            $("#popup_body").html(data);
            $("#overlay").show();
            $("#popup_box").show();
        }
    });
}

function report(school, user) {
    $.ajax({
        url: '/' + school + "/profiles/" + user + "/report",
        success: function(data) {
            $("#popup_body1").html(data);
            $("#popup_box1").show();
            $("#overlay").show();
        }
    });
}

function post(school, user) {
    $.ajax({
        url: '/' + school + "/profiles/" + user + "/post",
        success: function(data) {
            $("#popup_body1").html(data);
            $("#popup_box1").show();
            $("#overlay").show();
        }
    });
}

function new_compose(school) {
    $.ajax({
        url: '/' + school + '/profiles/new_compose',
        success: function(data) {
            $("#popup_body1").html(data);
            $("#overlay").show();
            $("#popup_box1").show();
        }
    });
}

function hide_popup() {

    if (jQuery('#popup_box')) {
        jQuery('#popup_body').html("");
        jQuery('#popup_box').hide();
        $("body").css({
            'overflow': "visible",
            'margin-right': "0px"
        })
    }

    if (jQuery('#popup_box1')) {
        jQuery('#popup_body1').html("");
        jQuery('#popup_box1').hide();
    }

    if (jQuery('#overlay')) {
        jQuery('#overlay').hide();
    }
}

//preview image

function readURL(input) {
    if (input.files && input.files[0]) {//Check if input has files.
        var reader = new FileReader();//Initialize FileReader.

        reader.onload = function(e) {
            $('#PreviewImage').attr('src', '/assets/check_loaded.png');
            $('#PreviewImage').show();
            $("#user_photo").hide();
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function readURL1(input) {
    if (input.files && input.files[0]) {//Check if input has files.
        var reader = new FileReader();//Initialize FileReader.

        reader.onload = function(e) {
            $('#PreviewImage2').attr('src', '/assets/check_loaded.png');
            $('#PreviewImage2').show();
        };
        reader.readAsDataURL(input.files[0]);
    }
}


//ajax pagination

$(function() {
    $(".pagination a").on("click", function() {
        $.getScript(this.href);
        return false;
    });
});

//ajac loader

jQuery(document).ajaxStart(function(settings) {
    jQuery('#ajax_loader_big_div').show();
});
jQuery(document).ajaxStop(function() {
    jQuery('#ajax_loader_big_div').hide();
});

//autocomplete scroll

function more_posts(school, page) {
    jQuery('#more_posts_link').remove();
    jQuery.ajax({
        beforeSend: function() {
            $('#ajax_loader_big_div').hide();
            jQuery('#posts').append($("#ajax").show());
        },
        url: "/" + school + "/profiles?page=" + page,
        success: function(data) {
            jQuery('#posts').append(data);
            jQuery($("#ajax"), this).remove();
        }
    });
}

function posts(school, user_id, page) {
    jQuery('#more_posts_link').remove();
    jQuery.ajax({
        beforeSend: function() {
            $('#ajax_loader_big_div').hide();
            jQuery('#posts').append($("#ajax").show());
        },
        url: '/' + school + "/profiles/" + user_id + "?page=" + page,
        success: function(data) {
            $("#ajax").show();
            jQuery('#posts').append(data);
            jQuery($("#ajax"), this).remove();
        }
    });
}


function notification_posts(school, page) {
    jQuery('#more_posts_link').remove();
    jQuery.ajax({
        beforeSend: function() {
            $('#ajax_loader_big_div').hide();
            jQuery('#posts').append($("#ajax").show());
        },
        url: '/' + school + "/notifications/posts?page=" + page,
        success: function(data) {
            $("#ajax").show();
            jQuery('#posts').append(data);
            jQuery($("#ajax"), this).remove();
        }
    });
}

function notification_replies(school, page) {
    jQuery('#more_posts_link').remove();
    jQuery.ajax({
        beforeSend: function() {
            $('#ajax_loader_big_div').hide();
            jQuery('#posts').append($("#ajax").show());
        },
        url: '/' + school + "/notifications?page=" + page,
        success: function(data) {
            $("#ajax").show();
            jQuery('#posts').append(data);
            jQuery($("#ajax"), this).remove();
        }
    });
}

function school_posts(user_id, student_id, page) {
    jQuery('#more_posts_link').remove();
    jQuery.ajax({
        beforeSend: function() {
            $('#ajax_loader_big_div').hide();
            jQuery('#posts').append($("#ajax").show());
        },
        url: "/schools/" + user_id + "/students/" + student_id + "?page=" + page,
        success: function(data) {
            jQuery('#posts').append(data);
            jQuery($("#ajax"), this).remove();
        }
    });
}


//change background image

var backImage = ["/assets/Amazing_Flowers_Wallpapers_55.jpg", "/assets/scene3.jpg", "/assets/rain1.jpg", "/assets/moss.jpg", "/assets/nature2.jpg"];
var count = 0;
function changeBGImage(school, whichImage, id) {
    count++;
    $(".cover_photo").css("background-image", "url(" + backImage[(count - 1)] + ")");
    $.ajax({
        url: "/" + school + "/profiles/switch_theme",
        type: 'PUT',
        data: {
            url: backImage[(count - 1)],
            id: id
        },
        success: function(data) {
        }
    });
    if (count == 5) {
        count = 0;
    }

}


var backImage = ["/assets/Amazing_Flowers_Wallpapers_55.jpg", "/assets/scene3.jpg", "/assets/rain1.jpg", "/assets/moss.jpg", "/assets/nature2.jpg"];
var count = 0;
function changeclassBGImage(school, whichImage, id) {
    count++;
    $(".cover_photo").css("background-image", "url(" + backImage[(count - 1)] + ")");
    $.ajax({
        url: "/" + school + "/classes/switch_theme",
        type: 'PUT',
        data: {
            url: backImage[(count - 1)],
            id: id
        },
        success: function(data) {
        }
    });
    if (count == 5) {
        count = 0;
    }

}

//onclick extend the box


$(document).ready(function() {
    var mouse_in_side = false;

    $("#area").click(function() {
        $("#area").css('min-height', '100px');
        $("#file_browse_wrapper1").show();
        $('.box_l1_hp').css('min-height', '240px');
        $('#PreviewImage').hide();
        $("#post").show();
        mouse_in_side = true;
    })

    $('.box_l1_hp').hover(function() {
        mouse_in_side = true;
    }, function() {
        mouse_in_side = false;
    });

    $('.conversation_post_input_box').hover(function() {
        mouse_in_side = true;
    }, function() {
        mouse_in_side = false;
    });

    $(document).click(function() {
        if (mouse_in_side == false) {
            $("#area").css('min-height', '10px');
            $("#file_browse_wrapper1").hide();
            $('.box_l1_hp').css('min-height', 'auto');
            $("#post").hide();
            $('#PreviewImage').hide();
        }
    });
});

//login form for ajax call

function student_login(user) {
    $.ajax({
        type: 'GET',
        url: "/users/sign_in",
        data: {
            role: user
        },
        success: function(data) {

        }
    });
}


function password_login(user) {
    $.ajax({
        type: 'GET',
        url: "/users/password/new",
        data: {
            role: user
        },
        success: function(data) {

        }
    });
}

$(document).ajaxError(function(e, XHR, options) {
    val1 = $('#user_email').val();
    val2 = $('#user_password').val();
    val3 = $('#user_role').val();
    if (val3 == 'student') {
        role = "#error"
    } else {
        role = "#error2"
    }
    if (XHR.status == 401) {
        if (val1 != '' || val2 != '') {
            $(role).show();
        } else {
            $(role).hide();
        }
    }
});

//onclick expand the data


function expand(post_id) {
    $("#expa_" + post_id).show();
    $("#pos_" + post_id).hide();
    $("#expand_" + post_id).hide();
    $("#unexpand_" + post_id).show();
}

function unexpand(post_id) {
    $("#expa_" + post_id).hide();
    $("#pos_" + post_id).show();
    $("#expand_" + post_id).show();
    $("#unexpand_" + post_id).hide();
}

function expand1(post_id) {
    $("#expa1_" + post_id).show();
    $("#pos1_" + post_id).hide();
    $("#expand1_" + post_id).hide();
    $("#unexpand1_" + post_id).show();
}

function unexpand1(post_id) {
    $("#expa1_" + post_id).hide();
    $("#pos1_" + post_id).show();
    $("#expand1_" + post_id).show();
    $("#unexpand1_" + post_id).hide();
}

function expand2(post_id) {
    $("#expa2_" + post_id).show();
    $("#pos2_" + post_id).hide();
    $("#expand2_" + post_id).hide();
    $("#unexpand2_" + post_id).show();
}

function unexpand2(post_id) {
    $("#expa2_" + post_id).hide();
    $("#pos2_" + post_id).show();
    $("#expand2_" + post_id).show();
    $("#unexpand2_" + post_id).hide();
}

function GetSubjects(sub) {
    $.ajax({
        url: "/teachers/" + sub + "/assign_subject/",
        method: "GET",
        dataType: "script",
        success: function(date) {

        }
    });
}
