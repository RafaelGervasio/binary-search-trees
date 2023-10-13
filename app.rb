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
                return
            end

            #now we're dealing with nodes that have either one or two children
            unless node.left_pt.nil? == false && node.right_pt.nil? == false
                if node.left_pt.nil? 
                    temp = node.right_pt.value
                    node.value = temp
                    node.right_pt = nil
                else
                    temp = node.left_pt.value
                    node.value = temp
                    node.left_pt = nil
                end
            else
                #2 childs deletion
                #find replacer
                replacer = nil
                replacer = node.right_pt
                
                until replacer.left_pt == nil
                    replacer = replacer.left_pt
                end
                replacer_parent = find_parent(replacer.value)
                node.value = replacer.value

                replacer_parent.left_pt == replacer.value ? replacer_parent.left_pt = nil : replacer_parent.right_pt = nil
                
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
      
    def find (value, node = @root)
        if node.nil?
            return "Doesn't exist in the tree"
        elsif node.value == value
            return node
        else
            value > node.value ? find(value, node.right_pt) : find(value, node.left_pt)
        end
    end

    def level_order(&block)
        queue = []
        array = []
        queue.push (@root)
        until queue.length == 0
            if block_given?
                block.call(queue[0])
            else
                array.push(queue[0].value)
            end
            queue[0].left_pt.nil? ? '' : queue.push(queue[0].left_pt)
            queue[0].right_pt.nil? ? '' : queue.push(queue[0].right_pt)
            queue.shift()
        end
        array.empty? ? '' : array
    end

    def preorder (node = @root, array = [], &block)
        node.nil? ? return : ''
        block_given? ? block.call(node) : array.push(node.value)
        preorder(node.left_pt, array, &block)
        preorder(node.right_pt, array, &block)
        array.length == 0 ? '' : array
    end

    def inorder (node = @root, array = [], &block)
        node.nil? ? return : ''
        inorder(node.left_pt, array, &block)
        block_given? ? block.call(node) : array.push(node.value)
        inorder(node.right_pt, array, &block)
        array.empty? ? '' : array
    end
    
    def postorder (node = @root, array = [], &block)
        node.nil? ? return : ''
        postorder(node.left_pt, array, &block)
        postorder(node.right_pt, array, &block)
        block_given? ? block.call(node) : array.push(node.value)
        array.empty? ? '' : array
    end

    def height (node)
        smallest_elem = inorder()[0]
        biggest_elem = inorder()[-1]
        if node.value == @root.value
            count_a = 0
            until smallest_elem == node.value
                count_a+=1
                smallest_elem = find_parent(smallest_elem).value
            end
            count_b = 0
            until biggest_elem == node.value
                count_b+=1
                biggest_elem = find_parent(biggest_elem).value
            end
            count_a>count_b ? count_a : count_b
        elsif node.value < @root.value
            count = 0
            until smallest_elem == node.value
                count+=1
                smallest_elem = find_parent(smallest_elem).value
            end
            count
        else
            count = 0
            until biggest_elem == node.value
                count+=1
                biggest_elem = find_parent(biggest_elem).value
            end
            count
        end
    end

    def depth(node)
        count = 0
        until node == @root
            node = find_parent(node.value)
            count +=1
        end
        count
    end

    def balanced?
        if (height(@root.left_pt) - height(@root.right_pt)) <=1 && (height(@root.left_pt) - height(@root.right_pt)) >= -1
            true
        else
            false
        end
    end

    def rebalance
        array_elems = inorder()
        @root = build_tree_recursive(array_elems)
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


t = Tree.new((Array.new(15) { rand(1..100) }))
p t.balanced?
t.pretty_print
p t.level_order
p t.inorder
p t.preorder
p t.postorder

t.insert(150)
t.insert(120)
t.insert(200)

p t.balanced?
t.rebalance
p t.balanced?

t.pretty_print
p t.level_order
p t.inorder
p t.preorder
p t.postorder
