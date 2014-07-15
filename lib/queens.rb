class Queens
  MAX = 4
  MAX_INDEX = 3

  def initialize
    @arr_i = []
    @arr_j = []

    i = 0
    while i < MAX
      @arr_i << 1
      i += 1
    end

    i = 0
    while i < MAX
      @arr_j << 1
      i += 1
    end

    @points_arr = build_diagonals
    @stack = []
    @tree = {}
    go!
  end

  def build_diagonals
    points = []
    k = 0
    d = []
    while k < MAX
      d << [k,k]
      k += 1
    end
    points << d

    k = 1
    while (k < MAX)
      j = k
      i = 0
      d1 = []
      d2 = []
      while (j < MAX)
        d1 << [i,j]
        d2 << [j,i]
        i += 1
        j += 1
      end
      points << d1
      points << d2
      k += 1
    end

    k = 0
    d = []
    while k < MAX
      j = MAX_INDEX - k
      d << [k,j]
      k += 1
    end

    k = MAX_INDEX
    while (k > 1)
      i = 0
      j = k
      d1 = []
      d2 = []
      while (i < k)
        d1 << [i, j]
        d2 << [MAX_INDEX-j, MAX_INDEX-i]
        i += 1
        j -= 1
      end
      points << d1
      points << d2
      k -= 1
    end

    puts "build_diagonals: {"
    puts "points: #{points.inspect}"
    puts "}"
    return points
  end

  def backtrack!
    val = @stack.pop!
    @arr_i[val[0]] = 1
    @arr_j[val[1]] = 1
    puts "backtrack {"
    puts "stack: #{@stack.inspect}"
    puts "@arr_i: #{@arr_i.inspect}"
    puts "@arr_j: #{@arr_j.inspect}"
    puts "}"
    go!
  end

  def go!
    while (@points_arr.length > 0)
      val = take(@points_arr)
      @arr_i[val[0]] = 0
      @arr_j[val[1]] = 0
      @stack << val
      puts "go!\n\twhile(@point_arr.length > 0) {"
      puts "\tval: #{val}\n"
      puts "\t@arr_i: #{@arr_i.inspect}"
      puts "\t@arr_j: #{@arr_j.inspect}"
      puts "\t@stack: #{@stack.inspect}"
      puts "}"
    end

    lock = 0
    i = 0
    while (i < 4)
      lock += (@arr_i[i] + @arr_j[j])
      return backtrack! if (lock > 0)
      i += 1
    end
    return @stack
  end

  def take(arr = [])
    index = rand * arr.length
    index = index.to_i
    puts "take {"
    puts "\tindex: #{index.inspect}"
    puts "\tarr[index]: #{arr[index]}"
    puts "}"
    arr[index]
  end

  def options
    @options = []
    @options = @points_arr.uniq!
    puts "options { "
    puts "\toptions: #{@options.inspect}"
    puts "}"
    @options
  end

  def build_diagonal(diagonal = [])
    options_diagonal = []
    diagonal.each do |d|
      if (!!@arr_i[d[0]] && !!@arr_j[d[1]])
        options_diagonal << [d[0], d[1]]
      else
        return [] unless (!!@arr_i[d[0]] || !!@arr_j[d[1]])
      end
    end
    puts "build_diagonal {"
    puts "\toptions_diagonal: #{options_diagonal}"
    puts "}"
    return options_diagonal
  end
end