
function validarFormularioCajaRegistradora() {
    if (!document.getElementById('btnGuardar').classList.contains("disabled")) {
        var message, x;
        var band = 0;
        var campos = ["nombreCaja", "montoInicial"];
        var msgs = ["msg_nombreCaja", "msg_montoInicial"];
        var primerCampo;
        for (i = 0; i < 2; i++) {
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                document.getElementById(campos[i]).style.border = "";
                if (x == "" && i==0) throw "no puede estar vacío";
                if (isNaN(x) && i == 1) throw "no es un número";
                if (x <= 0 && i == 1) throw "no puede tener valor negativo "
                if (x >= 999999 && i == 1) throw "no puede ser mayor que 999999 "
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
        if (band == 0) {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else {
            document.getElementById(primerCampo).focus();
            return false;
        }
    }
    else
        return false
}

function validarMontoInicial(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /^[0-9.\s\-\_]$/i;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}