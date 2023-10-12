class Tree
    
    def initialize (array)
        array = array.sort.uniq
        @root = build_tree_recursive(array)
    end

    def root
        @root
    end

    def build_tree_recursive (array)
        if array.empty?
            return nil
        end
        last = array.length - 1
        mid = (last / 2).to_i

        root_node = array[mid]

        left_node = build_tree_recursive(array[0...mid])
        right_node = build_tree_recursive(array[mid+1..-1])


        node = Node.new(root_node, left_node, right_node)
        return node
    end
      

      def pretty_print(node = @root, prefix = '', is_left = true)
        return if node.nil?
      
        pretty_print(node.right_pt, "#{prefix}#{is_left ? '│   ' : '    '}", false)
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left_pt, "#{prefix}#{is_left ? '    ' : '│   '}", true)
      end

      def insert (value, node = @root)
        # node = @root
        # inserted = false

        # until inserted
        #     if value > node.value && node.right_pt.nil? == false
        #         node = node.right_pt
        #     elsif value < node.value && node.left_pt.nil? == false
        #         node = node.left_pt
        #     else
        #         if value > node.value
        #             #insert to the right
        #             n = Node.new(value)
        #             node.right_pt = n
        #             inserted = true
        #         else
        #             #insert to the left
        #             n = Node.new(value)
        #             node.left_pt = n
        #             inserted = true
        #         end
        #     end
        # end

        #base case

        if value > node.value
            node.right_pt.nil? ? node.right_pt = Node.new(value) : insert(value, node.right_pt)
        elsif value < node.value
            node.left_pt.nil? ? node.left_pt = Node.new(value) : node = insert(value, node.left_pt)
        end


      end

      def delete (value, node = @root)
        if value > node.value
            node.right_pt.nil? ? "Value doesn't exist in tree" : delete(value, node.right_pt)
        elsif value < node.value
            node.left_pt.nil? ? "Value doesn't exist in tree" : delete(value, node.left_pt)
        else
            if node.left_pt.nil? && node.right_pt.nil?
                node.remove_instance_variable(:@value)
            end
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


t = Tree.new([7, 6, 5, 4, 3, 2, 1])
t.pretty_print

t.insert(10)
t.insert(0)
t.insert(8)
t.delete(8)

t.pretty_print


p t.root
