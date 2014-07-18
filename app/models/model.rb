class Model
  def initialize(h = {}, url = nil)
    add_url_route(url) if url
    instance_variable_set("@sets", [])
    add_to_super("sets")
    add(h)
  end

  def add_url_route(url = nil)
    instance_variable_set("@url", [])
    add_to_super("url")
  end

  def to_haml_js
    @data = map
    render js: @url
  end

  def to_json
    map.to_json
  end

  def add(h = {})
    h.each do |k,v|
      add_method(k,v)
    end
  end

  def map
    map = {}.with_indifferent_access
    @sets.each { |k| map[k] = instance_variable_get("@#{k}") }
    return map
  end

  def add_to_super(k)
    eigenclass = class<<self; self; end
    eigenclass.class_eval do
      attr_accessor k
    end
  end

  def add_method(k, v)
    @sets << k
    instance_variable_set("@#{k}", v)
    add_to_super(k)
  end

  def method_missing(method, *args, &block)
    method = method.to_s if method.is_a? Symbol
    if method.include? '='
      args = args[0] if args.length == 1
      return add_method(method.split('=').first.gsub('/\s+/', ""), args)
    else
      return add_method(method, nil)
    end
  rescue Exceptions::StdError => e
    super(method, *args, &block)
  end
end