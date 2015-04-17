<%-- 
    Document   : menu
    Created on : 30-abr-2012, 3:06:05
    Author     : Administrador
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.toogamers.berrygames.conecta4.ConexionBDconecta4"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList al = new ArrayList();
    ArrayList gamers = new ArrayList();
    String gamer=null;
    if(session.getAttribute("usuario") ==null){
        response.sendRedirect("index.jsp");
    }
    ConexionBDconecta4 bDconecta4 = new ConexionBDconecta4();
    try{
        al = bDconecta4.ejecutar("*","musuario", "cor_usu='"+session.getAttribute("usuario")+"'", "nic_usu");
        for(int jj =0 ; jj<al.size();jj++){
            gamers = bDconecta4.ejecutar("*", "djugador","con_jug='"+al.get(jj)+"'", "con_jug");   
        }
        for ( int ff=0;ff<gamers.size();ff++){
            if(gamers.get(ff)==al.get(0)){
                gamer = "2";
            }
        }
    }catch(Exception e){
        al.add("no hay usuario en linea");
    }
    
%>
<!DOCTYPE html>
<html>
    <LINK REL=StyleSheet HREF="style.css" TYPE="text/css"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conecta4 | Menú principal</title>
        <script src="jquery-1.7.2.min.js"></script>
        <script src="easing.js"></script>
        <script>
            var recarga;
            var recarga2;
            function reloadcontext(){
                $.ajax({
                    url:"Conectajuego"
                }).done(function(msg){
                    $('#Pop-menu').append(msg);
                });
                setTimeout(reloadcontext());

            }
            function stopcontext(){
                clearInterval(recarga);
                clearInterval(recarga2);
            }
            function enviacambio(a){ 
                if(a=="nom_usu"){
                    var aa = document.cambio.nombre.value;
                    envioajax(a, aa);
                }
                if(a=="nic_usu"){
                    var aa = document.cambio.nick.value;
                    envioajax(a, aa);
                }
                if(a=="ape_usu"){
                    var aa = document.cambio.pater.value;
                    envioajax(a, aa);
                }
                if(a=="ama_usu"){
                    var aa = document.cambio.materno.value;
                    envioajax(a, aa);
                }
                if(a=="cor_usu"){
                    var aa = document.cambio.correo.value;
                    envioajax(a, aa);
                }
            }
            function reload(){
                $.ajax({
                        type:"POST",
                        url:"Jugar",
                        data:{correo:'<%=session.getAttribute("usuario")%>'}
                        }).done(function (msg){
                            $('#Respuesta').html(msg);
                            $('#Respuesta').fadeIn(1000);
                            //recarga = setTimeout("reload()", 1000);
                        })
                        .fail(function() { stopcontext();
                    });
            }
            function envioajax(a,datos){
                $.ajax({
                        type:"POST",
                        url:"cambio",
                        data:{campo:a,cambio:datos,where:'<%=session.getAttribute("usuario")%>'}
                        }).done(function(nn){
                            if(a=="nom_usu"){
                                $("input[name=nombre]").css({"border":"2px solid chartreuse","color":"white","box-shadow":"0 0 10px black"});
                            }
                            if(a=="nic_usu"){
                                $("input[name=nick]").css({"border":"2px solid deeppink","color":"white","box-shadow":"0 0 10px black"});
                            }
                            if(a=="ape_usu"){
                                $("input[name=pater]").css({"border":"2px solid deeppink","color":"white","box-shadow":"0 0 10px black"});

                            }
                            if(a=="ama_usu"){
                                $("input[name=materno]").css({"border":"2px solid chartreuse","color":"white","box-shadow":"0 0 10px black"});
                            }
                            if(a=="cor_usu"){
                               $("input[name=correo]").css({"border":"2px solid deeppink","color":"white","box-shadow":"0 0 10px black"});
                            }
                        });
            }
            
            function aceptado(valor,correo){
               if(valor=="no"){
                   $.ajax({
                        type:"POST",
                        url:"Respuesta",
                        data:{answer:valor,local:'<%=session.getAttribute("usuario")%>',contrincante:correo}
                        }).done(function (msg){    
                            
                    });
               }
               if(valor=="si"){
                   $.ajax({
                        type:"POST",
                        url:"Respuesta",
                        data:{answer:valor,local:'<%=session.getAttribute("usuario")%>',contrincante:correo}
                        }).done(function (msg){
                            $('#Pop').show(500,function(){
                                $('#tablero').show(500);
                                location.href="juego.jsp?gamer=1&partida="+msg;
                            });
                    });
               }
            }
            var hola;
            function accept(asd){
                   $.ajax({
                        type:"POST",
                        url:"VerificaJuego",
                        data:{local:'<%=session.getAttribute("usuario")%>',contrincante:asd}
                        }).done(function (msg){
                            
                            if(msg=="1"){
                                
                                $.ajax({
                                    type:"POST",
                                    url:"Respuesta",
                                    data:{answer:"si",local:asd,contrincante:'<%=session.getAttribute("usuario")%>'}
                                    }).done(function (msg){
                                        $('#Pop-menu').hide(1000,function(){
                                            location.href="juego.jsp?gamer=2&partida"+msg;
                                        });
                                });
                                stopcontext();
                            }
                            if(msg=="2"){
                                alert("El otro usuario dijo que no jugaba");
                                $('#Pop-menu').hide(1000,function(){
                                   $('#Pop').hide(1000);
                                });
                                stopcontext();
                            }
                    });
            }
            function cuenta(){
                $.ajax({
                        type:"POST",
                        url:"Cuenta",
                        data:{nombre:'<%=session.getAttribute("usuario")%>',b:"0"}
                        }).done(function (msg){    
                            $('#Respuesta').html(msg);
                            $('#Respuesta').fadeIn(1000);
                    });
            }
            function enviadato(par,valor2){
                $.ajax({
                    method:"POST",
                    url:"Conectajuego",
                    data:{nic_usu:par,con_usu:valor2,gamer:"<%=gamer%>"}
                }).done(function(msg){
                    $('#Pop').show(1000,function(){
                       $('#Pop-menu').show(1000);
                    });
                    recarga2 = setInterval(function(){
                        accept(valor2);
                    }, 5000);
                    accept();
                });
                
            }
            function peticion(){
                $.ajax({
                   type:"POST",
                   url:"Peticiones",
                   data:{user:"<%out.print(session.getAttribute("usuario"));%>"}
                }).done(function(msg){
                    $('#peticiones').html(msg);
                });
            }
            $('document').ready(function(){
                recarga3 = setInterval(function(){
                        peticion();
                    }, 5000);
                    peticion();
                $('#mejores').click(function(){
                    /*$('#Pop-menu').show(1000,function(){
                        reloadcontext();
                    });*/
                    alert(document.URL+"Hola");
                });
                $('#Pop-menu').click(function(){
                    stopcontext();
                });
                $("#nick").click(function (){
                   $("#nick").addClass("input"); 
                   stopcontext();
                });
                enviacambio("start");
                $('#cuenta').click(function(){
                    stopcontext();
                    cuenta();
                });
                $('#jugar').click(function(){
                    recarga = setInterval(function(){
                        reload();
                    }, 5000);
                    reload();
                });
                $("li").mouseover(function(){  
                    $(this).stop().animate({height:'150px'},{queue:false, duration:600, easing: 'easeOutBounce'})  
                });  
                $("li").mouseout(function(){  
                    $(this).stop().animate({height:'70px'},{queue:false, duration:600, easing: 'easeOutBounce'})  
                });  

            });
        </script>
    </head>
    
    <body>
        <div id="Pop" hidden></div>
        <div id="Pop-menu" hidden> Esperando respuesta </div>
        <div id="tablero"></div>
        <div id="Encabezado">
            <img src=LOGO.png id=menu></img>
            <ul id="lista">
                <li class="green" id="jugar">
                    <p><a>Jugar</a></p>
                    <p class="subtext">Juega en Linea</p>
                </li>
                
                <li class="red" id="cuenta">
                    <p><a><%for(int i=0 ;i <al.size(); i++){ out.println(al.get(0));}%></a></p>
                    <p class="subtext">Cuenta</p>
                </li>
                <a href="index.jsp?ses=fin&Out=<%=session.getAttribute("usuario")%>"><li class="blue" id="cerrar">
                    <p class="negro">Cerrar sesión</p>
                    <p class="subtext">¿Ya te aburriste?</p>
                </li></a>
            </ul>
        </div>
        <div id="Respuesta" hidden>
            
        </div>
        <div id="peticiones">
            
        </div>
    </body>
</html>