<cfquery name="qGetBanners" datasource="#application.dsource#">
    SELECT bannerImage
    FROM banners
    WHERE bannerImage IS NOT NULL
</cfquery>


<style>
    .slider {
        position: relative;
        max-width: 100%;
        margin: auto;
        overflow: hidden;
        border-radius: 10px;
    }

    .slides {
        display: flex;
        transition: transform 0.5s ease-in-out;
    }

    .slide {
        min-width: 100%;
        box-sizing: border-box;
    }

    .slide img {
        width: 1145;
        height: auto; /* Maintain aspect ratio */
        max-height: 400px; /* Set max height */
        object-fit: cover; /* Ensure images cover the entire slide area */
        high resolution images
    }

    .prev, .next {
        cursor: pointer;
        position: absolute;
        top: 50%;
        width: auto;
        padding: 16px;
        margin-top: -22px;
        color: rgb(0, 0, 0);
        font-weight: bold;
        font-size: 18px;
        transition: 0.6s ease;
        border-radius: 0 3px 3px 0;
        user-select: none;
        background-color: rgba(255, 255, 255, 0.7); /* Add a background to improve visibility */
    }

    .next {
        right: 0;
        border-radius: 3px 0 0 3px;
    }

    .prev:hover, .next:hover {
        background-color: rgba(0, 0, 0, 0.8); /* Change background on hover */
            color: white; /* Change arrow color to white on hover */
    }
</style>


<div class="slider">
    <div class="slides">
        <cfoutput query="qGetBanners">
            <div class="slide">
                <img src="/images/banners/#bannerImage#" alt="Banner Image">
            </div>
        </cfoutput>
    </div>

    <!-- Next and previous buttons -->
    <a class="prev" onclick="moveSlide(-1)">&#10094;</a>
    <a class="next" onclick="moveSlide(1)">&#10095;</a>
</div>

<script>
    let slideIndex = 0;
    showSlides();

    function showSlides() {
        let slides = document.querySelectorAll('.slide');
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = 'none';
        }
        slideIndex++;
        if (slideIndex > slides.length) { slideIndex = 1 }
        slides[slideIndex - 1].style.display = 'block';
        setTimeout(showSlides, 3000); // Change image every 3 seconds
    }

    function moveSlide(n) {
        let slides = document.querySelectorAll('.slide');
        slideIndex += n;
        if (slideIndex > slides.length) { slideIndex = 1 }
        if (slideIndex < 1) { slideIndex = slides.length }
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = 'none';
        }
        slides[slideIndex - 1].style.display = 'block';
    }
</script>

</body>
</html>
