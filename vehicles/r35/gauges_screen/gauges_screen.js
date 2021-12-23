

angular.module('gaugesScreen', [])
.controller('GaugesScreenController', function($scope, $window) {
  var unit = null;
  $scope.data = {}
  // overwriting plain javascript function so we can access from within the controller
  $window.setUnits = (data) => {
    unit = data.unitType;
  }
  
  $window.updateData = (data) => {
    $scope.$evalAsync(function() {
      // We need access to the turbo bar svg element so that we can animate it
      var pressureCurve = document.getElementById('pressureCurve');
	  var pressureCurveLen = 1277.202;
	  var pressure_max = 20;
	  var pressure_min -15;
      value = data.turboBoost;
	  var percPos = (value - pressure_min) / (pressure_max - pressure_min);
	  
	  if (percPos < 0) {
		  percPos = 0;
	  }
	  if (percPos > 1) {
		  percPos = 1;
	  }
	  
      pressureCurve.style.strokeDasharray = pressureCurveLen + ' ' + pressureCurveLen;
      turbo.style.strokeDashoffset = pressureCurveLen - (pressureCurveLen * percPos);
    })
  }
});    