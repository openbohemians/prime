# Prime (c) 2013

fs = require('fs')

# Presently we are using a very primative parser. At some point
# in the future we can use something more sophisticated in order
# to better detect syntax errors before actual code execution.

class Prime

  constructor: ->
      @ktree = new KnowledgeTree(null, null)

  # Evaluate a prime program file.
  #
  # program - File path.
  #
  run: (program) ->
      evalFile(program)

  # Evaluate a prime file.
  #
  # program - File path.
  #

  evalFile: (program) ->
      fs.readFile program, (err, script) =>
          if (err)
              throw err
          eval(script)

  # Eval takes a string and evaluates it as a prime program.
  #
  # Returns nothing.

  eval: (program) ->
     statements = program.split(".")
     for statement in statements
         evalStatement(statement)

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
      atoms = splitAtoms(statement)
      fact(atoms)

  # Add new fact to the knowledge tree.
  #
  # Returns nothing.

  fact: (atoms) ->
      node = @ktree
      for atom, i in atoms
          match = node.match(atom)
          if match
              node = match
          else
              node.fact(atoms[i:cap(atoms)])
              break

  # Split statement into indvidual atoms.
  #
  # TODO: Split on multiple spaces.
  #
  # Returns array of string.

  splitAtoms: (statement) ->
      atoms = statement.split(" ")
      atoms

