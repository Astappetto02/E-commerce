<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <jsp:include page="WEB-INF/results/navbar_footer/navbar.jsp" />

            <main>
                <!-- Il contenuto della pagina va qui -->
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        let banners = document.getElementsByClassName("banner");
                        let currentIndex = 0;
                        let interval = 5000; // Tempo di visualizzazione di ogni immagine (in millisecondi)

                        function showNextBanner() {
                            // Nascondi il banner corrente
                            $(banners[currentIndex]).hide()

                            currentIndex = (currentIndex + 1) % banners.length;

                            // Mostra il prossimo banner
                            $(banners[currentIndex]).fadeIn(1000)
                        }

                        // Mostra il primo banner
                        $(banners[currentIndex]).show()

                        // Mostra i banner in sequenza
                        setInterval(showNextBanner, interval);
                    });
                </script>

                <div class="banner" >
                    <img src="https://cdn.shopify.com/s/files/1/0303/1135/0365/files/MAPLEWAFFLE.png?v=1688142267" class="banner-image">
                    <div class="banner-text"><h1>Yeah buddy, light weight baby!</h1></div>
                </div>

                <div class="banner">
                    <img src="https://cdn.shopify.com/s/files/1/0303/1135/0365/files/beta.png?v=1688160233" class="banner-image">
                    <div class="banner-text"><h1>Now five more reps!</h1></div>
                </div>

                <div class="prodotti">
                    <c:forEach var="prodotto" items="${prodotti}" varStatus="status">
                        <c:if test="${status.index < 4}">
                            <div class="bordo">
                                <a href="http://localhost:8080/Gisolfi_Merola_pj_war_exploded/visualizza?id=${prodotto.id}" style="text-decoration: none">
                                    <div class="prodotto">
                                        <img src="img/${prodotto.nome}${prodotto.id}.jpg"><br>
                                    </div>
                                    <h3 style="color: black">${prodotto.nome}</h3>
                                    <p style="color: #393E46">${prodotto.prezzo}€</p>
                                </a>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </main>
            <button onclick="scrollToTop()" id="scrollToTop"><i class="fa-solid fa-arrow-up fa-2xl"></i></button>
        </div>

       <jsp:include page="WEB-INF/results/navbar_footer/footer.jsp" />
    </body>
</html>
