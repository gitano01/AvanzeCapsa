// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function validarFormularioProductos() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")) {
        var message, x;
        var band = 0;
        var bandCategorias = 0;
        var bandKit = 0;
        var bandInputKit = 0;
        var campos = ["nombre", "descripcion", "codigo", "precio", "precio_costo"];
        var msgs = ["msg_nombre", "msg_descripcion", "msg_codigo", "msg_precio", "msg_precio_costo"];
        var primerCampo;
        for (i = 0; i < 5; i++) {
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                if (x == "") throw "no puede estar vacío";
                if (isNaN(x) && i > 2) throw "no es un número";
                if (x <= 0 && i > 2) throw "no puede tener valor negativo "
            }
            catch (err) {
                message.innerHTML = "* Este campo " + err;
                document.getElementById(msgs[i]).style.color = "red";
                document.getElementById(campos[i]).style.border = "solid .5px red";
                if (band == 0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        $("#lista_categorias input[type=checkbox]").each(function () {
            if ($(this).attr("checked"))
                bandCategorias = 1;
        });

        $("#tbody_kit tr").children().children("input").each(function () {
            if (parseInt($(this).val()) > 99 || parseInt($(this).val()) <= 0 || $(this).val()== "" )
            {
                bandInputKit = 1;
                $(this).css("border-color","red");
            }
        });
        if (bandCategorias === 0)
            $("#mensaje_categorias").html("*No has elegido ninguna categoría").css("color", "red");
        else
            $("#mensaje_categorias").html("");


        if (($("#check_kit").attr("checked") && $("#tbody_kit tr").length > 0) || !$("#check_kit").attr("checked")){
            $("#mensaje_kit").html("");
            bandKit = 1;
        }
        else
        {
            $("#mensaje_kit").html("*No has elegido ningun producto para el Kit").css("color","red");
        }
        if(bandInputKit)
        {
            $("#mensaje_kit").html(" *Los campos de cantidad solo aceptan valores entre 1 y 99 ").css("color","red");
        }

        if (band == 0 && bandCategorias == 1 && bandKit && !bandInputKit) {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            $("#array_productos").val(recuperarDatosKit(1));
            $("#array_cantidades").val(recuperarDatosKit(0));
            return true;
        }
        else {
            if(primerCampo)
            document.getElementById(primerCampo).focus();
            return false;
        }
    }
    else
        return false;
}
function recuperarDatosKit(bandera){
    var productos_kit = new Array();
    var cantidades_kit = new Array();
    var i=0;
    $("#tbody_kit tr").each(function () {
        productos_kit[i] = $(this).attr("id");
        cantidades_kit[i] = $(this).children().children("input").val();
        i++;
    });
    if(bandera)
        return productos_kit;
    else
        return cantidades_kit
}
$(function(){
    $("#cat_select").change(function(){
        $.ajax({url: $(this).attr("value"),type: 'post',dataType: 'script' ,
            data: {
            cat_id: $("#cat_select option:selected").val()
        }
        })
    });

    $("#btnAgregar").click(function(){
        $.ajax({url: $(this).attr("value"),type: 'post',dataType: 'script' ,
            data: {
                pro_id: $("#pro_select option:selected").val()
            }
        })
    });
    $("#lista_categorias input[type=checkbox],#check_kit").click(function(){
       if ($(this).attr("checked"))
            $(this).removeAttr("checked");
       else
           $(this).attr("checked","checked");
    });
    $("#check_kit").change(function () {
        $('#form_kit').toggle(350);
    });
    $(".eliminar").click(function () {
        $(this).parents(".fila_kit").remove();
    })
});