# Autogenerated from a Treetop grammar. Edits may be lost.


module Mapping
  include Treetop::Runtime

  def root
    @root ||= :mapping
  end

  module Mapping0
    def map
      elements[0]
    end

    def space
      elements[1]
    end

  end

  def _nt_mapping
    start_index = index
    if node_cache[:mapping].has_key?(index)
      cached = node_cache[:mapping][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r2 = _nt_map
      s1 << r2
      if r2
        r3 = _nt_space
        s1 << r3
        if r3
          s4, i4 = [], index
          loop do
            if has_terminal?("\n", false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("\n")
              r5 = nil
            end
            if r5
              s4 << r5
            else
              break
            end
          end
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          s1 << r4
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Mapping0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:mapping][start_index] = r0

    r0
  end

  module Map0
    def space1
      elements[1]
    end

    def class
      elements[2]
    end

    def space2
      elements[3]
    end

    def space3
      elements[5]
    end

    def space4
      elements[7]
    end

    def conzept
      elements[8]
    end

    def space5
      elements[9]
    end

  end

  def _nt_map
    start_index = index
    if node_cache[:map].has_key?(index)
      cached = node_cache[:map][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('(', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_class
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if has_terminal?(',', false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(',')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_space
              s0 << r6
              if r6
                if has_terminal?("Class", false, index)
                  r7 = instantiate_node(SyntaxNode,input, index...(index + 5))
                  @index += 5
                else
                  terminal_parse_failure("Class")
                  r7 = nil
                end
                s0 << r7
                if r7
                  r8 = _nt_space
                  s0 << r8
                  if r8
                    r9 = _nt_conzept
                    s0 << r9
                    if r9
                      r10 = _nt_space
                      s0 << r10
                      if r10
                        if has_terminal?(')', false, index)
                          r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
                          @index += 1
                        else
                          terminal_parse_failure(')')
                          r11 = nil
                        end
                        s0 << r11
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Map0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:map][start_index] = r0

    r0
  end

  def _nt_conzept
    start_index = index
    if node_cache[:conzept].has_key?(index)
      cached = node_cache[:conzept][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_atomic
    if r1
      r0 = r1
    else
      r2 = _nt_not
      if r2
        r0 = r2
      else
        r3 = _nt_or
        if r3
          r0 = r3
        else
          r4 = _nt_and
          if r4
            r0 = r4
          else
            r5 = _nt_exists
            if r5
              r0 = r5
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:conzept][start_index] = r0

    r0
  end

  module Not0
    def space
      elements[1]
    end

    def conzept
      elements[2]
    end
  end

  def _nt_not
    start_index = index
    if node_cache[:not].has_key?(index)
      cached = node_cache[:not][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("not ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("not ")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_conzept
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Not0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:not][start_index] = r0

    r0
  end

  module Or0
    def space
      elements[0]
    end

    def conzept
      elements[1]
    end
  end

  module Or1
  end

  def _nt_or
    start_index = index
    if node_cache[:or].has_key?(index)
      cached = node_cache[:or][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("or ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure("or ")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt_space
        s3 << r4
        if r4
          r5 = _nt_conzept
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Or0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Or1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:or][start_index] = r0

    r0
  end

  module And0
    def space
      elements[0]
    end

    def conzept
      elements[1]
    end
  end

  module And1
  end

  def _nt_and
    start_index = index
    if node_cache[:and].has_key?(index)
      cached = node_cache[:and][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("and ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("and ")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt_space
        s3 << r4
        if r4
          r5 = _nt_conzept
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(And0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(And1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:and][start_index] = r0

    r0
  end

  module Exists0
    def space1
      elements[1]
    end

    def role
      elements[2]
    end

    def space2
      elements[3]
    end

    def space3
      elements[5]
    end

    def conzept
      elements[6]
    end
  end

  def _nt_exists
    start_index = index
    if node_cache[:exists].has_key?(index)
      cached = node_cache[:exists][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("exists ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure("exists ")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_role
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if has_terminal?(" . ", false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 3))
              @index += 3
            else
              terminal_parse_failure(" . ")
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_space
              s0 << r6
              if r6
                r7 = _nt_conzept
                s0 << r7
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Exists0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:exists][start_index] = r0

    r0
  end

  def _nt_role
    start_index = index
    if node_cache[:role].has_key?(index)
      cached = node_cache[:role][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[a-zA-Z_]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:role][start_index] = r0

    r0
  end

  def _nt_atomic
    start_index = index
    if node_cache[:atomic].has_key?(index)
      cached = node_cache[:atomic][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[a-zA-Z_]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:atomic][start_index] = r0

    r0
  end

  module Class0
  end

  def _nt_class
    start_index = index
    if node_cache[:class].has_key?(index)
      cached = node_cache[:class][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?("Class ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 6))
      @index += 6
    else
      terminal_parse_failure("Class ")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[a-zA-Z_]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Class0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:class][start_index] = r0

    r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(" ", false, index)
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(" ")
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:space][start_index] = r0

    r0
  end

end

class MappingParser < Treetop::Runtime::CompiledParser
  include Mapping
end
