# Prime

Logical Programming in Plain Language

## About

Prime is a logical programming language in the the heiritage of Prolog.

In contrast to Prolog, Prime does not use predicate logic. Instead Prime allows
an open syntax. Prime programs are made up of sentences, and sentences are
constructed of atoms. These atoms can be either words, numbers
strings or a collection thereof. Symbols and numbers generally make up the
bulk of a Prime program's logic, whereas text is used for I/O.

Here is the classic Prolog program translated to Prime.

```prime
    x' is mortal: x' is human.
    Socrates is human.
    Socrates is mortal?
    > yes.
```

## Basics of Syntax

### Clauses

A clause that ends in a period is taken as a fact.

A clause that ends in a question mark is a query.

Commas are used to in clauses to relate sub-clauses via logical AND and
semicolons are used to relate them by logical OR. Colons are used to represent
causual relation, logical IF.

### Variables

Variable are used in relate commonality between clauses. Variables can be
desingated as unamed ordered. For example:

    _ likes _ : _ is a friend of _.

If the order is not the same we can use numbered slots. 

    _ likes _ : _2_ is a friend of _1_.

Variable slots can also be named.

    _x_ is tall : _x_ is greater than 6 ft in height.

### Queries

    _ like Mary?
    => Tom

The quesry is actually returning a list. If the variable slot was named,

    _who_ like Mary?
    => who: Tom

Then the query returns a map.

### Lists

Prime supports lists in similar fashion to Prolog. However, lists in Prime
are not structed as linked lists but rather as binary search trees. This makes
them more flexible, as well as a subset of the more general Tree type that
Prime supports.

In code lists are designated with square brackets, elements separated by spaces.

    [1 2 3]

Pattern matching can be used in lists to match the heat and tail of a list.

    [h' t*]

Prime's list are more flexible than lists in other funtional languages because
they are implemented as binary search trees, rather then simple linked lists.
This makes it possible to also do body/foot pattern matching.

    [b* f']

As well as more variaed patterns.

    [a' b' m* y' z']

### Trees

NOTE: The syntax for trees is still a work in progress.

In addition to lists, Prime can work with data trees, including directed graphs,
in similar fashion.

    [ root' < left' right' ]
    [ left' > root' < right' ]
    [ left' right' > root' ]

All three examples are equivalent, each pattern matching a binary tree node.

### Maps


## Implementation

Prime uses a *knoweldge tree* to record all facts. Using a tree structure
makes fact searching very fast, more so by that fact the each branch can
be searched concurrently, taking advantage of any number of available 
processors.

