# ⚔️ Batalha de Ideias (Flutter + Cloud Firestore)

## Configurar o Firebase (uma vez)
1. Crie um projeto em https://console.firebase.google.com
2. No projeto: **Build > Firestore Database > Criar banco de dados** (modo teste).
3. Na raiz deste projeto:
   ```
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   (isso sobrescreve `lib/firebase_options.dart` com as chaves do seu projeto)
4. Regras do Firestore (aba **Regras**) para a atividade:
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /ideias/{id} {
         allow read, write: if true;
       }
     }
   }
   ```
5. Rodar:
   ```
   flutter pub get
   flutter run -d chrome
   ```

## Teste obrigatório
Abra o app em duas abas/navegadores (`flutter run -d chrome` e abra a URL
em outra aba, ou use `-d web-server`). Cadastre uma ideia na primeira, veja
aparecer na segunda, vote na segunda e veja os votos mudarem na primeira.

## Como funciona
- Coleção `ideias`; campos `titulo`, `descricao`, `autor`, `votos`.
- Lista em tempo real com `snapshots()` (StreamBuilder), ordenada por votos.
- Voto com `FieldValue.increment(1)` (atômico, sem conflito entre usuários).
- Exclusão remove o documento do Firestore para todos.
- Ranking: a primeira da lista ordenada por votos (🏆 IDEIA MAIS VOTADA).

## Estrutura do código
```
lib/
├── main.dart                     # inicializa o Firebase e define o MaterialApp
├── firebase_options.dart         # gerado pelo flutterfire configure
├── models/ideia.dart             # modelo Ideia
├── services/ideia_service.dart   # acesso ao Firestore (cadastrar/votar/excluir/stream)
├── screens/
│   ├── tela_principal.dart       # lista + ranking + botão nova ideia
│   └── tela_erro.dart            # aviso se o Firebase não estiver configurado
└── widgets/
    ├── ideia_card.dart
    ├── ranking_card.dart
    └── form_ideia_dialog.dart
```
