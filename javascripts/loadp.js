/*
Web Construction / Web Design / Web Programming / SEO by:
  ___  _    _ _______ __  __ _                           
 / _ \| |  | |__   __|  \/  | |                          
| (_) | |__| |  | |  | \  / | |       ___ ___  _ __ ___  
 > _ <|  __  |  | |  | |\/| | |      / __/ _ \| '_ ` _ \ 
| (_) | |  | |  | |  | |  | | |____ | (_| (_) | | | | | |
 \___/|_|  |_|  |_|  |_|  |_|______(_)___\___/|_| |_| |_|
*/
(function (a, f, d) {
    function c(a) {
        a = a || location.href;
        return "#" + a.replace(/^[^#]*#?(.*)$/, "$1")
    }
    var e = document,
        b, g = a.event.special,
        h = e.documentMode,
        m = "onhashchange" in f && (h === d || 7 < h);
    a.fn.hashchange = function (a) {
        return a ? this.bind("hashchange", a) : this.trigger("hashchange")
    };
    a.fn.hashchange.delay = 50;
    g.hashchange = a.extend(g.hashchange, {
        setup: function () {
            if (m) return !1;
            a(b.start)
        },
        teardown: function () {
            if (m) return !1;
            a(b.stop)
        }
    });
    var p = function () {
        var d = c(),
            e = q(l);
        d !== l ? (n(l = d, e), a(f).trigger("hashchange")) : e !== l && (location.href = location.href.replace(/#.*/, "") + e);
        j = setTimeout(p, a.fn.hashchange.delay)
    }, g = {}, j, l = c(),
        n = h = function (a) {
            return a
        }, q = h;
    g.start = function () {
        j || p()
    };
    g.stop = function () {
        j && clearTimeout(j);
        j = d
    };
    if (a.browser.msie && !m) {
        var i, k;
        g.start = function () {
            i || (k = (k = a.fn.hashchange.src) && k + c(), i = a('<iframe tabindex="-1" title="empty"/>').hide().one("load", function () {
                k || n(c());
                p()
            }).attr("src", k || "javascript:0").insertAfter("body")[0].contentWindow, e.onpropertychange = function () {
                try {
                    "title" === event.propertyName && (i.document.title = e.title)
                } catch (a) {}
            })
        };
        g.stop = h;
        q = function () {
            return c(i.location.href)
        };
        n = function (d, c) {
            var b = i.document,
                h = a.fn.hashchange.domain;
            d !== c && (b.title = e.title, b.open(), h && b.write('<script>document.domain="' + h + '"<\/script>'), b.close(), i.location.hash = d)
        }
    }
    b = g
})(jQuery, this);

function sort_unique(a) {
    for (var a = a.sort(function (a, d) {
        return a.localeCompare(d)
    }), f = [a[0]], d = 1; d < a.length; d++) a[d - 1] !== a[d] && f.push(a[d]);
    return f
}
$(document).ready(function () {
    0 < $(".showcase").length && $(".showcase").simplyScroll();
    1 == $("#slider").length && $("#slider").sliderkit({
        auto: !0,
        circular: !0,
        panelfx: "sliding",
        autospeed: 5E3
    });
    1 == $("#newsslider").length && $("#newsslider").sliderkit({
        auto: !0,
        circular: !0,
        shownavitems: 1,
        panelfx: "sliding",
        panelfxspeed: 400,
        verticalnav: !0,
        verticalslide: !0
    });
    $("#menupop, #menupop2").css({
        position: "absolute",
        top: $("#lnkper").offset().top + $("#lnkper").outerHeight(),
        width: $("#wrapper").width()
    });
    1 == $("#allintros").length && $("#allintros").css({
        position: "absolute",
        top: $("#sintro").offset().top + $("#sintro").outerHeight() - 1,
        left: $("#sintro").offset().left
    });
    1 == $("#allservices").length && $("#allservices").css({
        position: "absolute",
        top: $("#sservice").offset().top + $("#sservice").outerHeight() - 1,
        left: $("#sservice").offset().left
    });
    1 == $("#allmalls").length && $("#allmalls").css({
        position: "absolute",
        top: $("#malls").offset().top + $("#malls").outerHeight() - 1,
        left: $("#malls").offset().left
    });
    var a = function () {
        $(".redbar li").removeClass("hidden");
        $("#lnkper").addClass("sel");
        $("#panelper .ph:first").addClass("cur");
        $("#menupop").removeClass("hidden");
        $("select").css({
            visibility: "hidden"
        });
        var a = 0;
        $("#panelper .ps, #panelper .ps2").each(function (c, e) {
            $(e).height() > a && (a = $(e).height())
        }).height(a)
    }, f = function () {
        $(".redbar li").addClass("hidden");
        $("#lnkper").removeClass("sel");
        $("#panelper .ph:first").removeClass("cur");
        $("#menupop").addClass("hidden");
        $("select").css({
            visibility: "visible"
        })
    }, y = function () {
        $(".redbar2 li").removeClass("hidden");
        $("#lnkper2").addClass("sel");
        $("#panelper2 .ph:first").addClass("cur");
        $("#menupop2").removeClass("hidden");
        $("select").css({
            visibility: "hidden"
        });
        var a = 0;
        $("#panelper2 .ps, #panelper2 .ps2").each(function (c, e) {
            $(e).height() > a && (a = $(e).height())
        }).height(a)
    }, z = function () {
        $(".redbar2 li").addClass("hidden");
        $("#lnkper2").removeClass("sel");
        $("#panelper2 .ph:first").removeClass("cur");
        $("#menupop2").addClass("hidden");
        $("select").css({
            visibility: "visible"
        })
    };
    $("#lnkper").hover(a, f);
    $("#menupop").hover(a, f);
    $("#lnkper2").hover(y, z);
    $("#menupop2").hover(y, z);
    $("#sintro, #allintros").hover(function () {
        var a = $("#sintro").offset().left;
        $("#sintro").addClass("malls_spec sel").css({
            left: a
        });
        $("#allintros").removeClass("hidden").css({
            left: a
        });
		$("#sintro").next(".sepr").css('marginLeft', $("#sintro").outerWidth());
    }, function () {
        $("#sintro").removeClass("malls_spec sel");
        $("#allintros").addClass("hidden");
		$("#sintro").next(".sepr").css('marginLeft', 0);
    });
    $("#sservice, #allservices").hover(function () {
        var a = $("#sservice").offset().left;
        $("#sservice").addClass("malls_spec sel").css({
            left: a
        });
        $("#allservices").removeClass("hidden").css({
            left: a
        });
		$("#sservice").next(".sepr").css('marginLeft', $("#sservice").outerWidth());
    }, function () {
        $("#sservice").removeClass("malls_spec sel");
        $("#allservices").addClass("hidden");
		$("#sservice").next(".sepr").css('marginLeft', 0);
    });
    $("#malls, #allmalls").hover(function () {
        var a = $("#malls").offset().left;
        $("#malls").addClass("malls_spec sel").css({
            left: a
        });
        $("#allmalls").removeClass("hidden").css({
            left: a
        })
    }, function () {
        $("#malls").removeClass("malls_spec sel");
        $("#allmalls").addClass("hidden")
    });
    1 == $("#etalage").length && $("#etalage").etalage({
        thumb_image_width: 250,
        thumb_image_height: 250,
        source_image_width: 600,
        source_image_height: 600,
        zoom_area_width: 300,
        zoom_area_height: 300,
        zoom_area_distance: 5,
        small_thumbs: 4,
        smallthumb_inactive_opacity: 0.3,
        smallthumbs_position: "bottom",
        speed: 200,
        show_icon: !1,
        autoplay: !1,
        keyboard: !1,
        zoom_easing: !1
    });
    $('#etalage').bind('contextmenu', function(){return false;});
    $(".tabbtn").bind("click", function () {
        var a = $(this).parent().index();
        $(".tabbtn").removeClass("sel");
        $(this).addClass("sel");
        $(".maincontent div.mc").hide();
        $(".maincontent div").eq(a).show()
    });
    $("a.otherp").each(function (a, c) {
        $("b", c).offset().top != $("i", c).offset().top && $("<br />").css({
            clear: "both"
        }).insertBefore(c)
    });
    1 == $("#sdprov").length && 1 == $("#sdcity").length && $.getJSON("/stores.json", function (a) {
        var c = [];
        $.each(a, function (a, b) {
            c.push(b[1])
        });
        c = sort_unique(c);
        $.each(c, function (a, b) {
            $("<option />", {
                text: b,
                value: b
            }).appendTo("#sdprov")
        });
        $("#sdprov").bind("change", function () {
            $("#sdcity").empty().append('<option value="">\u8bf7\u9009\u62e9</option>');
            var e = $(this).val();
            if ("" != e) {
                var b = [];
                $.each(a, function (a, c) {
                    c[1] == e && b.push(c[2])
                });
                b = sort_unique(b);
                $.each(b, function (a, b) {
                    $("<option />", {
                        text: b,
                        value: b
                    }).appendTo("#sdcity")
                })
            }
        });
        $("#sdfind").bind("click", function () {
            var a = $("#sdprov").val(),
                b = $("#sdcity").val();
            window.open("/stores/" + ("" == a ? "" : "" == b ? "#" + a : "#" + a + "-" + b))
        })
    })
});
