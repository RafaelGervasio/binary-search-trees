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

        if value> node.value
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
                parent_node = find_parent(node.value)
                parent_node.left_pt == node ? parent_node.left_pt = nil : parent_node.right_pt = nil
            end
        end
    end

    def find_parent(value, current = @root)
        return nil if @root.value == value

        unless current.left_pt.nil?
            return current if current.left_pt.value == value
        end
        unless current.right_pt.nil?
            return current if current.right_pt.value == value
        end

        current.value > value ? find_parent(value, current.left_pt) : find_parent(value, current.right_pt)
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

t.insert(10)
t.insert(0)
t.insert(8)

t.pretty_print

t.delete(8)
t.delete(10)
t.delete(0)

t.pretty_print

p t.root


#SOLUTION 1
# - Create a all_nodes IV in Nodes
# - Iterate over it until you find the node who's left and/or right pointer points to the Node I want to delete 
# - Cut it

# - If you're doing that, you lose the efficeincy benefit of deleting on the tree


#SOLUTION 2
# - 