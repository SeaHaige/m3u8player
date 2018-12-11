

fetch('http://127.0.0.1:1960/Close?').then(function(res){		
	if (res.ok) {
		PPeasy_Player_Hook();
		setInterval(PPeasy_Player_Hook(),1000); 
	}
	return null;
});
 
function PPeasy_Player_Hook(){	 
	for(var k=0;k<document.getElementsByTagName('video').length;k++)
	{			
		var vobj=document.getElementsByTagName('video')[k]; 
		if(typeof  vobj.playobj=='undefined') { 
			if(vobj.childNodes.length && typeof vobj.childNodes[0].src!='undefined' && vobj.childNodes[0].src!="")
			{
				
				vobj.src=vobj.childNodes[0].src;
				var url=vobj.src.substring(vobj.src.indexOf('://')+3);
				vobj.src='http://127.0.0.1:1960/play/'+url;
				
				vobj.childNodes[0].src='';
			}		
						
			if(vobj.src.substring(0,5)!='blob:' && vobj.src.substring(0,22)!='http://127.0.0.1:1960/' )
			{
				
				var url='';
				if(vobj.src!='')
				{
					url=vobj.src.substring(vobj.src.indexOf('://')+3);
					vobj.src='http://127.0.0.1:1960/play/'+url;
				}else
				if(vobj.childNodes.length)
				{
					url=vobj.childNodes[0].src.substring(vobj.childNodes[0].src.indexOf('://')+3);
					vobj.childNodes[0].src='';
					vobj.src='http://127.0.0.1:1960/play/'+url;
				}
			};	
				
			vobj.playobj=vobj.play;
			vobj.play=function(){ 								
				if(this.src.substring(0,5)!='blob:' && this.src.substring(0,22)!='http://127.0.0.1:1960/'   )
				{
					
					var url='';
					if(this.src!='')
					{
						url=this.src.substring(this.src.indexOf('://')+3);
						this.src='http://127.0.0.1:1960/play/'+url;
					}else
					if(this.childNodes.length)
					{
						url=this.childNodes[0].src.substring(this.childNodes[0].src.indexOf('://')+3);
						this.childNodes[0].src='';
						this.src='http://127.0.0.1:1960/play/'+url;
					}
				};	
				this.playobj();
			}
			//
		}
	} 
} 
