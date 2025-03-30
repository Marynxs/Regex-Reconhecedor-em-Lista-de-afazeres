# Regex Parser para Lista de Afazeres

Este projeto é um script Ruby projetado para identificar e extrair elementos específicos de uma lista de afazeres ou anotações, utilizando expressões regulares. Ele facilita a organização automática de tarefas, compromissos e contatos.

## 📌 Funcionalidades

O script reconhece e extrai as seguintes informações:

- **Horários**: diversos formatos (ex: `10:30`, `10 horas`, `às 10`)
- **Datas**: datas completas e abreviadas, além de palavras-chave como `hoje`, `amanhã` ou `depois de amanhã`
- **Hashtags (#)**: identificação de tags para categorização
- **URLs**: identificação e extração completa de links
- **Emails**: validação e extração correta de endereços de email
- **Ações**: verbos específicos relacionados a tarefas (`agendar`, `marcar`, `ligar`, `estudar`, `sair`)
- **Nomes de pessoas**: extração do nome após palavras-chave (ex: `com Maria`, `com João Pedro`)

## 📚 Dependências

O projeto utiliza apenas bibliotecas padrão do Ruby:

- `date` para manipular e formatar datas

## ⚙️ Exemplo de uso

```ruby
mensagem = "Agendar reunião com João amanhã às 14:00 #trabalho"
resultado = reconhecerLista(mensagem)

puts resultado
```
### Saida:
```ruby
{
  horarios: ["às 14:00"],
  dias_datas: ["30/03/2025"], # exemplo se hoje for 29/03/2025
  hashtags: ["#trabalho"],
  urls: [],
  emails: [],
  acoes: ["Agendar"],
  pessoas: ["João"]
}
```
