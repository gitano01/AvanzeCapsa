// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function validarFormularioCliente() {
    if (!document.getElementById('btnGuardar').classList.contains("disabled")) {
        var pattern = /^([A-Z,Ñ,&]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[A-Z|\d]{3})$/;
        var pattern_email = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        var rfc = document.getElementById('rfc').value;
        var email = document.getElementById('email1').value;
        var message, x;
        var band = 0;
        var campos = ["nombreC", "rfc", "email1"];
        var msgs = ["msg_nombreC", "rfcmensaje", "msemail"];
        var primerCampo;
        // RFC
        var n = pattern.test(rfc);
        var validar_email = pattern_email.test(email);
        for (i = 0; i < 3; i++) {
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                document.getElementById(campos[i]).style.border = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                if (campos[i] == "nombreC") {
                    if (x == "") throw "Este campo no puede estar vacío";
                }
                else {
                    if (campos[i] == "rfc" && n == false && rfc.length > 0) throw "RFC no es válido todo en mayúsculas, ejemplo ABCD060210XXX";

                    if (campos[i] == "email1" && validar_email == false && email.length > 0) throw "* Correo electrónico no válido. Formato correcto: nombre-de-cuenta@servidor.dominio";

                }
            }
            catch (err) {
                message.innerHTML = err;
                document.getElementById(msgs[i]).style.color = "red";
                document.getElementById(campos[i]).style.border = "solid .5px red";
                if (band == 0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        if (band == 0){
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else
            document.getElementById(primerCampo).focus();
        return false;
    }
    else
        return false;
}