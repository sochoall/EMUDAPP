
setTimeout(function(){
    $('.menuprincipal li:has(ul)').click(function(e){
            e.preventDefault();

            if($(this).hasClass('activado'))
            {
                $(this).removeClass('activado');
                $(this).children('ul').slideUp();
            }
            else
            {
                $('.menuprincipal li ul').slideUp();
                $('.menuprincipal li').removeClass('activado');
                $(this).addClass('activado');
                $(this).children('ul').slideDown();
            }
    });

    $('.btn-menu').click(function(){
        $('.contenedor-menu .menuprincipal').slideToggle();
    });

    $(window).resize(function(){
        if($(document).width() > 500)
        {
            $('.contenedor-menu .menuprincipal').css({'display':'block'});
        }

        if($(document).width() < 500)
        {
            $('.contenedor-menu .menuprincipal').css({'display':'none'});
            $('.menuprincipal li ul').slideUp();
            $('.menuprincipal li').removeClass('activado');
        }
    });

    $(".menuprincipal li ul li a").click(function (e) {
        window.location.href = $(this).attr("href");
     });
}, 500);




$(".dt-select tr ").click(function(){
	$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada');   
});