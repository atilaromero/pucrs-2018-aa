# Execução

Ao invés de rodar o contest usando JUnit, como era feito na versão original, foi criada uma classe Main em src/java. Para iniciar o servidor através do eclipse, uma opção é clicar com o botão direito sobre o arquivo src/java/Main.java e escolher a opção "Run As" -> "Java Application".

Isso irá iniciar o servidor e paralelamente rodar os agentes. 

## Um jogador/dois jogadores

Para escolher quantos times irão competir simultaneamente, alterar a variável "teamsPerMatch" do arquivo conf/server/server.json.

# Descrição do desenvolvimento dos agentes

## Etapas iniciais

O código-fonte original dos agentes foi criado pelo colega Tabajara e disponibilizado pelo professor Bordini. Assim que foi executado com sucesso, o próximo passo foi entender o código do time "dummy" e usá-lo como ponto de partida para criação de um novo time.

O código fonte do time "dummy" foi copiado para o outro time, "connectionA" e separado em arquivos menores por funcionalidade, para facilitar o entendimento, usando instruções do tipo:
```
{include("plans/charge.asl")}

```

Em seguida, foram feitas tentativas de melhorar o comportamento dos agentes. Os dois principais problemas do time "dummy" eram
 - Todos os agentes 
