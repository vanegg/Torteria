$tortas_name = ["pollo", "carne_res", "vegetariana"]
$lote = 5

class Torta

  def initialize(tipo = "pollo")
    #Existen tres tipo des tortas: pollo, carneRes, vegetariana
    @tipo = tipo
    recognize_type
  end

  def recognize_type
    @tortas_name
    accepted_type = false
    $tortas_name.each { |name| accepted_type = true if @tipo == name }
    raise TypeError, "No se reconoce el tipo de torta" unless accepted_type
  end

end

class Horno

  attr_reader :lote_tortas, :n_tortas, :min, :tortas_status

  def initialize
    @tortas_time = {pollo: 6, carne_res: 10, vegetariana: 4}
    @status = ["cruda(s)", "casi lista(s)", "lista(s)", "quemada(s)"]
    @tortas_status = Hash.new
    @n_tortas = 0
    @lote_tortas = Array.new(3){0}
    @min = 0
  end

  def new_torta(tipo = "pollo")
    @tipo = tipo
    cicle
  end

  def cicle
    Torta.new(@tipo)
    register_torta
    bake_tortas if lote_complete?
  end

  def register_torta
    @n_tortas += 1
    @lote_tortas[$tortas_name.index(@tipo)] += 1
  end

  def lote_complete?
    return @n_tortas == $lote ? true : false
  end

  def bake_tortas
    "Entro el lote al horno"
  end

  def min!
    @min += 1
  end

  def status
    @tortas_time.each do |k,v|
      if v < @min
        @tortas_status[k] = @status[3]
      elsif v == @min
        @tortas_status[k] = @status[2]
      elsif v/2 >= @min
        @tortas_status[k] = @status[0]
      else
        @tortas_status[k] = @status[1]
      end
    end
    @tortas_status
  end

  def report
    p "*****************************"
    p "TORTERIA.  Tortas horneadas: #{@n_tortas}"
    puts "El lote de #{$lote} tortas es:"
    puts "#{@lote_tortas[0]} de pollo"
    puts "#{@lote_tortas[1]} de carne de res"
    puts "#{@lote_tortas[2]} de vegetariana"
    puts "-----------------------------"

    3.times do |n|
    p "#{@lote_tortas[n-1]} Tortas #{@tortas_status[$tortas_name[n-1].to_sym]} de #{$tortas_name[n-1]}"
    end
    p "*****************************"
  end

end

orden = Horno.new
orden.new_torta("carne_res")
resp = false

#SIMULA UNA ORDEN DE TORTAS => Cocinero prepara un lote de tortas
until resp 
  resp = orden.new_torta($tortas_name.sample)
end

orden.bake_tortas
#Hornear por 5 minutos
NUM_MINUTOS = 5
until  orden.min > NUM_MINUTOS
 p "Minuto: #{orden.min} "
 p "Las tortas estan: "
 p orden.status
  orden.min!
  puts
end

orden.report