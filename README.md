# 🥗 PrepList — Planejador Semanal de Refeições & Compras

> Aplicativo mobile desenvolvido em **Flutter** para organizar o planejamento semanal de refeições (*Meal Prep*) e gerar automaticamente listas de compras inteligentes a partir do cardápio definido.

---

## 📱 Sobre o Projeto

Planejar o que comer durante a semana e lembrar de todos os ingredientes no supermercado costuma gerar desperdício de tempo e comida. O **PrepList** resolve esse problema conectando o cardápio semanal diretamente à lista de compras, permitindo visualizar as refeições de segunda a domingo e acompanhar o que já foi colocado no carrinho.

### ✨ Funcionalidades Principais

* **Cardápio Semanal:** Organização de refeições (café da manhã, almoço, jantar e lanches) por dia da semana.
* **Lista de Compras Automática:** Geração e agrupamento de ingredientes necessários com base nas receitas planejadas.
* **Checklist Interativo:** Marcação de itens já comprados e adição manual de produtos extras.
* **Funcionamento Offline:** Armazenamento local para acesso rápido mesmo sem conexão com a internet no mercado.

---

## 🛠️ Tecnologias Utilizadas

* **[Flutter](https://flutter.dev/)** & **[Dart](https://dart.dev/)** — Framework e linguagem principal do aplicativo.
* **Arquitetura MVVM** — Separação clara entre interface (Views), lógica de apresentação (ViewModels) e dados (Models).
* **Persistência Local** — *(Ex: SQLite / SharedPreferences / Hive — ajuste conforme o que você usou)*

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
* [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado.
* Emulador Android/iOS ou dispositivo físico com depuração USB ativada.

### Passo a passo

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/seu-usuario/meal_prep_app.git](https://github.com/kamillyvm/meal_prep_app.git)
