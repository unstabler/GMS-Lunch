$(function() {

    if (!window.console) {
        //자바스크립트 콘솔 기능이 없는 구형 브라우저(IE8 등)에서는 오류가 나기 때문에 회피를 해줘야 함.
        console = {log: function() {}};
    }
        
    $('button#lunchbot').click(function() { location.href="http://twitter.com/gms_lunchbot"; });
    $('button#yesterday').click(getLunch); 
    $('button#tomorrow').click(getLunch);
    $('button#return').click(function() {
       $('div.content#temp').hide();
       $('div.content#main').show();
        
    });
    $('button#info').click(function() {
        alert("경기모바일과학고등학교 오늘의 급식\n30710 박규환\n\njQuery Mobile이 아닌 순수 제 실력으로 새 버전을 개발하고 있습니다.\n많이 불편하시더라도 양해 바랍니다.\n\nThanks, Larry!\nhttp://www.perl.org");
    });
    
    $('button#github').click(function() {
        location.href="http://github.com/unstabler/GMS-Lunch";
    });

});

function getLunch(event) {
    console.log(typeof event);
    
    var apiUrl;
    if (event.currentTarget.id == "yesterday") {
        console.log("어제의 급식을 가져옵니다.");
        apiUrl = "/api/yesterday";
    } else if (event.currentTarget.id == "tomorrow") {
        console.log("내일의 급식을 가져옵니다.");
        apiUrl = "/api/tomorrow";
    } else {
        return false;
    }
    
    
    
    
    $.ajax({
        url: apiUrl,
    })
    .done(processLunch)
    .fail(function() {
        console.log("오류가 발생하였습니다.");
    });
    
        
    
    
    return true;
}

function processLunch(data) {
    data = $.parseJSON(data);
    console.log(data);
    
    data.date;
    data.method = (data.method == "yesterday")?"어제":(data.method == "tomorrow")?"내일":"";
    
    if (!data.lunch) data.lunch = "오늘은 중식이 없습니다.";
    if (!data.dinner) data.dinner = "오늘은 석식이 없습니다.";
    
    
    $('div.content#temp span').text(sprintf("%s %s의 급식은..", data.date, data.method));
    
    
    $('div.content#main').hide();
    $('div.content#temp').show();
    
    
    $('div.content#temp div.tab#lunch div.tab_content').text(data.lunch);
    $('div.content#temp div.tab#dinner div.tab_content').text(data.dinner);
    
    
}
