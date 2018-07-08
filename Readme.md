# Relatório

  Trabalho final

  Aluno: Atila Leites Romero


# Execução

Para iniciar o servidor através do eclipse, clicar com o botão direito sobre o arquivo src/java/Main.java e escolher a opção "Run As" -> "Java Application".

Isso irá iniciar o servidor e paralelamente rodar os agentes.

# Ciclo baseado em steps

Para poder participar do jogo, o agente precisa:
 - Esperar por um evento +step(X)
 - Responder qual ação pretende executar. Exemplo: goto(shop4)

Esta necessidade leva a um estilo de programação em que é necessário que cada intenção termine em com o
envio de uma ação ao servidor do jogo.

O resultado é um ciclo composto das seguintes etapas:

  - Esperar o evento +step(X)
  - Determinar a intenção atual
  - Verificar alterações na base de crenças
  - Decidir o que fazer
  - Enviar uma ação ao servidor do jogo

Quando uma rodada é iniciada, é esperada uma reposta relativamente rápida que indique qual a jogada seguinte do agente. Para chegar nesta resposta, segue-se uma série de passos, definidos por objetivos parciais, que terminam por entregar a resposta ao servidor, que pode ser, por exemplo, a ação de ir até uma loja. No entanto, para fazer um planejamento mais elaborado, é preciso definir várias etapas, como ir à loja, comprar um produto e levar a um depósito. Mas o problema é: como representar este planejamento de longo prazo, se os planos que transmitem as jogadas precisam ser curtos? Os eventos que iniciam a rodada são do tipo "+step(X)", como fazer para a partir deste evento inical continuar um plano que foi interrompido à espera de um evento externo?

Uma solução que deixa a desejar é utilizar uma função central que decida o próximo passo.

Esta abordagem tem vários problemas:

  - Lógica de programação concentrada nas condições de tratamento dos eventos +step(X): só um tratamento pode ser escolhido
  - Condições exageradamente extensas
  - Falta de comprometimento com um plano: as decisões têm curto prazo
  - Alteração em um trecho de código pode afetar trechos não desejados
  - Dificuldade de alterar a estratégia: necessário revisar todo o código
  - Bugs são difíceis de corrigir


Conforme novos planos de longo prazo precisam ser acrescentados, a complexidade dessa função central aumenta, pois ela precisa considerar vários fatores para descobrir qual o plano de longo prazo estava em vigor. Realizar esta tarefa sem acrescentar novas variáveis requer ajustes precisos na função central, com alto risco de afetar comportamentos em outros tipos de planos. Por exemplo, há o risto de, ao ajustar a estratégia de recarga a estratégia de compra ser afetada. Acrescentar novas variáveis também não é uma solução ótima, pois torna o código confuso e aumenta a chance de haver combinações de estados de variáveis não tratados.

O que ocorre com esta "quebra" em rodadas é que o mecanismo de controle de planos não está efetivamente sendo usado para planos de longo prazo, ele está sendo emulado.

Para resolver isto, foi procurado algum tipo de solução que permitisse que um plano, ao precisar ser interrompido por emissão e espera de eventos externos, não deixasse de estar em vigor. Por exemplo, se o plano atual é ir até uma loja, é desejável que o envio do comando de ir até a loja não finalize o plano e durante o trajeto, se forem necessários vários reexecuções deste comando, que estes reenvios sejam feitos de alguma forma automatica e que o plano só seja finalizado quando o veículo chegar ao seu destino ou concluir que falhou.

# Solução proposta

A solução proposta consiste em utilizar um modelo de duas camadas:
  - *Plan layer*: definição da estratégia e da sequência de passos

  - *Step layer*: responder ao eventos +step(X)

A *plan layer* define as intenções atuais, sem ter a obrigação de terminar em uma rodada.

A *step layer* verifica qual a intenção vigente, envia o comando adequado ao servidor de jogo e informa à outra camada quando as intenções foram atingidas ou falharam. Ela não toma decisões estratégicas

Curiosamente, é possível dizer que este seria um modelo GSLA: Globalmente Síncrono Localmente Assíncrono, o que é o oposto do  que é comumente encontrado.

O código-fonte a seguir ilustra este modelo aplicado à intenção de ir a um lugar.

Na *plan layer*, a intenção !try(goto(Y)) é mantida ativa indefinidamente, até que a step layer marque seu fim:
```
+!try(goto(Y))
<-
	!step(X);
	.wait(false);
.
```

Na *step layer*, a cada rodada é verificado se o objetivo foi
atingido e se a bateria acabou. A ação _goto(Y)_ é repetida até que o agente chegue ao seu destino:
```
+!step(X)	// reached destination
	: .intend(try(goto(Y)))
	& facility(Y)
<-
	.succeed_goal(try(goto(Y)));
.
+!step(X)	// on route, but must recharge
	: .intend(try(goto(Y)))
	& batteryOut
<-
	recharge;
.
+!step(X)	// on route
	: .intend(try(goto(Y)))
<-
	goto(Y);
.
```


# Estratégia de teste

# Resultados


## Aprimoramento

Para tentar melhorar os agentes em algum destes aspectos, foram feitas várias modificações de maneira incremental. No entanto, este processo se mostrou extremamente difícil, porque era difícil evitar a propagação de efeitos colaterais. Ou seja, era comum que ao tentar corrigir determinado comportamento, outro comportamento também fosse afetado.

Mais tarde, foi concluído que esta dificuldade estava relacionada com o tempo de vida dos planos em relação às rodadas do jogo.
...

A solução adotada originalmente no time "dummy" era a de usar variáveis que indicassem a intenção atual do agente e, a cada rodada, avaliar o estado do ambiente e decidir a próxima ação.
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
 - A terceira instrução, ".wait({-try(goto(Y))});" aguarda que a variável "try" não esteja mais na base de conhecimento. Quando isto ocorrer o plano será concluído e, se fizer parte de um plano maior, o próximo passo será executado.

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

  A estratégia atual é baseada em cada veículo pegar um trabalho diferente. Ao se responsabilizar por um trabalho, o agente avisa os outros e aguarda resposta positiva. Se algum agente também tiver escolhido aquele trabalho, avisa. Se houver disputa, a seleção de qual agente ficará com o trabalho é feita por ordem alfabética/numérica: o menor ganha.

  Atualmente o time "connectionA" ganha do time "dummy" e termina a partida com mais dinheiro do que começou, o que é um grande progresso, pois antes da nova abordagem o time "connectionA" além de perder do "dummy", terminava a partida com menos dinheiro do que tinha começado. Mas ainda existem muitas possíveis melhorias:

  - Considerar a carga do veículo. Os 2 drones param de trabalhar logo no início, pois tentam pegar todos os itens de um trabalho e excedem sua carga total. Talvez seja necessário um plano separado para eles. Com certeza é preciso verificar o peso dos itens.
  - Alguns veículos param de trabalhar quando estão fazendo um trabalho que por algum motivo não é mais válido, ou porque expirou, ou porque foi completado por outro time. Requer a criação de algum mecanismo para desistir do trabalho atual.
  - A escolha dos trabalhos não leva em consideração preço, itens ou data de expiração.
  - Os agentes não ajudam um ao outro. Esse item talvez não seja alterado, pois seria seguir uma estratégia diferente da atual.
  - Um agente não faz mais de um trabalho ao mesmo tempo.

# Github

O código-fonte do trabalho está disponível em:

https://github.com/atilaromero/pucrs-2018-aa

Para entrega do relatório, o arquivo Readme.md do projeto (este documento), foi convertido em pdf com o comando
```
pandoc Readme.md -s -o relatorio.pdf
```
