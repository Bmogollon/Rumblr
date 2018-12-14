
var slideb = document.querySelector(".slideb");
var check = 0;

slideb.addEventListener('click', function(e){
    var text = e.target.nextElementSibling;
    var loginText = e.target.parentElement;
    text.classList.toggle('show-hide');
    loginText.classList.toggle('expand');
    if(check == 0)
    {
        slideb.innerHTML = "<div class=\"slide-up\"></div>";
        check++;
    }
    else
    {
        slideb.innerHTML = "<div class=\"slide-down\"></div>";
        check = 0;
    }
})
