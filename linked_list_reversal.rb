#I'm writing an algo that woudl work for reversing the order of a linked list, and it's pointers, recursively

def reverse_ll (node)
    if node.nil? || node.next.nil?
        return node
    end
    
    new_node = reverse_ll(node.next)
    node.next.next = node
    node.next = nil

    node
end
    

def merge_sorted_ll (node_a, node_b)
