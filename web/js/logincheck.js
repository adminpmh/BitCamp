
//사용자 입력 폼 casting
//기본적인 유효성

//<form> casting
//onsubmit

var form = document.getElementById('loginform');

form.setAttribute('action','http://www.naver.com');

//onsubmit
form.onsubmit = function(){

    //<input> casting
    var uid = document.getElementById('id');
    var upw = document.getElementById('pw');

    if(uid.value==null||uid.value.length<1){
        alert('아이디를 입력해 주세요');
        return false;
    }
    if(upw.value==null||upw.value.length<1){
        alert('비밀번호를 입력해 주세요');
        return false;
    }
    
};