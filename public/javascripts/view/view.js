var $ = require('jquery');
var Chart = require('chart.js');
var ctx = document.getElementById('my-chart');
var labels = []
var data_ = []
var bgColor = []
var bColor = []

//set data
for (i in info.answers){
	labels.push(info.answers[i].opt);
	data_.push(info.answers[i].votes);
	r = Math.floor(Math.random() * 200);
	g = Math.floor(Math.random() * 200);
	b = Math.floor(Math.random() * 200);
	rgb = 'rgb(' + r + ', ' + g + ', ' + b + ')';
	bgColor.push(rgb);
	bColor.push(rgb);
}

var data = {
	datasets: [{
		label : info.question,
		data : data_,
		backgroundColor : bgColor,
		borderColor : bColor,
		borderWidth : 1
	}],
	labels: labels
};

var options = {
	animation : {
		animateScale : true
	}
}

var myDoughnutChart = new Chart(ctx, {
	type: 'doughnut',
	data: data,
	options: options
});

function changes(val){
	if (val == 'Enter Your Own'){
		$('#g_other').show();
		if ($('#i_other').val() == ''){
			$('#submit').prop('disabled',true);
		}else{
			$('#submit').prop('disabled',false);
		}
	}else if (val == null){
		$('#g_other').hide();
		$('#submit').prop('disabled',true);
	}else{
		$('#g_other').hide();
		$('#submit').prop('disabled',false);
	}
}

$('#i_other').change(function(){
	val = $(this).val();
	if (val == ''){
		$('#submit').prop('disabled',true);
	}else{
		$('#submit').prop('disabled',false);
	}
});

$('#i_answer').change(function(){
	val = $(this).val();
	changes(val);
});

$('#delete').click(function(evt){
	res = confirm("Sure You Want To Delete?");
	if (!res){
		evt.preventDefault();
	}
});

$(document).ready(function(){
	val = $('#i_answer').val();
	changes(val);
});
