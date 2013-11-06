# Prime

Logical Programming in Plain Language

## About

Prime is a logical programming language in the the heiritage of Prolog.

Here is the classic Prolog program translated to Prime.

```prime
    x' is mortal: x' is human.
    Socrates is human.
    Socrates is mortal?
    > yes.
```

## Basics of Syntax

Prime has very sparse and free-form syntax. The Prime programmer more or less
simply describes the logic of a program as he or she might describe it in natural
language. This is in contrast to Prolog, which uses a strict predicate logic
with a mathematical function-like syntax.

Prime programs are made up of *facts* and *queries*, and these are composed 
of various *terms*. Terms are either compositions of other terms, e.g. lists,
or *atoms*. Atoms can be either a name, a number or data string (raw or encoded).
Names and numbers tend to make up the bulk of a Prime program's logic, whereas
data is typically used only for I/O.

### Expressions

Facts and queries, taken together, are generally referred to as *expressions*.
(In Prolog these are called *clauses*). Expressions can be simple, or logical
compositions of simpler expressions.

An expression that ends in a period is taken as a fact.

An expression that end in a question mark is a query.

Expressions separated by commas are related via logical And.

Expressions separated by semicolons are related via logical Or.

Expressions separated by colons are related via logical If. These
are called rules and define a causual relation that prime can use
to deduce conculsions. The colon is read as `if` or `because`.

### Variables

Variable are used in relate commonality between clauses.

Variables can be desingated as unamed ordered. For example:

    _ likes _ : _ is a friend of _.

If the order is not the same, numbers slots can be used. 

    _ likes _ : _2 is a friend of _1.

Variable slots can also be named. There are two notations for this.
The modern apostrophe suffix notation is the recommended syntax and
will be used in most examples throughout the Prime documentation.

    x' is tall : x' is greater than 6 ft in height.

But the traditional Prolog underscore prefix notation is also supported:

    _x is tall : _x is greater than 6 ft in height.

Optionally the variables can have trailing underscores as well.

    _x_ is tall : _x_ is greater than 6 ft in height.

<i>TODO: What to use for throw-away slots? Prolog used `_`, but if Prime uses
`_` for ordered slots, then we need something else. Maybe `*` or `_*`?
Then again maybe we shouldn't bother with ordered slots? And maybe then
we can get rid of the named underscore notation all together?</i>

### Facts

Facts are bases of ... langauge. They can ba as simple as stating something
exists, e.g.

    tiger.

Qualifying something that exits.

    red car.

All the way up to stating some expressive truism.

    The world is round.

It really does not matter what the fact is. All that matters is that the 
programmer use a set of consistant expressions to represent their mental
model which can be inter-related via rules and logical compositions.

### Queries

Queries are used to ask the knowledge base for information based on the
facts it contains. Queries end in a question mark.

    _ like Mary?
    => Tom

Note the query is actually returning a list, as there can be more than one
answer. If the variable slot was named,

    _who_ likes Mary?
    => who: Tom

Then the query returns a map. Queries of this form a generally used for
debugging. Sub-queries are used for coding logic.

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

Maps are associative lists. They map a key to a value. Keys are unique and
typically order is insignificant, although Prime perserves order which can 
be useful in some cases.

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

It is most helpful to know that lists and maps share the same interface in Prime.
You can treat lists like maps, and the keys will just be the positional index.
This makes it much easier to work with list and maps since one doesn't have to 
learn a seprate set of expressions for working with each of them.

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

### Sub-expressions

Expressions can be embedded in other expressions. For short expressions this
often makes for more concise, and thus easier to read code.

    red car.
    blue car.
    (red car) is fast.
    (blue car) is slow.

Sub-expressions can also be used to make sub-queries.

    (_ likes Socrates) likes Philosophy.

Which is to say, whomever likes Socrates also likes Philosopy.

<i>NOTE: How is this implemtented? As a rule or as a set of facts? Should the 
programmer have some way to specify which? Maybe a `!` terminator?</i>


## Implementation

Prime uses a *knoweldge tree* to record all facts. Using a tree structure
makes fact searching very fast. In addition each branch can be searched
concurrently, taking advantage of any number of available processors.

