﻿$(document).ready(function () {
    $('ul[data-tab="tab"] li a[data-tag]').click(function (e) {
        e.preventDefault();
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
        });

        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $('ul[data-tab="tab"]').mouseover(function () {
        $("#barCursor").css("opacity", "1");
    }).mouseout(function () {
        $("#barCursor").css("opacity", "0");
    });
});