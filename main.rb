require 'date'

def reconhecerLista(mensagem)
    horarios = mensagem.scan(/((?!\d{4})\b\d{1,2}[: ]\d{2}\b)|(\b\d{1,2} ?horas?\b)|(\b(à|a)s ?\d{1,2}:?\d{2}?\b)/)
                       .map { |match| match.compact.first } 
    
    dias_datas = mensagem.scan(/((\d\d (de)? ?((J|j)aneiro|(F|f)evereiro|(M|m)arço|(A|a)bril|(M|m)aio|(J|j)unho|(J|j)ulho|(A|a)gosto|(S|s)etembro|(O|o)utubro|(N|n)ovembro|(D|d)ezembro)) ?(de)? ?(\d\d\d\d)?)|((\d\d)\/(\d\d)\/?(\d\d\d\d)?)|((hoje)|((depois de )?amanh(a|ã)))/)
                       .map { |match| match.compact.first }

    hashtags = mensagem.scan(/#[a-zA-Z0-9_-]+/)

    urls = mensagem.scan(/\bhttps?:\/\/[a-zA-Z0-9.-]+(?:\:\d+)?(?:\/[^\s,]*)?/)            

    emails = mensagem.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/)

    acoes = mensagem.scan(/\b(agendar|marcar|ligar|estudar|sair)\b/i)
                    .map { |match| match.compact.first }

   pessoas = mensagem.scan(/\bcom\s+([A-Za-zÁÉÍÓÚÂÊÔÃÕÄËÏÖÜáéíóúâêôãõäëïöü]+(?:\s+(?:da|de|do|dos|das)?\s?[A-Za-zÁÉÍÓÚÂÊÔÃÕÄËÏÖÜáéíóúâêôãõäëïöü]+)*)/)
                  .map { |match| match.compact.first }

    dias_datas.map! do |dia|
        case dia.downcase
        when "hoje"
            Date.today.strftime("%d/%m/%Y")
        when /^amanh[aã]$/
            (Date.today + 1).strftime("%d/%m/%Y")
        when /^depois de amanh[aã]$/
            (Date.today + 2).strftime("%d/%m/%Y")
        else
            dia
        end
    end


    return { 
        horarios: horarios.map(&:strip),
        dias_datas: dias_datas.map(&:strip),
        hashtags: hashtags.map(&:strip),
        urls: urls.map(&:strip), 
        emails: emails.map(&:strip),
        acoes: acoes.map(&:strip),
        pessoas: pessoas.map(&:strip)
    } 
end

mensagem = "10:30, 10 30, 10 horas, 1 hora, às 10
28 de Fevereiro, 13 de agosto de 2021, 30/01, 20/04/2022, hoje, amanhã, depois de amanhã, 18 agosto, 18 de agosto 2023
#casa, #trabalho
https://sp.senac.br/pag1#teste?aula=1&teste=4
jose.da-silva@sp.senac.br
https://sig.fhits.com.br/campanha/MzNsPieQBgwGPibadgIhutPI6anezU5pnaoWqGyx9lRhkgNjFqPf4nMovMRQa6my49PyXmeH7fmggIO9YDoaU81SmsJxTdfJWYRo1742308533
agendar|marcar|ligar|estudar|sair
https://sp.senac.br/pag1#teste?aula=1&teste=4
https://senacsp.blackboard.com/ultra/courses/_263747_1/cl/outline
Agendar com maria, reunião com João Pedro, falar com José da Silva
"
mensagem2 = "Agendar com José reunião às 10:00 amanha #trabalho e dia 24 de abril de 2025 marcar consulta"
mensagem3 = "28 de Fevereiro, 13 de agosto de 2021, 30/01, 20/04/2022, hoje, amanhã, depois de amanhã, 18 agosto, 18 de agosto 2023"
mensagem4= "http://sp.senac.br/pag1#teste?aula=1&teste=4?a=1&b=2"

resultado = reconhecerLista(mensagem)

puts "Horários encontrados: #{resultado[:horarios].join(', ')}"
puts "Dias e Datas encontrados: #{resultado[:dias_datas].join(', ')}"
puts "Hashtags encontradas: #{resultado[:hashtags].join(', ')}"
puts "URLs encontradas: #{resultado[:urls].join(', ')}"
puts "Emails encontrados: #{resultado[:emails].join(', ')}"
puts "Ações encontradas: #{resultado[:acoes].join(', ')}"
puts "Pessoas: #{resultado[:pessoas].join(', ')}"
