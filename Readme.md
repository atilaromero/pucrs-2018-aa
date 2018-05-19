# Execução

Ao invés de rodar o contest usando JUnit, como era feito na versão original, foi criada uma classe Main em src/java. Para iniciar o servidor através do eclipse, uma opção é clicar com o botão direito sobre o arquivo src/java/Main.java e escolher a opção "Run As" -> "Java Application".

Isso irá iniciar o servidor e paralelamente rodar os agentes. 

## Um jogador/dois jogadores

Para escolher quantos times irão competir simultaneamente, alterar a variável "teamsPerMatch" do arquivo conf/server/server.json.

# Descrição do desenvolvimento dos agentes

## Etapas iniciais

O código-fonte original dos agentes foi criado pelo colega Tabajara e disponibilizado pelo professor Bordini. Assim que foi executado com sucesso, o próximo passo foi entender o código do time "dummy" e usá-lo como ponto de partida para criação de um novo time. O time "dummy" é propositalmente básico, oferecendo um ponto de partida para criaçào de algo mais elaborado.

O código fonte do time "dummy" foi copiado para o outro time, "connectionA" e separado em arquivos menores por funcionalidade, para facilitar o entendimento, usando instruções do tipo:
```
{include("plans/charge.asl")}

```

Em seguida, foram feitas tentativas de melhorar o comportamento dos agentes. À primeira vista, os principais pontos a serem trabalhados no time "dummy" eram:
 - Os agentes se ajudam para completar o mesmo trabalho, o que é positivo, mas eles frequentemente vão todos à mesma loja para comprar os items.
 - Os agentes não se recarregam adequadamente.
 - Mais de um agente compra um mesmo item para um mesmo trabalho.
 - Apenas o último trabalho percebido é guardado em memória.
 - Itens não usados não são reaproveitados.
 - Não é feita busca por trabalhos similares que poderiam ser simultâneos.

Para tentar melhorar os agentes em algum destes aspectos, foram feitas várias modificações de maneira incremental. No entanto, este processo se mostrou extremamente difícil, porque era difícil evitar a propagação de efeitos colaterais. Ou seja, era comum que ao tentar corrigir determinado comportamento, outro comportamento também fosse afetado.

Mais tarde, foi concluído que esta dificuldade estava relacionada com o tempo de vida dos planos em relação às rodadas do jogo. Ocorre que quando uma rodada é iniciada, é esperada uma reposta relativamente rápida que indique qual a jogada seguinte do agente. Para chegar nesta resposta, segue-se uma série de passos, definidos por objetivos parciais, que terminam por entregar a resposta ao servidor, que pode ser, por exemplo, a ação de ir até uma loja. No entanto, para fazer um planejamento mais elaborado, é preciso definir várias etapas, como ir à loja, comprar um produto e levar a um depósito. Mas o problema é: como representar este planejamento de longo prazo, se os planos que transmitem as jogadas precisam ser curtos? Os eventos que iniciam a rodada são do tipo "+step(X)", como fazer para a partir deste evento inical continuar um plano do meio, que foi interrompido à espera de um evento externo?

A solução adotada originalmente no time "dummy" era a de usar variáveis que indicassem a intenção atual do agente e, a cada rodada, avaliar o estado do ambiente e decidir a próxima ação.
