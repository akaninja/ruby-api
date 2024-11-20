require 'json'

class RequestParser
  def initialize(request_string)
    @request_string = request_string
    @method, @full_path, @version = request_string.lines[0].split
  end

  def parse
    headers = {}
    @request_string.lines.each_with_index do |line, i|
      next if i == 0
      break if line.strip.empty?
      header, value = line.split
      headers[normalize(header)] = value
    end

    path, params = parse_path(@full_path)

    {
      method: @method,
      path: path,
      version: @version,
      headers: headers,
      params: params
    }
  end

  def parse_path(full_path)
    full_path = full_path.split("/")
    full_path.shift
    if full_path[0] == "parkings" && @method == 'POST' && full_path.size == 1
      return "/parkings", get_normalized_params(@request_string)
    elsif full_path[0] == "parkings" && @method == 'PUT' && full_path.size == 2
      return "/parkings", { plate: full_path[1] }
    elsif full_path.empty?
      return "/"
    else
      raise StandardError.new("Endereço não encontrado")
    end
  end

  def normalize(header)
    header.gsub(':', '').downcase.to_sym
  end

  def get_normalized_params(request_string)
    request_string.scan(/(?<=\{)(.*?)(?=\})/)
      .map { |e| e[0].delete("\" ").split(":") }.to_h.transform_keys(&:to_sym)
  end
end
