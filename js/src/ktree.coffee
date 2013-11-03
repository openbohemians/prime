# Prime (c) 2013 Open Bohemians

# Prime uses a tree to represent it's knowledge base, called appropriately
# enough, the Knowledge Tree. Each node is composed of:
#
#   atom   - value of the node
#   parent - parent node
#   branch - array of children nodes
#   count  - number of nodes below
#

class KnowledgeTree

  constructor: (atom, parent) ->
    @atom   = atom
    @parent = parent
    @branch = []
    @count  = 0

  # match - Find a matching branch node for a given
  # atom. If there are no matches return null.
  #
  # Returns matching branch or null.

  match: (atom) ->
    for b in tree.branch
        if (b.atom == atom)
            return b
    null

    # Add an atom to this tree node.
    #
    # Return new tree.

    add: (atom) ->
        node = KnowledgeTree(atom, this)
        @branch.push(node)
        @count = @count + 1
        node

    # Add a fact to the knowledge tree.
    #
    # atoms - Array of String
    #
    # Returns nothing.

    fact: (atoms) ->
        parent = this
        for atom in atoms
            parent = parent.add(atom)

    # Output a representation of the tree to stdout.
    #
    # Returns nothing.

    dump: ->
        dumpN(0)

    # Output a representation of the tree to stdout.
    #
    # depth - Integer
    #
    # Returns nothing.

    dumpN: (depth) ->
      console.log("%d\n", @branch.size)
      for b in @branch
        console.log("%s> %s", Array(depth).join('--'), b.atom)
        b.dumpN(depth + 1)

