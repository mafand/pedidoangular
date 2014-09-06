<html ng-app>
<head>
<script type="text/javascript" src="http://code.angularjs.org/1.0.7/angular.min.js"></script>
<script type="text/javascript">
	function RestauranteController($scope, $http) {
		$scope.pedidos = [];
        $scope.cardapio = [];

		$scope.carregarCardapio = function() {
			$http.get('cardapio').success(function(cardapio){
				$scope.cardapio = angular.fromJson(cardapio);
			});
		};

		$scope.fazerPedido = function() {
			var pedido = {codigo: $scope.pedido.codigo, data: new Date()};

            $http.post('pedido/' + $scope.pedido.item.id, pedido).success(function(){
	            $scope.pedidos.push(angular.copy($scope.pedido));
	            $scope.calcularSubTotal();
              });
		};

		$scope.calcularTotal = function() {
			$scope.total = 0;
			angular.forEach($scope.pedidos, function(pedido){
				$scope.total += pedido.item.preco;
			});
		};

		$scope.carregarCardapio();
	}
</script>
</head>
<body ng-controller="RestauranteController">
	<input type="text" ng-model="criterio" placeholder="O que você está procurando?">
	<table ng-show="(cardapio | filter:criterio).length != 0">
      <tr>
        <th>Descrição</th><th>Preço</th>
      </tr>
      <tr ng-repeat="item in cardapio | filter:criterio">
         <td>{{item.descricao | uppercase}}</td><td>{{item.preco | currency:'R$'}}</td>
      </tr>
    </table>
	<span ng-show="(cardapio | filter:criterio).length == 0">Infelizmente não temos o item que você está procurando!</span>
	</hr>
	<form name="pedidoForm">
		<input type="number" name="codigo" ng-model="pedido.codigo" ng-required="true" ng-minlength="2" ng-maxlength="4" placeholder="Codigo da mesa"/>
	
		<select name="item" ng-model="pedido.item" ng-options="item as item.descricao for item in (cardapio | filter:criterio)" ng-required="true">
			<option value="">Selecione um item</option>
		</select>
		<button ng-click="fazerPedido()" ng-disabled="pedidoForm.codigo.$invalid || pedidoForm.item.$invalid">Fazer pedido</button>
	</form>
	<span ng-show="pedidoForm.codigo.$dirty && pedidoForm.codigo.$invalid">O campo Código da Mesa é obrigatório e deve ter 2 caracteres no máximo</span>
	</br>
	<table ng-show="pedidos.length != 0">
      <tr>
        <th>Código</th><th>Descrição</th><th>Preço</th><th>Quando o pedido foi realizado?</th>
      </tr>
      <tr ng-repeat="pedido in pedidos">
         <td>{{pedido.codigo}}</td>
         <td>{{pedido.item.descricao | uppercase}}</td>
         <td>{{pedido.item.preco | currency:'R$'}}</td>
         <td>{{pedido.data | date:'dd/MM/yyyy hh:mm'}}</td>
      </tr>
      <tr>
        <td></td><td>SUB-TOTAL</td><td>{{total | currency:'R$'}}</td><td></td>
      </tr>
      <tr>
        <td></td><td>TAXA DE SERVIÇO</td><td>{{(total*0.10) | currency:'R$'}}</td><td></td>
      </tr>
      <tr>
        <td></td><td>TOTAL</td><td>{{(total*1.1) | currency:'R$'}}</td><td></td>
      </tr>
    </table>
</body>
</html>