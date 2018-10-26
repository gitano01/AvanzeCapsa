function validarFormularioInventario() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")){
    var message, x;
    var band = 0;
    var campos = ["nombreInventario"];
    var msgs = ["msg_nombreInventario"];
    var primerCampo;
    for (i=0;i<1;i++)
    {
        try {
            message = document.getElementById(msgs[i]);
            message.innerHTML = "";
            x = document.getElementById(campos[i]).value;
            x = x.trim();
            if(x == "")  throw "no puede estar vacío";
        }
        catch(err) {
            message.innerHTML = "* Este campo " + err;
            document.getElementById(msgs[i]).style.color = "red";
            document.getElementById(campos[i]).style.border="solid .5px red";
            if (band==0)
                    primerCampo = campos[i];
                band = 1;
            band = 1;
        }
    }
    if (band==0){
        var boton = document.getElementById('btnGuardar');
        boton.classList.add('disabled');
        return true;
    }
    else{
        document.getElementById(primerCampo).focus();
        return false;
    }
}
 else
    return false
}
