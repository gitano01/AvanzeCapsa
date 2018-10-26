function nombrePago(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /[A-Z0-9a-zñÑ-áéíóúÁÉÍÓÚ.\s\t-]/;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}

function validarFormularioPagos() {
    if (!document.getElementById('btnGuardar').classList.contains("disabled")) {
        var message, x;
        var band = 0;
        var i = 0;
        var campos = ["nombre"];
        var msgs = ["msg_nombre"];
        var primerCampo;
        try {
            message = document.getElementById(msgs[i]);
            message.innerHTML = "";
            x = document.getElementById(campos[i]).value;
            x = x.trim();
            if (x == "") throw "no puede estar vacío";
        }
        catch (err) {
            message.innerHTML = "* Este campo " + err + " solamente acepta caracteres de Aa-Zz0-9 vocales con acento";
            document.getElementById(msgs[i]).style.color = "red";
            document.getElementById(campos[i]).style.border = "solid .5px red";
            if (band == 0)
                primerCampo = campos[i];
            band = 1;
        }

        if (band == 0) {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else
            document.getElementById(primerCampo).focus();
        return false;
    }
    else
        return false
}