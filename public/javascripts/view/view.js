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
