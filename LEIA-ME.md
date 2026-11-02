# Mundo Avesso — app Android (Etapa 2: MVP mobile)

Projeto Android Studio que empacota o jogo (`app/src/main/assets/index.html`) num app nativo em tela cheia,
100% offline, sem anúncios, sem login e sem coleta de dados.

- Pacote: `com.empreenderthz.mundoavesso`
- Versão: 0.2.0 (versionCode 2)
- Android mínimo: 7.0 (API 24) · alvo: Android 16 (API 36, exigido pela Google Play desde 31/08/2026)
- Orientação: livre (retrato é o modo principal; também funciona deitado)
- Única permissão: `VIBRATE` (vibração leve; pode ser desligada em Ajustes no jogo)
- Dependência única: `androidx.webkit` (serve o jogo por uma origem https local segura)

## O que tem nesta versão
- **3 universos e 40 fases**:
  - **Jardim Invertido** (10 fases);
  - **Cidade de Borracha** (15 fases): borracha que quica, botões e portões, bondinhos, elevadores e botões pesados;
  - **Oceano Suspenso** (15 fases): água em que Pipo nada e as caixas boiam, rios voadores e correntes de vento.
- Cada universo tem:
  - visual e trilha musical próprios;
  - um coletável próprio (brotos, estrelas ou pérolas);
  - um personagem secundário: Dona Pétala, Seu Quicão ou Vovó Medusa;
  - uma fase final especial.
- **Poderes do Núcleo Avesso**: gravidade, escala e elasticidade, apresentados aos poucos. Muitas fases têm mais de uma solução, e o jogo conta as soluções diferentes que você descobre.
- **Progresso**: três medalhas por fase (concluída, todos os coletáveis e desafio opcional ★). Os universos se desbloqueiam em sequência.
- **Personalização**: 6 cores e 8 acessórios, sendo 4 liberados por conquistas.
- **Desafios compartilháveis**:
  - quem termina uma fase gera um código, por exemplo `AV-222K4ME`, que desafia outra pessoa a resolver do mesmo jeito em menos tempo;
  - o Desafio do Dia é igual para todo mundo.
  Tudo funciona offline: o código guarda só a fase, o jeito de resolver e o tempo.
- **Salvamento**: fica no aparelho. Para trocar de celular, existe um código de cópia do progresso (Ajustes › Cópia do progresso).
- **Modo Descoberta** (cargas infinitas) e acessibilidade:
  - botões maiores e modo canhoto;
  - alto contraste;
  - reduzir movimento;
  - jogar sem som;
  - vibração opcional.

## Garantia de qualidade das fases
Na pasta do jogo (fonte web), `tests/levels.test.js` joga automaticamente as soluções de referência das 40 fases.
Ele também confere as regras dos poderes, dos botões, dos portões, dos bondinhos e da água (209 verificações).
`tools/challenges.py` confirma que cada desafio opcional é possível.
`tools/solver.js` é um validador por busca. Ele confirma que cada fase tem solução e que as fases que ensinam um poder **não** podem ser vencidas sem ele.

## 1. Abrir e testar no celular
1. Instale o **Android Studio** e abra esta pasta (`File › Open`).
2. Aguarde o Gradle sincronizar. Ele baixa o Android Gradle Plugin 8.11.1 e o Gradle 8.14.3.
3. No celular, ative **Opções do desenvolvedor › Depuração USB** e conecte o cabo.
4. Clique em **Run ▶**.

## 2. Chave de assinatura (uma vez só, guarde com cuidado)
Use **Build › Generate Signed App Bundle or APK › Android App Bundle › Create new…**
- Salve como `mundoavesso-upload.jks` na raiz do projeto, com alias `mundoavesso`.
- Copie `keystore.properties.exemplo` para `keystore.properties` e preencha as senhas.

## 3. Gerar o pacote para a loja
```
./gradlew bundleRelease
```
O arquivo sai em `app/build/outputs/bundle/release/app-release.aab`.

## 4. Publicar na Google Play
1. Na **Play Console**, use **Criar app**: nome "Mundo Avesso", Português (Brasil), **Jogo**, **Gratuito**.
2. Preencha a **Ficha da loja** com `ficha-da-loja.md`, o ícone 512×512, o recurso gráfico 1024×500 e as capturas da pasta da loja.
3. Publique `politica-de-privacidade.html` num endereço público e informe a URL.
4. Em **Conteúdo do app**:
   - Classificação indicativa: responda ao questionário IARC. Sem violência, a expectativa é **Livre**.
   - Público-alvo: se incluir **menores de 13 anos**, o app entra na **Política para Famílias** do Google Play. Ele já atende: sem anúncios, sem coleta de dados, sem links externos e sem compras.
   - Anúncios: **Não**.
   - Segurança dos dados: **não coleta nem compartilha dados**.
5. Envie o `.aab` para **Teste interno**. Contas pessoais novas precisam de **teste fechado com pelo menos 12 testadores por 14 dias** antes da produção.
6. Promova a versão para **Produção**.

## 5. Atualizar
1. Troque `app/src/main/assets/index.html` pela nova versão.
2. Aumente `versionCode` em `app/build.gradle.kts`.
3. Gere novamente o `.aab`.

## Comportamento no celular
- Botão **Voltar**: pausa a fase ou volta ao menu anterior. No menu principal, dois toques fecham o app.
- Ao sair do app, a fase é pausada e o som para.
- A tela fica ligada durante o jogo.
