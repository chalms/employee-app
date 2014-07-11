class Queens
  def initialize
    @arr_i = [1,1,1,1,1,1,1,1]
    @arr_j = [1,1,1,1,1,1,1,1]
    @points_arr = build_diagonals
    @stack = []
    @tree = {}
    go!
  end

  def build_diagonals
    points = []
    i = 0
    j = 0
    while (i < 7)
      x = i
      y = j
      new_d = []
      while (x < 8 && y < 8)
        new_d << [x,y]
        x += 1
        y += 1
      end
      points << new_d
      x = i
      y = j
      unless x == 0
        new_d = []
        while (x <= 0 && y < 8)
          new_d << [x,y]
          x += -1
          y += 1
        end
        points << new_d
      end
      i += 1
    end
    return points
  end

  def backtrack!
    val = @stack.pop!
    @arr_i[val[0]] = 1
    @arr_j[val[1]] = 1
    go!
  end

  def go!
    while (options.length > 0)
      val = take(options)
      @arr_i[val[0]] = 0
      @arr_j[val[1]] = 0
      @stack << val
    end

    lock = 0
    i = 0
    while (i < 8)
      lock += (@arr_i[i] + @arr_j[j])
      return backtrack! if (lock > 0)
      i += 1
    end
    return @stack
  end

  def take(arr = [])
    index = rand * arr.length
    index = index.to_i
    arr[index]
  end

  def options
    @options = []
    @points_arr.each do |diagonal|
      @options += build_diagonal(diagonal)
      @options.uniq!
    end
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
    return options_diagonal
  end
end