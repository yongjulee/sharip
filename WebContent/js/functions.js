/**
 * 
 */

String.prototype.trimspace = function(){
	var result = this.replace(/(^(\n|\r)*|(\n|\r)*$)/gi, "");
	result = result.replace(/((\n|\r)+)/gi, "\n");
	return result.replace(/(^(\s)*|(\s)*$)/gi, "");
//	return result.replace(/\s{2,}/gi, " ");
}

String.prototype.checkOnlySpace = function(){
	var str = String(this); 
	if(!str) return true;
	var space = /^\s+$/;
	if(str.search(space)!=-1) return true;
	else return false;
}


function convertTagString(str, trim, noEncoded){
	var bef_result;
	if(!noEncoded) bef_result = decodeURIComponent(str);
	else bef_result = str;
	
	var temp_amp = bef_result.split('&');
	var result_amp = "";
	if(bef_result==temp_amp){
		result_amp = temp_amp;
	}
	else{
		for(var i=0; i<temp_amp.length-1; i++){
		result_amp = result_amp + temp_amp[i] + "&amp;" + temp_amp[i+1];
		}
	}
	result_amp = String(result_amp);
	
	if(trim==1) result_amp = result_amp.trimspace();
	else if(trim==2){
		while(result_amp.indexOf('\n')!=-1){
			result_amp = result_amp.replace('\n', ' ');
		}
		while(result_amp.indexOf('\r')!=-1){
			result_amp = result_amp.replace('\r', ' '); 
		}
	}

	while(result_amp.indexOf('"')!=-1){
		result_amp = result_amp.replace('"', '&quot;'); 
	}

	while(result_amp.indexOf('<')!=-1){
		result_amp = result_amp.replace('<', '&lt;');
	}

	while(result_amp.indexOf('>')!=-1){
		result_amp = result_amp.replace('>', '&gt;'); 
	}
/*
	while(result_amp.indexOf(' ')!=-1){
		result_amp = result_amp.replace(' ', '&nbsp;'); 
	}
*/
/*
	while(result_amp.indexOf('\r')!=-1){
		result_amp = result_amp.replace('\r', '<br>'); 
	}
*/
	while(result_amp.indexOf('\n')!=-1){
		result_amp = result_amp.replace('\n', '<br>'); 
	}

	return result_amp;
}


//	ex) convertTimeForm('2016-03-03-14-30-13')
function convertTimeForm(time, messages){
	var date = new Date();
	var nYear = date.getFullYear();
	var nMonth = (date.getMonth()+1)>9?(date.getMonth()+1):'0'+(date.getMonth()+1);
	var nDay = date.getDate()>9?date.getDate():'0'+date.getDate();
	var nHour = date.getHours()>9?date.getHours():'0'+date.getHours();
	var nMin = date.getMinutes()>9?date.getMinutes():'0'+date.getMinutes();
	var nSec = date.getSeconds()>9?date.getSeconds():'0'+date.getSeconds();
	var oTime = time.split('-');
	var oYear = oTime[0];
	var oMonth = oTime[1];
	var oDay = oTime[2];
	var oHour = oTime[3];
	var oMin = oTime[4];
	var oSec = oTime[5];

	var start_time = oTime[0]+oTime[1]+oTime[2]+oTime[3]+oTime[4]+oTime[5];
	var end_time = nYear+nMonth+nDay+nHour+nMin+nSec;
	var dif_time = calTimeRange(start_time, end_time); 
	var dif_day = dif_time[0];
	var dif_hour = dif_time[1];
	var dif_min = dif_time[2];
	var dif_sec = dif_time[3];
	var result;

	oMonth = parseInt(oMonth);
	oDay = parseInt(oDay);
	oHour = parseInt(oHour);
	
	if(dif_day==0){
		if(!messages){
			if(dif_hour==0){
				if(dif_min==0){
					if(dif_sec==0) result = "1초";
					else result = dif_sec+"초";
				}
				else result = dif_min+"분";
			}
			else result = dif_hour+"시간";
		}
		else{
			if(oHour>12 && oHour<24) result = "오후&nbsp"+(oHour-12)+":"+oMin;
			else if(oHour>0 && oHour<12) result = "오전&nbsp"+oHour+":"+oMin;
			else if(oHour==0) result = "오전&nbsp12:"+oMin;
			else if(oHour==12) result = "오후&nbsp12:"+oMin;
		}
	}
	else if(dif_day==1){
		if(oHour>12 && oHour<24) result = "어제&nbsp오후&nbsp"+(oHour-12)+":"+oMin;
		else if(oHour>0 && oHour<12) result = "어제&nbsp오전&nbsp"+oHour+":"+oMin;
		else if(oHour==0) result = "어제&nbsp오전&nbsp12:"+oMin;
		else if(oHour==12) result = "어제&nbsp오후&nbsp12:"+oMin;
	}
	else if(dif_day==2){
		if(oHour>12 && oHour<24) result = "그제&nbsp오후&nbsp"+(oHour-12)+":"+oMin;
		else if(oHour>0 && oHour<12) result = "그제&nbsp오전&nbsp"+oHour+":"+oMin;
		else if(oHour==0) result = "그제&nbsp오전&nbsp12:"+oMin;
		else if(oHour==12) result = "그제&nbsp오후&nbsp12:"+oMin;
	}
	else if(dif_day>2 && dif_day<120){
		result = oMonth+"월&nbsp"+oDay+"일&nbsp";
		if(oHour>12 && oHour<24) result += "오후&nbsp"+(oHour-12)+":"+oMin;
		else if(oHour>0 && oHour<12) result += "오전&nbsp"+oHour+":"+oMin;
		else if(oHour==0) result += "오전&nbsp12:"+oMin;
		else if(oHour==12) result += "오후&nbsp12:"+oMin;
	}
	else{
		result = oYear+"년&nbsp"+oMonth+"월&nbsp"+oDay+"일&nbsp";
		if(oHour>12 && oHour<24) result += "오후&nbsp"+(oHour-12)+":"+oMin;
		else if(oHour>0 && oHour<12) result += "오전&nbsp"+oHour+":"+oMin;
		else if(oHour==0) result += "오전&nbsp12:"+oMin;
		else if(oHour==12) result += "오후&nbsp12:"+oMin;
	}
	return result;
}

