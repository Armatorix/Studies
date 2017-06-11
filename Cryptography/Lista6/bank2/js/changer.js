window.onload = function() {
	document.body.innerHTML = document.body.innerHTML.replace("666666",getCookie("acc"));
	document.getElementById("submit").onclick = cookieAndChange;
}

function cookieAndChange() {
	var val=document.getElementById("acc_id").value;
	setCookie("acc",val,1);
	document.getElementById("acc_id").value="666666";
}
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}