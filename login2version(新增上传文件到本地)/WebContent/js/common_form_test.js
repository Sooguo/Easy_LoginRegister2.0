// 全局变量a和b，分别获取编号，用户框，密码框，邮件框，注册时间框的value值
var o = document.getElementsByTagName("input")[0].value;  /*编号*/
var a = document.getElementsByTagName("input")[1].value;  /*用户*/
var b = document.getElementsByTagName("input")[2].value;  /*密码*/
var c = document.getElementsByTagName("input")[3].value;  /*邮件*/
var d = document.getElementsByTagName("input")[4].value;  /*注册时间*/

//编号框失去焦点后验证value值
function oBlur_0() {
    if (!o) { //编号框value值为空
        document.getElementById("remind_0").innerHTML = "请输入编号！";
        document.getElementById("change_margin_0").style.marginBottom = 1 + "px";
    } else { //编号框value值不为空
        document.getElementById("remind_0").innerHTML = "";
        document.getElementById("change_margin_0").style.marginBottom = 19 + "px";
    }
}

//用户框失去焦点后验证value值
function oBlur_1() {
    if (!a) { //用户框value值为空
        document.getElementById("remind_1").innerHTML = "请输入用户名！";
        document.getElementById("change_margin_1").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_2").style.marginTop = 2 + "px";
    } else { //用户框value值不为空
        document.getElementById("remind_1").innerHTML = "";
        document.getElementById("change_margin_1").style.marginBottom = 19 + "px";
        document.getElementById("change_margin_2").style.marginTop = 19 + "px";
    }
}

//密码框失去焦点后验证value值
function oBlur_2() {
    if (!b) { //密码框value值为空
        document.getElementById("remind_2").innerHTML = "请输入密码！";
        document.getElementById("change_margin_2").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_3").style.marginTop = 2 + "px";
    } else { //密码框value值不为空
        document.getElementById("remind_2").innerHTML = "";
        document.getElementById("change_margin_2").style.marginBottom = 19 + "px";
        document.getElementById("change_margin_3").style.marginTop = 19 + "px";
    }
}

//邮箱框失去焦点后验证value值
function oBlur_3() {
    if (!c) { //邮箱框value值为空
        document.getElementById("remind_3").innerHTML = "请输入电子邮箱！";
        document.getElementById("change_margin_3").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_4").style.marginTop = 2 + "px";
    } else { //邮箱框value值不为空
        document.getElementById("remind_3").innerHTML = "";
        document.getElementById("change_margin_3").style.marginBottom = 19 + "px";
        document.getElementById("change_margin_4").style.marginTop = 19 + "px";
    }
}
//注册时间框失去焦点后验证value值
function oBlur_4() {
    if (!d) { //注册时间框value值为空
        document.getElementById("remind_4").innerHTML = "请输入注册时间！";
        document.getElementById("change_margin_4").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_5").style.marginTop = 2 + "px";
    } else { //注册时间框value值不为空
        document.getElementById("remind_4").innerHTML = "";
        document.getElementById("change_margin_4").style.marginBottom = 19 + "px";
        document.getElementById("change_margin_5").style.marginTop = 19 + "px";
    }
}

//编号框获得焦点的隐藏提醒
function oFocus_0() {
    document.getElementById("remind_0").innerHTML = "";
    document.getElementById("change_margin_0").style.marginBottom = 19 + "px";
}

//用户框获得焦点的隐藏提醒
function oFocus_1() {
    document.getElementById("remind_1").innerHTML = "";
    document.getElementById("change_margin_1").style.marginBottom = 19 + "px";
    document.getElementById("change_margin_2").style.marginTop = 19 + "px";
}

//密码框获得焦点的隐藏提醒
function oFocus_2() {
    document.getElementById("remind_2").innerHTML = "";
    document.getElementById("change_margin_2").style.marginBottom = 19 + "px";
    document.getElementById("change_margin_3").style.marginTop = 19 + "px";
}

//邮件框获得焦点的隐藏提醒
function oFocus_3() {
    document.getElementById("remind_3").innerHTML = "";
    document.getElementById("change_margin_3").style.marginBottom = 19 + "px";
    document.getElementById("change_margin_4").style.marginTop = 19 + "px";
}

//注册时间框获得焦点的隐藏提醒
function oFocus_4() {
    document.getElementById("remind_4").innerHTML = "";
    document.getElementById("change_margin_4").style.marginBottom = 19 + "px";
    document.getElementById("change_margin_5").style.marginTop = 19 + "px";
}

//若输入框为空，阻止表单的提交
function submitTest() {
    if (!a && !b && !c && !d && !o) { 
        document.getElementById("remind_0").innerHTML = "请输入编号！";
        document.getElementById("change_margin_0").style.marginBottom = 1 + "px";
        
        document.getElementById("remind_1").innerHTML = "请输入用户名！";
        document.getElementById("change_margin_1").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_2").style.marginTop = 2 + "px";
        
        document.getElementById("remind_2").innerHTML = "请输入密码！";
        document.getElementById("change_margin_2").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_3").style.marginTop = 2 + "px";
        
        document.getElementById("remind_3").innerHTML = "请输入电子邮箱！";
        document.getElementById("change_margin_3").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_4").style.marginTop = 2 + "px";
        
        document.getElementById("remind_4").innerHTML = "请输入注册时间！";
        document.getElementById("change_margin_4").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_5").style.marginTop = 2 + "px";
        return false; //只有返回true表单才会提交
    } 
    else if (!o) { 
        document.getElementById("remind_0").innerHTML = "请输入编号！";
        document.getElementById("change_margin_0").style.marginBottom = 1 + "px";
        return false;
    }else if (!a) { //用户框value值为空
        document.getElementById("remind_1").innerHTML = "请输入用户名！";
        document.getElementById("change_margin_1").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_2").style.marginTop = 2 + "px";
        return false;
    } else if (!b) { //密码框value值为空
        document.getElementById("remind_2").innerHTML = "请输入密码！";
        document.getElementById("change_margin_2").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_3").style.marginTop = 2 + "px";
        return false;
    }else if (!c) { //电子邮箱框value值为空
        document.getElementById("remind_3").innerHTML = "请输入电子邮箱！";
        document.getElementById("change_margin_3").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_4").style.marginTop = 2 + "px";
        return false;
    }else if (!d) { //注册时间框value值为空
        document.getElementById("remind_4").innerHTML = "请输入注册时间！";
        document.getElementById("change_margin_4").style.marginBottom = 1 + "px";
        document.getElementById("change_margin_5").style.marginTop = 2 + "px";
        return false;
    }
}