function validarFormularioTerminal() {
    if (!document.getElementById('btnGuardar').classList.contains("disabled")) {
        var message, x;
        var band = 0;
        var campos = ["nombreTerminal", "nombreCaja", "montoInicial"];
        var msgs = ["msg_nombreTerminal", "msg_nombreCaja", "msg_montoInicial"];
        var primerCampo;
        for (i = 0; i < 3; i++) {
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                document.getElementById(campos[i]).style.border = "";
                if (x == "" && i==0) throw "no puede estar vacío";
                if (($("#terminal_cajas_registradora_id option:selected").text()=='Otra') &&
                    i>0){
                    if (isNaN(x) && i == 2) throw "no es un número";
                    if (x <= 0 && i == 2) throw "no puede tener valor negativo "
                    if (x >= 999999 && i == 2) throw "no puede ser mayor que 999999 "
                    if (x == "") throw "no puede estar vacío";
                }
                //if (isNaN(x) && i == 2) throw "no es un número";
                //if (x <= 0 && i == 2) throw "no puede tener valor negativo "
                //if (x >= 999999 && i == 2) throw "no puede ser mayor que 999999 "
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
        var validar_seleccion = validar_select_caja();
        if (band == 0 && validar_seleccion) {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else {
            if(primerCampo)
            document.getElementById(primerCampo).focus();
            return false;
        }
    }
    else
        return false
}

function validar_select_caja(){
    band = true;
    $('#msg_seleccion').html('');
    if(($("#terminal_cajas_registradora_id option:selected").text().trim()=='---Seleccione una opción---')
        && $('#opciones_si').is(':checked')){
        $('#msg_seleccion').html('Seleccione una caja registradora');
        $('#msg_seleccion').css('color', 'red');
        band = false;
    }
    return band;
}

function validarMontoInicial(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /^[0-9.\s\-\_]$/i;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}