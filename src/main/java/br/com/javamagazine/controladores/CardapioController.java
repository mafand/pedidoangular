package br.com.javamagazine.controladores;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.javamagazine.entidades.CardapioItem;
import br.com.javamagazine.repositorios.RestauranteRepository;

@Controller
public class CardapioController {

	@Autowired
	private RestauranteRepository restauranteRepository;

	@RequestMapping(value = "/cardapio", method = RequestMethod.GET)
	@ResponseBody
	public List<CardapioItem> getCardapio() {
		return restauranteRepository.getItensDoCardapio();
	}
}
