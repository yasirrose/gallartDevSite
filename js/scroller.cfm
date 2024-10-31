var pic = new Array()

function banner(name, width, link){
	this.name = name
	this.width = width
	this.link = link
   }
<cfoutput query="data">
pic[#evaluate(currentrow-1)#] = new banner('#imageurl#',102,'item.cfm?pid=#uid#&xss=#xss#')
</cfoutput>

var speed = 50

var kk = pic.length
var ii
var hhh
var nnn
var myInterval
var myPause
var mode = 0


var imgArray = new Array(kk)
var myLeft = new Array(kk)

for (ii=0;ii<kk;ii++){
imgArray[ii] = new Image()
imgArray[ii].src = pic[ii].name
imgArray[ii].width = pic[ii].width

	hhh=0 
	for (nnn=0;nnn<ii;nnn++){
		hhh=hhh+pic[nnn].width
	}
	myLeft[ii] = hhh
}

function ready(){
	for (ii=0;ii<kk;ii++){ 
		if (document.images[ii].complete == false){
			return false	
			break
		}
	}
return true
}


function startScrolling(){
	if (ready() == true){		
		window.clearInterval(myPause)
		myInterval = setInterval("autoScroll()",speed)	
	}
}	
	

function autoScroll(){
	for (ii=0;ii<kk;ii++){
		myLeft[ii] = myLeft[ii] - 1
		
	if (myLeft[ii] == -(pic[ii].width)){
		hhh = 0
		for (nnn=0;nnn<kk;nnn++){
			if (nnn!=ii){
				hhh = hhh + pic[nnn].width
			}			
		}
		myLeft[ii] =  hhh
	}
		
				
		document.images[ii].style.left = myLeft[ii]
	}
	mode = 1
}

function stop(){
	if (mode == 1){
		window.clearInterval(myInterval)
	}
	if (mode == 0){
		window.clearInterval(myPause)
	}	
}

function go(){
	if (mode == 1){
		myInterval = setInterval("autoScroll()",speed)
	}
	if (mode == 0){
		myPause = setInterval("startScrolling()",3000)
	}	
}

myPause = setInterval("startScrolling()",3000)
