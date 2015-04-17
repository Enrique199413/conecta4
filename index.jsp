<%@page import="org.toogamers.berrygames.conecta4.ConexionBDconecta4"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></meta>
<%
    
        try{if("fin".equals(request.getParameter("ses")))
            {
                session.invalidate();
                ConexionBDconecta4 conexionBDconecta4 =null;
                conexionBDconecta4 = new ConexionBDconecta4();
                conexionBDconecta4.update("musuario","sta_usu=0","cor_usu='"+request.getParameter("Out")+"'");
                conexionBDconecta4.delete("estado1","cor_usu='"+request.getParameter("Out")+"'");
            }
        }
        catch(Exception a){}
%>
<html>
	<LINK REL=StyleSheet HREF="style.css" TYPE="text/css">
	<head>
		<title>Conecta4 | Inicio</title>
                <script src="jquery-1.7.2.min.js"></script>
            <script>
                var pass2;
                var nick;
                var nombre;
                var paterno;
                var materno;
                var correo;
                var pass1;
                function nn(){
                    nick = document.forms[1].nick.value;
                    nombre= document.forms[1].nombre.value;
                    paterno = document.forms[1].paterno.value;
                    materno = document.forms[1].materno.value;
                    correo= document.forms[1].correo.value;
                    pass1 = document.forms[1].pass1.value;
                    pass2 = document.forms[1].pass2.value;
                } 
                    $('document').ready(function (){

                            $('#hola').addClass("nada2");
                            $('#principal').fadeIn(500);
                            $('#nose').click(function a(){
                                nn();
                                $.ajax({
                                  type: "POST",
                                  url: "Registra",
                                  data:{nick:nick,nombre:nombre,paterno:paterno,materno:materno,correo:correo,pass1:pass1,pass2:pass2}
                                }).done(function( msg ) {
                                    $('#servermessage').html("Registro exitoso");
                                    $('#servermessage').fadeIn(1000,function(){
                                        $('#servermessage').fadeOut(4000);
                                    });
                                    $('#oculto').slideToggle();
                                    nick = document.forms[1].nick.value="";
                                    nombre= document.forms[1].nombre.value="";
                                    paterno = document.forms[1].paterno.value="";
                                    materno = document.forms[1].materno.value="";
                                    correo= document.forms[1].correo.value="";
                                    pass1 = document.forms[1].pass1.value="";
                                    pass2 = document.forms[1].pass2.value="";
                                    $('#logotipo').animate({'margin-top':'-50px'});
                                });
                            });                            
                            $('p[class=especial]').click(function(){
                                    $('#oculto').show(500);
                                    $('#principal').animate({'margin-top':'30px'});
                                    $('#logotipo').animate({'margin-top':'240px'});
                            });
                            $('font[class=ded]').click(function(){
                                    $('#oculto').hide(500);
                                    $('#logotipo').animate({'margin-top':'-60px'});
                                    $('#principal').animate({'margin-top':'80px'});
                            });
                    })
            </script>
	</head>
	<body>
            <style>
                .nada{
                    background: red;
                    display: inline;
                }
                .nada2{
                    background: red;
                    display: none;
                }
            </style>
            <div id="nada"></div>
                <div id="servermessage" hidden>
                    
                </div>
		<div id="principal"  class=ini>
		<br><br><div id="hola"></div>
                    <form action="Verificaconexion" method="post" name="formu1" id="inicio">
                            <p>Correo de usuario: <img src=LOGO.png id=logotipo></img><input type=text name=nombre id="nombre" class=left></p>
                            <p>Password: <input type=password name=pass class=left></p>
                            <div class=center>
                                    <input type=submit class=button>
                                    <input type=reset class=button>
                                    <p class="especial">Registrate</p>
                            </div>
                    </form>
                    <form action="" method="post" id="oculto" name="formu2">
                        <p>Nick: <input type=text name=nick class=left></p>
                        <p>Nombre: <input type=text name=nombre class=left></p>
                        <p>Apellido Paterno: <input type=text name=paterno class=left></p>
                        <p>Apellido Materno: <input type=text name=materno class=left></p>
                        <p>Correo: <input type=text name=correo class=left></p>
                        <p>Contraseña: <input type=password name=pass1 class=left></p>
                        <p>Confirmar contraseña: <input type=password name=pass2 class=left></p>
                        <div class=center>
                                <input type="button" class="button" id="nose" value="Registrar">
                                <input type=reset class=button>
                        </div>
                        <p><font style="float:rigth" color=red class="ded">Replegar</font></p>
                    </form>
                <div id="info"></div>
		</div>
	</body>
</html>
