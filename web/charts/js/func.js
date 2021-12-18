var start_year = 2017;

		function prepare_data_arr(){
			var curr_year = new Date().getFullYear();
			var t = [];
			for (y = start_year; y<=curr_year; y++){
				t[y] = [];
			}
			return t;
		}
		function color(year){
			var list = ['red', 'green', 'blue', 'yellow', 'fuchsia', 'purple', 'olive', 'navy', 'maroon', 'lime'];
			var curr_year = new Date().getFullYear();
			console.log(curr_year);
			var i = curr_year - year;
			return list[i];
		}
		function dataset(data, year){
			return {
                                        label: year,
                                        backgroundColor: color(year),
                                        borderColor: color(year),
                                        data: data[year],
                                        fill: false,
                                };
		}
		function datasets(data){
			var curr_year = new Date().getFullYear();
			var datasets = [];
			for (y = start_year; y<=curr_year; y++){
				datasets.push(dataset(data, y));
			}
			console.log(datasets);
			return datasets;
		}
		function labels(){
			return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		}
		
		function config(title, data){
  		   return {
			type: 'line',
			data: {
				labels: labels,
				datasets: datasets(data)
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: title
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}]
				}
			}
		   };
		}
