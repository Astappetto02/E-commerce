<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Utente" %>
<%@ page import="model.Carrello" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Tren Nutrition</title>
        <script src="js/codici.js"></script>
    </head>
    <body>
        <div class="content">
            <section id="header">
                <a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/"><img src="img/Logo.png" class="logo"></a>
                <div class="search-bar">
                    <form method="post" action="ricerca" autocomplete="off">
                        <input type="text" name="ricerca" placeholder="Cerca...">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
                <div>
                    <ul id="navbar" class="navbar">
                        <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/">Home</a></li>
                        <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/ChiSiamo.jsp">Chi siamo</a></li>
                        <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/categorie.jsp">Prodotti</a></li>
                        <c:choose>
                            <c:when test="${!empty utente && utente.admin}">
                                <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/utenti">Utenti</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/carrello"><i class="fas fa-shopping-cart"></i></a></li>
                            </c:otherwise>
                        </c:choose>
                        <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/account.jsp"><i class="far fa-user"></i></a></li>
                        <c:if test="${!empty utente}">
                            <li><h5>Ciao, ${utente.nome}</h5></li>
                        </c:if>
                        <li class="icon"><a href="javascript:void(0);"><i class="fa-solid fa-bars fa-xl"></i></a></li>
                    </ul>
                </div>
            </section>

            <navbar id="responsive">
                <ul class="responsive">
                    <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/">Home</a></li>
                    <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/ChiSiamo.jsp">Chi siamo</a></li>
                    <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/categorie.jsp">Prodotti</a></li>
                </ul>
            </navbar>

            <main>
              <!-- Il contenuto della pagina va qui -->
                  <%
                    Utente utente = (Utente) request.getSession().getAttribute("utente");
                  if(utente == null){%>
                        <div class="vuoto">
                           <h3>Per visualizzare il carrello <a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/account.jsp">accedi</a> o <a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/registrazione.html">registrati</a></h3>
                        </div>
                    <%}else{
                    Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
                    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodottiCarrello");
                    List<Integer> quantita = carrello.getQuantita();
                    if(prodotti != null){
                      if(prodotti.isEmpty()){%>
                        <div class="vuoto">
                            <i class="fa-solid fa-cart-shopping fa-2xl"></i>
                            <h3>Il carrello &egrave vuoto, prova ad aggiungere qualcosa</h3>
                        </div>
                <%}else{%>
                <div class="carrello">
                    <div class="prodotticarello">
                      <%Double totale = 0D;
                      int i = 0;
                      for(Prodotto p : prodotti){
                        totale+=p.getPrezzo()*quantita.get(i);%>
                        <div class="bordo">
                            <a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/visualizza?id=<%=p.getId()%>" style="text-decoration: none">
                                <img src="img/<%=p.getNome()%><%=p.getId()%>.jpg">
                                <h3><%=p.getNome()%></h3>
                                <div class="info">
                                    <h6><%=p.getPrezzo()%>€</h6>
                                    <h6>Quantità: <%=quantita.get(i)%></h6>
                                    <form action="rimuovi" method="post">
                                      <input type="hidden" name="id" value="<%=p.getId()%>">
                                      <button type="submit" id="removeToCart"><i class="fa-solid fa-trash" style="color: #393E46"></i></button>
                                    </form>
                                </div>
                            </a>
                        </div>
                        <%i++;}
                            BigDecimal tot = new BigDecimal(totale).setScale(2, RoundingMode.HALF_UP);
                            totale = Double.valueOf(String.valueOf(tot));
                        %>
                    </div>
                    <div class="checkout">
                      <h4>Totale: <%=totale%>€</h4>

                          <form action="checkout" method="get">
                              <input type="hidden" name="totale" value="<%=totale%>">
                              <div class="button-container">
                                <button id="checkoutTesto"type="submit" value="Vai al checkout">Vai al checkout</button>
                                <button id="checkoutIcona"type="submit"><i class="fa-solid fa-money-bill"></i></button>
                              </div>
                          </form>
                    </div>
                </div>
                <%}
                }else {%>
                  <h3>Il carrello &egrave vuoto, prova ad aggiungere qualcosa</h3
                    <%}
                }%>
            </main>
            <button onclick="scrollToTop()" id="scrollToTop"><i class="fa-solid fa-arrow-up fa-2xl"></i></button>
        </div>
        <footer class="footer">
            <div class="social">
                <a href="https://www.instagram.com"><i class="fa-brands fa-instagram"></i></a>
                <a href="https://twitter.com"><i class="fa-brands fa-twitter"></i></a>
                <a href="https://it-it.facebook.com"><i class="fa-brands fa-facebook-f"></i></a>
            </div>
            <ul>
                <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/">Home</a></li>
                <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/categorie.jsp">Prodotti</a></li>
                <li><a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/ChiSiamo.jsp">About Us</a></li>
            </ul>
            <p class="copyright">TrenNutrition © 2023</p>
        </footer>
    </body>
</html>