function calTimeRange(startTime, endTime){
	var startDate = new Date(parseInt(startTime.substring(0,4), 10),
		parseInt(startTime.substring(4,6), 10)-1,
		parseInt(startTime.substring(6,8), 10),
		parseInt(startTime.substring(8,10), 10),
		parseInt(startTime.substring(10,12), 10),
		parseInt(startTime.substring(12,14), 10)
		);
	var staryDay = new Date(parseInt(startTime.substring(0,4), 10),
		parseInt(startTime.substring(4,6), 10)-1,
		parseInt(startTime.substring(6,8), 10));


	var endDate = new Date(parseInt(endTime.substring(0,4), 10),
		parseInt(endTime.substring(4,6), 10)-1,
		parseInt(endTime.substring(6,8), 10),
		parseInt(endTime.substring(8,10), 10),
		parseInt(endTime.substring(10,12), 10),
		parseInt(endTime.substring(12,14), 10)
		);
	var endDay = new Date(parseInt(endTime.substring(0,4), 10),
		parseInt(endTime.substring(4,6), 10)-1,
		parseInt(endTime.substring(6,8), 10));

	var dayGap = endDay.getTime() - staryDay.getTime();
	var timeGap = new Date(0, 0, 0, 0, 0, 0, endDate - startDate); 

	var diffDay  = (dayGap / (1000 * 60 * 60 * 24));
	var diffHour = timeGap.getHours();      
	var diffMin  = timeGap.getMinutes();    
	var diffSec  = timeGap.getSeconds();    

	return new Array(diffDay, diffHour, diffMin, diffSec);
}












var modal_stack = new Array();

