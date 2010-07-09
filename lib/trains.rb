# A solution for a ThoughtWorks code review.
#
# Author:: Scott Robinson <scott@quadhome.com>

module Trains
  require 'set'

  # A struct for graph edges.
  Edge = Struct.new(:from, :to, :distance)

  class Graph
    SEARCH_DEPTH_LIMIT = 1000   # :nodoc:

    class EdgeArray < Array        # :nodoc:
      def distance
        return self.empty? ? nil : self.reduce(0) { |s, e| s += e.distance }
      end
    end

    attr_accessor :distances

    # Produce a graph from a graph definition.
    #
    # A valid definition is in the format of [A-Z][A-Z][0-9]+.
    # Punctuation is ignored.
    #
    # Examples:
    #
    #   AB5, BC4, CD8
    #   AD5 CE2 EB3
    def Graph.parse(definition)
      Graph.new(definition.split(/[^\w\d]+/).map do |edge_s|
        if edge_s =~ /([A-Z])([A-Z])(\d+)/
          Edge.new($1, $2, $3.to_i)
        else
          raise ArgumentError, "'#{edge_s}' not in [A-Z][A-Z][0-9] edge format" \
        end
      end)
    end

    # Initialize a graph from a set of edges.
    def initialize(edges)
      # Distances auto-populate temporarily, for ease.
      @distances = Hash.new { |h, k| h[k] = Hash.new }

      # A little sanity checking.
      for e in edges
        if @distances[e.from].key?(e.to)
          raise ArgumentError, "#{e.from}#{e.to} is routed multiple times"
        elsif e.from == e.to
          raise ArgumentError, "#{e.from}#{e.to} routes to itself"
        end

        @distances[e.from][e.to] = e.distance
      end

      # Turn off the auto-populate behavior.
      @distances.default = nil
    end

    # All edges from a vertex.
    def [](source_label)
      @distances[source_label] and @distances[source_label].map { |to_l, d| Edge.new(source_label, to_l, d) }
    end

    # The total distance of a route.
    #--
    # Walk the graph, keep count.
    def route_distance(route_string)
      sum = 0

      route_string.reduce do |src, dest|
        return nil unless @distances.fetch(src, {}).key?(dest)
        sum += @distances[src][dest]
        dest
      end

      return sum
    end

    # Find all routes between two vertices constrained by a condition.
    #--
    # A depth-first search without memory.
    def all_routes(source_label, destination_label, &condition)
      routes = EdgeArray.new
      stack = [self[source_label]].compact

      until stack.empty?
        raise NoMemoryError, "Too deep (limit of #{SEARCH_DEPTH_LIMIT})" unless stack.length < SEARCH_DEPTH_LIMIT

        path = EdgeArray.new(stack.map { |edges| edges.first })

        if condition.call(path)
          routes << path if path.last.to == destination_label
          if self[stack.last.first.to]
            stack << self[stack.last.first.to]
            next
          end
        end

        stack.last.shift
        while stack.last and stack.last.empty?
          stack.pop
          stack.last.shift unless stack.empty?
        end
      end

      return routes
    end
    
    # Find the shortest routes between two vertices.
    #--
    # Dijkstra's algorithm.
    def shortest_route(source_label, destination_label)
      vertices = @distances.map { |s, d| d.keys << s }.flatten.to_set

      prev = Hash[vertices.map { |l| [l, nil] }]
      cost = Hash[vertices.map { |l| [l, nil] }]

      # Frontload the costs from the source vertex.
      if self[source_label]
        for edge in self[source_label]
          cost[edge.to] = edge.distance
          prev[edge.to] = edge
        end
      end

      until vertices.empty?
        closest = vertices.map { |l| [cost[l], l] }.reject { |c, v| c.nil? }.min
        break if closest.nil?

        closest_cost, closest_label = closest
        break if closest_label == destination_label and prev[destination_label]

        vertices.delete(closest_label)

        if self[closest_label]
          for edge in self[closest_label].select { |e| vertices.include?(e.to) or cost[e.to].nil? }   # Yes, I just did that.
            maybe_new_cost = cost[closest_label] + edge.distance

            if cost[edge.to].nil? or maybe_new_cost < cost[edge.to]
              cost[edge.to] = maybe_new_cost
              prev[edge.to] = edge
            end
          end
        end
      end

      # Follow the breadcrumbs home.
      path = EdgeArray.new [prev[destination_label]].compact
      while path.first and path.first.from != source_label
        path.unshift(prev[path.first.from])
      end

      return path
    end

    # Number of vertices.
    def length
      @distances.reduce(0) { |sum, item| sum += item[1].length }
    end
  end

  class Main
    OUTPUTS = [
      Proc.new { |g| g.route_distance(%w[A B C]) },
      Proc.new { |g| g.route_distance(%w[A D]) },
      Proc.new { |g| g.route_distance(%w[A D C]) },
      Proc.new { |g| g.route_distance(%w[A E B C D]) },
      Proc.new { |g| g.route_distance(%w[A E D]) },
      Proc.new { |g| g.all_routes('C', 'C') { |p| p.length <= 3 }.length },
      Proc.new { |g| g.all_routes('A', 'C') { |p| p.length <= 4 }.reject { |p| p.length != 4 }.length },
      Proc.new { |g| g.shortest_route('A', 'C').distance },
      Proc.new { |g| g.shortest_route('B', 'B').distance },
      Proc.new { |g| g.all_routes('C', 'C') { |p| p.distance < 30 }.length }
    ]

    def Main.execute(args)
      return puts "Usage: #{$0} [filename ...]" if args.empty?

      for ln in $<
        if ln.strip =~ /Graph:(.*)/
          graph = Graph::parse($1.strip)

          OUTPUTS.each_index do |num|
            r = OUTPUTS[num].call(graph)
            puts "Output \##{num + 1}: " + (r.nil? ? "NO SUCH ROUTE" : r.to_s)
          end
        end
      end
    end
  end
end
