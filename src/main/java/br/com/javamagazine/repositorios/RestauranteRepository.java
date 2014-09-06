package br.com.javamagazine.repositorios;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.com.javamagazine.entidades.CardapioItem;
import br.com.javamagazine.entidades.Pedido;

@Repository
public class RestauranteRepository {

	@Autowired
	SessionFactory sessionFactory;

	@Transactional
	public List<CardapioItem> getItensDoCardapio() {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(CardapioItem.class);
		return (List<CardapioItem>) criteria.list();
	}

	@Transactional
	public void salvarPedido(Pedido pedido) {
		Session session = sessionFactory.getCurrentSession();
		session.save(pedido);
		session.flush();
	}

	@Transactional
	public CardapioItem getItem(Long id) {
		return (CardapioItem) sessionFactory.getCurrentSession().get(CardapioItem.class, id);
	}

}