function Modal(modal_tag){
	var that = this;
	var loaded = false;
	var mobile_user = mobileCheck();
	
	var modal_parents;
	var modal_scroll;
	var modal_border;
	var container = document.getElementById("container");

	modal_tag.style.display = 'none';

	this.closeModal = function(his, closeExe){
		if(mobile_user) container.style.position = 'static';
		if(his) history.back();
		if(typeof closeExe==='function') closeExe();
		if(modal_parents.parentNode) modal_parents.parentNode.removeChild(modal_parents);
		if(modal_scroll.parentNode) modal_scroll.parentNode.removeChild(modal_scroll);
	//	modal_parents.style.display = 'none';
	//	modal_scroll.style.display = 'none';
		modal_stack.removeElement(modal_stack.length-1);
		if(!getIdNum()){
			document.body.style.overflowX = 'auto';
			document.body.style.overflowY = 'scroll';
		}
	}

	this.openModal = function(mWidth, mHeight, his, closeExe){
		initOpenModal(mWidth, mHeight, his, closeExe);
		resizeModal(mWidth, mHeight);
		if(!mobile_user){
			addEventListener('resize', function(){
				resizeModal(mWidth, mHeight);
			});
		}

		modal_tag.onmousedown = function(e){
			e.stopPropagation();
		};
	};

	this.openModalIE = function(mWidth, mHeight, his, closeExe){
		initOpenModal(mWidth, mHeight, his, closeExe);
		resizeModalIE(mWidth, mHeight);
		attachEvent('onresize', function(){
			resizeModalIE(mWidth, mHeight);
		});
		
		modal_tag.onmousedown = function(e){
			e.cancelBubble = true;
		};
	};

	function initOpenModal(mWidth, mHeight, his, closeExe){
		var id_num = getIdNum();
		
	//	if(!loaded){
	//		console.log(loaded);
			modal_parents = document.createElement('div');
			modal_scroll = document.createElement('div');
			modal_border = document.createElement('div');
			document.body.appendChild(modal_parents);
			document.body.appendChild(modal_scroll);
			modal_scroll.appendChild(modal_border);
			modal_scroll.appendChild(modal_tag);
	//		loaded = true;
	//	}

		modal_scroll.style.top = '0';
		modal_scroll.style.left = '0';
		modal_scroll.style.display = 'none';
		modal_scroll.style.position = 'absolute';

		modal_parents.className = "md-parent";

		modal_stack[id_num] = new Object();
		modal_stack[id_num].name = modal_tag;
		modal_stack[id_num].his = his;
		modal_stack[id_num].closeExe = closeExe;
		modal_stack[id_num].parents = modal_parents;
		modal_stack[id_num].scroll = modal_scroll;
		modal_stack[id_num].border = modal_border;

		modal_parents.style.opacity = '0.6';
		modal_parents.style.filter = "alpha(opacity=60)";

		modal_border.style.display = 'none';
		modal_border.style.position = 'absolute';
		modal_border.style.width = (mWidth+60)+'px';
		modal_border.style.height = (mHeight+60)+'px';
		modal_border.style.marginLeft = (-mWidth/2-30)+'px';
		modal_border.style.marginTop = (-mHeight/2-30)+'px';

		modal_tag.style.display = 'none';
		modal_tag.style.position = 'absolute';
		modal_tag.style.width = mWidth+'px';
		modal_tag.style.height = mHeight+'px';
		modal_tag.style.backgroundColor = 'white';
		modal_tag.style.marginLeft = (-mWidth/2)+'px';
		modal_tag.style.marginTop = (-mHeight/2)+'px';

		modal_parents.style.zIndex = 10+(id_num*5);
		modal_tag.style.zIndex = 11+(id_num*5);
		modal_border.style.zIndex = 11+(id_num*5);
		modal_scroll.style.zIndex = 12+(id_num*5);

		modal_parents.style.display = 'block';
		modal_tag.style.display = 'block';
		modal_scroll.style.display = 'block';
		modal_border.style.display = 'block';

		document.body.style.overflowY = 'hidden';
		document.body.style.overflowX = 'hidden';

		modal_scroll.style.overflowY = 'scroll';
		modal_scroll.style.overflowX = 'auto';

		window.onkeydown = function(e){
			var m_id = modal_stack[modal_stack.length-1];
			if(m_id && m_id.name.style.display=='block'){
				if (!e) e = event;
				if (e.keyCode==27){
					that.closeModal(m_id.his, m_id.closeExe);
				}
			}
		};

		var state_down = false;
		modal_scroll.onmousedown = function(){
			state_down = true;
		}
		modal_scroll.onclick = function(){
			if(state_down) that.closeModal(his, closeExe);
			state_down = false;
		};

		modal_tag.onmouseup = function(){
			state_down = false;
		};

		if(his){
			window.onhashchange = function(){
				if(!parseHashURL(his)){
					that.closeModal();
				}
			}
		}
	}

	function resizeModal(mWidth, mHeight){
		var body_size = getBody();
		var cur_sizeX;
		var cur_sizeY;

		if(!mobile_user){
			modal_border.style.left = window.innerWidth/2 + body_size.x + 'px';
			modal_border.style.top = window.innerHeight/2 + body_size.y + 'px';
			modal_tag.style.left = window.innerWidth/2 + body_size.x + 'px';
			modal_tag.style.top = window.innerHeight/2 + body_size.y + 'px';
		}
		else{
			container.style.position = 'fixed';
			modal_border.style.left = document.body.scrollWidth/2 + 'px';
			modal_border.style.top = document.body.scrollHeight/2 + 'px';
			modal_tag.style.left = document.body.scrollWidth/2 + 'px';
			modal_tag.style.top = document.body.scrollHeight/2 + 'px';
		}

		body_size = getBody();
		if(!mobile_user){
			if(cur_sizeX != window.innerWidth || !cur_sizeX){
				cur_sizeX = window.innerWidth;
				modal_border.style.left = window.innerWidth/2 + 'px';
				modal_tag.style.left = window.innerWidth/2 + 'px';
				if(cur_sizeX < mWidth+80){
					modal_border.style.left = (mWidth/2)+40+'px';
					modal_tag.style.left = (mWidth/2)+40+'px';
				}
			}
			if(cur_sizeY != window.innerHeight || !cur_sizeY){
				cur_sizeY = window.innerHeight;
				modal_border.style.top = window.innerHeight/2 + 'px';
				modal_tag.style.top = window.innerHeight/2 + 'px';
				if(cur_sizeY < mHeight+80){
					modal_border.style.top = (mHeight/2)+40+'px';
					modal_tag.style.top = (mHeight/2)+40+'px';
				}
			}

			modal_scroll.style.left = body_size.x + 'px';
			modal_scroll.style.top = body_size.y + 'px';
			modal_scroll.style.width = window.innerWidth + 'px';
			modal_scroll.style.height = window.innerHeight + 'px';
		}
		else{
			modal_scroll.style.width = body_size.width + 'px';
			modal_scroll.style.height = body_size.height + 'px';
		}

		modal_parents.style.width = body_size.width + 'px';
		modal_parents.style.height = body_size.height + 'px';
	}

	function resizeModalIE(){
		var body_size = getBody();
		var cur_sizeX;
		var cur_sizeY;

		if(!mobile_user){
			modal_border.style.left = document.documentElement.clientWidth/2 + body_size.x + 'px';
			modal_border.style.top = document.documentElement.clientHeight/2 + body_size.y + 'px';
			modal_tag.style.left = document.documentElement.clientWidth/2 + body_size.x + 'px';
			modal_tag.style.top = document.documentElement.clientHeight/2 + body_size.y + 'px';
		}
		else{
			container.style.position = 'fixed';
			modal_border.style.left = document.body.scrollWidth/2 + 'px';
			modal_border.style.top = document.body.scrollHeight/2 + 'px';
			modal_tag.style.left = document.body.scrollWidth/2 + 'px';
			modal_tag.style.top = document.body.scrollHeight/2 + 'px';
		}

		body_size = getBody();
		if(!mobile_user){
			if(cur_sizeX != document.documentElement.clientWidth || !cur_sizeX){
				cur_sizeX = document.documentElement.clientWidth;
				modal_border.style.left = document.documentElement.clientWidth/2 + 'px';
				modal_tag.style.left = document.documentElement.clientWidth/2 + 'px';
				if(cur_sizeX < 880){
					modal_border.style.left = 440 + 'px';
					modal_tag.style.left = 440 + 'px';
				}
			}
			if(cur_sizeY != document.documentElement.clientHeight || !cur_sizeY){
				cur_sizeY = document.documentElement.clientHeight;
				modal_border.style.top = document.documentElement.clientHeight/2 + 'px';
				modal_tag.style.top = document.documentElement.clientHeight/2 + 'px';
				if(cur_sizeY < 480){
					modal_border.style.top = 240 + 'px';
					modal_tag.style.top = 240 + 'px';
				}
			}
			modal_scroll.style.left = body_size.x + 'px';
			modal_scroll.style.top = body_size.y + 'px';
			modal_scroll.style.width = document.documentElement.clientWidth + 'px';
			modal_scroll.style.height = document.documentElement.clientHeight + 'px';
		}
		else{
			modal_scroll.style.width = body_size.width + 'px';
			modal_scroll.style.height = body_size.height + 'px';
		}

		modal_parents.style.width = body_size.width + 'px';
		modal_parents.style.height = body_size.height + 'px';
	}

	function mobileCheck(){
		var browserCheckText = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson');
		for (var i=0, item; item=browserCheckText[i]; i++){
			if(navigator.userAgent.toUpperCase().match(item.toUpperCase()) != null){
				return true;
			}
		}
		return false;
	}

	function getIdNum(){
		var id_num = 0;
		if(document.addEventListener) var md_parent = document.getElementsByClassName("md-parent");
		else if(document.attachEvent) var md_parent = document.querySelectorAll("md-parent");
		for(var i=0; i<md_parent.length; i++){
			if(md_parent[i].style.display=='block') id_num++;
		}
		return id_num;
	}
}






