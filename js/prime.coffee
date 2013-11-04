# Prime (c) 2013 Open Bohemians

fs = require('fs')

# Presently we are using a very primative parser. At some point
# in the future we can use something more sophisticated in order
# to better detect syntax errors before actual code execution.

class Interpretor

  constructor: ->
      @ktree = new KnowledgeTree(null, null)

  # Evaluate a prime program file.
  #
  # program - File path.
  #
  run: (program) ->
      @evalFile(program)

  # Evaluate a prime file.
  #
  # program - File path.
  #

  evalFile: (program) ->
      fs.readFile program, 'utf8', (err, script) =>
          if (err)
              throw err
          @eval(script)

  # Eval takes a string and evaluates it as a prime program.
  #
  # Returns nothing.

  eval: (script) ->
     statements = script.split(".")
     for statement in statements
         @evalStatement(statement)

  # Parses a single program statement and add it to the knowledge tree.
  #
  # statement - Single program statement.
  #
  # Returns nothing.

  evalStatement: (statement) ->
      statement = statement.trim(statement)
      # TODO: remove trailing comments
      # TODO: skip comments
      # skip blanks
      if (statement == "")
          return
      atoms = @splitAtoms(statement)
      @fact(atoms)

  # Add new fact to the knowledge tree.
  #
  # Returns nothing.

  fact: (atoms) ->
      node = @ktree
      #console.log(node)
      for atom, i in atoms
          match = node.match(atom)
          if match
              node = match
          else
              node.fact(atoms[i..-1])
              break

  # Split statement into indvidual atoms.
  #
  # TODO: Split on multiple spaces.
  #
  # Returns array of string.

  splitAtoms: (statement) ->
      atoms = statement.split(" ")
      atoms

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
        for b in @branch
            if (b.atom == atom)
                return b
        null

    # Add an atom to this tree node.
    #
    # Return new tree.

    add: (atom) ->
        node = new KnowledgeTree(atom, this)
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
            console.log(parent)

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


exports.cli = ->
    program = require('commander')

    program
      .version('0.0.1')
      .option('-e, --exec [code]', 'Execute code')
      .option('-v, --version', 'Output version information')
      .option('-h, --help', 'Show usage information')
      .parse(process.argv)

    if program.args.length == 1
        file = program.args[0]
        intr = new Interpretor
        intr.run(file)
    else
        console.log("Error: too many arguments")


