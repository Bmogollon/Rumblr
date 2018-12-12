console.log("conected");

var slideb = document.querySelector(".slideb");
var check = 0;

slideb.addEventListener('click', function(e){
    var text = e.target.nextElementSibling;
    var loginText = e.target.parentElement;
    text.classList.toggle('show-hide');
    loginText.classList.toggle('expand');
    if(check == 0)
    {
        slideb.innerHTML = "<i class=\"slide-up\"></i>";
        check++;
    }
    else
    {
        slideb.innerHTML = "<i class=\"slide-down\"></i>";
        check = 0;
    }
})
