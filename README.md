# Prime

Logical Programming in Plain Language

## About

Prime is a logical programming language in the the heiritage of Prolog.
In contrast to Prolog, Prime does not use a predicate structure.
Prime has flexible and clean syntax. Prime programs are made up of sentences,
and sentences are constructed of atoms. These atoms can be either 
symbols, numbers or text. Symbols and numbers generally make up the bulk
of a prime program, whereas text is typically used for I/O.

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

Commas are used to in cluases to mean `AND` and semicolons are used to mean `OR`.

### Lists

Prime supports lists in similar fashion to Prolog. However, lists in Prime
are not structed as linked lists but rather as binary search trees. This makes
them more flexible, as well as a subset of the more general Tree type that
Prime supports.

In code lists are represented with square brackets, elements separated by spaces.

```prime
  [1 2 3].
```

Head and tail of a list.

  [h' *t']

### Trees



## Implementation

Prime uses a *knoweldge tree* to record all facts. Using a tree structure
makes fact searching very fast, more so by that fact the each branch can
be searched concurrently, taking advantage of any number of available 
processors.

