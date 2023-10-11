class Tree
    
    def initialize (root=nil)
        # @array = array
        @root = nil
    end

    def root
        @root
    end

    def build_tree (array)
        until array.length == 0
            array = array.sort.uniq
            p array
            
            start = 0
            ending = array.length - 1
            mid = start + ending / 2

            # p mid

            
            #if there's a top root, pass current root as pointet to top root
            if @root.nil?
                @root = Node.new(array[mid])
            elsif
                node = Node.new(array[mid])
                if @root.value > node.value
                    # nx = @root
                    # until nx.left_pt.nil?
                    #     nx = nx.left_pt
                    # end
                    # nx.left_pt = node
                    @root.left_pt = node
                else
                    @root.right_pt = node
                end
            end
            left_array = array[0...mid]
            right_array = array[mid+1..ending]

            # p left_array
            # p right_array

            build_tree(left_array)
            build_tree(right_array)
            return
        end
    end

end

class Node
    attr_accessor :value, :left_pt, :right_pt

    def initialize(value=nil, left_pt=nil, right_pt=nil)
        @value = value
        @left_pt = left_pt
        @right_pt = right_pt
    end

    def value
        return @value
    end

    def right_pt
        @right_pt
    end

    def left_pt
        @left_pt
    end
end


t = Tree.new()
t.build_tree([3, 2, 1])

p t.root