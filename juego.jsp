<%-- 
    Document   : newjsp
    Created on : 18-abr-2012, 16:52:48
    Author     : Administrador
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="org.toogamers.berrygames.conecta4.ConexionBDconecta4"%>
<%@page import="org.toogamers.berrygames.conecta4.Conectajuego"%>
<%@page import="org.toogamers.berrygames.conecta4.Brain" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession httpSession = request.getSession();
    if(httpSession.getAttribute("usuario")==null){
        response.sendRedirect("index.jsp");
    }
    String jugador = request.getParameter("gamer");
    String partida = request.getParameter("partida");
%>
<!DOCTYPE html>
<html>
    <LINK REL=StyleSheet HREF="style.css" TYPE="text/css"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="jquery-1.7.2.min.js"></script>
        <script>
        var h=1;
        no="";
        function aaa(){
            verificar = setInterval(function(){
                       revisatiro();
                   },1000);
                   revisatiro();
        }
        function revisatiro(){
            $.ajax({
               type:"POST" ,
               url:"Procesa",
               data:{play:"7",gamer:0,status:2,partida:"-1"}
            }).done(function(msg){
                var no = msg.split(",");
                for (a=0;a<no.length;a++){
                    $('img[class=ficha'+no[a]+']').fadeIn(10);
                }
            });
        }
        function sendjugador(gamer){
            $.ajax({
               type:"POST" ,
               url:"Muestrajujador",
               data:{jugador:gamer}
            }).done(function(msg){
                $('#Pop').hide(1000,function(){
                       $('#tablero').hide(1000);
                    });
            });
        }
            function j(l,s){
                
                $.ajax({
                    type:"POST",
                    url:"Procesa",
                    data:{play:l,gamer:s,status:h,partida:'<%=partida%>'}
                }).done(function(msg){
                        h=2;
                        var nombre = msg.split(",");
                        for (x=0;x<nombre.length;x++){
                            if(nombre[x]=="Gano2"){
                                alert("Gano el jugador 1");
                                $('#tablero').hide(400);
                                $('#Pop-menu').hide(1000,function(){
                                   $('#Pop').hide(1000);
                                });
                                clearInterval(verificar);
                            }
                            if(nombre[x]=="Gano1"){
                                alert("Gano el jugador 2");
                                $('#tablero').hide(400);
                                $('#Pop-menu').hide(1000,function(){
                                   $('#Pop').hide(1000);
                                });
                                clearInterval(verificar);
                            }else{
                                $('img[class=ficha'+nombre[x]+']').fadeIn(10);
                            }
                        }  
                });
                
            }       
            var g;
            var h;
            $('document').ready(function (){
                   
            });
            function a(g){
                $('img[class=head'+g+']').fadeIn(10);
            }
            function k(h){
                $('img[class=head'+h+']').fadeOut(10);
            }
            function Envia(o){
                $('img[class=ficha'+o+']').fadeIn(10);
            }
	</script>
    </head>
    
    
    <body onload="aaa()">
            <div id="Score">
                
            </div>
            
            <div id="tablero2">
                <p id="gamers">Jugador <%=jugador%></p>
                
                <br>
                <br><br>
                <center><table border="0" bgcolor=" #bc0101">
                    <%
                    if("2".equals(jugador)){
                    %>
                    <tr class="Hola">
                        <td  onMouseOver="a(0)" onmouseout="k(0)" onclick="j(1,<%=jugador%>)"><img class="head0" src="AMARILLA FICHA.png" /></td>
                        <td  onMouseOver="a(1)" onmouseout="k(1)" onclick="j(2,<%=jugador%>)"><img class="head1" src="AMARILLA FICHA.png" /></td>
                        <td  onMouseOver="a(2)" onmouseout="k(2)" onclick="j(3,<%=jugador%>)"><img class="head2" src="AMARILLA FICHA.png" /></td>
                        <td  onMouseOver="a(3)" onmouseout="k(3)" onclick="j(4,<%=jugador%>)"><img class="head3" src="AMARILLA FICHA.png" /></td>
                        <td  onMouseOver="a(4)" onmouseout="k(4)" onclick="j(5,<%=jugador%>)"><img class="head4" src="AMARILLA FICHA.png" /></td>
                        <td  onMouseOver="a(5)" onmouseout="k(5)" onclick="j(6,<%=jugador%>)"><img class="head5" src="AMARILLA FICHA.png" /></td>
                    </tr>
                    <%}    
                    
                    if("1".equals(jugador)){
                    %>
                    <tr class="Hola">
                        <td  onMouseOver="a(0)" onmouseout="k(0)" onclick="j(1,<%=jugador%>)"><img class="head0" src="AZUL Ficha.png" /></td>
                        <td  onMouseOver="a(1)" onmouseout="k(1)" onclick="j(2,<%=jugador%>)"><img class="head1" src="AZUL Ficha.png" /></td>
                        <td  onMouseOver="a(2)" onmouseout="k(2)" onclick="j(3,<%=jugador%>)"><img class="head2" src="AZUL Ficha.png" /></td>
                        <td  onMouseOver="a(3)" onmouseout="k(3)" onclick="j(4,<%=jugador%>)"><img class="head3" src="AZUL Ficha.png" /></td>
                        <td  onMouseOver="a(4)" onmouseout="k(4)" onclick="j(5,<%=jugador%>)"><img class="head4" src="AZUL Ficha.png" /></td>
                        <td  onMouseOver="a(5)" onmouseout="k(5)" onclick="j(6,<%=jugador%>)"><img class="head5" src="AZUL Ficha.png" /></td>
                    </tr>
                    <%}%>
                    <%for(int h = 0 ; h < 6;h++){
                        %><tr><%
                        for(int k  = 0 ; k < 6;k++){%>
                        
                            <td class="juego"><img src="AMARILLA FICHA.png" class="ficha<%=h%><%=k%>2"  hidden /><img src="AZUL Ficha.png" class="ficha<%=h%><%=k%>1" hidden /></td>
                        <%
                            if(h==6){
                                %>
                                </tr>
                        <%
                            }
                        }
                        %>
                    <%}%>

                </table></center>
            </div>
            
       
    </body>
</html>