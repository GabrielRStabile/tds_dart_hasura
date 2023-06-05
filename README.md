# CRUD de Lista de Tarefas

Este é um aplicativo de servidor construído usando [Shelf](https://pub.dev/packages/shelf), podendo ser executado com [Docker](https://www.docker.com/).

# Executando o exemplo

## Executando com o Dart SDK

Você pode executar o servidor com o [Dart SDK](https://dart.dev/get-dart) da seguinte maneira:

```
$ dart run bin/server.dart
Server listening on port 5400
```


# Rotas

## GET `/todo?userId={userId}`

Retorna todas as tarefas do usuário.

Exemplo de resposta:
```json
[
	{
		"id": 2,
		"createdAt": 1685971264372, //Tempo POSIX (epoch)
		"todo": "comprar remédio",
		"isDone": false,
		"priority": 1
	},
	{
		"id": 4,
		"createdAt": 1685971264372,
		"todo": "comprar remédio",
		"isDone": false,
		"priority": 1
	},
	{
		"id": 1,
		"createdAt": 1685971264372,
		"todo": "comprar remédio amanhã",
		"isDone": false,
		"priority": 1
	}
  ...
]
```

## POST `/todo`

Cria uma nova tarefa na lista.

Corpo da solicitação:
```json
{
    "userId": "439f3b94-a26a-4570-9569-2dad58dcf297",
	"todo": "Fazer prova",
	"isDone": false,
	"priority": 2,
}
```

Exemplo de resposta:
```json
{
	"id": 10,
	"createdAt": 1685971264372,
	"todo": "comprar remédio amanhã",
	"isDone": false,
	"priority": 1
}
```

## DELETE `/todo/{id}`

Exclui uma tarefa da lista pelo seu ID.

Exemplo de resposta:
```
Ok
```

## PUT `/todo`

Atualiza uma tarefa existente na lista pelo seu ID.

Corpo da solicitação:
```json
{
    "id": 5,
    "userId": "439f3b94-a26a-4570-9569-2dad58dcf297",
	"isDone": true
}
```

Exemplo de resposta:
```json
{
	"id": 5,
	"createdAt": 1685971264372,
	"todo": "comprar remédio amanhã",
	"isDone": true,
	"priority": 1
}
```
