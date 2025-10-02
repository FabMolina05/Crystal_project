# TODO: Write documentation for `ApiCrystal`
require "http/client"
require "json"
require "./paises"


module ApiCrystal
  VERSION = "0.1.0"

  begin
    
    nombre = nil

    until nombre && !nombre.empty?
      puts "Escribe tu nombre: "
      nombre = gets
    end
    
    httpRequest("https://api.nationalize.io/?name=#{nombre}",Paises::PAISES)

  rescue exception
    puts "Hubo un fallo: #{exception.message}"
  end
    
end

def httpRequest(url : String, paises : Hash)
  
  inicio = Time.local
  respuesta = HTTP::Client.get(url)
  
  if !respuesta.success?
    puts respuesta.status_message
  else 
    datos = JSON.parse(respuesta.body)
    paisesProbables = datos["country"]

    puts "\n Los paises a los que puedes pertener son : \n"

    paisesProbables.as_a.each do |pais|
      codigo = pais["country_id"].as_s
      if nombre_pais = paises[codigo]?
        puts "#{nombre_pais} => Probabilidad: #{pais["probability"]}"
      end
    end

    final= Time.local

    puts "----- Tiempo de respuesta : #{(final - inicio).total_seconds} ms -----"
  end
end
