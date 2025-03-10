import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loteria/app/pages/home/aposta_page.dart';
import 'package:loteria/app/pages/home/surpresinha_page.dart';
import 'package:loteria/app/pages/meus_jogos/meus_jogos_page.dart';
import 'package:loteria/app/widgets/card_jogos.dart';

class AcessoRapido extends StatelessWidget {
  const AcessoRapido({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Acesso rápido',
          style: TextStyle(color: Color(0xFFF2EFE5), fontSize: 22),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardJogosWidget(
                nome: 'Adicionar jogo',
                icon: FontAwesomeIcons.clover,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ApostaPage()));
                },
              ),
              const SizedBox(
                width: 10,
              ),
              CardJogosWidget(
                nome: 'Surpresinha',
                icon: FontAwesomeIcons.arrowRightFromBracket,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SurpresinhaPage()));
                },
              ),
              const SizedBox(
                width: 10,
              ),
              CardJogosWidget(
                nome: 'Meus Jogos',
                icon: FontAwesomeIcons.dice,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MeusJogosPage()));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
