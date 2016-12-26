$(window).scroll(function(){
	if($(window).scrollTop()>0){
		$('#fixHead').css({
			'position':'fixed',
			'width':'100%',
			'z-index':'9'
		})
	}
})
$(function(){
	
	//Drop down box
	$('#dropInfoBox').hover(
		function(){
			//alert('hover')
			$('.dropInfo').fadeIn('fast');
		},function(){
			//alert('out')
			$('.dropInfo').fadeOut('fast');
		}
	)
	var Flag = 0;
	$('.sub_mClick').click(function(){
		//$(this).parent().parent().find('.mClick').next('div').slideUp()
		//$(this).parent().parent().find('.mClick').removeClass('selectedMemb')
		$(this).toggleClass('selectedMemb')
		$(this).next('div').slideToggle()
		//alert($(this).is('class')=='active')
	})
	
	//jQtransform
	$('.jqGreenForm').jqTransform({imgPath:'images/'});	
	$('.jqSmallform').jqTransform({imgPath:'images/'});	
	$('.jqBigform').jqTransform({imgPath:'images/'});
	
	//Setting Box
	$('.settingBox').hover(
		function(){
			$(this).find('.moreSetting').show();
		},
		function(){
			$(this).find('.moreSetting').hide();
		}
	)
	
	//Tooltip Script
	var leftPosition = 10;
	var topPosition = -5;
	$('.infoIcon,.infoTxt').hover(
		function() {
			
		this.info = this.title;
		
		$('body').append(
			'<div class="toolTipWrapper">'
				+'<div class="toolTipTop"></div>'
				+this.info
			+'</div>'
		);
		this.title = "";
		$('.toolTipWrapper').css({ left:$(this).offset().left+$(this).width()+leftPosition,top:$(this).offset().top+topPosition });
		$('.toolTipWrapper').fadeIn(300);
	},
	function() {
		$('.toolTipWrapper').fadeOut(100);
		this.title = this.info;
		$('.toolTipWrapper').remove()
	}
	);
	
	 showHoverBox('.updateAct','.updatePop','eventBox');
	 showHoverBox('.showPop','.calInfoPop','');
	 showHoverBox('.showPop','.iconInfo','');
	 
	 if($('.activityBtn').size() == 1){
		 $(".jqGreenForm div.jqTransformSelectWrapper ul li a,.jqSmallform div.jqTransformSelectWrapper ul li a").click(function(){
			  var value = $(this).parent().index();
			  $("[name=city]").attr('selectedIndex', value);
			
			  var infoList = $(this).attr('name')
			  var spiteInfo = infoList.split('#')	  
					
			  //alert(spiteInfo[1]+spiteInfo[2]+spiteInfo[3]+'.html'+'Add a New '+spiteInfo[0])
			  // will alert 21, 12, or 34 depending on which one was selected
			  if(value != 0){
				if(value==2){
					loadWindow(spiteInfo[1],spiteInfo[2],spiteInfo[3],spiteInfo[0]);
				}else if(value==1){
					location.href='child_activities_timetable.html';		
				}else{
					loadWindow(spiteInfo[1],spiteInfo[2],spiteInfo[3],'Add a New '+spiteInfo[0]);
				}
			  }  
			  return false; 
		  }); 
	 }
		
	 $("a.show_val").each(function(index){		
		console.log($(this).text());
		if($(this).text() != "Click to add" && $(this).text() != "Please select from dropdown"){
			$(this).css("color", "black");
			$(this).css("font-weight", "600");		
		}
	});
	 
});

function showBoxInfo(obj,objShow){
	var tipLeft = 0;
	var tipTop = 0;
	$(obj).mouseover(function(e) {
		var tipPoL = $(this).position().left - $(objShow).innerWidth()
		$(objShow).css({left:tipPoL + tipLeft,top:$(this).position().top + tipTop})
		$(objShow).fadeIn()
		
    });	
}

function showHoverBox(obj,ojeHover,objClass){
	$(obj).hover(
		function(){
			var winHeight = $(window).outerHeight()
			var popHeight = $(this).find(ojeHover).outerHeight()
			var overPosition = $(this).offset().top
			
			$(this).find(ojeHover).fadeIn()
			if(winHeight==648){
				$(this).find(ojeHover).fadeIn()
				.css({top:-(popHeight-overPosition)})
			}
			$(this).addClass(objClass)
		},
		function(){
			$(this).find(ojeHover).fadeOut();
			$(this).removeClass(objClass)
		}
	)
}

