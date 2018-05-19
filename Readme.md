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

A solução adotada originalmente no time "dummy" era a de usar variáveis que indicassem a intenção atual do agente e, a cada rodada, avaliar o estado do ambiente e decidir a próxima ação. Para isso, é necessário definir uma função central que decida o próximo passo. O problema dessa abordagem é que, conforme novos planos de longo prazo precisam ser acrescentados, a complexidade dessa função central aumenta, pois ela precisa considerar vários fatores para descobrir qual o plano de longo prazo estava em vigor. Realizar esta tarefa sem acrescentar novas variáveis requer ajustes precisos na função central, com alto risco de afetar comportamentos em outros tipos de planos. Por exemplo, há o risto de, ao ajustar a estratégia de recarga a estratégia de compra ser afetada. Acrescentar novas variáveis também não é uma solução ótima, pois torna o código confuso e aumenta a chance de haver combinações de estados de variáveis não tratados.

O que ocorre com esta "quebra" em rodadas é que o mecanismo de controle de planos não está efetivamente sendo usado para planos de longo prazo, ele está sendo emulado. Para resolver isto, foi procurado algum tipo de solução que permitisse que um plano, ao precisar ser interrompido por emissão e espera de eventos externos, não deixasse de estar em vigor. Por exemplo, se o plano atual é ir até uma loja, é desejável que o envio do comando de ir até a loja não finalize o plano e durante o trajeto, se forem necessários vários reexecuções deste comando, que estes reenvios sejam feitos de alguma forma automatica e que o plano só seja finalizado quando o veículo chegar ao seu destino ou concluir que falhou.

A solução encontrada foi a criação de um tipo de plano, chamado de "!try", e de uma variável, também chamada de "try". Quando é executado um plano, por exemplo, "!try(goto(Y))", o seguinte código é executado:
```
+!try(goto(Y))
<-
	+try(goto(Y));
	!step(X);
	.wait({-try(goto(Y))});
.
```

 - A instrução "+try(goto(Y));" acrescenta a variável "try" a base de conhecimento. Essa variável indica que há um plano em execução.
 - A segunda instrução, "!step(X);", força a execução do plano de curto prazo, que também é iniciado quando há um evento do tipo "+step(X)". A resposta a este evento, informando ao servidor a jogada do agente, será tratada pelo trecho de código que tratar eventos do tipo "+!step(X): try(goto(Y)) <-". 
 - Na terceira instrução, ".wait({-try(goto(Y))});" aguarda que a variável "try" não esteja mais na base de conhecimento. Quando isto ocorrer o plano será concluído e, se fizer parte de um plano maior, o próximo passo será executado.

A variável "try" é retirada da base de conhecimento quando o agente chega ao seu destino:
```
+!step(X)
	: try(goto(Y))
	& facility(Y)
<-
	-try(goto(Y));
.
```

Se o agente está no meio do percurso e precisa responder qual sua jogada, ele informa que pretende continuar indo:
```
+!step(X)
	: try(goto(Y))
<-
	!perform_action(goto(Y));
.
```

Se acaba sua bateria, ele recarrega usando painel solar:
```
+!step(X)
	: try(goto(Y))
	& batteryOut
<-
	!perform_action(recharge);
.
```

Usando esta abordagem, passa a ser possível usar um plano do tipo:
```
+!solo
	: .my_name(Me)
	& not doing(_, Me)
<-
	!pick_job_solo;
	!check_job_solo;
	!solo;
.
+!solo
	: .my_name(Me)
	& doing(Job, Me)
<-
	!fetchItemsFor(Job);
	?job(Job, Storage, Reward, Start, End, Items)
	!maybe_charge;
	!try(goto(Storage));
	!try(deliver_job(Job));
	!job_done(Job);
	!leave_job(Job);
	!maybe_charge;
.
```
 - "!pick_job_solo;" e "!check_job_solo;" encontram um trabalho para o agente, que será o único do time a fazê-lo.
 - "!fetchItemsFor(Job);" internamente usa as instruções "!try(goto(Shop))" e "!try(buy(Item, Qtd))" para comprar items.
 - "!maybe_charge;" verifica se a bateria está baixa (valor arbitrário de <40%) e, se estiver, vai até uma chargingStation e recarrega.
 - "!try(goto(Storage));" e "!try(deliver_job(Job));" são as abstrações de alto nível criadas: os detalhes de envio das jogadas e leitura dos resultados são tratados mas não atrapalham a descrição do plano. "!try(deliver_job(Job));" usa um mecanismo similar ao mostrado para "+!try(goto(Y))", só que conta as tentativas e, se falhar 5 vezes, marca que o flano falhou usando ".fail".

## Situação atual do time
