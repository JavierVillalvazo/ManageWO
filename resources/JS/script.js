// function disableBack() { window.history.forward(); }
// setTimeout("disableBack()", 0);
// window.onunload = function () { null };



// $(document).ready(function () {
//     $('#BtnFile').click(function () {
//         if ($('#fuData').val() == "No file choosen") {
//             $('#alert').show();
//             $('#BtnFile').prop("disabled", true);
//             return false;
//         }
//         else if ($('#file').val() != "") {
//             $('#alert').hide();
//             $('#BtnFile').prop("disabled", false);
//             return true;
//         }
//     });

//     $("#fuData").change(function(){
//             if ($('#fuData').val() == "No file choosen") {
//             $('#alert').show();
//             $('#BtnFile').prop("disabled", true);
//             return false;
//         }else if ($('#fuData').val() != "") {
//             $('#alert').hide();
//             $('#BtnFile').prop("disabled", false);
//             return true;
//         }
//     });
// });

document.getElementById('btnSwitch').addEventListener('click',()=>{
    if (document.documentElement.getAttribute('data-bs-theme') == 'dark') {
        document.documentElement.setAttribute('data-bs-theme','light')
    }
    else {
        document.documentElement.setAttribute('data-bs-theme','dark')
    }
})