//popup Scirpt
var windowLoad = 0;
function loadWindow(winWidth,winHeight,winContent,winTitle){
	if(windowLoad==1){
		disablePopup();
	}
	if(windowLoad==0){		
		windowLoad=1;
		var windowDiv = $('<div class="popupWindow">'+
							  '<div class="popupHead">'+
								'<div class="popupTitle">'+winTitle+'</div>'+
								'<div class="closeBtn" onclick="disablePopup()"></div>'+
								'<div class="CL"></div>'+
							  '</div>'+
							  '<div class="popupContaint">Popup content</div>'+
							'</div>');
							
		$('body').prepend(windowDiv);
		
		var divOverlay = $('<div class="overLay"></div>');
		$('body').prepend(divOverlay);		
		divOverlay.css({
			'width':$(window).width(),
			'height':$(window).height(),
			'position':'fixed',
			'opacity':0.5,
			'background-color':'#000',
			'z-index':'90'	
		})		
		windowDiv.css({
			'width':winWidth,
			'height':winHeight,
			'z-index':90
		});		
		$('.popupContaint').load(winContent,function(){
			if($('.jqBigform').size()>=1){
				$('.jqBigform').jqTransform({imgPath:'images/'});	
			}	
			if($('.jqSmallform').size()>=1){
				$('.jqSmallform').jqTransform({imgPath:'images/'});	
			}
			if($('.childRole').size()>=1){
				$('.childRole').jScrollPane({
				  maintainPosition: true,
				  bottomCapHeight: 0,
				  topCapHeight: 0,
				  verticalDragMinHeight: 20,
				  verticalDragMaxHeight: 20,
				  bottomCapColor: 'transparent',
				  hijackInternalLinks:true,
				  animateScroll:true	
				})	
			}
			//popScroll			
			if($('.popScroll').size()>=1){
				$('.popScroll').jScrollPane({
				  maintainPosition: true,
				  bottomCapHeight: 0,
				  topCapHeight: 0,
				  verticalDragMinHeight: 40,
				  verticalDragMaxHeight: 40,
				  bottomCapColor: 'transparent',
				  hijackInternalLinks:true,
				  animateScroll:true	
				})	
			}
		});		
		centerPopup();
	}
	
}
function centerPopup(){
	var windowWidth = $(window).width();
	var windowHeight = $(window).height();
	$('.popupWindow').css({
		'left':(windowWidth-$('.popupWindow').outerWidth())/2,
		'top':(windowHeight-$('.popupWindow').outerHeight())/2
	});
}
function disablePopup(){
	$('.popupWindow').remove();
	$('.overLay').remove();
	windowLoad = 0;
}

// 2 show hide Script
function showEdit(showObj,hideObj,hideEdit){
	$(showObj).show()
	$(hideObj).hide()
	//$(showObj).parent().find(hideEdit).hide()
	if($('.jqSmallform').size()<=1){
		$('.jqSmallform').jqTransform({imgPath:'images/'});
	}
}
function hideEdit(showObj,hideObj,hideEdit){
	$(showObj).hide()
	$(hideObj).show()
	//$(showObj).parent().find(hideEdit).show();
}
//simpl hide show
function showObj(obj){
	$(obj).show();
	//scrollPop
	if($('.scrollPop').size()>=1){
		$('.scrollPop').jScrollPane({
	  maintainPosition: true,
	  bottomCapHeight: 0,
	  topCapHeight: 0,
	  verticalDragMinHeight: 20,
	  verticalDragMaxHeight: 20,
	  bottomCapColor: 'transparent',
	  hijackInternalLinks:true,
	  animateScroll:true	
	})	
	}
}
function hideObj(obj){
	$(obj).hide()
}

function showFunctionAlert(obj){		
	if($('#checkbox').attr("checked")=='checked'){
		$('#repeatShow').show();	//repeatShow
		$('#repeatShow').jScrollPane({
		  maintainPosition: true,
		  bottomCapHeight: 0,
		  topCapHeight: 0,
		  verticalDragMinHeight: 20,
		  verticalDragMaxHeight: 20,
		  bottomCapColor: 'transparent',
		  hijackInternalLinks:true,
		  animateScroll:true	
		})	
	}else{
		$('#repeatShow').hide();	
	}
}

function saveProfileAttribute(type, field, value, obj_name){
	real_value = value + ' input[type="text"]'
	if(field == 'country' || field == 'state' || field == 'city' || field == 'mother_tongue' || field == 'nationality' || field =='occupation' || field =='industry' || obj_name == 'finance' || field == 'category' ){
		real_value = value + ' select'
	}
	//if( type == '' || type != 'p' || type != 'c' ) return false;	
	
	var url = type == 'p' ? 'profile/parent_save_value' : 'profile/child_save_value'
	
	console.log(real_value);
	
	$.post( url, {
		obj: obj_name,
		field: field,
		value: $(real_value).val()
	}).success(function() {
		console.log('success');
	}).error(function() {
		console.log('failure');
	});
}

function saveChildInterest(type, opt_name, value, id){
	var url = 'profile/child_save_value'
	
	if(type=='edit'){
		real_value = value + ' select'
	}else{
		real_value = value + ' select'
	}

	console.log(real_value);
	
	$.post( url, {
		obj: 'interest',
		type: type,
		id: id,
		field: opt_name,
		value: $(real_value).val()
	}).success(function() {
		$('#child_interest_form').submit();
	}).error(function() {
		console.log('failure');
	});
}

function setValue(dest, value, type){
	var real_value = value + ' input[type="text"]';
	if(type=='input'){
		real_value = value + ' input[type="text"]'
	}else if(type=='select'){
		real_value = value + ' select'
	}
	val = $(real_value).val();
	$(dest).text(val);
	return true;
}