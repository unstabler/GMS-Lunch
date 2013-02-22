$(function() {
    $('button#lunchbot').click(function() { location.href="http://twitter.com/gms_lunchbot"; });
    $('button#yesterday').click(getLunch); 
    $('button#tomorrow').click(getLunch);
    $('button#return').click(function() {
       $('div.content#temp').hide();
       $('div.content#main').show();
        
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