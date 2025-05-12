/**
 * 
 */

$(document).ready(function () {
	
	$('#chatting').click(function (e) {
	    e.preventDefault(); // a 링크 기본 이동 막기
	    if (typeof memNo !== 'undefined' && typeof prodNo !== 'undefined') {
	        $('#main-content').load('/CarrotEasy/chattingroom.do?memNo=' + memNo + '&prodNo=' + prodNo + '&source=prodView');
	    } else {
	        $('#main-content').load('/CarrotEasy/chattingroom.do');
	    }
	});

});


