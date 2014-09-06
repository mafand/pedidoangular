package br.com.javamagazine.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.javamagazine.entidades.CardapioItem;
import br.com.javamagazine.entidades.Pedido;
import br.com.javamagazine.repositorios.RestauranteRepository;

@Controller
public class PedidoController {

	@Autowired
	private RestauranteRepository restauranteRepository;

	@RequestMapping(value = "/pedido/{id}", method = RequestMethod.POST)
	@ResponseBody
	public void fazerPedido(@RequestBody Pedido pedido, @PathVariable Long id) {
		CardapioItem item = restauranteRepository.getItem(id);
		pedido.setItem(item);
		restauranteRepository.salvarPedido(pedido);
	}
}
