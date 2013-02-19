$(function() {
    $('button#lunchbot').click(function() { location.href="http://twitter.com/gms_lunchbot"; });
    $('button#yesterday').click(getLunch); 
    $('button#tomorrow').click(getLunch);
});

function getLunch(event) {
    var method;
    if (event.currentTarget.id == "yesterday") {
        console.log("어제의 급식을 가져옵니다.");
        method = 0;
    } else if (event.currentTarget.id == "tomorrow") {
        console.log("내일의 급식을 가져옵니다.");
        method = 1;
    } else {
        return false;
    }
    
    
    
    
    return true;
}
