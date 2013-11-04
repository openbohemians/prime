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

A clause that end in a question mark is a query.

Clauses separated by commas are related via logical AND.

Claues separated by semicolons are related via logical OR.

Clauses separated by colons are related via logical IF. These
are called rules. The define a causual relation. The colon
is read as `if` or `because`.

### Variables

Variable are used in relate commonality between clauses.

Variables can be desingated as unamed ordered. For example:

    _ likes _ : _ is a friend of _.

If the order is not the same we can use numbered slots. 

    _ likes _ : 2' is a friend of 1'.

Variable slots can also be named.

    x' is tall : x' is greater than 6 ft in height.

### Queries

Queries are used to ask the knowledge base for information. Queries end in a
question mark.

    _ like Mary?
    => Tom

The quesry is actually returning a list. If the variable slot was named,

    _who_ like Mary?
    => who: Tom

Then the query returns a map. Queries of this form a generally used for
debugging. Sub-queries are used for coding logic (see below).

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

As well as more varied patterns.

    [a' b' m* y' z']

### Maps

Maps are associative array. They map an key to a value. Keys are unique and
order is insignificant. (NOTE: Prime may perserve order if it proves useful to do so.)

    [a:1 b:2 c:3]

Pattern matching on maps works much like it does for lists.

    [k':v']

This matches any key-value pair.

    [x:v']

This matches value of entry with key `x`. There will be only one.

    [k':x]

And this matches all keys that have value `x`. This will be a list since there
can be more than one. Querying values with given keys is much more
efficient than the converse.

### Trees

<i>NOTE: The syntax for trees is still a work in progress. One question that still
needs to be considered is the order of branches --how can it be controlled?
Does it need to be?</i>

In addition to lists, Prime can work with trees, including directed graphs,
in similar fashion.

    [ root' < left' right' ]
    [ left' > root' < right' ]
    [ left' right' > root' ]

All three examples are equivalent, each pattern matching a binary tree node.
Nodes can have any number of branches.

    [ root' < a' ]
    [ root' < a' b' c' d' ]

The branches can though of as a list and matched in the same fashion.

    [ root' < h' t* ]

It is interesting to note that tree with nodes containing only single branches
are equivalent to linked lists.


### Sub-clauses

Clauses can be embedded in other clauses. For short clauses this often makes
for more concise, and thus easier to read code.

    red car.
    blue car.
    (red car) is fast.
    (blue car) is slow.

Sub-clauses can also for the sub-queries.

    (_ likes Socrates) likes Philosophy.

Which is to say, whomever likes Socrates also likes Philosopy.

<i>NOTE: How is this implemtented? As a rule or as a set of facts? Should the 
programmer have sopme way to specify which? Maybe a `!` terminator?</i>


## Implementation

Prime uses a *knoweldge tree* to record all facts. Using a tree structure
makes fact searching very fast. In addition each branch can be searched
concurrently, taking advantage of any number of available processors.

